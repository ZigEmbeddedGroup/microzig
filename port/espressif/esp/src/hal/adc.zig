const microzig = @import("microzig");
const APB_SARADC = microzig.chip.peripherals.APB_SARADC;

const clocks = @import("clocks.zig");
const time = @import("time.zig");
const system = @import("system.zig");

const Channel = u4;

pub const Attenuation = enum(u2) {
    @"0dB" = 0b00,
    @"2.5dB" = 0b01,
    @"6dB" = 0b10,
    @"12dB" = 0b11,
};

pub fn num(n: u1) ADC {
    return @enumFromInt(n);
}

pub const ADC = enum(u1) {
    adc1,
    adc2,

    pub const Config = union(enum) {
        oneshot,
    };

    pub fn apply(_: ADC) void {
        system.enable_clocks_and_release_reset(.{ .apb_saradc = true });
    }

    pub fn read_oneshot(instance: ADC, clock_config: clocks.Config, channel: Channel, attenuation: Attenuation) u16 {
        APB_SARADC.CLKM_CONF.modify(.{
            .CLK_SEL = 2, // APB clock
        });

        APB_SARADC.CTRL.modify(.{
            .SARADC_SAR_CLK_GATED = 1,
        });

        APB_SARADC.CLKM_CONF.modify(.{
            .CLKM_DIV_NUM = 15,
            .CLKM_DIV_B = 1,
            .CLKM_DIV_A = 0,
        });

        APB_SARADC.CTRL.modify(.{
            .SARADC_SAR_CLK_DIV = 2,
        });

        APB_SARADC.INT_ENA.modify(.{
            .APB_SARADC1_DONE_INT_ENA = instance == .adc1,
            .APB_SARADC2_DONE_INT_ENA = instance == .adc2,
        });

        APB_SARADC.INT_CLR.modify(.{
            .APB_SARADC1_DONE_INT_CLR = instance == .adc1,
            .APB_SARADC2_DONE_INT_CLR = instance == .adc2,
        });

        const adc_ctrl_clk = clock_config.apb_clk_freq / (15 + 0 / 1 + 1);
        const sample_delay_us = (1_000_000 / adc_ctrl_clk + 1) * 3;

        APB_SARADC.ONETIME_SAMPLE.modify(.{
            .SARADC1_ONETIME_SAMPLE = instance == .adc1,
            .SARADC2_ONETIME_SAMPLE = instance == .adc2,
            .SARADC_ONETIME_CHANNEL = channel,
            .SARADC_ONETIME_ATTEN = @intFromEnum(attenuation),
        });

        APB_SARADC.ONETIME_SAMPLE.modify(.{
            .SARADC_ONETIME_START = 0,
        });

        time.sleep_us(sample_delay_us);

        APB_SARADC.ONETIME_SAMPLE.modify(.{
            .SARADC_ONETIME_START = 1,
        });

        switch (instance) {
            .adc1 => while (APB_SARADC.INT_RAW.read().APB_SARADC1_DONE_INT_RAW != 1) {},
            .adc2 => while (APB_SARADC.INT_RAW.read().APB_SARADC2_DONE_INT_RAW != 1) {},
        }

        APB_SARADC.INT_CLR.modify(.{
            .APB_SARADC1_DONE_INT_CLR = 1,
        });
    }
};
