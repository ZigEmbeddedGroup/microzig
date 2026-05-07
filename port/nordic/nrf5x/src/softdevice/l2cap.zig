// BLE L2CAP (Logical Link Control and Adaptation Protocol).

const svc = @import("svc.zig");
const err = @import("err.zig");
const gap = @import("gap.zig");
const Error = err.Error;

// SVC base = 0xB8
const SVC_BASE = 0xB8;

pub const ch_count_max = 64;
pub const mtu_min: u16 = 23;
pub const mps_min: u16 = 23;
pub const cid_invalid: u16 = 0x0000;
pub const credits_default: u16 = 1;

pub const ChSetupRefusedSrc = enum(u8) {
    local = 0x01,
    remote = 0x02,
};

pub const ChStatusCode = enum(u16) {
    success = 0x0000,
    le_psm_not_supported = 0x0002,
    no_resources = 0x0004,
    insuf_authentication = 0x0005,
    insuf_authorization = 0x0006,
    insuf_enc_key_size = 0x0007,
    insuf_enc = 0x0008,
    invalid_src_cid = 0x0009,
    src_cid_already_allocated = 0x000A,
    unacceptable_params = 0x000B,
    _,
};

pub const ChRxParams = extern struct {
    rx_mtu: u16,
    rx_mps: u16,
    sdu_buf: gap.Data = .{},
};

pub const ChSetupParams = extern struct {
    rx_params: ChRxParams,
    le_psm: u16,
    status: ChStatusCode = .success,
};

pub const ChTxParams = extern struct {
    tx_mtu: u16,
    peer_mps: u16,
    tx_mps: u16,
    credits: u16,
};

pub const ConnCfg = extern struct {
    rx_mps: u16 = 0,
    tx_mps: u16 = 0,
    rx_queue_size: u8 = 0,
    tx_queue_size: u8 = 0,
    ch_count: u8 = 0,
};

// --- Event structures ---

pub const EvtChSetupRequest = extern struct {
    tx_params: ChTxParams,
    le_psm: u16,
};

pub const EvtChSetupRefused = extern struct {
    source: ChSetupRefusedSrc,
    status: ChStatusCode,
};

pub const EvtChSetup = extern struct {
    tx_params: ChTxParams,
};

pub const EvtChSduBufReleased = extern struct {
    sdu_buf: gap.Data,
};

pub const EvtChCredit = extern struct {
    credits: u16,
};

pub const EvtChRx = extern struct {
    sdu_len: u16,
    sdu_buf: gap.Data,
};

pub const EvtChTx = extern struct {
    sdu_buf: gap.Data,
};

pub const EvtId = enum(u16) {
    ch_setup_request = 0x70,
    ch_setup_refused = 0x71,
    ch_setup = 0x72,
    ch_released = 0x73,
    ch_sdu_buf_released = 0x74,
    ch_credit = 0x75,
    ch_rx = 0x76,
    ch_tx = 0x77,
    _,
};

// --- SVC functions ---

pub fn ch_setup(conn_handle: u16, p_local_cid: *u16, p_params: *const ChSetupParams) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 0, conn_handle, @intFromPtr(p_local_cid), @intFromPtr(p_params)));
}

pub fn ch_release(conn_handle: u16, local_cid: u16) Error!void {
    return err.check(svc.svcall2(SVC_BASE + 1, conn_handle, local_cid));
}

pub fn ch_rx(conn_handle: u16, local_cid: u16, p_sdu_buf: *const gap.Data) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 2, conn_handle, local_cid, @intFromPtr(p_sdu_buf)));
}

pub fn ch_tx(conn_handle: u16, local_cid: u16, p_sdu_buf: *const gap.Data) Error!void {
    return err.check(svc.svcall3(SVC_BASE + 3, conn_handle, local_cid, @intFromPtr(p_sdu_buf)));
}

pub fn ch_flow_control(conn_handle: u16, local_cid: u16, credits: u16, p_credits: ?*u16) Error!void {
    return err.check(svc.svcall4(SVC_BASE + 4, conn_handle, local_cid, credits, @intFromPtr(p_credits)));
}
