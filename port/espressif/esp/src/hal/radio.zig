const std = @import("std");
const Allocator = std.mem.Allocator;

const c = @import("esp-wifi-driver");
const microzig = @import("microzig");
const TrapFrame = microzig.cpu.TrapFrame;
const time = microzig.drivers.time;
const hal = microzig.hal;
const systimer = hal.systimer;
const peripherals = microzig.chip.peripherals;
const SYSTEM = peripherals.SYSTEM;
const RTC_CNTL = peripherals.RTC_CNTL;
const APB_CTRL = peripherals.APB_CTRL;

const efuse = @import("efuse.zig");
pub const bluetooth = @import("radio/bluetooth.zig");
const osi = @import("radio/osi.zig");
const timer = @import("radio/timer.zig");
pub const wifi = @import("radio/wifi.zig");
const Scheduler = @import("Scheduler.zig");

const log = std.log.scoped(.esp_radio);

pub const Options = struct {
    wifi_interrupt: microzig.cpu.Interrupt,

    wifi: wifi.Options = .{},
};

pub const options = microzig.options.hal.radio orelse
    @compileError("Please specify options if you want to use radio.");

// TODO: We should allow the user to select the scheduling algorithm. Maybe at
// compile time?

/// Radio uses the official esp drivers. You should enable interrupts
/// after/before this.
pub fn init(allocator: Allocator, scheduler: *Scheduler) Allocator.Error!void {
    // TODO: check that clock frequency is higher or equal to 80mhz

    {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        enable_wifi_power_domain_and_init_clocks();
        // phy_mem_init(); // only sets some global variable on esp32c3

        osi.allocator = allocator;
        osi.scheduler = scheduler;

        setup_interrupts();
    }

    log.debug("initialization complete", .{});

    // TODO: config
    wifi.c_result(c.esp_wifi_internal_set_log_level(c.WIFI_LOG_VERBOSE)) catch {
        log.warn("failed to set wifi internal log level", .{});
    };
}

// TODO
// should free everything
pub fn deinit() void {}

pub fn tick() void {
    timer.tick();
}

pub fn read_mac(iface: enum {
    sta,
    ap,
    bt,
}) [6]u8 {
    var mac = efuse.read_mac();
    switch (iface) {
        .sta => {},
        .ap => mac[5] += 1,
        .bt => mac[5] += 2,
    }
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

    microzig.cpu.interrupt.map(.wifi_mac, options.wifi_interrupt);
    microzig.cpu.interrupt.map(.wifi_pwr, options.wifi_interrupt);

    microzig.cpu.interrupt.set_type(options.wifi_interrupt, .level);
    microzig.cpu.interrupt.set_priority(options.wifi_interrupt, .highest);
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
};
