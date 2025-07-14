const std = @import("std");
const log = std.log.scoped(.esp_radio);
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
const TrapFrame = microzig.cpu.TrapFrame;
const time = microzig.drivers.time;
const hal = microzig.hal;
const systimer = hal.systimer;
const peripherals = microzig.chip.peripherals;
const SYSTEM = peripherals.SYSTEM;
const RTC_CNTL = peripherals.RTC_CNTL;
const APB_CTRL = peripherals.APB_CTRL;

const c = @import("esp-wifi-driver");

pub const wifi = @import("radio/wifi.zig");
pub const bluetooth = @import("radio/bluetooth.zig");

const osi = @import("radio/osi.zig");
const timer = @import("radio/timer.zig");
const multitasking = @import("radio/multitasking.zig");

/// You should enable interrupts after/before this.
pub fn init(allocator: Allocator) Allocator.Error!void {
    // TODO: check that clock frequency is higher or equal to 80mhz

    {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        enable_wifi_power_domain_and_init_clocks();
        // phy_mem_init(); // only sets some global variable on esp32c3

        osi.allocator = allocator;

        setup_timer_periodic_alarm();
        setup_interrupts();

        // TODO: errdefer deinit
        try multitasking.init(allocator);
        try timer.init(allocator);
    }

    multitasking.yield_task();

    log.debug("initialization complete", .{});

    // TODO: config
    wifi.c_result(c.esp_wifi_internal_set_log_level(c.WIFI_LOG_VERBOSE)) catch {
        log.warn("failed to set wifi internal log level", .{});
    };
}

// TODO: deinit

// TODO: maybe this can be moved in an efuse hal
pub fn read_mac() [6]u8 {
    const EFUSE = microzig.chip.peripherals.EFUSE;

    var mac: [6]u8 = undefined;

    const low_32_bits: u32 = EFUSE.RD_MAC_SPI_SYS_0.read().MAC_0;
    const high_16_bits: u16 = EFUSE.RD_MAC_SPI_SYS_1.read().MAC_1;
    @memcpy(mac[0..4], std.mem.asBytes(&low_32_bits));
    @memcpy(mac[4..6], std.mem.asBytes(&high_16_bits));

    return mac;
}

fn enable_wifi_power_domain_and_init_clocks() void {
    const system_wifibb_rst: u32 = 1 << 0;
    const system_fe_rst: u32 = 1 << 1;
    const system_wifimac_rst: u32 = 1 << 2;
    const system_btbb_rst: u32 = 1 << 3; // bluetooth baseband
    const system_btmac_rst: u32 = 1 << 4; // deprecated
    const system_rw_btmac_rst: u32 = 1 << 9; // bluetooth mac
    const system_rw_btmac_reg_rst: u32 = 1 << 11; // bluetooth mac registers
    const system_btbb_reg_rst: u32 = 1 << 13; // bluetooth baseband registers

    const modem_reset_field_when_pu: u32 = system_wifibb_rst |
        system_fe_rst |
        system_wifimac_rst |
        system_btbb_rst |
        system_btmac_rst |
        system_rw_btmac_rst |
        system_rw_btmac_reg_rst |
        system_btbb_reg_rst;

    RTC_CNTL.DIG_PWC.modify(.{
        .WIFI_FORCE_PD = 0,
        .BT_FORCE_PD = 0,
    });

    APB_CTRL.WIFI_RST_EN.write(.{ .WIFI_RST = APB_CTRL.WIFI_RST_EN.read().WIFI_RST | modem_reset_field_when_pu });
    APB_CTRL.WIFI_RST_EN.write(.{ .WIFI_RST = APB_CTRL.WIFI_RST_EN.read().WIFI_RST & ~modem_reset_field_when_pu });

    RTC_CNTL.DIG_ISO.modify(.{
        .WIFI_FORCE_ISO = 0,
        .BT_FORCE_ISO = 0,
    });

    const system_wifi_clk_i2c_clk_en: u32 = 1 << 5;
    const system_wifi_clk_unused_bit12: u32 = 1 << 12;
    const wifi_bt_sdio_clk: u32 = system_wifi_clk_i2c_clk_en | system_wifi_clk_unused_bit12;
    const system_wifi_clk_en: u32 = 0x00FB9FCF;

    RTC_CNTL.DIG_ISO.modify(.{
        .WIFI_FORCE_ISO = 0,
        .BT_FORCE_ISO = 0,
    });

    RTC_CNTL.DIG_PWC.modify(.{
        .WIFI_FORCE_PD = 0,
        .BT_FORCE_PD = 0,
    });

    APB_CTRL.WIFI_CLK_EN.write(.{
        .WIFI_CLK_EN = APB_CTRL.WIFI_CLK_EN.read().WIFI_CLK_EN &
            ~wifi_bt_sdio_clk |
            system_wifi_clk_en,
    });
}

fn setup_interrupts() void {
    // TODO: which interrupts are used should be configurable.

    microzig.cpu.interrupt.set_priority_threshold(.zero);

    microzig.cpu.interrupt.map(.wifi_mac, .interrupt1);
    microzig.cpu.interrupt.map(.wifi_pwr, .interrupt1);
    microzig.cpu.interrupt.map(.systimer_target0, .interrupt2);
    microzig.cpu.interrupt.map(.from_cpu_intr0, .interrupt3);

    inline for (&.{ .interrupt1, .interrupt2, .interrupt3 }) |int| {
        microzig.cpu.interrupt.set_type(int, .level);
        microzig.cpu.interrupt.set_priority(int, .lowest);
    }

    inline for (&.{ .interrupt2, .interrupt3 }) |int| {
        microzig.cpu.interrupt.enable(int);
    }
}

// TODO: config (even other timers)
const timer_alarm: systimer.Alarm = .alarm0;
const preemt_interval: time.Duration = .from_ms(10);

fn setup_timer_periodic_alarm() void {
    // unit0 is already enabled as it is used by `hal.time`.
    timer_alarm.set_unit(.unit0);

    // sets the period to one second.
    timer_alarm.set_period(@intCast(preemt_interval.to_us() * systimer.ticks_per_us()));

    // to enable period mode you have to first clear the mode bit.
    timer_alarm.set_mode(.target);
    timer_alarm.set_mode(.period);

    timer_alarm.set_interrupt_enabled(true);
    timer_alarm.set_enabled(true);
}

pub const interrupt_handlers = struct {
    pub fn wifi_xxx(_: *TrapFrame) linksection(".ram_text") callconv(.c) void {
        const handler = osi.wifi_interrupt_handler;

        log.debug("interrupt WIFI_xxx {} {?}", .{
            handler.f,
            handler.arg,
        });

        handler.f(handler.arg);
    }

    pub fn timer(trap_frame: *TrapFrame) linksection(".ram_text") callconv(.c) void {
        timer_alarm.clear_interrupt();

        multitasking.switch_task(trap_frame);
    }

    pub fn software(trap_frame: *TrapFrame) linksection(".ram_text") callconv(.c) void {
        // TODO: config
        SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
            .CPU_INTR_FROM_CPU_0 = 0,
        });

        multitasking.switch_task(trap_frame);
    }
};
