//! CYW43 3-wire SPI driver build on PIO
//! Code based on embassy cyw43-pio driver https://github.com/embassy-rs/embassy/tree/main/cyw43-pio
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

pub fn init(pio: hal.pio.Pio, cs_pin: hal.gpio.Pin, io_pin: hal.gpio.Pin, clk_pin: hal.gpio.Pin) !Cyw43PioSpi {
    const sm = try pio.claim_unused_state_machine();

    // Chip select pin setup
    cs_pin.set_function(.sio);
    cs_pin.set_direction(.out);
    cs_pin.put(1);

    // IO pin setup
    io_pin.set_function(get_pin_pio_function(pio));
    io_pin.set_output_disabled(false);
    io_pin.set_pull(.disabled);
    io_pin.set_schmitt_trigger(.enabled);

    pio.set_input_sync_bypass(@truncate(@intFromEnum(io_pin)));

    io_pin.set_drive_strength(.@"12mA");
    io_pin.set_slew_rate(.fast);

    // Clock pin setup
    clk_pin.set_function(get_pin_pio_function(pio));
    clk_pin.set_output_disabled(false);
    clk_pin.set_drive_strength(.@"12mA");
    clk_pin.set_slew_rate(.fast);

    try pio.sm_load_and_start_program(sm, cyw43spi_program, .{
        // Default max value from pico-sdk 62.5Mhz
        .clkdiv = .{ .int = 2, .frac = 0 },
        .pin_mappings = .{
            .out = .{ .base = @truncate(@intFromEnum(io_pin)), .count = 1 },
            .set = .{ .base = @truncate(@intFromEnum(io_pin)), .count = 1 },
            .side_set = .{ .base = @truncate(@intFromEnum(clk_pin)), .count = 1 },
            .in_base = @truncate(@intFromEnum(io_pin)),
        },
        .shift = .{
            .out_shiftdir = .left,
            .in_shiftdir = .left,
            .autopull = true,
            .autopush = true,
        },
    });

    pio.sm_set_pindir(sm, @truncate(@intFromEnum(clk_pin)), 1, .out);
    pio.sm_set_pindir(sm, @truncate(@intFromEnum(io_pin)), 1, .out);

    pio.sm_set_pin(sm, @truncate(@intFromEnum(clk_pin)), 1, 0);
    pio.sm_set_pin(sm, @truncate(@intFromEnum(io_pin)), 1, 0);

    return .{ .pio = pio, .sm = sm, .cs_pin = cs_pin, .io_pin = io_pin, .clk_pin = clk_pin };
}

fn get_pin_pio_function(pio: hal.pio.Pio) hal.gpio.Function {
    return switch (chip) {
        .RP2040 => switch (pio) {
            .pio0 => .pio0,
            .pio1 => .pio1,
        },
        .RP2350 => switch (pio) {
            .pio0 => .pio0,
            .pio1 => .pio1,
            .pio2 => .pio2,
        },
    };
}

pub const Cyw43PioSpi = struct {
    const Self = @This();

    pio: hal.pio.Pio,
    sm: hal.pio.StateMachine,
    cs_pin: hal.gpio.Pin,
    io_pin: hal.gpio.Pin,
    clk_pin: hal.gpio.Pin,

    pub fn spi_read_blocking(this: *Self, cmd: u32, buffer: []u32) u32 {
        this.cs_pin.put(0);
        defer this.cs_pin.put(1);

        return this.read_blocking(cmd, buffer);
    }

    pub fn spi_write_blocking(this: *Self, buffer: []const u32) u32 {
        this.cs_pin.put(0);
        defer this.cs_pin.put(1);

        return this.write_blocking(buffer);
    }

    fn read_blocking(this: *Self, cmd: u32, buffer: []u32) u32 {
        this.pio.sm_set_enabled(this.sm, false);

        const write_bits = 31;
        const read_bits = buffer.len * 32 + 32 - 1;

        this.pio.sm_exec_set_y(this.sm, read_bits);
        this.pio.sm_exec_set_x(this.sm, write_bits);
        this.pio.sm_exec_set_pindir(this.sm, 0b1);
        this.pio.sm_exec_jmp(this.sm, cyw43spi_program.wrap_target.?);

        this.pio.sm_set_enabled(this.sm, true);

        const dma_ch = hal.dma.claim_unused_channel().?;
        defer dma_ch.unclaim();

        dma_ch.trigger_transfer(this.get_pio_tx_fifo_addr(), @intFromPtr(&cmd), 1, .{ .data_size = .size_32, .enable = true, .read_increment = true, .write_increment = false, .dreq = this.get_pio_tx_dreq() });

        dma_ch.wait_for_finish_blocking();

        dma_ch.trigger_transfer(@intFromPtr(buffer.ptr), this.get_pio_rx_fifo_addr(), buffer.len, .{ .data_size = .size_32, .enable = true, .read_increment = false, .write_increment = true, .dreq = this.get_pio_rx_dreq() });

        dma_ch.wait_for_finish_blocking();

        var status: u32 = 0;
        dma_ch.trigger_transfer(@intFromPtr(&status), this.get_pio_rx_fifo_addr(), 1, .{ .data_size = .size_32, .enable = true, .read_increment = false, .write_increment = true, .dreq = this.get_pio_rx_dreq() });

        dma_ch.wait_for_finish_blocking();

        return status;
    }

    fn write_blocking(this: *Self, buffer: []const u32) u32 {
        this.pio.sm_set_enabled(this.sm, false);

        const write_bits = buffer.len * 32 - 1;
        const read_bits = 31;

        this.pio.sm_exec_set_x(this.sm, write_bits);
        this.pio.sm_exec_set_y(this.sm, read_bits);
        this.pio.sm_exec_set_pindir(this.sm, 0b1);
        this.pio.sm_exec_jmp(this.sm, cyw43spi_program.wrap_target.?);

        this.pio.sm_set_enabled(this.sm, true);

        const dma_ch = hal.dma.claim_unused_channel().?;
        defer dma_ch.unclaim();

        dma_ch.trigger_transfer(this.get_pio_tx_fifo_addr(), @intFromPtr(buffer.ptr), buffer.len, .{ .data_size = .size_32, .enable = true, .read_increment = true, .write_increment = false, .dreq = this.get_pio_tx_dreq() });

        dma_ch.wait_for_finish_blocking();

        var status: u32 = 0;
        dma_ch.trigger_transfer(@intFromPtr(&status), this.get_pio_rx_fifo_addr(), 1, .{ .data_size = .size_32, .enable = true, .read_increment = false, .write_increment = true, .dreq = this.get_pio_rx_dreq() });

        dma_ch.wait_for_finish_blocking();

        return status;
    }

    inline fn get_pio_tx_fifo_addr(this: *Self) u32 {
        return @intFromPtr(this.pio.sm_get_tx_fifo(this.sm));
    }

    inline fn get_pio_rx_fifo_addr(this: *Self) u32 {
        return @intFromPtr(this.pio.sm_get_rx_fifo(this.sm));
    }

    inline fn get_pio_tx_dreq(this: *Self) hal.dma.Dreq {
        return @enumFromInt(@intFromEnum(this.pio) * @as(u6, 8) + @intFromEnum(this.sm));
    }

    inline fn get_pio_rx_dreq(this: *Self) hal.dma.Dreq {
        return @enumFromInt(@intFromEnum(this.pio) * @as(u6, 8) + @intFromEnum(this.sm) + 4);
    }

    /// Cyw43_Spi interface implementation
    pub fn cyw43_spi(this: *Self) Cyw43_Spi {
        return .{
            .ptr = this,
            .vtable = &vtable,
        };
    }

    const vtable = Cyw43_Spi.VTable {
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
