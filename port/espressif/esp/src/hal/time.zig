const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const TIMER = microzig.chip.peripherals.TIMG0;

const TICKS_PER_US = 2;

// TODO: Update APB freq function?
// void iram_attr esp_timer_impl_update_apb_freq(uint32_t apb_ticks_per_us)
// {
//     portenter_critical_safe(&s_time_update_lock);
//     assert(apb_ticks_per_us >= 3 && "divider value too low");
//     assert(apb_ticks_per_us % ticks_per_us == 0 && "apb frequency (in mhz) should be divisible by tick_per_us");
//     reg_set_field(config_reg, timg_lact_divider, apb_ticks_per_us / ticks_per_us);
//     portexit_critical_safe(&s_time_update_lock);
// }
fn update_apb_freq(ticks_per_us: 32) void {
    //     portenter_critical_safe(&s_time_update_lock);
    //     assert(apb_ticks_per_us >= 3 && "divider value too low");
    //     assert(apb_ticks_per_us % ticks_per_us == 0 && "apb frequency (in mhz) should be divisible by tick_per_us");
    //     reg_set_field(config_reg, timg_lact_divider, apb_ticks_per_us / ticks_per_us);
    //     portexit_critical_safe(&s_time_update_lock);
}

// TODO: Set timer function?
// void esp_timer_impl_set(uint64_t new_us)
// {
//     portENTER_CRITICAL(&s_time_update_lock);
//     timer_64b_reg_t dst = { .val = new_us * TICKS_PER_US };
//     REG_WRITE(LOAD_LO_REG, dst.lo);
//     REG_WRITE(LOAD_HI_REG, dst.hi);
//     REG_WRITE(LOAD_REG, 1);
//     portEXIT_CRITICAL(&s_time_update_lock);
// }

// esp_err_t esp_timer_impl_early_init(void)
fn early_init() void {
    // PERIPH_RCC_ACQUIRE_ATOMIC(PERIPH_LACT, ref_count) {
    //     if (ref_count == 0) {
    //         timer_ll_enable_bus_clock(LACT_MODULE, true);
    //         timer_ll_reset_register(LACT_MODULE);
    //     }
    // }

    // REG_WRITE(CONFIG_REG, 0);
    TIMER.T0CONFIG.write(0);
    // REG_WRITE(LOAD_LO_REG, 0);
    TIMER.T0LO.write(0);
    // REG_WRITE(LOAD_HI_REG, 0);
    TIMER.T0HI.write(0);
    // REG_WRITE(ALARM_LO_REG, UINT32_MAX);
    TIMER.T0ALARMLO.write(std.math.maxInt());
    // REG_WRITE(ALARM_HI_REG, UINT32_MAX);
    TIMER.T0ALARMHI.write(std.math.maxInt());
    // REG_WRITE(LOAD_REG, 1);
    TIMER.T0LOAD.write(1);
    // REG_SET_BIT(INT_CLR_REG, TIMG_LACT_INT_CLR);
    // REG_SET_FIELD(CONFIG_REG, TIMG_LACT_DIVIDER, APB_CLK_FREQ / 1000000 / TICKS_PER_US);
    // REG_SET_BIT(CONFIG_REG, TIMG_LACT_INCREASE |
    //             TIMG_LACT_LEVEL_INT_EN |
    //             TIMG_LACT_EN);

    return;
}

fn get_time() u64 {
    // Notes:
    // TIMG0 based 0x6001f000
    // * Confguration as simple clock:
    //   * Select clock source by setting or clearing TIMG_T0_USE_XTAL
    //   * Configure 16-bit prescale TIMEG_T0_DIVIDER
    //   * Cofingure timer direction TIMG_T0_INCREASE
    //   * (Set starting value)
    //   * Start the timer
    //     * TIMG_TO_EN TIMER.T0CONFIG.modify(.{.T0_EN = 1});
    //   * Read value: write to T0UPDATE
    //   * Wait until it's cleared
    //   * Read latched values from T0LO & T0Hi
    var low_word_start = TIMER.T0LO.read().T0_LO;
    var low_word = low_word_start;
    var high_word = TIMER.T0HI.read().T0_HI;

    // Latch values
    TIMER.T0UPDATE.modify(.{ .T0_UPDATE = 1 });
    //  Wait until it's cleared
    //  This is what's suggested by the datasheet
    while (TIMER.T0UPDATE.read().T0_UPDATE != 0) {}
    // This is how it's done in idf https://github.com/espressif/esp-idf/blob/master/components/esp_timer/src/esp_timer_impl_lac.c#L109
    // Poll low part of counter until it changes, or a timeout expires.
    // var div = TIMER.T0CONFIG.read().T0_DIVIDER;
    // while (low_word == low_word_start and ((div - 1) > 0)) {
    //     div -= 1;
    //     low_word = TIMER.T0LO.read().T0_LO;
    // }

    // Since this can be interrupted, verify registers are consistent. Reread
    // both registers until we get two consistent readings on the low word.
    return while (true) {
        low_word_start = low_word;
        high_word = TIMER.T0HI.read().T0_HI;
        low_word = TIMER.T0LO.read().T0_LO;
        if (low_word_start == low_word)
            break @as(u64, @intCast(high_word)) << 32 | low_word;
    } else unreachable;
}

pub fn get_time_since_boot() time.Absolute {
    return @enumFromInt(get_time() / TICKS_PER_US);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
