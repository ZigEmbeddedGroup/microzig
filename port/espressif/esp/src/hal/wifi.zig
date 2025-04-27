const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const RTC_CNTL = peripherals.RTC_CNTL;
const APB_CTRL = peripherals.APB_CTRL;

const c = @import("wifi-driver-c");

// based on the rust crate esp-wifi: https://github.com/esp-rs/esp-hal/blob/main/esp-wifi

pub fn enable_wifi_power_domain() void {
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
    });

    APB_CTRL.WIFI_RST_EN.write(APB_CTRL.WIFI_RST_EN.raw | modem_reset_field_when_pu);
    APB_CTRL.WIFI_RST_EN.write(APB_CTRL.WIFI_RST_EN.raw & ~modem_reset_field_when_pu);

    RTC_CNTL.DIG_ISO.modify(.{
        .WIFI_FORCE_ISO = 0,
    });
}

pub fn init() void {
    // TODO: check that clock frequency is higher or equal to 80mhz

    enable_wifi_power_domain();

    // phy_mem_init();

    // setup scheduler
}

pub const interrupt_handlers = struct {
    const TrapFrame = microzig.cpu.InterruptStack;

    pub fn wifi_mac(_: *TrapFrame) callconv(.c) void {
        // TODO: call driver set handler
    }

    pub fn wifi_pwr(_: *TrapFrame) callconv(.c) void {
        // TODO: call driver set handler
    }

    pub fn timer(_: *TrapFrame) callconv(.c) void {
        // TODO: clear interrupt

        // TODO: switch task
    }

    pub fn software(_: *TrapFrame) callconv(.c) void {
    }
};
