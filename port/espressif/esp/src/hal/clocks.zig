const microzig = @import("microzig");

pub const Source = union(enum) {
    pub const PllFreq = enum {
        @"80mhz",
        @"160mhz",
    };

    pll_clk: PllFreq,
    xtal_clk: u10,
};

pub const Config = struct {
    cpu_clk_freq: u32,
    xtal_clk_freq: u32,
    apb_clk_freq: u32,

    pub fn init(cpu_clk_source: Source) Config {
        const xtal_clk_freq: u32 = 40_000_000;
        const cpu_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => |pll_freq| switch (pll_freq) {
                .@"80mhz" => 80_000_000,
                .@"160mhz" => 160_000_000,
            },
            .xtal_clk => |div| xtal_clk_freq / div,
        };

        const apb_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => 80_000_000,
            .xtal_clk => cpu_clk_freq,
        };

        return .{
            .cpu_clk_freq = cpu_clk_freq,
            .xtal_clk_freq = xtal_clk_freq,
            .apb_clk_freq = apb_clk_freq,
        };
    }
};
