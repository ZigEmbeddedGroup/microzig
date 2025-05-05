const std = @import("std");
const log = std.log.scoped(.esp_radio_wifi);

const microzig = @import("microzig");

const osi = @import("interface.zig").osi;

const c = @import("esp-wifi-driver");

pub const InternalError = error{InternalError};

var inited: bool = false;

const InitError = InternalError;

pub fn init() InternalError!void {
    init_config.wpa_crypto_funcs = c.g_wifi_default_wpa_crypto_funcs;

    // TODO: if coex enabled
    if (false) try c_result(c.coex_init());

    try c_result(c.esp_wifi_init_internal(&init_config));
    try c_result(c.esp_wifi_set_mode(c.WIFI_MODE_NULL));
    try c_result(c.esp_supplicant_init());

    try c_result(c.esp_wifi_set_tx_done_cb(tx_done_cb));

    try c_result(c.esp_wifi_internal_reg_rxcb(c.ESP_IF_WIFI_STA, recv_cb_sta));
    try c_result(c.esp_wifi_internal_reg_rxcb(c.ESP_IF_WIFI_AP, recv_cb_ap));

    {
        // TODO: config
        const country_code: [3]u8 = .{ 'C', 'N', 0 };
        const country: c.wifi_country_t = .{
            .cc = country_code,
            .schan = 1,
            .nchan = 13,
            .max_tx_power = 20,
            .policy = c.WIFI_COUNTRY_POLICY_MANUAL,
        };
        try c_result(c.esp_wifi_set_country(&country));
    }

    try set_power_save_mode(.none);

    inited = true;
}

pub fn deinit() void {
    if (!inited) {
        @panic("trying to deinit the wifi controller but it isn't initialized");
    }

    _ = c.esp_wifi_stop();
    _ = c.esp_wifi_deinit_internal();
    _ = c.esp_supplicant_deinit();

    inited = false;
}

pub const PowerSaveMode = enum(u32) {
    none = c.WIFI_PS_NONE,
    min = c.WIFI_PS_MIN_MODEM,
    max = c.WIFI_PS_MAX_MODEM,
};

pub fn set_power_save_mode(mode: PowerSaveMode) InternalError!void {
    try c_result(c.esp_wifi_set_ps(@intFromEnum(mode)));
}

var wifi_tx_in_flight: usize = 0;

fn tx_done_cb(
    _: u8,
    _: [*c]u8,
    _: [*c]u16,
    _: bool,
) callconv(.c) void {
    log.debug("tx_done_cb", .{});

    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    if (wifi_tx_in_flight > 0) {
        wifi_tx_in_flight -= 1;
    }
}

fn recv_cb_sta(buf: ?*anyopaque, len: u16, eb: ?*anyopaque) callconv(.c) c.esp_err_t {
    _ = buf; // autofix
    _ = len; // autofix
    _ = eb; // autofix

    log.debug("recv_cb_sta", .{});

    @panic("recv_cb_sta");

    // return c.ESP_OK;
}

fn recv_cb_ap(buf: ?*anyopaque, len: u16, eb: ?*anyopaque) callconv(.c) c.esp_err_t {
    _ = buf; // autofix
    _ = len; // autofix
    _ = eb; // autofix

    log.debug("recv_cb_ap", .{});

    @panic("recv_cb_ap");

    // return c.ESP_OK;
}

// I pupulated this with the defaults from rust. Some of it should be configurable.
var init_config: c.wifi_init_config_t = .{
    .osi_funcs = &g_wifi_osi_funcs,
    // .wpa_crypto_funcs = c.g_wifi_default_wpa_crypto_funcs,
    .static_rx_buf_num = 10,
    .dynamic_rx_buf_num = 32,
    .tx_buf_type = c.CONFIG_ESP_WIFI_TX_BUFFER_TYPE,
    .static_tx_buf_num = 0,
    .dynamic_tx_buf_num = 32,
    .rx_mgmt_buf_type = c.CONFIG_ESP_WIFI_DYNAMIC_RX_MGMT_BUF,
    .rx_mgmt_buf_num = c.CONFIG_ESP_WIFI_RX_MGMT_BUF_NUM_DEF,
    .cache_tx_buf_num = c.WIFI_CACHE_TX_BUFFER_NUM,
    .csi_enable = 0, // TODO: WiFi channel state information enable flag.
    .ampdu_rx_enable = 1,
    .ampdu_tx_enable = 1,
    .amsdu_tx_enable = 0,
    .nvs_enable = 0,
    .nano_enable = 0,
    .rx_ba_win = 6,
    .wifi_task_core_id = 0,
    .beacon_max_len = c.WIFI_SOFTAP_BEACON_MAX_LEN,
    .mgmt_sbuf_num = c.WIFI_MGMT_SBUF_NUM,
    .feature_caps = wifi_feature_caps,
    .sta_disconnected_pm = false,
    .espnow_max_encrypt_num = c.CONFIG_ESP_WIFI_ESPNOW_MAX_ENCRYPT_NUM,
    .tx_hetb_queue_num = 3,
    .dump_hesigb_enable = false,
    .magic = c.WIFI_INIT_CONFIG_MAGIC,
};

const wifi_enable_wpa3_sae: u64 = 1 << 0;
const wifi_enable_enterprise: u64 = 1 << 7;
// const wifi_ftm_initiator: u64 = 1 << 2;
// const wifi_ftm_responder: u64 = 1 << 3;
// const wifi_enable_gcmp: u64 = 1 << 4;
// const wifi_enable_gmac: u64 = 1 << 5;
// const wifi_enable_11r: u64 = 1 << 6;

const wifi_feature_caps: u64 = wifi_enable_wpa3_sae | wifi_enable_enterprise;

export var g_wifi_osi_funcs: c.wifi_osi_funcs_t = .{
    ._version = c.ESP_WIFI_OS_ADAPTER_VERSION,
    ._env_is_chip = osi.env_is_chip,
    ._set_intr = osi.set_intr,
    ._clear_intr = osi.clear_intr,
    ._set_isr = osi.set_isr,
    ._ints_on = osi.ints_on,
    ._ints_off = osi.ints_off,
    ._is_from_isr = osi.is_from_isr,
    ._spin_lock_create = osi.spin_lock_create,
    ._spin_lock_delete = osi.spin_lock_delete,
    ._wifi_int_disable = osi.wifi_int_disable,
    ._wifi_int_restore = osi.wifi_int_restore,
    ._task_yield_from_isr = osi.task_yield_from_isr,
    ._semphr_create = osi.semphr_create,
    ._semphr_delete = osi.semphr_delete,
    ._semphr_take = osi.semphr_take,
    ._semphr_give = osi.semphr_give,
    ._wifi_thread_semphr_get = osi.wifi_thread_semphr_get,
    ._mutex_create = osi.mutex_create,
    ._recursive_mutex_create = osi.recursive_mutex_create,
    ._mutex_delete = osi.mutex_delete,
    ._mutex_lock = osi.mutex_lock,
    ._mutex_unlock = osi.mutex_unlock,
    ._queue_create = osi.queue_create,
    ._queue_delete = osi.queue_delete,
    ._queue_send = osi.queue_send,
    ._queue_send_from_isr = osi.queue_send_from_isr,
    ._queue_send_to_back = @ptrCast(&osi.queue_send_to_back),
    ._queue_send_to_front = @ptrCast(&osi.queue_send_to_front),
    ._queue_recv = osi.queue_recv,
    ._queue_msg_waiting = osi.queue_msg_waiting,
    ._event_group_create = @ptrCast(&osi.event_group_create),
    ._event_group_delete = @ptrCast(&osi.event_group_delete),
    ._event_group_set_bits = @ptrCast(&osi.event_group_set_bits),
    ._event_group_clear_bits = @ptrCast(&osi.event_group_clear_bits),
    ._event_group_wait_bits = @ptrCast(&osi.event_group_wait_bits),
    ._task_create_pinned_to_core = osi.task_create_pinned_to_core,
    ._task_create = osi.task_create,
    ._task_delete = @ptrCast(&osi.task_delete),
    ._task_delay = osi.task_delay,
    ._task_ms_to_tick = osi.task_ms_to_tick,
    ._task_get_current_task = osi.task_get_current_task,
    ._task_get_max_priority = osi.task_get_max_priority,
    ._malloc = osi.malloc,
    ._free = &osi.free,
    ._event_post = @ptrCast(&osi.event_post),
    ._get_free_heap_size = @ptrCast(&osi.get_free_heap_size),
    ._rand = osi.rand,
    ._dport_access_stall_other_cpu_start_wrap = osi.dport_access_stall_other_cpu_start_wrap,
    ._dport_access_stall_other_cpu_end_wrap = osi.dport_access_stall_other_cpu_end_wrap,
    ._wifi_apb80m_request = osi.wifi_apb80m_request,
    ._wifi_apb80m_release = osi.wifi_apb80m_release,
    ._phy_disable = osi.phy_disable,
    ._phy_enable = osi.phy_enable,
    ._phy_update_country_info = osi.phy_update_country_info,
    ._read_mac = osi.read_mac,
    ._timer_arm = osi.timer_arm,
    ._timer_disarm = osi.timer_disarm,
    ._timer_done = osi.timer_done,
    ._timer_setfn = osi.timer_setfn,
    ._timer_arm_us = osi.timer_arm_us,
    ._wifi_reset_mac = osi.wifi_reset_mac,
    ._wifi_clock_enable = osi.wifi_clock_enable,
    ._wifi_clock_disable = osi.wifi_clock_disable,
    ._wifi_rtc_enable_iso = @ptrCast(&osi.wifi_rtc_enable_iso),
    ._wifi_rtc_disable_iso = @ptrCast(&osi.wifi_rtc_disable_iso),
    ._esp_timer_get_time = osi.esp_timer_get_time,
    ._nvs_set_i8 = @ptrCast(&osi.nvs_set_i8),
    ._nvs_get_i8 = @ptrCast(&osi.nvs_get_i8),
    ._nvs_set_u8 = @ptrCast(&osi.nvs_set_u8),
    ._nvs_get_u8 = @ptrCast(&osi.nvs_get_u8),
    ._nvs_set_u16 = @ptrCast(&osi.nvs_set_u16),
    ._nvs_get_u16 = @ptrCast(&osi.nvs_get_u16),
    ._nvs_open = @ptrCast(&osi.nvs_open),
    ._nvs_close = @ptrCast(&osi.nvs_close),
    ._nvs_commit = @ptrCast(&osi.nvs_commit),
    ._nvs_set_blob = @ptrCast(&osi.nvs_set_blob),
    ._nvs_get_blob = @ptrCast(&osi.nvs_get_blob),
    ._nvs_erase_key = @ptrCast(&osi.nvs_erase_key),
    ._get_random = osi.get_random,
    ._get_time = @ptrCast(&osi.get_time),
    ._random = &osi.random,
    ._slowclk_cal_get = osi.slowclk_cal_get,
    ._log_write = osi.log_write,
    ._log_writev = osi.log_writev,
    ._log_timestamp = osi.log_timestamp,
    ._malloc_internal = osi.malloc_internal,
    ._realloc_internal = @ptrCast(&osi.realloc_internal),
    ._calloc_internal = osi.calloc_internal,
    ._zalloc_internal = osi.zalloc_internal,
    ._wifi_malloc = osi.wifi_malloc,
    ._wifi_realloc = @ptrCast(&osi.wifi_realloc),
    ._wifi_calloc = osi.wifi_calloc,
    ._wifi_zalloc = osi.wifi_zalloc,
    ._wifi_create_queue = osi.wifi_create_queue,
    ._wifi_delete_queue = osi.wifi_delete_queue,
    ._coex_init = osi.coex_init,
    ._coex_deinit = osi.coex_deinit,
    ._coex_enable = @ptrCast(&osi.coex_enable),
    ._coex_disable = @ptrCast(&osi.coex_disable),
    ._coex_status_get = @ptrCast(&osi.coex_status_get),
    ._coex_condition_set = null,
    ._coex_wifi_request = osi.coex_wifi_request,
    ._coex_wifi_release = osi.coex_wifi_release,
    ._coex_wifi_channel_set = osi.coex_wifi_channel_set,
    ._coex_event_duration_get = osi.coex_event_duration_get,
    ._coex_pti_get = osi.coex_pti_get,
    ._coex_schm_status_bit_clear = osi.coex_schm_status_bit_clear,
    ._coex_schm_status_bit_set = osi.coex_schm_status_bit_set,
    ._coex_schm_interval_set = osi.coex_schm_interval_set,
    ._coex_schm_interval_get = osi.coex_schm_interval_get,
    ._coex_schm_curr_period_get = osi.coex_schm_curr_period_get,
    ._coex_schm_curr_phase_get = osi.coex_schm_curr_phase_get,
    ._coex_schm_process_restart = osi.coex_schm_process_restart,
    ._coex_schm_register_cb = osi.coex_schm_register_cb,
    ._coex_register_start_cb = osi.coex_register_start_cb,
    ._coex_schm_flexible_period_set = osi.coex_schm_flexible_period_set,
    ._coex_schm_flexible_period_get = osi.coex_schm_flexible_period_get,
    ._magic = @bitCast(c.ESP_WIFI_OS_ADAPTER_MAGIC),
};

pub fn c_result(err_code: i32) InternalError!void {
    const InternalWifiError = enum(i32) {
        /// Out of memory
        esp_err_no_mem = 0x101,

        /// Invalid argument
        esp_err_invalid_arg = 0x102,

        /// Wi_fi driver was not installed by esp_wifi_init
        esp_err_wifi_not_init = 0x3001,

        /// Wi_fi driver was not started by esp_wifi_start
        esp_err_wifi_not_started = 0x3002,

        /// Wi_fi driver was not stopped by esp_wifi_stop
        esp_err_wifi_not_stopped = 0x3003,

        /// Wi_fi interface error
        esp_err_wifi_if = 0x3004,

        /// Wi_fi mode error
        esp_err_wifi_mode = 0x3005,

        /// Wi_fi internal state error
        esp_err_wifi_state = 0x3006,

        /// Wi_fi internal control block of station or soft-AP error
        esp_err_wifi_conn = 0x3007,

        /// Wi_fi internal NVS module error
        esp_err_wifi_nvs = 0x3008,

        /// MAC address is invalid
        esp_err_wifi_mac = 0x3009,

        /// SSID is invalid
        esp_err_wifi_ssid = 0x300A,

        /// Password is invalid
        esp_err_wifi_password = 0x300B,

        /// Timeout error
        esp_err_wifi_timeout = 0x300C,

        /// Wi_fi is in sleep state(RF closed) and wakeup fail
        esp_err_wifi_wake_fail = 0x300D,

        /// The caller would block
        esp_err_wifi_would_block = 0x300E,

        /// Station still in disconnect status
        esp_err_wifi_not_connect = 0x300F,

        /// Failed to post the event to Wi_fi task
        esp_err_wifi_post = 0x3012,

        /// Invalid Wi_fi state when init/deinit is called
        esp_err_wifi_init_state = 0x3013,

        /// Returned when Wi_fi is stopping
        esp_err_wifi_stop_state = 0x3014,

        /// The Wi_fi connection is not associated
        esp_err_wifi_not_assoc = 0x3015,

        /// The Wi_fi TX is disallowed
        esp_err_wifi_tx_disallow = 0x3016,
    };

    if (err_code != c.ESP_OK) {
        const err: InternalWifiError = @enumFromInt(err_code);
        log.err("Internal wifi error occurred: {s}", .{@tagName(err)});
        return error.InternalError;
    }
}
