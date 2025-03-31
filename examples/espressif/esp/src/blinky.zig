const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const gpio = microzig.hal.gpio;
const uart = microzig.hal.uart;
const TIMG0 = peripherals.TIMG0;
const RTC_CNTL = peripherals.RTC_CNTL;

const dogfood: u32 = 0x50D83AA1;
const super_dogfood: u32 = 0x8F1D312A;

pub fn main() !void {
    // Feed and disable watchdog 0
    TIMG0.WDTWPROTECT.raw = dogfood;
    TIMG0.WDTCONFIG0.raw = 0;
    TIMG0.WDTWPROTECT.raw = 0;

    // Feed and disable rtc watchdog
    RTC_CNTL.WDTWPROTECT.raw = dogfood;
    RTC_CNTL.WDTCONFIG0.raw = 0;
    RTC_CNTL.WDTWPROTECT.raw = 0;

    // Feed and disable rtc super watchdog
    RTC_CNTL.SWD_WPROTECT.raw = super_dogfood;
    RTC_CNTL.SWD_CONF.modify(.{ .SWD_DISABLE = 1 });
    RTC_CNTL.SWD_WPROTECT.raw = 0;

    const led_pin = gpio.instance.num(8);
    led_pin.apply(.{
        .output_enable = true,
        .output_signal = .ledc_ls_sig_out0,
    });

    const clock_config = microzig.hal.clocks.Config.get_active();
    const div = clock_config.xtal_clk_freq / 800_000;

    // peripherals.SYSTEM.CLOCK_GATE.write();
    peripherals.SYSTEM.PERIP_CLK_EN0.modify(.{
        .LEDC_CLK_EN = 1,
    });
    peripherals.SYSTEM.PERIP_RST_EN0.modify(.{
        .LEDC_RST = 1,
    });

    peripherals.LEDC.CONF.modify(.{
        .APB_CLK_SEL = 1,
        .CLK_EN = 1,
    });

    const max_duty: u14 = std.math.maxInt(u14);
    peripherals.LEDC.LSTIMER0_CONF.modify(.{
        .LSTIMER0_DUTY_RES = 10,
        .CLK_DIV_LSTIMER0 = @as(u18, @intCast(div << 8)),
        .LSTIMER0_PAUSE = 0,
        .LSTIMER0_RST = 1,
        .LSTIMER0_PARA_UP = 1,
    });

    peripherals.LEDC.LSCH0_DUTY.write(.{
        .DUTY_LSCH0 = max_duty,
        .padding = 0,
    });

    peripherals.LEDC.LSCH0_CONF0.modify(.{
        .TIMER_SEL_LSCH0 = 0,
        .SIG_OUT_EN_LSCH0 = 0,
        .PARA_UP_LSCH0 = 1,
    });

    peripherals.LEDC.LSCH0_CONF1.modify(.{
        .DUTY_SCALE_LSCH0 = 1,
        .DUTY_START_LSCH0 = 1,
    });

    var buf: [16]u8 = undefined;
    while (true) {
        const n = std.fmt.formatIntBuf(&buf, peripherals.LEDC.LSCH0_DUTY_R.read().DUTY_LSCH0_R, 10, .lower, .{});
        uart.write(0, "value: ");
        uart.write(0, buf[0..n]);
        uart.write(0, "\n");
        microzig.hal.rom.ets_delay_us(1_000_000);
    }
}
