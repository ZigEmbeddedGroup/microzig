// BLE GAP (Generic Access Profile) - advertising, connections, scanning, security.
//
// Types are defined at file scope (shared across all SoftDevice variants).
// Functions are variant-parameterized via Api().

const Self = @This();
const svc = @import("svc.zig");
const err = @import("err.zig");
const Variant = @import("variant.zig").Variant;
const Error = err.Error;

pub const addr_len = 6;
pub const sec_key_len = 16;
pub const sec_rand_len = 8;
pub const passkey_len = 6;
pub const lesc_p256_pk_len = 64;
pub const lesc_dhkey_len = 32;
pub const channel_count = 40;
pub const whitelist_addr_max_count = 8;
pub const device_identities_max_count = 8;
pub const devname_max_len = 248;
pub const adv_set_data_size_max: u16 = 31;
pub const adv_set_data_size_extended_max_supported: u16 = 255;

pub const Role = enum(u8) {
    invalid = 0x0,
    periph = 0x1,
    central = 0x2,
};

pub const AddrType = enum(u7) {
    public = 0x00,
    random_static = 0x01,
    random_private_resolvable = 0x02,
    random_private_non_resolvable = 0x03,
    anonymous = 0x7F,
    _,
};

pub const Addr = extern struct {
    flags: packed struct(u8) {
        addr_id_peer: u1 = 0,
        addr_type: AddrType = .public,
    } = .{},
    addr: [addr_len]u8 = .{0} ** addr_len,
};

pub const ConnParams = extern struct {
    min_conn_interval: u16,
    max_conn_interval: u16,
    slave_latency: u16,
    conn_sup_timeout: u16,
};

pub const ConnSecMode = packed struct(u8) {
    sm: u4 = 0,
    lv: u4 = 0,

    pub fn no_access() ConnSecMode {
        return .{ .sm = 0, .lv = 0 };
    }
    pub fn open() ConnSecMode {
        return .{ .sm = 1, .lv = 1 };
    }
    pub fn enc_no_mitm() ConnSecMode {
        return .{ .sm = 1, .lv = 2 };
    }
    pub fn enc_with_mitm() ConnSecMode {
        return .{ .sm = 1, .lv = 3 };
    }
    pub fn lesc_enc_with_mitm() ConnSecMode {
        return .{ .sm = 1, .lv = 4 };
    }
    pub fn signed_no_mitm() ConnSecMode {
        return .{ .sm = 2, .lv = 1 };
    }
    pub fn signed_with_mitm() ConnSecMode {
        return .{ .sm = 2, .lv = 2 };
    }
};

pub const ConnSec = extern struct {
    sec_mode: ConnSecMode,
    encr_key_size: u8,
};

pub const Irk = extern struct {
    irk: [sec_key_len]u8,
};

pub const ChannelMask = [5]u8;

pub const AdvProperties = extern struct {
    type_: AdvType,
    flags: packed struct(u8) {
        anonymous: u1 = 0,
        include_tx_power: u1 = 0,
        _pad: u6 = 0,
    } = .{},
};

pub const AdvType = enum(u8) {
    connectable_scannable_undirected = 0x01,
    connectable_nonscannable_directed_high_duty_cycle = 0x02,
    connectable_nonscannable_directed = 0x03,
    nonconnectable_scannable_undirected = 0x04,
    nonconnectable_nonscannable_undirected = 0x05,
    extended_connectable_nonscannable_undirected = 0x06,
    extended_connectable_nonscannable_directed = 0x07,
    extended_nonconnectable_scannable_undirected = 0x08,
    extended_nonconnectable_scannable_directed = 0x09,
    extended_nonconnectable_nonscannable_undirected = 0x0A,
    extended_nonconnectable_nonscannable_directed = 0x0B,
    _,
};

pub const AdvFilterPolicy = enum(u8) {
    any = 0x00,
    filter_scanreq = 0x01,
    filter_connreq = 0x02,
    filter_both = 0x03,
};

pub const AdvParams = extern struct {
    properties: AdvProperties,
    p_peer_addr: ?*const Addr = null,
    interval: u32,
    duration: u16,
    max_adv_evts: u8 = 0,
    channel_mask: ChannelMask = .{0} ** 5,
    filter_policy: AdvFilterPolicy = .any,
    primary_phy: Phy = .@"1mbps",
    secondary_phy: Phy = .@"1mbps",
    adv_flags: packed struct(u8) {
        set_id: u4 = 0,
        scan_req_notification: u1 = 0,
        _pad: u3 = 0,
    } = .{},
};

pub const AdvData = extern struct {
    adv_data: Data = .{},
    scan_rsp_data: Data = .{},
};

pub const Data = extern struct {
    p_data: ?[*]u8 = null,
    len: u16 = 0,

    pub fn from_slice(slice: []u8) Data {
        return .{ .p_data = slice.ptr, .len = @intCast(slice.len) };
    }
};

pub const Phy = enum(u8) {
    auto = 0x00,
    @"1mbps" = 0x01,
    @"2mbps" = 0x02,
    coded = 0x04,
    not_set = 0xFF,
    _,
};

pub const Phys = extern struct {
    tx_phys: u8,
    rx_phys: u8,
};

pub const ScanParams = extern struct {
    flags: packed struct(u8) {
        extended: u1 = 0,
        report_incomplete_evts: u1 = 0,
        active: u1 = 0,
        filter_policy: u2 = 0,
        _pad: u3 = 0,
    } = .{},
    scan_phys: u8 = 0x01,
    interval: u16,
    window: u16,
    timeout: u16 = 0,
    channel_mask: ChannelMask = .{0} ** 5,
};

pub const PrivacyMode = enum(u8) {
    off = 0x00,
    device_privacy = 0x01,
    network_privacy = 0x02,
};

pub const PrivacyParams = extern struct {
    privacy_mode: PrivacyMode = .off,
    private_addr_type: AddrType = .random_private_resolvable,
    private_addr_cycle_s: u16 = 900,
    p_device_irk: ?*Irk = null,
};

pub const SecKdist = packed struct(u8) {
    enc: u1 = 0,
    id: u1 = 0,
    sign: u1 = 0,
    link: u1 = 0,
    _pad: u4 = 0,
};

pub const IoCaps = enum(u3) {
    display_only = 0,
    display_yesno = 1,
    keyboard_only = 2,
    none = 3,
    keyboard_display = 4,
};

pub const SecParams = extern struct {
    flags: packed struct(u8) {
        bond: u1 = 0,
        mitm: u1 = 0,
        lesc: u1 = 0,
        keypress: u1 = 0,
        io_caps: IoCaps = .none,
        oob: u1 = 0,
    },
    min_key_size: u8 = 7,
    max_key_size: u8 = 16,
    kdist_own: SecKdist = .{},
    kdist_peer: SecKdist = .{},
};

pub const EncInfo = extern struct {
    ltk: [sec_key_len]u8,
    flags: packed struct(u8) {
        lesc: u1 = 0,
        auth: u1 = 0,
        ltk_len: u6 = 0,
    },
};

pub const MasterId = extern struct {
    ediv: u16,
    rand: [sec_rand_len]u8,
};

pub const SignInfo = extern struct {
    csrk: [sec_key_len]u8,
};

pub const LescP256Pk = extern struct {
    pk: [lesc_p256_pk_len]u8,
};

pub const LescDhkey = extern struct {
    key: [lesc_dhkey_len]u8,
};

pub const LescOobData = extern struct {
    addr: Addr,
    r: [sec_key_len]u8,
    c: [sec_key_len]u8,
};

pub const EncKey = extern struct {
    enc_info: EncInfo,
    master_id: MasterId,
};

pub const IdKey = extern struct {
    id_info: Irk,
    id_addr_info: Addr,
};

pub const SecKeys = extern struct {
    p_enc_key: ?*EncKey = null,
    p_id_key: ?*IdKey = null,
    p_sign_key: ?*SignInfo = null,
    p_pk: ?*LescP256Pk = null,
};

pub const SecKeyset = extern struct {
    keys_own: SecKeys = .{},
    keys_peer: SecKeys = .{},
};

pub const DataLengthParams = extern struct {
    max_tx_octets: u16 = 0,
    max_rx_octets: u16 = 0,
    max_tx_time_us: u16 = 0,
    max_rx_time_us: u16 = 0,
};

pub const DataLengthLimitation = extern struct {
    tx_payload_limited_octets: u16,
    rx_payload_limited_octets: u16,
    tx_rx_time_limited_us: u16,
};

pub const ConnCfg = extern struct {
    conn_count: u8 = 1,
    event_length: u16 = 3,
};

pub const ConnEvtTrigger = extern struct {
    ppi_ch_id: u8,
    task_endpoint: u32,
    conn_evt_counter_start: u16,
    period_in_events: u16,
};

pub const AdvReportType = packed struct(u16) {
    connectable: u1 = 0,
    scannable: u1 = 0,
    directed: u1 = 0,
    scan_response: u1 = 0,
    extended_pdu: u1 = 0,
    status: u2 = 0,
    _reserved: u9 = 0,
};

pub const TxPowerRole = enum(u8) {
    adv = 1,
    scan_init = 2,
    conn = 3,
};

pub const CfgRoleCount = extern struct {
    adv_set_count: u8 = 1,
    periph_role_count: u8 = 1,
    central_role_count: u8 = 3,
    central_sec_count: u8 = 1,
    qos_channel_survey_role_available: u8 = 0,
};

pub const CfgDeviceName = extern struct {
    write_perm: ConnSecMode = ConnSecMode.no_access(),
    vloc: u8 = 0x01,
    p_value: ?[*]u8 = null,
    current_len: u16 = 0,
    max_len: u16 = 31,
};

pub const Cfg = extern union {
    role_count: CfgRoleCount,
    device_name: CfgDeviceName,
    ppcp_include_cfg: u8,
    car_include_cfg: u8,
};

// --- GAP Event structures ---

pub const EvtConnected = extern struct {
    peer_addr: Addr,
    role: Role,
    conn_params: ConnParams,
    adv_handle: u8,
    adv_data: AdvData,
};

pub const EvtDisconnected = extern struct {
    reason: u8,
};

pub const EvtConnParamUpdate = extern struct {
    conn_params: ConnParams,
};

pub const EvtSecParamsRequest = extern struct {
    peer_params: SecParams,
};

pub const EvtSecInfoRequest = extern struct {
    peer_addr: Addr,
    master_id: MasterId,
    enc_info: u1,
    id_info: u1,
    sign_info: u1,
};

pub const EvtPasskeyDisplay = extern struct {
    passkey: [passkey_len]u8,
    match_request: u8,
};

pub const EvtAuthKeyRequest = extern struct {
    key_type: u8,
};

pub const EvtLescDhkeyRequest = extern struct {
    p_pk_peer: *LescP256Pk,
    oobd_req: u8,
};

pub const EvtAuthStatus = extern struct {
    auth_status: u8,
    error_src: u8,
    bonded: u8,
    lesc: u8,
    sm1_levels: packed struct(u8) {
        sec_mode_1_lv1: u1 = 0,
        sec_mode_1_lv2: u1 = 0,
        sec_mode_1_lv3: u1 = 0,
        sec_mode_1_lv4: u1 = 0,
        _pad: u4 = 0,
    },
    sm2_levels: packed struct(u8) {
        sec_mode_2_lv1: u1 = 0,
        sec_mode_2_lv2: u1 = 0,
        _pad: u6 = 0,
    },
    kdist_own: SecKdist,
    kdist_peer: SecKdist,
};

pub const EvtConnSecUpdate = extern struct {
    conn_sec: ConnSec,
};

pub const EvtTimeout = extern struct {
    src: TimeoutSrc,
};

pub const TimeoutSrc = enum(u8) {
    scan = 0x01,
    conn = 0x02,
    auth_payload = 0x03,
};

pub const EvtRssiChanged = extern struct {
    rssi: i8,
    ch_index: u8,
};

pub const EvtAdvReport = extern struct {
    type_: AdvReportType,
    peer_addr: Addr,
    direct_addr: Addr,
    primary_phy: Phy,
    secondary_phy: Phy,
    tx_power: i8,
    rssi: i8,
    ch_index: u8,
    set_id: u8,
    data_id: u16 align(1),
    data: Data,
    aux_pointer: AuxPointer,
};

pub const AuxPointer = extern struct {
    aux_offset: u16,
    aux_phy: Phy,
};

pub const EvtSecRequest = extern struct {
    bond: u8,
    mitm: u8,
    lesc: u8,
    keypress: u8,
};

pub const EvtConnParamUpdateRequest = extern struct {
    conn_params: ConnParams,
};

pub const EvtPhyUpdateRequest = extern struct {
    peer_preferred_phys: Phys,
};

pub const EvtPhyUpdate = extern struct {
    status: u8,
    tx_phy: Phy,
    rx_phy: Phy,
};

pub const EvtDataLengthUpdateRequest = extern struct {
    peer_params: DataLengthParams,
};

pub const EvtDataLengthUpdate = extern struct {
    effective_params: DataLengthParams,
};

pub const EvtQosChannelSurveyReport = extern struct {
    channel_energy: [channel_count]i8,
};

pub const EvtAdvSetTerminated = extern struct {
    reason: u8,
    adv_handle: u8,
    num_completed_adv_events: u8,
    adv_data: AdvData,
};

pub const EvtScanReqReport = extern struct {
    adv_handle: u8,
    rssi: i8,
    peer_addr: Addr,
};

pub const EvtKeyPressed = extern struct {
    kp_not: u8,
};

// --- GAP Option types ---

pub const OptChMap = extern struct {
    conn_handle: u16,
    ch_map: ChannelMask,
};

pub const OptLocalConnLatency = extern struct {
    conn_handle: u16,
    requested_latency: u16,
    p_actual_latency: ?*u16,
};

pub const OptPasskey = extern struct {
    p_passkey: ?*const [passkey_len]u8,
};

pub const OptCompatMode1 = extern struct {
    enable: u8,
};

pub const OptAuthPayloadTimeout = extern struct {
    conn_handle: u16,
    auth_payload_timeout: u16,
};

pub const OptSlaveLatencyDisable = extern struct {
    conn_handle: u16,
    disable: u8,
};

pub const Opt = extern union {
    ch_map: OptChMap,
    local_conn_latency: OptLocalConnLatency,
    passkey: OptPasskey,
    compat_mode_1: OptCompatMode1,
    auth_payload_timeout: OptAuthPayloadTimeout,
    slave_latency_disable: OptSlaveLatencyDisable,
};

// --- GAP Event IDs ---

pub const EvtId = enum(u16) {
    connected = 0x10,
    disconnected = 0x11,
    conn_param_update = 0x12,
    sec_params_request = 0x13,
    sec_info_request = 0x14,
    passkey_display = 0x15,
    key_pressed = 0x16,
    auth_key_request = 0x17,
    lesc_dhkey_request = 0x18,
    auth_status = 0x19,
    conn_sec_update = 0x1A,
    timeout = 0x1B,
    rssi_changed = 0x1C,
    adv_report = 0x1D,
    sec_request = 0x1E,
    conn_param_update_request = 0x1F,
    scan_req_report = 0x20,
    phy_update_request = 0x21,
    phy_update = 0x22,
    data_length_update_request = 0x23,
    data_length_update = 0x24,
    qos_channel_survey_report = 0x25,
    adv_set_terminated = 0x26,
    _,
};

// --- Advertising Data Type constants ---

pub const ad_type = struct {
    pub const flags: u8 = 0x01;
    pub const @"16bit_service_uuid_more_available": u8 = 0x02;
    pub const @"16bit_service_uuid_complete": u8 = 0x03;
    pub const @"32bit_service_uuid_more_available": u8 = 0x04;
    pub const @"32bit_service_uuid_complete": u8 = 0x05;
    pub const @"128bit_service_uuid_more_available": u8 = 0x06;
    pub const @"128bit_service_uuid_complete": u8 = 0x07;
    pub const short_local_name: u8 = 0x08;
    pub const complete_local_name: u8 = 0x09;
    pub const tx_power_level: u8 = 0x0A;
    pub const appearance: u8 = 0x19;
    pub const manufacturer_specific_data: u8 = 0xFF;
};

pub const adv_flag = struct {
    pub const le_limited_disc_mode: u8 = 0x01;
    pub const le_general_disc_mode: u8 = 0x02;
    pub const br_edr_not_supported: u8 = 0x04;
    pub const le_only_limited_disc_mode: u8 = 0x01 | 0x04;
    pub const le_only_general_disc_mode: u8 = 0x02 | 0x04;
};

// --- Variant-parameterized SVC function API ---

pub fn Api(comptime v: Variant) type {
    return struct {
        // Type re-exports (shared across all variants, not duplicated)
        pub const addr_len = Self.addr_len;
        pub const sec_key_len = Self.sec_key_len;
        pub const sec_rand_len = Self.sec_rand_len;
        pub const passkey_len = Self.passkey_len;
        pub const lesc_p256_pk_len = Self.lesc_p256_pk_len;
        pub const lesc_dhkey_len = Self.lesc_dhkey_len;
        pub const channel_count = Self.channel_count;
        pub const whitelist_addr_max_count = Self.whitelist_addr_max_count;
        pub const device_identities_max_count = Self.device_identities_max_count;
        pub const devname_max_len = Self.devname_max_len;
        pub const adv_set_data_size_max = Self.adv_set_data_size_max;
        pub const adv_set_data_size_extended_max_supported = Self.adv_set_data_size_extended_max_supported;

        pub const Role = Self.Role;
        pub const AddrType = Self.AddrType;
        pub const Addr = Self.Addr;
        pub const ConnParams = Self.ConnParams;
        pub const ConnSecMode = Self.ConnSecMode;
        pub const ConnSec = Self.ConnSec;
        pub const Irk = Self.Irk;
        pub const ChannelMask = Self.ChannelMask;
        pub const AdvProperties = Self.AdvProperties;
        pub const AdvType = Self.AdvType;
        pub const AdvFilterPolicy = Self.AdvFilterPolicy;
        pub const AdvParams = Self.AdvParams;
        pub const AdvData = Self.AdvData;
        pub const Data = Self.Data;
        pub const Phy = Self.Phy;
        pub const Phys = Self.Phys;
        pub const ScanParams = Self.ScanParams;
        pub const PrivacyMode = Self.PrivacyMode;
        pub const PrivacyParams = Self.PrivacyParams;
        pub const SecKdist = Self.SecKdist;
        pub const IoCaps = Self.IoCaps;
        pub const SecParams = Self.SecParams;
        pub const EncInfo = Self.EncInfo;
        pub const MasterId = Self.MasterId;
        pub const SignInfo = Self.SignInfo;
        pub const LescP256Pk = Self.LescP256Pk;
        pub const LescDhkey = Self.LescDhkey;
        pub const LescOobData = Self.LescOobData;
        pub const EncKey = Self.EncKey;
        pub const IdKey = Self.IdKey;
        pub const SecKeys = Self.SecKeys;
        pub const SecKeyset = Self.SecKeyset;
        pub const DataLengthParams = Self.DataLengthParams;
        pub const DataLengthLimitation = Self.DataLengthLimitation;
        pub const ConnCfg = Self.ConnCfg;
        pub const ConnEvtTrigger = Self.ConnEvtTrigger;
        pub const AdvReportType = Self.AdvReportType;
        pub const TxPowerRole = Self.TxPowerRole;
        pub const CfgRoleCount = Self.CfgRoleCount;
        pub const CfgDeviceName = Self.CfgDeviceName;
        pub const Cfg = Self.Cfg;

        pub const EvtConnected = Self.EvtConnected;
        pub const EvtDisconnected = Self.EvtDisconnected;
        pub const EvtConnParamUpdate = Self.EvtConnParamUpdate;
        pub const EvtSecParamsRequest = Self.EvtSecParamsRequest;
        pub const EvtSecInfoRequest = Self.EvtSecInfoRequest;
        pub const EvtPasskeyDisplay = Self.EvtPasskeyDisplay;
        pub const EvtAuthKeyRequest = Self.EvtAuthKeyRequest;
        pub const EvtLescDhkeyRequest = Self.EvtLescDhkeyRequest;
        pub const EvtAuthStatus = Self.EvtAuthStatus;
        pub const EvtConnSecUpdate = Self.EvtConnSecUpdate;
        pub const EvtTimeout = Self.EvtTimeout;
        pub const TimeoutSrc = Self.TimeoutSrc;
        pub const EvtRssiChanged = Self.EvtRssiChanged;
        pub const EvtAdvReport = Self.EvtAdvReport;
        pub const AuxPointer = Self.AuxPointer;
        pub const EvtSecRequest = Self.EvtSecRequest;
        pub const EvtConnParamUpdateRequest = Self.EvtConnParamUpdateRequest;
        pub const EvtPhyUpdateRequest = Self.EvtPhyUpdateRequest;
        pub const EvtPhyUpdate = Self.EvtPhyUpdate;
        pub const EvtDataLengthUpdateRequest = Self.EvtDataLengthUpdateRequest;
        pub const EvtDataLengthUpdate = Self.EvtDataLengthUpdate;
        pub const EvtQosChannelSurveyReport = Self.EvtQosChannelSurveyReport;
        pub const EvtAdvSetTerminated = Self.EvtAdvSetTerminated;
        pub const EvtScanReqReport = Self.EvtScanReqReport;
        pub const EvtKeyPressed = Self.EvtKeyPressed;

        pub const OptChMap = Self.OptChMap;
        pub const OptLocalConnLatency = Self.OptLocalConnLatency;
        pub const OptPasskey = Self.OptPasskey;
        pub const OptCompatMode1 = Self.OptCompatMode1;
        pub const OptAuthPayloadTimeout = Self.OptAuthPayloadTimeout;
        pub const OptSlaveLatencyDisable = Self.OptSlaveLatencyDisable;
        pub const Opt = Self.Opt;

        pub const EvtId = Self.EvtId;
        pub const ad_type = Self.ad_type;
        pub const adv_flag = Self.adv_flag;

        // --- SVC functions ---

        pub fn addr_set(p_addr: *const Self.Addr) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.addr_set), @intFromPtr(p_addr)));
        }

        pub fn addr_get(p_addr: *Self.Addr) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.addr_get), @intFromPtr(p_addr)));
        }

        pub fn whitelist_set(pp_wl_addrs: [*]const *const Self.Addr, len: u8) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.whitelist_set), @intFromPtr(pp_wl_addrs), len));
        }

        pub fn device_identities_set(pp_id_keys: [*]const *const Self.Addr, pp_local_irks: ?[*]const *const Self.Irk, len: u8) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.device_identities_set), @intFromPtr(pp_id_keys), @intFromPtr(pp_local_irks), len));
        }

        pub fn privacy_set(p_privacy_params: *const Self.PrivacyParams) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.privacy_set), @intFromPtr(p_privacy_params)));
        }

        pub fn privacy_get(p_privacy_params: *Self.PrivacyParams) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.privacy_get), @intFromPtr(p_privacy_params)));
        }

        pub fn adv_set_configure(p_adv_handle: *u8, p_adv_data: ?*const Self.AdvData, p_adv_params: ?*const Self.AdvParams) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.adv_set_configure), @intFromPtr(p_adv_handle), @intFromPtr(p_adv_data), @intFromPtr(p_adv_params)));
        }

        pub fn adv_start(adv_handle: u8, conn_cfg_tag: u8) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.adv_start), adv_handle, conn_cfg_tag));
        }

        pub fn adv_stop(adv_handle: u8) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.adv_stop), adv_handle));
        }

        pub fn conn_param_update(conn_handle: u16, p_conn_params: *const Self.ConnParams) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.conn_param_update), conn_handle, @intFromPtr(p_conn_params)));
        }

        pub fn disconnect(conn_handle: u16, hci_status_code: u8) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.disconnect), conn_handle, hci_status_code));
        }

        pub fn tx_power_set(role: Self.TxPowerRole, handle: u16, tx_power: i8) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.tx_power_set), @intFromEnum(role), handle, @as(usize, @bitCast(@as(isize, tx_power)))));
        }

        pub fn appearance_set(appearance: u16) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.appearance_set), appearance));
        }

        pub fn appearance_get(p_appearance: *u16) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.appearance_get), @intFromPtr(p_appearance)));
        }

        pub fn ppcp_set(p_conn_params: *const Self.ConnParams) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.ppcp_set), @intFromPtr(p_conn_params)));
        }

        pub fn ppcp_get(p_conn_params: *Self.ConnParams) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.ppcp_get), @intFromPtr(p_conn_params)));
        }

        pub fn device_name_set(p_write_perm: *const Self.ConnSecMode, p_dev_name: [*]const u8, len: u16) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.device_name_set), @intFromPtr(p_write_perm), @intFromPtr(p_dev_name), len));
        }

        pub fn device_name_get(p_dev_name: ?[*]u8, p_len: *u16) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.device_name_get), @intFromPtr(p_dev_name), @intFromPtr(p_len)));
        }

        pub fn authenticate(conn_handle: u16, p_sec_params: ?*const Self.SecParams) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.authenticate), conn_handle, @intFromPtr(p_sec_params)));
        }

        pub fn sec_params_reply(conn_handle: u16, sec_status: u8, p_sec_params: ?*const Self.SecParams, p_sec_keyset: ?*Self.SecKeyset) Error!void {
            return err.check(svc.svcall4(v.gap_svc(.sec_params_reply), conn_handle, sec_status, @intFromPtr(p_sec_params), @intFromPtr(p_sec_keyset)));
        }

        pub fn auth_key_reply(conn_handle: u16, key_type: u8, p_key: ?[*]const u8) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.auth_key_reply), conn_handle, key_type, @intFromPtr(p_key)));
        }

        pub fn lesc_dhkey_reply(conn_handle: u16, p_dhkey: *const Self.LescDhkey) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.lesc_dhkey_reply), conn_handle, @intFromPtr(p_dhkey)));
        }

        pub fn keypress_notify(conn_handle: u16, kp_not: u8) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.keypress_notify), conn_handle, kp_not));
        }

        pub fn lesc_oob_data_get(conn_handle: u16, p_pk_own: *const Self.LescP256Pk, p_oobd_own: *Self.LescOobData) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.lesc_oob_data_get), conn_handle, @intFromPtr(p_pk_own), @intFromPtr(p_oobd_own)));
        }

        pub fn lesc_oob_data_set(conn_handle: u16, p_oobd_own: ?*const Self.LescOobData, p_oobd_peer: ?*const Self.LescOobData) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.lesc_oob_data_set), conn_handle, @intFromPtr(p_oobd_own), @intFromPtr(p_oobd_peer)));
        }

        /// Central-only: encrypt a connection as the central device.
        pub fn encrypt(conn_handle: u16, p_master_id: *const Self.MasterId, p_enc_info: *const Self.EncInfo) Error!void {
            if (!v.has_central()) @compileError("encrypt requires central role (S132/S140)");
            return err.check(svc.svcall3(v.gap_svc(.encrypt), conn_handle, @intFromPtr(p_master_id), @intFromPtr(p_enc_info)));
        }

        pub fn sec_info_reply(conn_handle: u16, p_enc_info: ?*const Self.EncInfo, p_id_info: ?*const Self.Irk, p_sign_info: ?*const Self.SignInfo) Error!void {
            return err.check(svc.svcall4(v.gap_svc(.sec_info_reply), conn_handle, @intFromPtr(p_enc_info), @intFromPtr(p_id_info), @intFromPtr(p_sign_info)));
        }

        pub fn conn_sec_get(conn_handle: u16, p_conn_sec: *Self.ConnSec) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.conn_sec_get), conn_handle, @intFromPtr(p_conn_sec)));
        }

        pub fn rssi_start(conn_handle: u16, threshold_dbm: u8, skip_count: u8) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.rssi_start), conn_handle, threshold_dbm, skip_count));
        }

        pub fn rssi_stop(conn_handle: u16) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.rssi_stop), conn_handle));
        }

        /// Observer/central-only: start scanning for advertising packets.
        pub fn scan_start(p_scan_params: *const Self.ScanParams, p_adv_report_buffer: *const Self.Data) Error!void {
            if (!v.has_observer()) @compileError("scan_start requires observer role (S113/S132/S140)");
            return err.check(svc.svcall2(v.gap_svc(.scan_start), @intFromPtr(p_scan_params), @intFromPtr(p_adv_report_buffer)));
        }

        /// Observer/central-only: stop scanning.
        pub fn scan_stop() Error!void {
            if (!v.has_observer()) @compileError("scan_stop requires observer role (S113/S132/S140)");
            return err.check(svc.svcall0(v.gap_svc(.scan_stop)));
        }

        /// Central-only: initiate a connection to a peer.
        pub fn connect(p_peer_addr: *const Self.Addr, p_scan_params: *const Self.ScanParams, p_conn_params: *const Self.ConnParams, conn_cfg_tag: u8) Error!void {
            if (!v.has_central()) @compileError("connect requires central role (S132/S140)");
            return err.check(svc.svcall4(v.gap_svc(.connect), @intFromPtr(p_peer_addr), @intFromPtr(p_scan_params), @intFromPtr(p_conn_params), conn_cfg_tag));
        }

        /// Central-only: cancel a pending connection attempt.
        pub fn connect_cancel() Error!void {
            if (!v.has_central()) @compileError("connect_cancel requires central role (S132/S140)");
            return err.check(svc.svcall0(v.gap_svc(.connect_cancel)));
        }

        pub fn rssi_get(conn_handle: u16, p_rssi: *i8, p_ch_index: ?*u8) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.rssi_get), conn_handle, @intFromPtr(p_rssi), @intFromPtr(p_ch_index)));
        }

        pub fn phy_update(conn_handle: u16, p_gap_phys: *const Self.Phys) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.phy_update), conn_handle, @intFromPtr(p_gap_phys)));
        }

        pub fn data_length_update(conn_handle: u16, p_dl_params: ?*const Self.DataLengthParams, p_dl_limitation: ?*Self.DataLengthLimitation) Error!void {
            return err.check(svc.svcall3(v.gap_svc(.data_length_update), conn_handle, @intFromPtr(p_dl_params), @intFromPtr(p_dl_limitation)));
        }

        /// Start QoS channel survey (S122/S132/S140 only).
        pub fn qos_channel_survey_start(interval_us: u32) Error!void {
            if (!v.has_qos_survey()) @compileError("qos_channel_survey_start not available on " ++ @tagName(v));
            return err.check(svc.svcall1(v.gap_svc(.qos_channel_survey_start), interval_us));
        }

        /// Stop QoS channel survey (S122/S132/S140 only).
        pub fn qos_channel_survey_stop() Error!void {
            if (!v.has_qos_survey()) @compileError("qos_channel_survey_stop not available on " ++ @tagName(v));
            return err.check(svc.svcall0(v.gap_svc(.qos_channel_survey_stop)));
        }

        pub fn adv_addr_get(adv_handle: u8, p_addr: *Self.Addr) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.adv_addr_get), adv_handle, @intFromPtr(p_addr)));
        }

        pub fn next_conn_evt_counter_get(conn_handle: u16, p_counter: *u16) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.next_conn_evt_counter_get), conn_handle, @intFromPtr(p_counter)));
        }

        pub fn conn_evt_trigger_start(conn_handle: u16, p_params: *const Self.ConnEvtTrigger) Error!void {
            return err.check(svc.svcall2(v.gap_svc(.conn_evt_trigger_start), conn_handle, @intFromPtr(p_params)));
        }

        pub fn conn_evt_trigger_stop(conn_handle: u16) Error!void {
            return err.check(svc.svcall1(v.gap_svc(.conn_evt_trigger_stop), conn_handle));
        }
    };
}
