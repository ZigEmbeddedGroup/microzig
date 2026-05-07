// BLE GATT Server - service/characteristic management, notifications, indications.

const svc = @import("svc.zig");
const err = @import("err.zig");
const gatt = @import("gatt.zig");
const gap = @import("gap.zig");
const Error = err.Error;

// SVC base = 0xA8
const SVC_BASE = 0xA8;

pub const Uuid = extern struct {
    uuid: u16,
    type_: u8,
};

pub const SrvcType = enum(u8) {
    invalid = 0x00,
    primary = 0x01,
    secondary = 0x02,
};

pub const Vloc = enum(u2) {
    invalid = 0,
    stack = 1,
    user = 2,
};

pub const AuthorizeType = enum(u8) {
    invalid = 0x00,
    read = 0x01,
    write = 0x02,
};

pub const AttrMd = extern struct {
    read_perm: gap.ConnSecMode = gap.ConnSecMode.open(),
    write_perm: gap.ConnSecMode = gap.ConnSecMode.open(),
    flags: packed struct(u8) {
        vlen: u1 = 0,
        vloc: Vloc = .stack,
        rd_auth: u1 = 0,
        wr_auth: u1 = 0,
        _pad: u3 = 0,
    } = .{},
};

pub const Attr = extern struct {
    p_uuid: *const Uuid,
    p_attr_md: *const AttrMd,
    init_len: u16,
    init_offs: u16 = 0,
    max_len: u16,
    p_value: ?[*]u8 = null,
};

pub const Value = extern struct {
    len: u16,
    offset: u16 = 0,
    p_value: ?[*]u8 = null,
};

pub const CharPf = extern struct {
    format: gatt.CpfFormat,
    exponent: i8 = 0,
    unit: u16 = 0,
    name_space: u8 = 0,
    desc: u16 = 0,
};

pub const CharMd = extern struct {
    char_props: gatt.CharProps = .{},
    char_ext_props: gatt.CharExtProps = .{},
    p_char_user_desc: ?[*]const u8 = null,
    char_user_desc_max_size: u16 = 0,
    char_user_desc_size: u16 = 0,
    p_char_pf: ?*const CharPf = null,
    p_user_desc_md: ?*const AttrMd = null,
    p_cccd_md: ?*const AttrMd = null,
    p_sccd_md: ?*const AttrMd = null,
};

pub const CharHandles = extern struct {
    value_handle: u16 = 0,
    user_desc_handle: u16 = 0,
    cccd_handle: u16 = 0,
    sccd_handle: u16 = 0,
};

pub const HvxParams = extern struct {
    handle: u16,
    type_: gatt.HvxType,
    offset: u16 = 0,
    p_len: *u16,
    p_data: ?[*]const u8 = null,
};

pub const AuthorizeParams = extern struct {
    gatt_status: gatt.StatusCode = .success,
    flags: packed struct(u8) {
        update: u1 = 0,
        _pad: u7 = 0,
    } = .{},
    offset: u16 = 0,
    len: u16 = 0,
    p_data: ?[*]const u8 = null,
};

pub const RwAuthorizeReplyParams = extern struct {
    type_: AuthorizeType,
    params: extern union {
        read: AuthorizeParams,
        write: AuthorizeParams,
    },
};

pub const ConnCfg = extern struct {
    hvn_tx_queue_size: u8 = 1,
};

pub const CfgServiceChanged = extern struct {
    flags: packed struct(u8) {
        service_changed: u1 = 1,
        _pad: u7 = 0,
    } = .{},
};

pub const CfgAttrTabSize = extern struct {
    attr_tab_size: u32 = 1408,
};

pub const Cfg = extern union {
    service_changed: CfgServiceChanged,
    attr_tab_size: CfgAttrTabSize,
};

pub const SysAttrFlag = struct {
    pub const sys_srvcs: u32 = 1 << 0;
    pub const usr_srvcs: u32 = 1 << 1;
};

// --- Event structures ---

pub const EvtWrite = extern struct {
    handle: u16,
    uuid: Uuid,
    op: u8,
    auth_required: u8,
    offset: u16,
    len: u16,
    data: [1]u8,
};

pub const EvtRead = extern struct {
    handle: u16,
    uuid: Uuid,
    offset: u16,
};

pub const EvtRwAuthorizeRequest = extern struct {
    type_: AuthorizeType,
    request: extern union {
        read: EvtRead,
        write: EvtWrite,
    },
};

pub const EvtSysAttrMissing = extern struct {
    hint: u8,
};

pub const EvtHvc = extern struct {
    handle: u16,
};

pub const EvtExchangeMtuRequest = extern struct {
    client_rx_mtu: u16,
};

pub const EvtTimeout = extern struct {
    src: u8,
};

pub const EvtHvnTxComplete = extern struct {
    count: u8,
};

pub const EvtId = enum(u16) {
    write = 0x50,
    rw_authorize_request = 0x52,
    sys_attr_missing = 0x53,
    hvc = 0x54,
    sc_confirm = 0x55,
    exchange_mtu_request = 0x56,
    timeout = 0x57,
    hvn_tx_complete = 0x58,
    _,
};

// --- SVC functions ---

pub fn service_add(type_: SrvcType, p_uuid: *const Uuid, p_handle: *u16) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 6, @intFromEnum(type_), @intFromPtr(p_uuid), @intFromPtr(p_handle)));
}

pub fn include_add(service_handle: u16, inc_srvc_handle: u16, p_include_handle: *u16) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 7, service_handle, inc_srvc_handle, @intFromPtr(p_include_handle)));
}

pub fn characteristic_add(service_handle: u16, p_char_md: *const CharMd, p_attr_char_value: *const Attr, p_handles: *CharHandles) Error!void {
    return err.check(svc.svcall4(SVC_BASE + 1, service_handle, @intFromPtr(p_char_md), @intFromPtr(p_attr_char_value), @intFromPtr(p_handles)));
}

pub fn descriptor_add(char_handle: u16, p_attr: *const Attr, p_handle: *u16) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 2, char_handle, @intFromPtr(p_attr), @intFromPtr(p_handle)));
}

pub fn value_set(conn_handle: u16, handle: u16, p_value: *Value) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 3, conn_handle, handle, @intFromPtr(p_value)));
}

pub fn value_get(conn_handle: u16, handle: u16, p_value: *Value) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 4, conn_handle, handle, @intFromPtr(p_value)));
}

pub fn hvx(conn_handle: u16, p_hvx_params: *HvxParams) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 5, conn_handle, @intFromPtr(p_hvx_params)));
}

pub fn service_changed(conn_handle: u16, start_handle: u16, end_handle: u16) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 0, conn_handle, start_handle, end_handle));
}

pub fn rw_authorize_reply(conn_handle: u16, p_rw_authorize_reply_params: *const RwAuthorizeReplyParams) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 8, conn_handle, @intFromPtr(p_rw_authorize_reply_params)));
}

pub fn sys_attr_set(conn_handle: u16, p_sys_attr_data: ?[*]const u8, len: u16, flags: u32) Error!void {
    return err.check(svc.svcall4(SVC_BASE + 9, conn_handle, @intFromPtr(p_sys_attr_data), len, flags));
}

pub fn sys_attr_get(conn_handle: u16, p_sys_attr_data: ?[*]u8, p_len: *u16, flags: u32) Error!void {
    return err.check(svc.svcall4(SVC_BASE + 10, conn_handle, @intFromPtr(p_sys_attr_data), @intFromPtr(p_len), flags));
}

pub fn initial_user_handle_get(p_handle: *u16) Error!void {
    return err.check(svc.svcall1(SVC_BASE + 11, @intFromPtr(p_handle)));
}

pub fn attr_get(handle: u16, p_uuid: ?*Uuid, p_md: ?*AttrMd) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 12, handle, @intFromPtr(p_uuid), @intFromPtr(p_md)));
}

pub fn exchange_mtu_reply(conn_handle: u16, server_rx_mtu: u16) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 13, conn_handle, server_rx_mtu));
}
