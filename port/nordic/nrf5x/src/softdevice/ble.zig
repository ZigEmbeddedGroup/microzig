// BLE core - enable, event retrieval, UUID management, configuration.

const svc = @import("svc.zig");
const err = @import("err.zig");
const gap = @import("gap.zig");
const gattc = @import("gattc.zig");
const gatts = @import("gatts.zig");
const gatt = @import("gatt.zig");
const l2cap = @import("l2cap.zig");
const Error = err.Error;

// SVC base = 0x60
const SVC_BASE = 0x60;

pub const conn_handle_invalid: u16 = 0xFFFF;
pub const conn_handle_all: u16 = 0xFFFE;
pub const conn_cfg_tag_default: u8 = 0;
pub const uuid_vs_count_default: u8 = 10;
pub const uuid_vs_count_max: u8 = 254;
pub const evt_ptr_alignment: u8 = 4;

pub const UuidType = enum(u8) {
    unknown = 0x00,
    ble = 0x01,
    vendor_begin = 0x02,
    _,
};

pub const Uuid = extern struct {
    uuid: u16,
    type_: u8,
};

pub const Uuid128 = extern struct {
    uuid128: [16]u8,
};

pub const UserMemType = enum(u8) {
    invalid = 0x00,
    gatts_queued_writes = 0x01,
};

pub const UserMemBlock = extern struct {
    p_mem: ?[*]u8 = null,
    len: u16 = 0,
};

pub const Version = extern struct {
    version_number: u8,
    company_id: u16,
    subversion_number: u16,
};

pub const PaLnaCfg = packed struct(u8) {
    enable: u1 = 0,
    active_high: u1 = 0,
    gpio_pin: u6 = 0,
};

pub const CommonOptPaLna = extern struct {
    pa_cfg: PaLnaCfg = .{},
    lna_cfg: PaLnaCfg = .{},
    ppi_ch_id_set: u8 = 0,
    ppi_ch_id_clr: u8 = 0,
    gpiote_ch_id: u8 = 0,
};

pub const CommonOptConnEvtExt = extern struct {
    flags: packed struct(u8) {
        enable: u1 = 0,
        _pad: u7 = 0,
    } = .{},
};

pub const CommonOptExtendedRcCal = extern struct {
    flags: packed struct(u8) {
        enable: u1 = 1,
        _pad: u7 = 0,
    } = .{},
};

pub const CommonOpt = extern union {
    pa_lna: CommonOptPaLna,
    conn_evt_ext: CommonOptConnEvtExt,
    extended_rc_cal: CommonOptExtendedRcCal,
};

pub const Opt = extern union {
    common_opt: CommonOpt,
    gap_opt: gap.Opt,
    gattc_opt: gattc.Opt,
};

pub const ConnCfgGap = extern struct {
    conn_count: u8 = 1,
    event_length: u16 = 3,
};

pub const ConnCfg = extern struct {
    conn_cfg_tag: u8,
    params: extern union {
        gap_conn_cfg: gap.ConnCfg,
        gattc_conn_cfg: gattc.ConnCfg,
        gatts_conn_cfg: gatts.ConnCfg,
        gatt_conn_cfg: gatt.ConnCfg,
        l2cap_conn_cfg: l2cap.ConnCfg,
    },
};

pub const CommonCfgVsUuid = extern struct {
    vs_uuid_count: u8 = uuid_vs_count_default,
};

pub const CommonCfg = extern union {
    vs_uuid_cfg: CommonCfgVsUuid,
};

pub const GapCfg = extern union {
    role_count: gap.CfgRoleCount,
    device_name: gap.CfgDeviceName,
    ppcp_include_cfg: u8,
    car_include_cfg: u8,
};

pub const GattsCfg = extern union {
    service_changed: gatts.CfgServiceChanged,
    attr_tab_size: gatts.CfgAttrTabSize,
};

pub const Cfg = extern union {
    conn_cfg: ConnCfg,
    common_cfg: CommonCfg,
    gap_cfg: GapCfg,
    gatts_cfg: GattsCfg,
};

// BLE Configuration IDs
pub const cfg_id = struct {
    // Common
    pub const vs_uuid: u32 = 0x01;
    // Connection
    pub const conn_gap: u32 = 0x20;
    pub const conn_gattc: u32 = 0x21;
    pub const conn_gatts: u32 = 0x22;
    pub const conn_gatt: u32 = 0x23;
    pub const conn_l2cap: u32 = 0x24;
    // GAP
    pub const gap_role_count: u32 = 0x40;
    pub const gap_device_name: u32 = 0x41;
    pub const gap_ppcp_incl: u32 = 0x42;
    pub const gap_car_incl: u32 = 0x43;
    // GATTS
    pub const gatts_service_changed: u32 = 0xA0;
    pub const gatts_attr_tab_size: u32 = 0xA1;
};

// BLE Option IDs
pub const opt_id = struct {
    pub const common_pa_lna: u32 = 0x01;
    pub const common_conn_evt_ext: u32 = 0x02;
    pub const common_extended_rc_cal: u32 = 0x03;
    pub const gap_ch_map: u32 = 0x20;
    pub const gap_local_conn_latency: u32 = 0x21;
    pub const gap_passkey: u32 = 0x22;
    pub const gap_compat_mode_1: u32 = 0x23;
    pub const gap_auth_payload_timeout: u32 = 0x24;
    pub const gap_slave_latency_disable: u32 = 0x25;
    pub const gattc_uuid_disc: u32 = 0x60;
};

// Event header
pub const EvtHdr = extern struct {
    evt_id: u16,
    evt_len: u16,
};

// Common event IDs
pub const EvtId = enum(u16) {
    user_mem_request = 0x01,
    user_mem_release = 0x02,
    _,
};

// Standard BLE UUIDs
pub const uuid = struct {
    pub const service_primary: u16 = 0x2800;
    pub const service_secondary: u16 = 0x2801;
    pub const service_include: u16 = 0x2802;
    pub const characteristic: u16 = 0x2803;
    pub const descriptor_char_ext_prop: u16 = 0x2900;
    pub const descriptor_char_user_desc: u16 = 0x2901;
    pub const descriptor_client_char_config: u16 = 0x2902;
    pub const descriptor_server_char_config: u16 = 0x2903;
    pub const gap: u16 = 0x1800;
    pub const gatt_: u16 = 0x1801;
    pub const gap_device_name: u16 = 0x2A00;
    pub const gap_appearance: u16 = 0x2A01;
    pub const gap_ppcp: u16 = 0x2A04;
    pub const gatt_service_changed: u16 = 0x2A05;
};

// --- SVC functions ---

pub fn enable(p_app_ram_base: *u32) Error!void {
    return err.check(svc.svcall1(SVC_BASE + 0, @intFromPtr(p_app_ram_base)));
}

pub fn cfg_set(cfg_id_val: u32, p_cfg: *const Cfg, app_ram_base: u32) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 9, cfg_id_val, @intFromPtr(p_cfg), app_ram_base));
}

pub fn evt_get(p_dest: ?[*]align(4) u8, p_len: *u16) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 1, @intFromPtr(p_dest), @intFromPtr(p_len)));
}

pub fn uuid_vs_add(p_vs_uuid: *const Uuid128, p_uuid_type: *u8) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 2, @intFromPtr(p_vs_uuid), @intFromPtr(p_uuid_type)));
}

pub fn uuid_vs_remove(p_uuid_type: *u8) Error!void {
    return err.check(svc.svcall1(SVC_BASE + 10, @intFromPtr(p_uuid_type)));
}

pub fn uuid_decode(uuid_le_len: u8, p_uuid_le: [*]const u8, p_uuid: *Uuid) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 3, uuid_le_len, @intFromPtr(p_uuid_le), @intFromPtr(p_uuid)));
}

pub fn uuid_encode(p_uuid: *const Uuid, p_uuid_le_len: *u8, p_uuid_le: ?[*]u8) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 4, @intFromPtr(p_uuid), @intFromPtr(p_uuid_le_len), @intFromPtr(p_uuid_le)));
}

pub fn version_get(p_version: *Version) Error!void {
    return err.check(svc.svcall1(SVC_BASE + 5, @intFromPtr(p_version)));
}

pub fn user_mem_reply(conn_handle: u16, p_block: ?*const UserMemBlock) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 6, conn_handle, @intFromPtr(p_block)));
}

pub fn opt_set(opt_id_val: u32, p_opt: *const Opt) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 7, opt_id_val, @intFromPtr(p_opt)));
}

pub fn opt_get(opt_id_val: u32, p_opt: *Opt) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 8, opt_id_val, @intFromPtr(p_opt)));
}
