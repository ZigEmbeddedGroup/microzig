// System on Chip (SoC) library - flash, power, clock, RNG, encryption, radio timeslot.

const svc = @import("svc.zig");
const err = @import("err.zig");
const Error = err.Error;

// SVC bases
const SOC_SVC_BASE = 0x20;
const SOC_SVC_BASE_NOT_AVAILABLE = 0x2C;

pub const ecb_key_length = 16;
pub const ecb_cleartext_length = 16;
pub const ecb_ciphertext_length = 16;

pub const PowerMode = enum(u8) {
    const_lat = 0,
    low_pwr = 1,
};

pub const PowerThreshold = enum(u8) {
    v17 = 4,
    v21 = 5,
    v23 = 6,
    v25 = 7,
    v27 = 8,
    v28 = 15,
    _,
};

pub const PowerThresholdVddh = enum(u8) {
    v27 = 0,
    v28 = 1,
    v29 = 2,
    v30 = 3,
    v31 = 4,
    v32 = 5,
    v33 = 6,
    v34 = 7,
    v35 = 8,
    v36 = 9,
    v37 = 10,
    v38 = 11,
    v39 = 12,
    v40 = 13,
    v41 = 14,
    v42 = 15,
};

pub const DcdcMode = enum(u8) {
    disable = 0,
    enable = 1,
};

pub const RadioNotificationDistance = enum(u8) {
    none = 0,
    @"800us" = 1,
    @"1740us" = 2,
    @"2680us" = 3,
    @"3620us" = 4,
    @"4560us" = 5,
    @"5500us" = 6,
};

pub const RadioNotificationType = enum(u8) {
    none = 0,
    int_on_active = 1,
    int_on_inactive = 2,
    int_on_both = 3,
};

pub const RadioHfclkCfg = enum(u8) {
    xtal_guaranteed = 0,
    no_guarantee = 1,
};

pub const RadioPriority = enum(u8) {
    high = 0,
    normal = 1,
};

pub const RadioRequestType = enum(u8) {
    earliest = 0,
    normal = 1,
};

pub const RadioSignalCallbackAction = enum(u8) {
    none = 0,
    extend = 1,
    end_ = 2,
    request_and_end = 3,
};

pub const RadioCallbackSignalType = enum(u8) {
    start = 0,
    timer0 = 1,
    radio = 2,
    extend_failed = 3,
    extend_succeeded = 4,
};

pub const RadioRequestEarliest = extern struct {
    hfclk: RadioHfclkCfg,
    priority: RadioPriority,
    length_us: u32,
    timeout_us: u32,
};

pub const RadioRequestNormal = extern struct {
    hfclk: RadioHfclkCfg,
    priority: RadioPriority,
    distance_us: u32,
    length_us: u32,
};

pub const RadioRequest = extern struct {
    request_type: RadioRequestType,
    params: extern union {
        earliest: RadioRequestEarliest,
        normal: RadioRequestNormal,
    },
};

pub const RadioSignalCallbackReturnParam = extern struct {
    callback_action: RadioSignalCallbackAction,
    params: extern union {
        request: RadioRequest,
        extend_us: u32,
    },
};

pub const RadioSignalCallback = *const fn (signal_type: RadioCallbackSignalType) callconv(.c) *RadioSignalCallbackReturnParam;

pub const EcbData = extern struct {
    key: [ecb_key_length]u8,
    cleartext: [ecb_cleartext_length]u8,
    ciphertext: [ecb_ciphertext_length]u8,
};

pub const EcbDataBlock = extern struct {
    p_key: *const [ecb_key_length]u8,
    p_cleartext: *const [ecb_cleartext_length]u8,
    p_ciphertext: *[ecb_ciphertext_length]u8,
};

pub const SocEvt = enum(u32) {
    hfclk_started = 0,
    power_failure_warning = 1,
    flash_operation_success = 2,
    flash_operation_error = 3,
    radio_blocked = 4,
    radio_canceled = 5,
    radio_signal_callback_invalid_return = 6,
    radio_session_idle = 7,
    radio_session_closed = 8,
    power_usb_power_ready = 9,
    power_usb_detected = 10,
    power_usb_removed = 11,
    _,
};

// --- PPI functions (available when SD is disabled too) ---

pub fn ppi_channel_enable_get(p_channel_enable: *u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE + 0, @intFromPtr(p_channel_enable)));
}

pub fn ppi_channel_enable_set(channel_enable_set_msk: u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE + 1, channel_enable_set_msk));
}

pub fn ppi_channel_enable_clr(channel_enable_clr_msk: u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE + 2, channel_enable_clr_msk));
}

pub fn ppi_channel_assign(channel_num: u8, evt_endpoint: u32, task_endpoint: u32) Error!void {
    return err.check(svc.svcall3(SOC_SVC_BASE + 3, channel_num, evt_endpoint, task_endpoint));
}

pub fn ppi_group_task_enable(group_num: u8) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE + 4, group_num));
}

pub fn ppi_group_task_disable(group_num: u8) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE + 5, group_num));
}

pub fn ppi_group_assign(group_num: u8, channel_msk: u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE + 6, group_num, channel_msk));
}

pub fn ppi_group_get(group_num: u8, p_channel_msk: *u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE + 7, group_num, @intFromPtr(p_channel_msk)));
}

// --- Flash functions ---

pub fn flash_page_erase(page_number: u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE + 8, page_number));
}

pub fn flash_write(p_dst: *u32, p_src: *const u32, size: u32) Error!void {
    return err.check(svc.svcall3(SOC_SVC_BASE + 9, @intFromPtr(p_dst), @intFromPtr(p_src), size));
}

// --- Functions requiring SoftDevice to be enabled ---

pub fn mutex_new(p_mutex: *u8) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 0, @intFromPtr(p_mutex)));
}

pub fn mutex_acquire(p_mutex: *u8) Error!bool {
    const ret = svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 1, @intFromPtr(p_mutex));
    if (ret == 0) return true; // acquired
    if (ret == 0x2000) return false; // already taken
    return err.from_code(ret);
}

pub fn mutex_release(p_mutex: *u8) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 2, @intFromPtr(p_mutex)));
}

pub fn rand_application_pool_capacity_get(p_pool_capacity: *u8) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 3, @intFromPtr(p_pool_capacity)));
}

pub fn rand_application_bytes_available_get(p_bytes_available: *u8) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 4, @intFromPtr(p_bytes_available)));
}

pub fn rand_application_vector_get(p_buff: [*]u8, length: u8) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 5, @intFromPtr(p_buff), length));
}

pub fn power_mode_set(power_mode: PowerMode) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 6, @intFromEnum(power_mode)));
}

pub fn power_system_off() Error!void {
    return err.check(svc.svcall0(SOC_SVC_BASE_NOT_AVAILABLE + 7));
}

pub fn power_reset_reason_get(p_reset_reason: *u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 8, @intFromPtr(p_reset_reason)));
}

pub fn power_reset_reason_clr(reset_reason_clr_msk: u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 9, reset_reason_clr_msk));
}

pub fn power_pof_enable(pof_enable: bool) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 10, @intFromBool(pof_enable)));
}

pub fn power_pof_threshold_set(threshold: PowerThreshold) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 11, @intFromEnum(threshold)));
}

pub fn power_pof_thresholdvddh_set(threshold: PowerThresholdVddh) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 12, @intFromEnum(threshold)));
}

pub fn power_ram_power_set(index: u8, ram_powerset: u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 13, index, ram_powerset));
}

pub fn power_ram_power_clr(index: u8, ram_powerclr: u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 14, index, ram_powerclr));
}

pub fn power_ram_power_get(index: u8, p_ram_power: *u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 15, index, @intFromPtr(p_ram_power)));
}

pub fn power_gpregret_set(gpregret_id: u32, gpregret_msk: u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 16, gpregret_id, gpregret_msk));
}

pub fn power_gpregret_clr(gpregret_id: u32, gpregret_msk: u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 17, gpregret_id, gpregret_msk));
}

pub fn power_gpregret_get(gpregret_id: u32, p_gpregret: *u32) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 18, gpregret_id, @intFromPtr(p_gpregret)));
}

pub fn power_dcdc_mode_set(dcdc_mode: DcdcMode) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 19, @intFromEnum(dcdc_mode)));
}

pub fn power_dcdc0_mode_set(dcdc_mode: DcdcMode) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 20, @intFromEnum(dcdc_mode)));
}

pub fn app_evt_wait() Error!void {
    return err.check(svc.svcall0(SOC_SVC_BASE_NOT_AVAILABLE + 21));
}

pub fn clock_hfclk_request() Error!void {
    return err.check(svc.svcall0(SOC_SVC_BASE_NOT_AVAILABLE + 22));
}

pub fn clock_hfclk_release() Error!void {
    return err.check(svc.svcall0(SOC_SVC_BASE_NOT_AVAILABLE + 23));
}

pub fn clock_hfclk_is_running(p_is_running: *u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 24, @intFromPtr(p_is_running)));
}

pub fn radio_notification_cfg_set(type_: RadioNotificationType, distance: RadioNotificationDistance) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 25, @intFromEnum(type_), @intFromEnum(distance)));
}

pub fn ecb_block_encrypt(p_ecb_data: *EcbData) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 26, @intFromPtr(p_ecb_data)));
}

pub fn ecb_blocks_encrypt(ecb_block_count: u8, p_data_blocks: [*]EcbDataBlock) Error!void {
    return err.check(svc.svcall2(SOC_SVC_BASE_NOT_AVAILABLE + 27, ecb_block_count, @intFromPtr(p_data_blocks)));
}

pub fn radio_session_open(p_radio_signal_callback: RadioSignalCallback) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 28, @intFromPtr(p_radio_signal_callback)));
}

pub fn radio_session_close() Error!void {
    return err.check(svc.svcall0(SOC_SVC_BASE_NOT_AVAILABLE + 29));
}

pub fn radio_request(p_request: *const RadioRequest) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 30, @intFromPtr(p_request)));
}

pub fn evt_get(p_evt_id: *u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 31, @intFromPtr(p_evt_id)));
}

pub fn temp_get(p_temp: *i32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 32, @intFromPtr(p_temp)));
}

pub fn power_usbpwrrdy_enable(enable: bool) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 33, @intFromBool(enable)));
}

pub fn power_usbdetected_enable(enable: bool) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 34, @intFromBool(enable)));
}

pub fn power_usbremoved_enable(enable: bool) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 35, @intFromBool(enable)));
}

pub fn power_usbregstatus_get(p_usbregstatus: *u32) Error!void {
    return err.check(svc.svcall1(SOC_SVC_BASE_NOT_AVAILABLE + 36, @intFromPtr(p_usbregstatus)));
}
