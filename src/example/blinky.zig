const std = @import("std");
const microzig = @import("microzig");

pub fn main() !void {
    // const led_r_mux = @ptrToInt(*volatile u32, IO_MUX_BASE + IO_MUX_GPIOn_REG(LED_R_PIN));
    // const led_g_mux = @ptrToInt(*volatile u32, IO_MUX_BASE + IO_MUX_GPIOn_REG(LED_G_PIN));
    // const led_b_mux = @ptrToInt(*volatile u32, IO_MUX_BASE + IO_MUX_GPIOn_REG(LED_B_PIN));

    // led_r_mux.* = 0x80;

    const gpio_out = @intToPtr(*volatile u32, GPIO_BASE + GPIO_OUT_REG);
    const gpio_ena = @intToPtr(*volatile u32, GPIO_BASE + GPIO_ENABLE_REG);
    gpio_ena.* = (1 << LED_R_PIN) | (1 << LED_G_PIN) | (1 << LED_B_PIN);
    gpio_out.* = (1 << LED_R_PIN) | (1 << LED_G_PIN) | (1 << LED_B_PIN);
}

const GPIO_BASE = 0x6000_4000;
const IO_MUX_BASE = 0x6000_9000;

const GPIO_OUT_REG = 0x0004;
const GPIO_ENABLE_REG = 0x0020;

fn GPIO_FUNCn_OUT_SEL_CFG_REG(comptime n: comptime_int) comptime_int {
    return 0x0554 + 4 * n;
}

const LED_R_PIN = 3;
const LED_G_PIN = 4;
const LED_B_PIN = 5;
