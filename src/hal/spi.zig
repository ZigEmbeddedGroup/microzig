const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SPI0 = peripherals.SPI0;
const SPI1 = peripherals.SPI1;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const resets = @import("resets.zig");
const time = @import("time.zig");
const util = @import("util.zig");

const SpiRegs = microzig.chip.types.peripherals.SPI0;

pub const Config = struct {
    clock_config: clocks.GlobalConfiguration,
    tx_pin: ?gpio.Pin = gpio.num(19),
    rx_pin: ?gpio.Pin = gpio.num(16),
    sck_pin: ?gpio.Pin = gpio.num(18),
    csn_pin: ?gpio.Pin = gpio.num(17),
    baud_rate: u32 = 1000 * 1000,
};

pub fn num(n: u1) SPI {
    return @intToEnum(SPI, n);
}

pub const SPI = enum(u1) {
    _,

    fn get_regs(spi: SPI) *volatile SpiRegs {
        return switch (@enumToInt(spi)) {
            0 => SPI0,
            1 => SPI1,
        };
    }

    pub fn apply(spi: SPI, comptime config: Config) void {
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

        if (config.tx_pin) |pin| pin.set_function(.spi);
        if (config.rx_pin) |pin| pin.set_function(.spi);
        if (config.sck_pin) |pin| pin.set_function(.spi);
        if (config.csn_pin) |pin| pin.set_function(.spi);
    }

    pub inline fn is_writable(spi: SPI) bool {
        return spi.get_regs().SSPSR.read().TNF == 1;
    }

    pub inline fn is_readable(spi: SPI) bool {
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
    /// Write len bytes directly from src to the SPI, and discard any data received back
    pub fn write(spi: SPI, src: []const u8) usize {
        const spi_regs = spi.get_regs();
        // Write to TX FIFO whilst ignoring RX, then clean up afterward. When RX
        // is full, PL022 inhibits RX pushes, and sets a sticky flag on
        // push-on-full, but continues shifting. Safe if SSPIMSC_RORIM is not set.
        for (src) |s| {
            while (!spi.is_writable()) {
                util.tight_loop_contents();
            }
            spi_regs.SSPDR.write_raw(s);
        }
        // Drain RX FIFO, then wait for shifting to finish (which may be *after*
        // TX FIFO drains), then drain RX FIFO again
        while (spi.is_readable()) {
            _ = spi_regs.SSPDR.read();
        }
        while (spi_regs.SSPSR.read().BSY == 1) {
            util.tight_loop_contents();
        }
        while (spi.is_readable()) {
            _ = spi_regs.SSPDR.read();
        }
        // Don't leave overrun flag set
        peripherals.SPI0.SSPICR.modify(.{ .RORIC = 1 });
        return src.len;
    }

    /// Read len bytes directly from the SPI to dst.
    /// repeated_tx_data is output repeatedly on SO as data is read in from SI.
    /// Generally this can be 0, but some devices require a specific value here,
    /// e.g. SD cards expect 0xff
    pub fn read(spi: SPI, repeated_tx_data: u8, dst: []u8) usize {
        const spi_regs = spi.get_regs();
        const fifo_depth = 8;
        var rx_remaining = dst.len;
        var tx_remaining = dst.len;

        while (rx_remaining > 0 or tx_remaining > 0) {
            if (tx_remaining > 0 and spi.is_writable() and rx_remaining < tx_remaining + fifo_depth) {
                spi_regs.SSPDR.write_raw(repeated_tx_data);
                tx_remaining -= 1;
            }
            if (rx_remaining > 0 and spi.is_readable()) {
                const bytes = std.mem.asBytes(&spi_regs.SSPDR.read().DATA);
                dst[dst.len - rx_remaining] = bytes[0];
                rx_remaining -= 1;
            }
        }
        return dst.len;
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
