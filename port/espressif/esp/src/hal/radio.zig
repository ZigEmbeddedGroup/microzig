/// ESP Wi-Fi drivers integration.
///
/// Based on https://github.com/esp-rs/esp-hal/tree/main/esp-radio.

const builtin = @import("builtin");
const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

const c = @import("esp-wifi-driver");
const microzig = @import("microzig");
const TrapFrame = microzig.cpu.TrapFrame;
const peripherals = microzig.chip.peripherals;
const RTC_CNTL = peripherals.RTC_CNTL;
const APB_CTRL = peripherals.APB_CTRL;

const efuse = @import("efuse.zig");
pub const bluetooth = @import("radio/bluetooth.zig");
const osi = @import("radio/osi.zig");
const timer = @import("radio/timer.zig");
pub const wifi = @import("radio/wifi.zig");

const log = std.log.scoped(.esp_radio);

pub const Options = struct {
    interrupt: microzig.cpu.Interrupt = .interrupt29,
    wifi: wifi.Options = .{},
};

var refcount: std.atomic.Value(usize) = .init(0);

pub fn init(gpa: Allocator) Allocator.Error!void {
    // TODO: check that clock frequency is higher or equal to 80mhz

    const radio_interrupt = microzig.options.hal.radio.interrupt;

    comptime {
        if (!microzig.options.hal.rtos.enable)
            @compileError("radio requires the rtos option to be enabled");

        microzig.cpu.interrupt.expect_handler(radio_interrupt, interrupt_handler);

        osi.export_symbols();
    }

    if (refcount.rmw(.Add, 1, .monotonic) > 0) {
        return;
    }

    try timer.init(gpa);

    {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        enable_wifi_power_domain_and_init_clocks();
        // phy_mem_init(); // only sets some global variable on esp32c3

        osi.gpa = gpa;

        microzig.cpu.interrupt.map(.wifi_mac, radio_interrupt);
        microzig.cpu.interrupt.map(.wifi_pwr, radio_interrupt);
        microzig.cpu.interrupt.set_type(radio_interrupt, .level);
        microzig.cpu.interrupt.set_priority(radio_interrupt, .highest);
    }

    log.debug("initialization complete", .{});

    const internal_wifi_log_level = switch (builtin.mode) {
        .Debug => c.WIFI_LOG_VERBOSE,
        else => c.WIFI_LOG_NONE,
    };
    wifi.c_err(c.esp_wifi_internal_set_log_level(internal_wifi_log_level)) catch {
        log.warn("failed to set wifi internal log level", .{});
    };
}

pub fn deinit() void {
    const prev_count = refcount.rmw(.Sub, 1, .monotonic);
    assert(prev_count != 0);
    if (prev_count != 1) {
        return;
    }

    timer.deinit();
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

pub const interrupt_handler: microzig.cpu.InterruptHandler = .{
    .c = struct {
        fn handler_fn(_: *TrapFrame) linksection(".ram_text") callconv(.c) void {
            const status: microzig.cpu.interrupt.Status = .init();
            if (status.is_set(.wifi_mac) or status.is_set(.wifi_pwr)) {
                if (osi.wifi_interrupt_handler) |handler| {
                    handler.f(handler.arg);
                } else {
                    // should be unreachable
                }
            }
        }
    }.handler_fn,
};
