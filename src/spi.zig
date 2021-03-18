const mmio = @import("rk2040.zig");

pub const SPIConfig = struct {
    baudrate: u32,
    data_bits: DataBits = .D8,
    clock_polarity: Polariy = .IdleHigh,
    enable_dma: bool = false,

    const DataBits = enum {
        D8 = 8 - 1,
    };

    const Polariy = enum {
        IdleHigh, IdleLow
    };
};

fn reset(comptime index: u1) void {
    // TODO: handle spi1
    mmio.RESETS.RESET.set(.{ .spi0 = true });
    mmio.RESETS.RESET.set(.{ .spi0 = false });

    while (true) {
        const v = mmio.RESETS.RESET_DONE.read();
        if (v.spi0)
            break;
    }
}

// TODO: handle baudrate
pub fn SPI(comptime index: u1) type {
    return struct {
        const SPI_MMIO = switch (index) {
            0 => mmio.SPI0,
            1 => mmio.SPI1,
        };
        pub fn init(comptime config: SPIConfig) void {
            reset();

            SPI_MMIO.SSPCPSR.set(.{ .CPSDVSR = 2 });
            SPI_MMIO.SSPCR0.set(.{
                .SCR = 0, // with CPSDVSR is used to divide the SSPCLK
                .DSS = @enumToInt(config.data_bits),
                .SPO = config.clock_polarity == .IdleHigh,
            });
            SPI_MMIO.SSPCR1.set(.{ .SSE = true });

            if (config.enable_dma)
                SPI_MMIO.SSPDMACR.set(.{ .TXDMAE = true });
        }

        pub fn set_baudrate(baudrate: u32) void {
            // TODO:
        }

        pub fn set_clock_polarity(polarity: SPIConfig.Polariy) void {
            SPI_MMIO.SSPCR0.set(.{
                .SPO = clock_polarity == .IdleHigh,
            });
        }

        pub fn set_data_bits(data_bits: SPIConfig.DataBits) void {
            SPI_MMIO.SSPCR0.set(.{
                .DSS = @enumToInt(data_bits),
            });
        }

        pub fn write(data: u16) callconv(.Inline) void {
            while (SPI_MMIO.SSPSR.read().BSY) {
                asm volatile ("nop");
            }
            SPI_MMIO.SSPDR.set(.{ .DATA = data });
        }

        pub fn read() callconv(.Inline) u32 {
            return SPI_MMIO.SSPDR.get().DATA;
        }
    };
}

pub const SPI0 = SPI(0);
pub const SPI1 = SPI(1);
