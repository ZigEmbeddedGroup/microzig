const std = @import("std");
const assert = std.debug.assert;

pub const c = @import("esp-wifi-driver");
const microzig = @import("microzig");
const wifi_options = microzig.options.hal.radio.wifi;

const radio = @import("../radio.zig");
const rtos = @import("../rtos.zig");
const osi = @import("osi.zig");

const log = std.log.scoped(.esp_radio_wifi);

pub const Options = struct {
    on_event: ?*const fn (e: Event) void = null,
    on_packet_received: ?*const fn (comptime interface: Interface, data: []const u8) void = null,
    on_packet_transmitted: ?*const fn (interface: Interface, data: []const u8, status: bool) void = null,
};

const InitError = std.mem.Allocator.Error || InternalError;

pub const InitConfig = struct {
    /// Power save mode.
    power_save_mode: PowerSaveMode = .none,

    /// Country info. If .auto the country info of the AP to which the station
    /// is connected is used.
    country_info: CountryInfo = .auto,
    /// Set maximum transmitting power after WiFi start.
    /// TODO: explain what values are valid
    /// TODO: should it be part of country info?
    max_tx_power: i8 = 20,

    /// Max number of WiFi static RX buffers.
    ///
    /// Each buffer takes approximately 1.6KB of RAM. The static rx buffers are
    /// allocated when esp_wifi_init is called, they are not freed until
    /// esp_wifi_deinit is called.
    ///
    /// WiFi hardware use these buffers to receive all 802.11 frames. A higher
    /// number may allow higher throughput but increases memory use. If
    /// [`Self::ampdu_rx_enable`] is enabled, this value is recommended to set
    /// equal or bigger than [`Self::rx_ba_win`] in order to achieve better
    /// throughput and compatibility with both stations and APs.
    static_rx_buf_num: u8 = 10,

    /// Max number of WiFi dynamic RX buffers
    ///
    /// Set the number of WiFi dynamic RX buffers, 0 means unlimited RX buffers
    /// will be allocated (provided sufficient free RAM). The size of each
    /// dynamic RX buffer depends on the size of the received data frame.
    ///
    /// For each received data frame, the WiFi driver makes a copy to an RX
    /// buffer and then delivers it to the high layer TCP/IP stack. The dynamic
    /// RX buffer is freed after the higher layer has successfully received the
    /// data frame.
    ///
    /// For some applications, WiFi data frames may be received faster than the
    /// application can process them. In these cases we may run out of memory
    /// if RX buffer number is unlimited (0).
    ///
    /// If a dynamic RX buffer limit is set, it should be at least the number
    /// of static RX buffers.
    dynamic_rx_buf_num: u16 = 32,

    /// Set the number of WiFi static TX buffers.
    ///
    /// Each buffer takes approximately 1.6KB of RAM. The static RX buffers are
    /// allocated when esp_wifi_init() is called, they are not released until
    /// esp_wifi_deinit() is called.
    ///
    /// For each transmitted data frame from the higher layer TCP/IP stack, the
    /// WiFi driver makes a copy of it in a TX buffer.
    ///
    /// For some applications especially UDP applications, the upper layer can
    /// deliver frames faster than WiFi layer can transmit. In these cases, we
    /// may run out of TX buffers.
    static_tx_buf_num: u8 = 0,

    /// Set the number of WiFi dynamic TX buffers.
    ///
    /// The size of each dynamic TX buffer is not fixed, it depends on the size
    /// of each transmitted data frame.
    ///
    /// For each transmitted frame from the higher layer TCP/IP stack, the WiFi
    /// driver makes a copy of it in a TX buffer.
    ///
    /// For some applications, especially UDP applications, the upper layer can
    /// deliver frames faster than WiFi layer can transmit. In these cases, we
    /// may run out of TX buffers.
    dynamic_tx_buf_num: u16 = 32,

    /// Select this option to enable AMPDU RX feature.
    ampdu_rx_enable: bool = true,

    /// Select this option to enable AMPDU TX feature.
    ampdu_tx_enable: bool = true,

    /// Select this option to enable AMSDU TX feature.
    amsdu_tx_enable: bool = false,

    /// Set the size of WiFi Block Ack RX window.
    ///
    /// Generally a bigger value means higher throughput and better
    /// compatibility but more memory. Most of time we should NOT change the
    /// default value unless special reason, e.g. test the maximum UDP RX
    /// throughput with iperf etc. For iperf test in shieldbox, the recommended
    /// value is 9~12.
    ///
    /// If PSRAM is used and WiFi memory is preferred to allocate in PSRAM
    /// first, the default and minimum value should be 16 to achieve better
    /// throughput and compatibility with both stations and APs.
    rx_ba_win: u8 = 6,

    pub const CountryInfo = union(enum) {
        auto,
        manual: struct {
            /// Country code.
            country_code: *const [2]u8 = "01",
            /// Start channel of the allowed 2.4GHz Wi-Fi channels.
            start_channel: u8 = 1,
            /// Total channel number of the allowed 2.4GHz Wi-Fi channels.
            total_channel_number: u8 = 11,
        },

        fn get_wifi_country_t(info: CountryInfo, max_tx_power: i8) c.wifi_country_t {
            return switch (info) {
                .auto => .{
                    .cc = .{'0', '1', 0},
                    .schan = 1,
                    .nchan = 11,
                    .max_tx_power = max_tx_power,
                    .policy = c.WIFI_COUNTRY_POLICY_AUTO

                },
                .manual => |manual_info| .{
                    .cc = manual_info.country_code.* ++ .{0},
                    .schan = manual_info.start_channel,
                    .nchan = manual_info.total_channel_number,
                    .max_tx_power = max_tx_power,
                    .policy = c.WIFI_COUNTRY_POLICY_MANUAL,
                },
            };
        }
    };
};

pub fn init(gpa: std.mem.Allocator, config: InitConfig) InitError!void {
    comptime export_symbols();

    try radio.init(gpa);

    {
        init_config.wpa_crypto_funcs = c.g_wifi_default_wpa_crypto_funcs;
        init_config.feature_caps = g_wifi_feature_caps;
        init_config.static_rx_buf_num = config.static_rx_buf_num;
        init_config.dynamic_rx_buf_num = config.dynamic_rx_buf_num;
        init_config.static_tx_buf_num = config.static_tx_buf_num;
        init_config.dynamic_tx_buf_num = config.dynamic_tx_buf_num;
        init_config.ampdu_rx_enable = @intFromBool(config.ampdu_rx_enable);
        init_config.ampdu_tx_enable = @intFromBool(config.ampdu_tx_enable);
        init_config.amsdu_tx_enable = @intFromBool(config.amsdu_tx_enable);
        init_config.rx_ba_win = config.rx_ba_win;
    }

    // TODO: if coex enabled
    if (false) try c_result(c.coex_init());

    try c_result(c.esp_wifi_init_internal(&init_config));

    try c_result(c.esp_wifi_set_mode(c.WIFI_MODE_NULL));

    try c_result(c.esp_supplicant_init());

    try c_result(c.esp_wifi_set_tx_done_cb(tx_done_cb));
    try c_result(c.esp_wifi_internal_reg_rxcb(c.ESP_IF_WIFI_AP, recv_cb_ap));
    try c_result(c.esp_wifi_internal_reg_rxcb(c.ESP_IF_WIFI_STA, recv_cb_sta));

    {
        const country_info = config.country_info.get_wifi_country_t(config.max_tx_power);
        try c_result(c.esp_wifi_set_country(&country_info));
    }

    try set_power_save_mode(config.power_save_mode);
}

pub fn deinit() void {
    _ = c.esp_wifi_stop();
    _ = c.esp_wifi_deinit_internal();
    _ = c.esp_supplicant_deinit();

    radio.deinit();
}

pub const ApplyConfigError = InternalError || error{
    InvalidConfig,
};

pub const Config = union(enum) {
    ap: AccessPoint,
    sta: Station,
    ap_sta: struct {
        ap: AccessPoint,
        sta: Station,
    },
    // TODO: eap_sta

    pub const AccessPoint = struct {
        /// The SSID of the access point.
        ssid: []const u8,

        /// Whether the SSID is hidden or visible.
        ssid_hidden: bool = false,

        /// The channel the access point will operate on. Ignored in `ap_sta`
        /// mode.
        channel: u8,

        /// The secondary channel configuration.
        secondary_channel: ?u8 = null,

        /// Authentication config to be used by the access point.
        auth: ?Auth = null,

        /// The maximum number of connections allowed on the access point.
        max_connections: u8,
    };

    pub const Station = struct {
        /// The SSID of the Wi-Fi network.
        ssid: []const u8,

        /// The BSSID (MAC address) of the client.
        bssid: ?[6]u8 = null,

        /// Authentication config for the Wi-Fi connection.
        auth: ?Auth = null,

        /// The Wi-Fi channel to connect to.
        channel: u8 = 0,

        scan_method: ScanMethod = .fast,

        listen_interval: u16 = 3,

        failure_retry_cnt: u8 = 1,

        pub const ScanMethod = enum(u32) {
            fast = c.WIFI_FAST_SCAN,
            all_channel = c.WIFI_ALL_CHANNEL_SCAN,
        };
    };

    pub const Auth = struct {
        password: []const u8,
        method: Method,

        pub const Method = enum(u32) {
            /// Wired Equivalent Privacy (WEP) authentication.
            wep = c.WIFI_AUTH_WEP,

            /// Wi-Fi Protected Access (WPA) authentication.
            wpa = c.WIFI_AUTH_WPA_PSK,

            /// Wi-Fi Protected Access 2 (WPA2) Personal authentication (default).
            wpa2_personal = c.WIFI_AUTH_WPA2_PSK,

            /// WPA/WPA2 Personal authentication (supports both).
            wpa_wpa2_personal = c.WIFI_AUTH_WPA_WPA2_PSK,

            /// WPA2 Enterprise authentication.
            wpa2_enterprise = c.WIFI_AUTH_WPA2_ENTERPRISE,

            /// WPA3 Personal authentication.
            wpa3_personal = c.WIFI_AUTH_WPA3_PSK,

            /// WPA2/WPA3 Personal authentication (supports both).
            wpa2_wpa3_personal = c.WIFI_AUTH_WPA2_WPA3_PSK,

            /// WLAN Authentication and Privacy Infrastructure (WAPI).
            wapi_personal = c.WIFI_AUTH_WAPI_PSK,
        };
    };
};

pub fn apply(config: Config) ApplyConfigError!void {
    switch (config) {
        .ap => |ap_config| {
            try set_mode(.ap);
            try apply_access_point_config(ap_config);
        },
        .sta => |sta_config| {
            try set_mode(.sta);
            try apply_station_config(sta_config);
        },
        .ap_sta => |ap_sta_config| {
            try set_mode(.ap_sta);
            try apply_access_point_config(ap_sta_config.ap);
            try apply_station_config(ap_sta_config.sta);
        },
    }
}

pub const WifiMode = enum(u32) {
    sta = c.WIFI_MODE_STA,
    ap = c.WIFI_MODE_AP,
    ap_sta = c.WIFI_MODE_APSTA,

    pub fn is_sta(self: WifiMode) bool {
        return self == .sta or self == .ap_sta;
    }

    pub fn is_ap(self: WifiMode) bool {
        return self == .ap or self == .ap_sta;
    }
};

pub fn get_mode() InternalError!WifiMode {
    var mode: c.wifi_mode_t = undefined;
    try c_result(c.esp_wifi_get_mode(&mode));
    return @enumFromInt(mode);
}

fn set_mode(mode: WifiMode) InternalError!void {
    try c_result(c.esp_wifi_set_mode(@intFromEnum(mode)));
}

fn apply_access_point_config(config: Config.AccessPoint) ApplyConfigError!void {
    if (config.ssid.len > 32) {
        return error.InvalidConfig;
    }

    if (config.auth) |auth| {
        if (auth.password.len > 64) {
            return error.InvalidConfig;
        }
    }

    var ap_cfg: c_patched.wifi_ap_config_t = .{
        .ssid_len = @intCast(config.ssid.len),
        .channel = config.channel,
        .authmode = if (config.auth) |auth| @intFromEnum(auth.method) else c.WIFI_AUTH_OPEN,
        .ssid_hidden = @intFromBool(config.ssid_hidden),
        .max_connection = config.max_connections,
        .beacon_interval = 100,
        .pairwise_cipher = c.WIFI_CIPHER_TYPE_CCMP,
        .ftm_responder = false,
        .pmf_cfg = .{
            .capable = true,
            .required = false,
        },
        .sae_pwe_h2e = 0,
        .csa_count = 3,
        .dtim_period = 2,
    };

    @memcpy(ap_cfg.ssid[0..config.ssid.len], config.ssid);
    if (config.auth) |auth| {
        @memcpy(ap_cfg.password[0..auth.password.len], auth.password);
    }

    var tmp: c_patched.wifi_config_t = .{ .ap = ap_cfg };
    try c_result(c_patched.esp_wifi_set_config(c.WIFI_IF_AP, &tmp));
}

fn apply_station_config(config: Config.Station) ApplyConfigError!void {
    if (config.ssid.len > 32) {
        return error.InvalidConfig;
    }

    if (config.auth) |auth| {
        if (auth.password.len > 64) {
            return error.InvalidConfig;
        }
    }

    var sta_cfg: c_patched.wifi_sta_config_t = .{
        .scan_method = @intFromEnum(config.scan_method),
        .bssid_set = config.bssid != null,
        .bssid = config.bssid orelse @splat(0),
        .channel = config.channel,
        .listen_interval = config.listen_interval,
        .sort_method = c.WIFI_CONNECT_AP_BY_SIGNAL,
        .threshold = .{
            .rssi = -99,
            .authmode = if (config.auth) |auth| @intFromEnum(auth.method) else c.WIFI_AUTH_OPEN,
        },
        .pmf_cfg = .{
            .capable = true,
            .required = false,
        },
        .failure_retry_cnt = config.failure_retry_cnt,
    };

    @memcpy(sta_cfg.ssid[0..config.ssid.len], config.ssid);
    if (config.auth) |auth| {
        @memcpy(sta_cfg.password[0..auth.password.len], auth.password);
    }

    var tmp: c_patched.wifi_config_t = .{ .sta = sta_cfg };
    try c_result(c_patched.esp_wifi_set_config(c.WIFI_IF_STA, &tmp));
}

pub const PowerSaveMode = enum(u32) {
    none = c.WIFI_PS_NONE,
    min = c.WIFI_PS_MIN_MODEM,
    max = c.WIFI_PS_MAX_MODEM,
};

pub fn set_power_save_mode(mode: PowerSaveMode) InternalError!void {
    try c_result(c.esp_wifi_set_ps(@intFromEnum(mode)));
}

pub const Protocol = enum(u8) {
    /// 802.11b protocol.
    P802D11B = c.WIFI_PROTOCOL_11B,

    /// 802.11b/g protocol.
    P802D11BG = c.WIFI_PROTOCOL_11B | c.WIFI_PROTOCOL_11G,

    /// 802.11b/g/n protocol (default).
    P802D11BGN = c.WIFI_PROTOCOL_11B | c.WIFI_PROTOCOL_11G | c.WIFI_PROTOCOL_11N,

    /// 802.11b/g/n long-range (LR) protocol.
    P802D11BGNLR = c.WIFI_PROTOCOL_11B | c.WIFI_PROTOCOL_11G | c.WIFI_PROTOCOL_11N | c.WIFI_PROTOCOL_LR,

    /// 802.11 long-range (LR) protocol.
    P802D11LR = c.WIFI_PROTOCOL_LR,

    /// 802.11b/g/n/ax protocol.
    P802D11BGNAX = c.WIFI_PROTOCOL_11B | c.WIFI_PROTOCOL_11G | c.WIFI_PROTOCOL_11N | c.WIFI_PROTOCOL_11AX,
};

pub fn set_protocol(protocols: []const Config.AccessPoint.Protocol) InternalError!void {
    var combined: u8 = 0;
    for (protocols) |protocol| {
        combined |= @intFromEnum(protocol);
    }

    const mode = try get_mode();
    if (mode.is_sta()) {
        try c_result(c.esp_wifi_set_protocol(c.WIFI_IF_STA, combined));
    }
    if (mode.is_ap()) {
        try c_result(c.esp_wifi_set_protocol(c.WIFI_IF_AP, combined));
    }
}

/// Set the inactive time in seconds of the STA or AP.
///
/// 1. For Station, if the station does not receive a beacon frame from the
/// connected SoftAP during the inactive time, disconnect from SoftAP. Default
/// 6s. Must be at least 3s.
///
/// 2. For SoftAP, if the softAP doesn't receive any data from the connected
/// STA during inactive time, the softAP will force deauth the STA. Default is
/// 300s. Must be at least 10s.
pub fn set_inactive_time(interface: Interface, inactive_time: u32) InternalError!void {
    try c_result(c.esp_wifi_set_inactive_time(
        @intFromEnum(interface),
        inactive_time,
    ));
}

pub fn start() InternalError!void {
    try c_result(c.esp_wifi_start());
}

pub fn stop() InternalError!void {
    try c_result(c.esp_wifi_stop());
}

/// Non-blocking.
pub fn connect() InternalError!void {
    try c_result(c.esp_wifi_connect_internal());
}

pub fn disconnect() InternalError!void {
    try c_result(c.esp_wifi_disconnect_internal());
}

pub fn start_blocking() InternalError!void {
    const mode = try get_mode();
    var events: EventSet = .initEmpty();
    if (mode.is_sta()) events.setPresent(.StaStart, true);
    if (mode.is_ap()) events.setPresent(.ApStart, true);
    clear_events(events);
    try start();
    wait_for_all_events(events);
}

pub const ConnectError = error{FailedToConnect} || InternalError;

pub fn connect_blocking() ConnectError!void {
    const events: EventSet = .initMany(&.{ .StaConnected, .StaDisconnected });
    clear_events(events);
    try connect();
    if (wait_for_any_event(events).contains(.StaDisconnected))
        return error.FailedToConnect;
}

pub const EventType = enum(i32) {
    /// Wi-Fi is ready for operation.
    WifiReady = 0,
    /// Scan operation has completed.
    ScanDone,
    /// Station mode started.
    StaStart,
    /// Station mode stopped.
    StaStop,
    /// Station connected to a network.
    StaConnected,
    /// Station disconnected from a network.
    StaDisconnected,
    /// Station authentication mode changed.
    StaAuthmodeChange,

    /// Station WPS succeeds in enrollee mode.
    StaWpsErSuccess,
    /// Station WPS fails in enrollee mode.
    StaWpsErFailed,
    /// Station WPS timeout in enrollee mode.
    StaWpsErTimeout,
    /// Station WPS pin code in enrollee mode.
    StaWpsErPin,
    /// Station WPS overlap in enrollee mode.
    StaWpsErPbcOverlap,

    /// Soft-AP start.
    ApStart,
    /// Soft-AP stop.
    ApStop,
    /// A station connected to Soft-AP.
    ApStaconnected,
    /// A station disconnected from Soft-AP.
    ApStadisconnected,
    /// Received probe request packet in Soft-AP interface.
    ApProbereqrecved,

    /// Received report of FTM procedure.
    FtmReport,

    /// AP's RSSI crossed configured threshold.
    StaBssRssiLow,
    /// Status indication of Action Tx operation.
    ActionTxStatus,
    /// Remain-on-Channel operation complete.
    RocDone,

    /// Station beacon timeout.
    StaBeaconTimeout,

    /// Connectionless module wake interval has started.
    ConnectionlessModuleWakeIntervalStart,

    /// Soft-AP WPS succeeded in registrar mode.
    ApWpsRgSuccess,
    /// Soft-AP WPS failed in registrar mode.
    ApWpsRgFailed,
    /// Soft-AP WPS timed out in registrar mode.
    ApWpsRgTimeout,
    /// Soft-AP WPS pin code in registrar mode.
    ApWpsRgPin,
    /// Soft-AP WPS overlap in registrar mode.
    ApWpsRgPbcOverlap,

    /// iTWT setup.
    ItwtSetup,
    /// iTWT teardown.
    ItwtTeardown,
    /// iTWT probe.
    ItwtProbe,
    /// iTWT suspended.
    ItwtSuspend,
    /// TWT wakeup event.
    TwtWakeup,
    /// bTWT setup.
    BtwtSetup,
    /// bTWT teardown.
    BtwtTeardown,

    /// NAN (Neighbor Awareness Networking) discovery has started.
    NanStarted,
    /// NAN discovery has stopped.
    NanStopped,
    /// NAN service discovery match found.
    NanSvcMatch,
    /// Replied to a NAN peer with service discovery match.
    NanReplied,
    /// Received a follow-up message in NAN.
    NanReceive,
    /// Received NDP (Neighbor Discovery Protocol) request from a NAN peer.
    NdpIndication,
    /// NDP confirm indication.
    NdpConfirm,
    /// NAN datapath terminated indication.
    NdpTerminated,
    /// Wi-Fi home channel change, doesn't occur when scanning.
    HomeChannelChange,

    /// Received Neighbor Report response.
    StaNeighborRep,
};

pub const Event = union(EventType) {
    /// Wi-Fi is ready for operation.
    WifiReady,
    /// Scan operation has completed.
    ScanDone: c.wifi_event_sta_scan_done_t,
    /// Station mode started.
    StaStart,
    /// Station mode stopped.
    StaStop,
    /// Station connected to a network.
    StaConnected: c.wifi_event_sta_connected_t,
    /// Station disconnected from a network.
    StaDisconnected: c.wifi_event_sta_disconnected_t,
    /// Station authentication mode changed.
    StaAuthmodeChange: c.wifi_event_sta_authmode_change_t,

    /// Station WPS succeeds in enrollee mode.
    StaWpsErSuccess: c.wifi_event_sta_wps_er_success_t,
    /// Station WPS fails in enrollee mode.
    StaWpsErFailed,
    /// Station WPS timeout in enrollee mode.
    StaWpsErTimeout,
    /// Station WPS pin code in enrollee mode.
    StaWpsErPin: c.wifi_event_sta_wps_er_pin_t,
    /// Station WPS overlap in enrollee mode.
    StaWpsErPbcOverlap,

    /// Soft-AP start.
    ApStart,
    /// Soft-AP stop.
    ApStop,
    /// A station connected to Soft-AP.
    ApStaconnected: c.wifi_event_ap_staconnected_t,
    /// A station disconnected from Soft-AP.
    ApStadisconnected: c.wifi_event_ap_stadisconnected_t,
    /// Received probe request packet in Soft-AP interface.
    ApProbereqrecved: c.wifi_event_ap_probe_req_rx_t,

    /// Received report of FTM procedure.
    FtmReport: c.wifi_event_ftm_report_t,

    /// AP's RSSI crossed configured threshold.
    StaBssRssiLow: c.wifi_event_bss_rssi_low_t,
    /// Status indication of Action Tx operation.
    ActionTxStatus: c.wifi_event_action_tx_status_t,
    /// Remain-on-Channel operation complete.
    RocDone: c.wifi_event_roc_done_t,

    /// Station beacon timeout.
    StaBeaconTimeout,

    /// Connectionless module wake interval has started.
    ConnectionlessModuleWakeIntervalStart,

    /// Soft-AP WPS succeeded in registrar mode.
    ApWpsRgSuccess: c.wifi_event_ap_wps_rg_success_t,
    /// Soft-AP WPS failed in registrar mode.
    ApWpsRgFailed: c.wifi_event_ap_wps_rg_fail_reason_t,
    /// Soft-AP WPS timed out in registrar mode.
    ApWpsRgTimeout,
    /// Soft-AP WPS pin code in registrar mode.
    ApWpsRgPin: c.wifi_event_ap_wps_rg_pin_t,
    /// Soft-AP WPS overlap in registrar mode.
    ApWpsRgPbcOverlap,

    /// iTWT setup.
    ItwtSetup,
    /// iTWT teardown.
    ItwtTeardown,
    /// iTWT probe.
    ItwtProbe,
    /// iTWT suspended.
    ItwtSuspend,
    /// TWT wakeup event.
    TwtWakeup,
    /// bTWT setup.
    BtwtSetup,
    /// bTWT teardown.
    BtwtTeardown,

    /// NAN (Neighbor Awareness Networking) discovery has started.
    NanStarted,
    /// NAN discovery has stopped.
    NanStopped,
    /// NAN service discovery match found.
    // TODO: c.wifi_event_nan_svc_match_t
    NanSvcMatch,
    /// Replied to a NAN peer with service discovery match.
    // TODO: c.wifi_event_nan_replied_t
    NanReplied,
    /// Received a follow-up message in NAN.
    // TODO: c.wifi_event_nan_receive_t
    NanReceive,
    /// Received NDP (Neighbor Discovery Protocol) request from a NAN peer.
    // TODO: c.wifi_event_ndp_indication_t
    NdpIndication,
    /// NDP confirm indication.
    // TODO: c.wifi_event_ndp_confirm_t
    NdpConfirm,
    /// NAN datapath terminated indication.
    // TODO: c.wifi_event_ndp_terminated_t
    NdpTerminated,
    /// Wi-Fi home channel change, doesn't occur when scanning.
    HomeChannelChange: c.wifi_event_home_channel_change_t,

    /// Received Neighbor Report response.
    StaNeighborRep: c.wifi_event_neighbor_report_t,
};

pub const EventSet = std.EnumSet(EventType);

var event_mutex: rtos.Mutex = .{};
var event_condition: rtos.Condition = .{};
var active_events: EventSet = .{};

pub fn wait_for_any_event(events: EventSet) EventSet {
    event_mutex.lock();
    defer event_mutex.unlock();

    while (true) {
        const intersection = active_events.intersectWith(events);
        if (intersection.count() > 0) return intersection;
        event_condition.wait(&event_mutex);
    }
}

pub fn wait_for_all_events(events: EventSet) void {
    event_mutex.lock();
    defer event_mutex.unlock();

    while (!active_events.supersetOf(events)) {
        event_condition.wait(&event_mutex);
    }
}

pub fn wait_for_event(event: EventType) void {
    event_mutex.lock();
    defer event_mutex.unlock();

    while (!active_events.contains(event)) {
        event_condition.wait(&event_mutex);
    }
}

pub fn clear_events(events: EventSet) void {
    event_mutex.lock();
    defer event_mutex.unlock();

    active_events = active_events.differenceWith(events);
}

/// Internal function. Called by osi layer.
pub fn on_event_post(id: i32, data: ?*anyopaque, data_size: usize) void {
    log.debug("esp_event_post {} {?} {}", .{ id, data, data_size });

    const event_type: EventType = @enumFromInt(id);
    update_sta_state(event_type);

    {
        event_mutex.lock();
        defer event_mutex.unlock();
        active_events.setPresent(event_type, true);
    }
    event_condition.broadcast();

    const event = switch (event_type) {
        inline else => |tag| blk: {
            const PayloadType = @FieldType(Event, @tagName(tag));
            if (PayloadType == void) break :blk @unionInit(Event, @tagName(tag), {});

            // Purposely skipping the assert if the type is void. There are
            // some todos where we use void for the payload instead of the
            // actual payload type.
            assert(data_size == @sizeOf(PayloadType));

            break :blk @unionInit(Event, @tagName(tag), @as(*PayloadType, @ptrCast(@alignCast(data))).*);
        },
    };

    if (wifi_options.on_event) |on_event| {
        on_event(event);
    }
}

pub const StaState = enum(u32) {
    none,
    started,
    connected,
    disconnected,
    stopped,

    pub fn is_started(state: StaState) bool {
        return switch (state) {
            .started, .connected, .disconnected => true,
            else => false,
        };
    }
};

var sta_state: std.atomic.Value(StaState) = .init(.none);

fn update_sta_state(event: EventType) void {
    const new_sta_state: StaState = switch (event) {
        .StaStart => .started,
        .StaConnected => .connected,
        .StaDisconnected => .disconnected,
        .StaStop => .stopped,
        else => return,
    };
    sta_state.store(new_sta_state, .monotonic);
}

pub fn get_sta_state() StaState {
    return sta_state.load(.monotonic);
}

pub const Interface = enum(u32) {
    ap = c.WIFI_IF_AP,
    sta = c.WIFI_IF_STA,

    pub fn is_active(self: Interface) InternalError!bool {
        const mode = try get_mode();
        return switch (self) {
            .ap => mode.is_ap(),
            .sta => mode.is_sta(),
        };
    }
};

pub fn send_packet(iface: Interface, data: []const u8) (error{TooManyPacketsInFlight} || InternalError)!void {
    try c_result(c.esp_wifi_internal_tx(@intFromEnum(iface), @ptrCast(@constCast(data.ptr)), @intCast(data.len)));
}

fn tx_done_cb(
    iface_idx: u8,
    data_ptr: [*c]u8,
    data_len: [*c]u16,
    status: bool,
) callconv(.c) void {
    log.debug("tx_done_cb", .{});

    if (wifi_options.on_packet_transmitted) |on_packet_transmitted|
        on_packet_transmitted(@intFromEnum(iface_idx), data_ptr[0..data_len], status);
}

fn recv_cb_ap(buf: ?*anyopaque, len: u16, eb: ?*anyopaque) callconv(.c) c.esp_err_t {
    log.debug("recv_cb_ap {?} {} {?}", .{ buf, len, eb });

    if (wifi_options.on_packet_received) |on_packet_received| {
        on_packet_received(.ap, @as([*]const u8, @ptrCast(buf))[0..len]);
    }
    c.esp_wifi_internal_free_rx_buffer(eb);

    return c.ESP_OK;
}

fn recv_cb_sta(buf: ?*anyopaque, len: u16, eb: ?*anyopaque) callconv(.c) c.esp_err_t {
    log.debug("recv_cb_sta {?} {} {?}", .{ buf, len, eb });

    if (wifi_options.on_packet_received) |on_packet_received| {
        on_packet_received(.sta, @as([*]const u8, @ptrCast(buf))[0..len]);
    }
    c.esp_wifi_internal_free_rx_buffer(eb);

    return c.ESP_OK;
}

fn export_symbols() void {
    @export(&g_wifi_feature_caps, .{ .name = "g_wifi_feature_caps" });
    @export(&g_wifi_osi_funcs, .{ .name = "g_wifi_osi_funcs" });
}

// TODO: configurable
var init_config: c.wifi_init_config_t = .{
    .osi_funcs = &g_wifi_osi_funcs,
    // .wpa_crypto_funcs = c.g_wifi_default_wpa_crypto_funcs,
    .static_rx_buf_num = 10, // overwritten by init
    .dynamic_rx_buf_num = 32, // overwritten by init
    .tx_buf_type = c.CONFIG_ESP_WIFI_TX_BUFFER_TYPE,
    .static_tx_buf_num = 0, // overwritten by init
    .dynamic_tx_buf_num = 32, // overwritten by init
    .rx_mgmt_buf_type = c.CONFIG_ESP_WIFI_STATIC_RX_MGMT_BUFFER,
    .rx_mgmt_buf_num = c.CONFIG_ESP_WIFI_RX_MGMT_BUF_NUM_DEF,
    .cache_tx_buf_num = c.WIFI_CACHE_TX_BUFFER_NUM,
    .csi_enable = 0, // TODO: WiFi channel state information enable flag.
    .ampdu_rx_enable = 1, // overwritten by init
    .ampdu_tx_enable = 1, // overwritten by init
    .amsdu_tx_enable = 0, // overwritten by init
    .nvs_enable = 0,
    .nano_enable = 0,
    .rx_ba_win = 6, // overwritten by init
    .wifi_task_core_id = 0,
    .beacon_max_len = c.WIFI_SOFTAP_BEACON_MAX_LEN,
    .mgmt_sbuf_num = c.WIFI_MGMT_SBUF_NUM,
    .feature_caps = c.WIFI_FEATURE_CAPS,
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

var g_wifi_feature_caps: u64 = wifi_enable_wpa3_sae | wifi_enable_enterprise;

var g_wifi_osi_funcs: c.wifi_osi_funcs_t = .{
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
    ._task_delete = osi.task_delete,
    ._task_delay = osi.task_delay,
    ._task_ms_to_tick = osi.task_ms_to_tick,
    ._task_get_current_task = osi.task_get_current_task,
    ._task_get_max_priority = osi.task_get_max_priority,
    ._malloc = osi.malloc,
    ._free = osi.free,
    ._event_post = osi.esp_event_post,
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
    ._coex_enable = osi.coex_enable,
    ._coex_disable = osi.coex_disable,
    ._coex_status_get = osi.coex_status_get,
    ._coex_condition_set = @ptrCast(&osi.coex_condition_set),
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

pub const InternalError = error {
    OutOfMemory,
    InvalidArg,
    Timeout,
    WouldBlock,
    WifiNotInitialized,
    WifiNotStarted,
    WifiNotStopped,
    WifiNotConnected,
    WifiInvalid_MAC,
    WifiInvalid_SSID,
    WifiInvalidPassword,
    WifiOther,
};

pub fn c_result(raw_err_code: i32) InternalError!void {
    const InternalWifiErrorCode = enum(i32) {
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

    if (raw_err_code != c.ESP_OK) {
        const err_code = std.enums.fromInt(InternalWifiErrorCode, raw_err_code) orelse
            @panic("esp wifi returned unexpected error code");
        log.debug("internal wifi error occurred: {t}", .{err_code});
        return switch (err_code) {
            .esp_err_no_mem => error.OutOfMemory,
            .esp_err_wifi_timeout => error.Timeout,
            .esp_err_wifi_would_block => error.WouldBlock,
            .esp_err_wifi_not_init => error.WifiNotInitialized,
            .esp_err_wifi_not_started => error.WifiNotStarted,
            .esp_err_wifi_not_connect => error.WifiNotConnected,
            .esp_err_wifi_not_stopped => error.WifiNotStopped,
            .esp_err_wifi_mac => error.WifiInvalid_MAC,
            .esp_err_wifi_ssid => error.WifiInvalid_SSID,
            .esp_err_wifi_password => error.WifiInvalidPassword,
            else => error.WifiOther,
        };
    }
}

pub const c_patched = struct {
    pub const wifi_ap_config_t = extern struct {
        ssid: [32]u8 = std.mem.zeroes([32]u8),
        password: [64]u8 = std.mem.zeroes([64]u8),
        ssid_len: u8 = std.mem.zeroes(u8),
        channel: u8 = std.mem.zeroes(u8),
        authmode: c.wifi_auth_mode_t = std.mem.zeroes(c.wifi_auth_mode_t),
        ssid_hidden: u8 = std.mem.zeroes(u8),
        max_connection: u8 = std.mem.zeroes(u8),
        beacon_interval: u16 = std.mem.zeroes(u16),
        csa_count: u8 = std.mem.zeroes(u8),
        dtim_period: u8 = std.mem.zeroes(u8),
        pairwise_cipher: c.wifi_cipher_type_t = std.mem.zeroes(c.wifi_cipher_type_t),
        ftm_responder: bool = std.mem.zeroes(bool),
        pmf_cfg: c.wifi_pmf_config_t = std.mem.zeroes(c.wifi_pmf_config_t),
        sae_pwe_h2e: c.wifi_sae_pwe_method_t = std.mem.zeroes(c.wifi_sae_pwe_method_t),
    };

    pub const wifi_sta_config_t = extern struct {
        // NOTE: maybe a little more imagination
        pub const Packed1 = packed struct {
            rm_enabled: bool,
            btm_enabled: bool,
            mbo_enabled: bool,
            ft_enabled: bool,
            owe_enabled: bool,
            transition_disable: bool,
            reserved: u26,
        };

        pub const Packed2 = packed struct {
            he_dcm_set: u1,
            he_dcm_max_constellation_tx: u2,
            he_dcm_max_constellation_rx: u2,
            he_mcs9_enabled: u1,
            he_su_beamformee_disabled: u1,
            he_trig_su_bmforming_feedback_disabled: u1,
            he_trig_mu_bmforming_partial_feedback_disabled: u1,
            he_trig_cqi_feedback_disable: u1,
            he_reserved: u22,
        };

        ssid: [32]u8 = std.mem.zeroes([32]u8),
        password: [64]u8 = std.mem.zeroes([64]u8),
        scan_method: c.wifi_scan_method_t = std.mem.zeroes(c.wifi_scan_method_t),
        bssid_set: bool = std.mem.zeroes(bool),
        bssid: [6]u8 = std.mem.zeroes([6]u8),
        channel: u8 = std.mem.zeroes(u8),
        listen_interval: u16 = std.mem.zeroes(u16),
        sort_method: c.wifi_sort_method_t = std.mem.zeroes(c.wifi_sort_method_t),
        threshold: c.wifi_scan_threshold_t = std.mem.zeroes(c.wifi_scan_threshold_t),
        pmf_cfg: c.wifi_pmf_config_t = std.mem.zeroes(c.wifi_pmf_config_t),
        packed1: Packed1 = std.mem.zeroes(Packed1),
        sae_pwe_h2e: c.wifi_sae_pwe_method_t = std.mem.zeroes(c.wifi_sae_pwe_method_t),
        sae_pk_mode: c.wifi_sae_pk_mode_t = std.mem.zeroes(c.wifi_sae_pk_mode_t),
        failure_retry_cnt: u8 = std.mem.zeroes(u8),
        packed2: Packed2 = std.mem.zeroes(Packed2),
        sae_h2e_identifier: [32]u8 = std.mem.zeroes([32]u8),
    };

    pub const wifi_nan_config_t = extern struct {
        op_channel: u8 = std.mem.zeroes(u8),
        master_pref: u8 = std.mem.zeroes(u8),
        scan_time: u8 = std.mem.zeroes(u8),
        warm_up_sec: u16 = std.mem.zeroes(u16),
    };

    pub const wifi_config_t = extern union {
        ap: wifi_ap_config_t,
        sta: wifi_sta_config_t,
        nan: wifi_nan_config_t,
    };

    extern fn esp_wifi_set_config(interface: c.wifi_interface_t, conf: ?*wifi_config_t) c.esp_err_t;
};
