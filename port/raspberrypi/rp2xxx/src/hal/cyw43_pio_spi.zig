//! CYW43 3-wire SPI driver build on PIO
//! Code based on embassy cyw43-pio driver https://github.com/embassy-rs/embassy/tree/main/cyw43-pio (last commit: d41eeea)
const std = @import("std");
const mem = std.mem;
const microzig = @import("microzig");
const hal = @import("../hal.zig");

const cyw43spi_program = blk: {
    @setEvalBranchQuota(5000);
    break :blk hal.pio.assemble(
        \\.program cyw43spi
        \\.side_set 1
        \\
        \\.wrap_target
        \\
        \\; write out x-1 bits
        \\lp:
        \\out pins, 1    side 0
        \\jmp x-- lp     side 1
        \\
        \\; switch directions
        \\set pindirs, 0 side 0
        \\nop            side 0
        \\
        \\; read in y-1 bits
        \\lp2:
        \\in pins, 1     side 1
        \\jmp y-- lp2    side 0
        \\
        \\; wait for event and irq host
        \\wait 1 pin 0   side 0
        \\irq 0          side 0
        \\
        \\.wrap
    , .{}).get_program_by_name("cyw43spi");
};

fn pin_num(pin: hal.gpio.Pin) u5 {
    return @truncate(@intFromEnum(pin));
}

const Cyw43PioSpi = @This();

pio: hal.pio.Pio,
sm: hal.pio.StateMachine,
cs_pin: hal.gpio.Pin,
io_pin: hal.gpio.Pin,
clk_pin: hal.gpio.Pin,
channel: ?hal.dma.Channel = null, // current dma channel

pub const Config = struct {
    pio: hal.pio.Pio = hal.pio.num(0),
    cs_pin: hal.gpio.Pin = hal.gpio.num(25),
    io_pin: hal.gpio.Pin = hal.gpio.num(24),
    clk_pin: hal.gpio.Pin = hal.gpio.num(29),
    pwr_pin: hal.gpio.Pin = hal.gpio.num(23),
};

pub fn init(config: Config) !Cyw43PioSpi {
    const sm = try config.pio.claim_unused_state_machine();

    // Chip select pin setup
    config.cs_pin.set_function(.sio);
    config.cs_pin.set_direction(.out);
    config.cs_pin.put(1);

    // IO pin setup
    config.pio.gpio_init(config.io_pin);
    config.io_pin.set_output_disabled(false);
    config.io_pin.set_pull(.disabled);
    config.io_pin.set_schmitt_trigger_enabled(true);

    try config.pio.set_input_sync_bypass(config.io_pin);

    config.io_pin.set_drive_strength(.@"12mA");
    config.io_pin.set_slew_rate(.fast);

    // Clock pin setup
    config.pio.gpio_init(config.clk_pin);
    config.clk_pin.set_output_disabled(false);
    config.clk_pin.set_drive_strength(.@"12mA");
    config.clk_pin.set_slew_rate(.fast);

    try config.pio.sm_load_and_start_program(sm, cyw43spi_program, .{
        // TODO: int = 2 gives 62.5Mhz on pico, but it is too much on pico2
        // This should depend on pico/pico2: 2/3
        // 50MHz i recomended by datasheet
        .clkdiv = .{ .int = 3, .frac = 0 },
        .pin_mappings = .{
            .out = .single(config.io_pin),
            .set = .single(config.io_pin),
            .side_set = .single(config.io_pin),
            .in_base = config.io_pin,
        },
        .shift = .{
            .out_shiftdir = .left,
            .in_shiftdir = .left,
            .autopull = true,
            .autopush = true,
        },
    });

    try config.pio.sm_set_pindir(sm, config.clk_pin, 1, .out);
    try config.pio.sm_set_pindir(sm, config.io_pin, 1, .out);

    try config.pio.sm_set_pin(sm, config.clk_pin, 1, 0);
    try config.pio.sm_set_pin(sm, config.io_pin, 1, 0);

    return .{
        .pio = config.pio,
        .sm = sm,
        .cs_pin = config.cs_pin,
        .io_pin = config.io_pin,
        .clk_pin = config.clk_pin,
    };
}

pub fn read(ptr: *anyopaque, cmd: u32, buffer: []u32) u32 {
    const self: *Cyw43PioSpi = @ptrCast(@alignCast(ptr));
    self.cs_pin.put(0);
    defer self.cs_pin.put(1);

    self.channel = hal.dma.claim_unused_channel();
    defer self.channel.?.unclaim();

    self.prep(buffer.len * 32 + 32 - 1, 31);
    self.dma_write(&.{cmd});
    self.dma_read(buffer);
    return self.status();
}

pub fn write(ptr: *anyopaque, cmd: u32, buffer: []const u32) u32 {
    const self: *Cyw43PioSpi = @ptrCast(@alignCast(ptr));
    self.cs_pin.put(0);
    defer self.cs_pin.put(1);

    self.channel = hal.dma.claim_unused_channel();
    defer self.channel.?.unclaim();

    self.prep(31, buffer.len * 32 + 32 - 1);
    self.dma_write(&.{cmd});
    self.dma_write(buffer);
    return self.status();
}

fn prep(self: *Cyw43PioSpi, read_bits: u32, write_bits: u32) void {
    self.pio.sm_set_enabled(self.sm, false);
    self.pio.sm_exec_set_y(self.sm, read_bits);
    self.pio.sm_exec_set_x(self.sm, write_bits);
    self.pio.sm_exec_set_pindir(self.sm, 0b1);
    self.pio.sm_exec_jmp(self.sm, cyw43spi_program.wrap_target.?);
    self.pio.sm_set_enabled(self.sm, true);
}

fn dma_read(self: *Cyw43PioSpi, data: []u32) void {
    const ch = self.channel.?;
    const rx_fifo_addr = @intFromPtr(self.pio.sm_get_rx_fifo(self.sm));
    ch.setup_transfer_raw(@intFromPtr(data.ptr), rx_fifo_addr, data.len, .{
        .trigger = true,
        .data_size = .size_32,
        .enable = true,
        .read_increment = false,
        .write_increment = true,
        .dreq = @enumFromInt(@intFromEnum(self.pio) * @as(u6, 8) + @intFromEnum(self.sm) + 4),
    });
    ch.wait_for_finish_blocking();
}

fn dma_write(self: *Cyw43PioSpi, data: []const u32) void {
    const ch = self.channel.?;
    const tx_fifo_addr = @intFromPtr(self.pio.sm_get_tx_fifo(self.sm));
    ch.setup_transfer_raw(tx_fifo_addr, @intFromPtr(data.ptr), data.len, .{
        .trigger = true,
        .data_size = .size_32,
        .enable = true,
        .read_increment = true,
        .write_increment = false,
        .dreq = @enumFromInt(@intFromEnum(self.pio) * @as(u6, 8) + @intFromEnum(self.sm)),
    });
    ch.wait_for_finish_blocking();
}

// By default it sends status after each read/write.
// ref: datasheet 'Table 6. gSPI Registers' status enable has default 1
fn status(self: *Cyw43PioSpi) u32 {
    var val: u32 = 0;
    self.dma_read(mem.bytesAsSlice(u32, mem.asBytes(&val)));
    return val;
}
