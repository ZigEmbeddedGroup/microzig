const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SPI0 = peripherals.SPI0;
const SPI1 = peripherals.SPI1;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const resets = @import("resets.zig");
const time = @import("time.zig");

const SpiRegs = microzig.chip.types.peripherals.SPI0;

pub const Config = struct {
    clock_config: clocks.GlobalConfiguration,
    tx_pin: ?u32 = 19,
    rx_pin: ?u32 = 16,
    sck_pin: ?u32 = 18,
    csn_pin: ?u32 = 17,
    baud_rate: u32 = 1000 * 1000,
};

pub const SPI = enum {
    spi0,
    spi1,

    fn get_regs(spi: SPI) *volatile SpiRegs {
        return switch (spi) {
            .spi0 => SPI0,
            .spi1 => SPI1,
        };
    }

    pub fn reset(spi: SPI) void {
        switch (spi) {
            .spi0 => resets.reset(&.{.spi0}),
            .spi1 => resets.reset(&.{.spi1}),
        }
    }

    pub fn init(comptime id: u32, comptime config: Config) SPI {
        const spi: SPI = switch (id) {
            0 => .spi0,
            1 => .spi1,
            else => @compileError("there is only spi0 and spi1"),
        };

        spi.reset();

        const peri_freq = config.clock_config.peri.?.output_freq;
        _ = spi.set_baudrate(config.baud_rate, peri_freq);

        const spi_regs = spi.get_regs();

        // set fromat
        spi_regs.SSPCR0.modify(.{
            .DSS = 0b0111, // 8 bits
            .SPO = 0,
            .SPH = 0,
        });

        // Always enable DREQ signals -- harmless if DMA is not listening
        spi_regs.SSPDMACR.modify(.{
            .TXDMAE = 1,
            .RXDMAE = 1,
        });

        // Finally enable the SPI
        spi_regs.SSPCR1.modify(.{
            .SSE = 1,
        });

        if (config.tx_pin) |pin| gpio.set_function(pin, .spi);
        if (config.rx_pin) |pin| gpio.set_function(pin, .spi);
        if (config.sck_pin) |pin| gpio.set_function(pin, .spi);
        if (config.csn_pin) |pin| gpio.set_function(pin, .spi);

        return spi;
    }

    pub fn is_writable(spi: SPI) bool {
        return spi.get_regs().SSPSR.read().TNF == 1;
    }

    pub fn is_readable(spi: SPI) bool {
        return spi.get_regs().SSPSR.read().RNE == 1;
    }
    pub fn transceive(spi: SPI, src: []const u8, dst: []u8) usize {
        const spi_regs = spi.get_regs();
        std.debug.assert(src.len == dst.len);
        const fifo_depth = 8;
        var rx_remaining = dst.len;
        var tx_remaining = src.len;

        while (rx_remaining > 0 or tx_remaining > 0) {
            if (tx_remaining > 0 and spi.is_writable() and rx_remaining < tx_remaining + fifo_depth) {
                spi_regs.SSPDR.write_raw(src[src.len - tx_remaining]);
                tx_remaining -= 1;
            }
            if (rx_remaining > 0 and spi.is_readable()) {
                const bytes = std.mem.asBytes(&spi_regs.SSPDR.read().DATA);
                dst[dst.len - rx_remaining] = bytes[0];
                rx_remaining -= 1;
            }
        }

        return src.len;
    }
    // Write len bytes directly from src to the SPI, and discard any data received back
    pub fn write(spi: SPI, src: []const u8) usize {
        const spi_regs = spi.get_regs();
        // Write to TX FIFO whilst ignoring RX, then clean up afterward. When RX
        // is full, PL022 inhibits RX pushes, and sets a sticky flag on
        // push-on-full, but continues shifting. Safe if SSPIMSC_RORIM is not set.
        for (src) |s| {
            while (!spi.is_writable()) {
                std.log.debug("SPI not writable!", .{});
            }
            spi_regs.SSPDR.write_raw(s);
        }
        // Drain RX FIFO, then wait for shifting to finish (which may be *after*
        // TX FIFO drains), then drain RX FIFO again
        while (spi.is_readable()) {
            _ = spi_regs.SSPDR.raw;
        }
        while (spi.get_regs().SSPSR.read().BSY == 1) {
            std.log.debug("SPI busy!", .{});
        }
        while (spi.is_readable()) {
            _ = spi_regs.SSPDR.raw;
        }
        // Don't leave overrun flag set
        peripherals.SPI0.SSPICR.modify(.{ .RORIC = 1 });
        return src.len;
    }

    fn set_baudrate(spi: SPI, baudrate: u32, freq_in: u32) u64 {
        const spi_regs = spi.get_regs();
        // Find smallest prescale value which puts output frequency in range of
        // post-divide. Prescale is an even number from 2 to 254 inclusive.
        var prescale: u64 = 2;
        while (prescale <= 254) : (prescale += 2) {
            if (freq_in < (prescale + 2) * 256 * baudrate) break;
        }
        std.debug.assert(prescale <= 254); //Freq too low
        // Find largest post-divide which makes output <= baudrate. Post-divide is
        // an integer in the range 1 to 256 inclusive.

        var postdiv: u64 = 256;
        while (postdiv > 1) : (postdiv -= 1) {
            if (freq_in / (prescale * (postdiv - 1)) > baudrate) break;
        }
        spi_regs.SSPCPSR.modify(.{ .CPSDVSR = @intCast(u8, prescale) });
        spi_regs.SSPCR0.modify(.{ .SCR = @intCast(u8, postdiv - 1) });

        // Return the frequency we were able to achieve
        return freq_in / (prescale * postdiv);
    }
};
