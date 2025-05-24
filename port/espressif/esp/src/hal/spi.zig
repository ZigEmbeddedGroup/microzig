const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const system = hal.system;

const SPI_Regs = microzig.chip.types.peripherals.SPI2;

pub const SPI = enum(u2) {
    spi2,

    inline fn get_regs(self: SPI) *volatile SPI_Regs {
        return switch (self) {
            .spi2 => microzig.chip.peripherals.SPI2,
        };
    }

    pub const Config = struct {
        clock_config: hal.clocks.Config,
        baud_rate: u32,

        fn validate(self: Config) !void {
            const source_freq = self.clock_config.apb_clk_freq;
            const min_divider = 1;
            const max_divider = 16 * 64;

            if (self.baud_rate < source_freq / max_divider or self.baud_rate > source_freq / min_divider) {
                return error.InvalidFrequency;
            }
        }

        fn calculate_reg(self: Config) u32 {
            const source_freq = self.clock_config.apb_clk_freq;
            const duty_cycle = 128;

            // Use APB directly if target frequency is high enough
            if (self.baud_rate > ((source_freq / 4) * 3)) {
                return 1 << 31;
            }

            var bestn: i32 = -1;
            var bestpre: i32 = -1;
            var besterr: i32 = 0;

            const target_freq_hz: i32 = @intCast(self.baud_rate);
            const source_freq_hz: i32 = @intCast(source_freq);

            // Try all n values from 2 to 64
            var n: i32 = 2;
            while (n <= 64) : (n += 1) {
                var pre = @divTrunc((source_freq_hz / n) + (target_freq_hz / 2), target_freq_hz);
                if (pre <= 0) pre = 1;
                if (pre > 16) pre = 16;

                const real_freq = source_freq_hz / (pre * n);
                const errval = @abs(real_freq - target_freq_hz);

                if (bestn == -1 or errval <= besterr) {
                    besterr = errval;
                    bestn = n;
                    bestpre = pre;
                }
            }

            const l: i32 = bestn;
            var h: i32 = (duty_cycle * bestn + 127) / 256;
            if (h <= 0) h = 1;

            return @as(u32, @intCast(l - 1)) | (@as(u32, @intCast(h - 1)) << 6) |
                (@as(u32, @intCast(bestn - 1)) << 12) | (@as(u32, @intCast(bestpre - 1)) << 18);
        }
    };

    pub fn apply(self: SPI, comptime config: Config) void {
        comptime config.validate() catch @compileError("Invalid clock frequency");

        system.clocks_enable_set(.{
            .spi2 = true,
        });
        system.peripheral_reset(.{
            .spi2 = true,
        });

        const regs = self.get_regs();

        regs.USER.modify(.{
            .DOUTDIN = 1,
            .USR_MISO_HIGHPART = 0,
            .USR_MOSI_HIGHPART = 0,
            .USR_MISO = 1,
            .USR_MOSI = 1,
            .CS_HOLD = 0,
            .USR_DUMMY_IDLE = 1,
            .USR_ADDR = 0,
            .USR_COMMAND = 0,
        });

        regs.MISC.write_raw(0);

        regs.SLAVE.write_raw(0);

        regs.CLOCK.write_raw(config.calculate_reg());
    }

    pub const BitOrder = enum {
        lsb_first,
        msb_first,
    };
};
