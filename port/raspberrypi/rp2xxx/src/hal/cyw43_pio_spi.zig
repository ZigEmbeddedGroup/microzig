//! CYW43 3-wire SPI driver build on PIO
//! Code based on embassy cyw43-pio driver https://github.com/embassy-rs/embassy/tree/main/cyw43-pio (last commit: d41eeea)
const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");

const Cyw43_Spi = microzig.drivers.wireless.Cyw43_Spi;

const chip = microzig.hal.compatibility.chip;

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

pub const Cyw43PioSpi_Config = struct {
    pio: hal.pio.Pio,
    cs_pin: hal.gpio.Pin,
    io_pin: hal.gpio.Pin,
    clk_pin: hal.gpio.Pin,
};

pub fn init(config: Cyw43PioSpi_Config) !Cyw43PioSpi {
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
        // Default max value from pico-sdk 62.5Mhz
        .clkdiv = .{ .int = 2, .frac = 0 },
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

pub const Cyw43PioSpi = struct {
    const Self = @This();

    pio: hal.pio.Pio,
    sm: hal.pio.StateMachine,
    cs_pin: hal.gpio.Pin,
    io_pin: hal.gpio.Pin,
    clk_pin: hal.gpio.Pin,

    pub fn spi_read_blocking(self: *Self, cmd: u32, buffer: []u32) u32 {
        self.cs_pin.put(0);
        defer self.cs_pin.put(1);

        return self.read_blocking(cmd, buffer);
    }

    pub fn spi_write_blocking(self: *Self, buffer: []const u32) u32 {
        self.cs_pin.put(0);
        defer self.cs_pin.put(1);

        return self.write_blocking(buffer);
    }

    fn read_blocking(self: *Self, cmd: u32, buffer: []u32) u32 {
        self.pio.sm_set_enabled(self.sm, false);

        const write_bits = 31;
        const read_bits = buffer.len * 32 + 32 - 1;

        self.pio.sm_exec_set_y(self.sm, read_bits);
        self.pio.sm_exec_set_x(self.sm, write_bits);
        self.pio.sm_exec_set_pindir(self.sm, 0b1);
        self.pio.sm_exec_jmp(self.sm, cyw43spi_program.wrap_target.?);

        self.pio.sm_set_enabled(self.sm, true);

        const dma_ch = hal.dma.claim_unused_channel().?;
        defer dma_ch.unclaim();

        dma_ch.setup_transfer_raw(self.get_pio_tx_fifo_addr(), @intFromPtr(&cmd), 1, .{
            .trigger = true,
            .data_size = .size_32,
            .enable = true,
            .read_increment = true,
            .write_increment = false,
            .dreq = self.get_pio_tx_dreq(),
        });

        dma_ch.wait_for_finish_blocking();

        dma_ch.setup_transfer_raw(@intFromPtr(buffer.ptr), self.get_pio_rx_fifo_addr(), buffer.len, .{
            .trigger = true,
            .data_size = .size_32,
            .enable = true,
            .read_increment = false,
            .write_increment = true,
            .dreq = self.get_pio_rx_dreq(),
        });

        dma_ch.wait_for_finish_blocking();

        var status: u32 = 0;
        dma_ch.setup_transfer_raw(@intFromPtr(&status), self.get_pio_rx_fifo_addr(), 1, .{
            .data_size = .size_32,
            .enable = true,
            .read_increment = false,
            .write_increment = true,
            .dreq = self.get_pio_rx_dreq(),
        });

        dma_ch.wait_for_finish_blocking();

        return status;
    }

    fn write_blocking(self: *Self, buffer: []const u32) u32 {
        self.pio.sm_set_enabled(self.sm, false);

        const write_bits = buffer.len * 32 - 1;
        const read_bits = 31;

        self.pio.sm_exec_set_x(self.sm, write_bits);
        self.pio.sm_exec_set_y(self.sm, read_bits);
        self.pio.sm_exec_set_pindir(self.sm, 0b1);
        self.pio.sm_exec_jmp(self.sm, cyw43spi_program.wrap_target.?);

        self.pio.sm_set_enabled(self.sm, true);

        const dma_ch = hal.dma.claim_unused_channel().?;
        defer dma_ch.unclaim();

        dma_ch.setup_transfer_raw(self.get_pio_tx_fifo_addr(), @intFromPtr(buffer.ptr), buffer.len, .{
            .data_size = .size_32,
            .enable = true,
            .read_increment = true,
            .write_increment = false,
            .dreq = self.get_pio_tx_dreq(),
        });

        dma_ch.wait_for_finish_blocking();

        var status: u32 = 0;
        dma_ch.setup_transfer_raw(@intFromPtr(&status), self.get_pio_rx_fifo_addr(), 1, .{
            .data_size = .size_32,
            .enable = true,
            .read_increment = false,
            .write_increment = true,
            .dreq = self.get_pio_rx_dreq(),
        });

        dma_ch.wait_for_finish_blocking();

        return status;
    }

    inline fn get_pio_tx_fifo_addr(self: *Self) u32 {
        return @intFromPtr(self.pio.sm_get_tx_fifo(self.sm));
    }

    inline fn get_pio_rx_fifo_addr(self: *Self) u32 {
        return @intFromPtr(self.pio.sm_get_rx_fifo(self.sm));
    }

    inline fn get_pio_tx_dreq(self: *Self) hal.dma.Dreq {
        return @enumFromInt(@intFromEnum(self.pio) * @as(u6, 8) + @intFromEnum(self.sm));
    }

    inline fn get_pio_rx_dreq(self: *Self) hal.dma.Dreq {
        return @enumFromInt(@intFromEnum(self.pio) * @as(u6, 8) + @intFromEnum(self.sm) + 4);
    }

    /// Cyw43_Spi interface implementation
    pub fn cyw43_spi(self: *Self) Cyw43_Spi {
        return .{
            .ptr = self,
            .vtable = &vtable,
        };
    }

    const vtable = Cyw43_Spi.VTable{
        .spi_read_blocking_fn = spi_read_blocking_fn,
        .spi_write_blocking_fn = spi_write_blocking_fn,
    };

    fn spi_read_blocking_fn(spi: *anyopaque, cmd: u32, buffer: []u32) u32 {
        const cyw43spi: *Self = @ptrCast(@alignCast(spi));
        return cyw43spi.spi_read_blocking(cmd, buffer);
    }

    fn spi_write_blocking_fn(spi: *anyopaque, buffer: []const u32) u32 {
        const cyw43spi: *Self = @ptrCast(@alignCast(spi));
        return cyw43spi.spi_write_blocking(buffer);
    }
};
