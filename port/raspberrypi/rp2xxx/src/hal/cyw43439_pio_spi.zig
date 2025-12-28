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

const Self = @This();

pio: hal.pio.Pio,
sm: hal.pio.StateMachine,
channel: ?hal.dma.Channel = null, // current dma channel
pins: Pins,

pub const Config = struct {
    pio: hal.pio.Pio = hal.pio.num(0),
    pins: Pins = .{},
};

pub const Pins = struct {
    cs: hal.gpio.Pin = hal.gpio.num(25),
    io: hal.gpio.Pin = hal.gpio.num(24),
    clk: hal.gpio.Pin = hal.gpio.num(29),
    pwr: hal.gpio.Pin = hal.gpio.num(23),
};

pub fn init(config: Config) !Self {
    const pins = config.pins;
    const pio = config.pio;
    const sm = try pio.claim_unused_state_machine();

    // Chip select pin setup
    pins.cs.set_function(.sio);
    pins.cs.set_direction(.out);
    pins.cs.put(1);

    // IO pin setup
    pio.gpio_init(pins.io);
    pins.io.set_output_disabled(false);
    pins.io.set_pull(.disabled);
    pins.io.set_schmitt_trigger_enabled(true);
    try pio.set_input_sync_bypass(pins.io);
    pins.io.set_drive_strength(.@"12mA");
    pins.io.set_slew_rate(.fast);

    // Clock pin setup
    pio.gpio_init(pins.clk);
    pins.clk.set_output_disabled(false);
    pins.clk.set_drive_strength(.@"12mA");
    pins.clk.set_slew_rate(.fast);

    try pio.sm_load_and_start_program(sm, cyw43spi_program, .{
        .clkdiv = .{
            // 50MHz is recomended by datasheet
            .int = if (hal.compatibility.chip == .RP2040) 2 else 3,
            .frac = 0,
        },
        .pin_mappings = .{
            .out = .single(pins.io),
            .set = .single(pins.io),
            .side_set = .single(pins.clk),
            .in_base = pins.io,
        },
        .shift = .{
            .out_shiftdir = .left,
            .in_shiftdir = .left,
            .autopull = true,
            .autopush = true,
        },
    });

    try pio.sm_set_pindir(sm, pins.clk, 1, .out);
    try pio.sm_set_pindir(sm, pins.io, 1, .out);
    try pio.sm_set_pin(sm, pins.clk, 1, 0);
    try pio.sm_set_pin(sm, pins.io, 1, 0);

    // Power init sequence
    pins.pwr.set_function(.sio);
    pins.pwr.set_direction(.out);
    pins.pwr.put(0);
    hal.time.sleep_ms(50);
    pins.pwr.put(1);
    hal.time.sleep_ms(250);

    return .{
        .pio = pio,
        .sm = sm,
        .pins = pins,
    };
}

pub fn read(ptr: *anyopaque, words: []u32) void {
    const self: *Self = @ptrCast(@alignCast(ptr));
    self.pins.cs.put(0);
    defer self.pins.cs.put(1);

    self.channel = hal.dma.claim_unused_channel();
    defer self.channel.?.unclaim();

    self.prep(words.len * 32 - 1, 31);
    self.dma_write(words[0..1]);
    self.dma_read(words); // last word is status
}

// By default it sends status after each read/write.
// ref: datasheet 'Table 6. gSPI Registers' status enable has default 1
pub fn write(ptr: *anyopaque, words: []u32) void {
    const self: *Self = @ptrCast(@alignCast(ptr));
    self.pins.cs.put(0);
    defer self.pins.cs.put(1);

    self.channel = hal.dma.claim_unused_channel();
    defer self.channel.?.unclaim();

    self.prep(31, words.len * 32 - 1);
    self.dma_write(words);
    self.dma_read(words[0..1]); // read status into first word
}

fn prep(self: *Self, read_bits: u32, write_bits: u32) void {
    self.pio.sm_set_enabled(self.sm, false);
    self.pio.sm_exec_set_y(self.sm, read_bits);
    self.pio.sm_exec_set_x(self.sm, write_bits);
    self.pio.sm_exec_set_pindir(self.sm, 0b1);
    self.pio.sm_exec_jmp(self.sm, cyw43spi_program.wrap_target.?);
    self.pio.sm_set_enabled(self.sm, true);
}

fn dma_read(self: *Self, data: []u32) void {
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

fn dma_write(self: *Self, data: []const u32) void {
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
