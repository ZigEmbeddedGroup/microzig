// BLE GATT Client - service/characteristic discovery, read, write, and notifications.

const svc = @import("svc.zig");
const err = @import("err.zig");
const gatt = @import("gatt.zig");
const Error = err.Error;

// SVC base = 0x9B
const SVC_BASE = 0x9B;

pub const Uuid = extern struct {
    uuid: u16,
    type_: u8,
};

pub const Uuid128 = extern struct {
    uuid128: [16]u8,
};

pub const HandleRange = extern struct {
    start_handle: u16,
    end_handle: u16,
};

pub const Service = extern struct {
    uuid: Uuid,
    handle_range: HandleRange,
};

pub const Include = extern struct {
    handle: u16,
    included_srvc: Service,
};

pub const Char = extern struct {
    uuid: Uuid,
    char_props: gatt.CharProps,
    char_ext_props_flags: packed struct(u8) {
        char_ext_props: u1 = 0,
        _pad: u7 = 0,
    } = .{},
    handle_decl: u16,
    handle_value: u16,
};

pub const Desc = extern struct {
    handle: u16,
    uuid: Uuid,
};

pub const WriteParams = extern struct {
    write_op: gatt.WriteOp,
    flags: u8 = 0,
    handle: u16,
    offset: u16 = 0,
    len: u16,
    p_value: [*]const u8,
};

pub const AttrInfo16 = extern struct {
    handle: u16,
    uuid: Uuid,
};

pub const AttrInfo128 = extern struct {
    handle: u16,
    uuid: Uuid128,
};

pub const AttrInfoFormat = enum(u8) {
    @"16bit" = 1,
    @"128bit" = 2,
};

pub const ConnCfg = extern struct {
    write_cmd_tx_queue_size: u8 = 1,
};

pub const OptUuidDisc = extern struct {
    auto_add_vs_enable_flags: packed struct(u8) {
        auto_add_vs_enable: u1 = 0,
        _pad: u7 = 0,
    } = .{},
};

pub const Opt = extern union {
    uuid_disc: OptUuidDisc,
};

// --- Event structures ---

pub const EvtPrimSrvcDiscRsp = extern struct {
    count: u16,
    services: [1]Service,
};

pub const EvtRelDiscRsp = extern struct {
    count: u16,
    includes: [1]Include,
};

pub const EvtCharDiscRsp = extern struct {
    count: u16,
    chars: [1]Char,
};

pub const EvtDescDiscRsp = extern struct {
    count: u16,
    descs: [1]Desc,
};

pub const EvtReadRsp = extern struct {
    handle: u16,
    offset: u16,
    len: u16,
    data: [1]u8,
};

pub const EvtCharValsReadRsp = extern struct {
    len: u16,
    values: [1]u8,
};

pub const EvtWriteRsp = extern struct {
    handle: u16,
    write_op: u8,
    offset: u16,
    len: u16,
    data: [1]u8,
};

pub const EvtHvx = extern struct {
    handle: u16,
    type_: gatt.HvxType,
    len: u16,
    data: [1]u8,
};

pub const EvtExchangeMtuRsp = extern struct {
    server_rx_mtu: u16,
};

pub const EvtTimeout = extern struct {
    src: u8,
};

pub const EvtWriteCmdTxComplete = extern struct {
    count: u8,
};

pub const EvtId = enum(u16) {
    prim_srvc_disc_rsp = 0x30,
    rel_disc_rsp = 0x31,
    char_disc_rsp = 0x32,
    desc_disc_rsp = 0x33,
    attr_info_disc_rsp = 0x34,
    char_val_by_uuid_read_rsp = 0x35,
    read_rsp = 0x36,
    char_vals_read_rsp = 0x37,
    write_rsp = 0x38,
    hvx = 0x39,
    exchange_mtu_rsp = 0x3A,
    timeout = 0x3B,
    write_cmd_tx_complete = 0x3C,
    _,
};

// --- SVC functions ---

pub fn primary_services_discover(conn_handle: u16, start_handle: u16, p_srvc_uuid: ?*const Uuid) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 0, conn_handle, start_handle, @intFromPtr(p_srvc_uuid)));
}

pub fn relationships_discover(conn_handle: u16, p_handle_range: *const HandleRange) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 1, conn_handle, @intFromPtr(p_handle_range)));
}

pub fn characteristics_discover(conn_handle: u16, p_handle_range: *const HandleRange) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 2, conn_handle, @intFromPtr(p_handle_range)));
}

pub fn descriptors_discover(conn_handle: u16, p_handle_range: *const HandleRange) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 3, conn_handle, @intFromPtr(p_handle_range)));
}

pub fn attr_info_discover(conn_handle: u16, p_handle_range: *const HandleRange) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 4, conn_handle, @intFromPtr(p_handle_range)));
}

pub fn char_value_by_uuid_read(conn_handle: u16, p_uuid: *const Uuid, p_handle_range: *const HandleRange) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 5, conn_handle, @intFromPtr(p_uuid), @intFromPtr(p_handle_range)));
}

pub fn read(conn_handle: u16, handle: u16, offset: u16) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 6, conn_handle, handle, offset));
}

pub fn char_values_read(conn_handle: u16, p_handles: [*]const u16, handle_count: u16) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 7, conn_handle, @intFromPtr(p_handles), handle_count));
}

pub fn write(conn_handle: u16, p_write_params: *const WriteParams) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 8, conn_handle, @intFromPtr(p_write_params)));
}

pub fn hv_confirm(conn_handle: u16, handle: u16) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 9, conn_handle, handle));
}

pub fn exchange_mtu_request(conn_handle: u16, client_rx_mtu: u16) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 10, conn_handle, client_rx_mtu));
}
