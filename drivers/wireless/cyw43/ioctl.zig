//! An IOCTL (Input/Output Control) call is sent by the Pico host CPU (RP2040)
//! to the ARM CPU in the WiFi chip, to read or write configuration data, or send
//! a specific command.
//!
//! An event is an unsolicited block of data sent from the WiFi CPU to the host;
//! it can be a notification that an action is complete, or some data that has
//! arrived over the WiFi network.
//!
//! https://iosoft.blog/2022/12/06/picowi_part3/
//!
//! https://github.com/embassy-rs/embassy/blob/main/cyw43/src/structs.rs !
//! https://github.com/jbentham/picowi/blob/main/lib/picowi_ioctl.h
//!
const std = @import("std");
const mem = std.mem;
const assert = std.debug.assert;
const testing = std.testing;
const log = std.log.scoped(.ioctl);

// Max IOCTL length (really 1536txms) TODO: decide
const max_packet_length = 1600;
// Time to wait for ioctl response (msec)
pub const response_wait = 30;
// Polling interval for ioctl responses
pub const response_pool_interval = 10;

// TODO
var ioctl_reqid: u16 = 0;
var tx_seq: u8 = 0;

// SDIO/SPI Bus Layer (SDPCM) header
// ref: https://iosoft.blog/2022/12/06/picowi_part3/
const BusHeader = extern struct {
    len: u16,
    not_len: u16,
    /// Rx/Tx sequence number
    seq: u8,
    ///  4 MSB Channel number, 4 LSB arbitrary fla TODO: split
    chan: Chan,
    /// Length of next data frame, reserved for Tx
    nextlen: u8 = 0,
    /// Data offset from the start of the packet.
    /// Includes BusHeader length and padding after BusHeader.
    hdrlen: u8,
    /// Flow control bits, reserved for Tx
    flow: u8 = 0,
    /// Maximum Sequence number allowed by firmware for Tx
    credit: u8 = 0,
    _reserved: u16 = 0,

    const Chan = enum(u8) {
        control = 0,
        event = 1,
        data = 2,
    };
};

const CdcHeader = extern struct {
    cmd: Cmd,
    outlen: u16,
    inlen: u16 = 0,
    flags: u16 = 0,
    id: u16,
    status: u32 = 0,

    pub fn status_ok(self: CdcHeader) bool {
        //dev/ apsta, ampdu_rx_factor commands are returing status 0xFFFFFFFB
        return self.status == 0 or self.status == 0xFFFFFFFB;
    }
};

pub const Cmd = enum(u32) {
    up = 2,
    down = 3,
    set_infra = 20,
    set_auth = 22,
    set_ssid = 26,
    set_antdiv = 64,
    set_gmode = 110,
    set_wsec = 134,
    set_band = 142,
    set_wpa_auth = 165,
    get_var = 262,
    set_var = 263,
    set_wsec_pmk = 268,
    _,
};

pub const BdcHeader = extern struct {
    flags: u8,
    priority: u8,
    flags2: u8,
    offset: u8,

    // Padding after bdc header where data or event bytes starts
    fn padding(self: BdcHeader) usize {
        return @as(usize, self.offset) * 4;
    }
};

// Structure:
//  - 12 bytes BusHeader
//  - xx padding bytes (defined by BusHeader.hdrlen)
// than if chan == .control
//  - 16 bytes of cdc header
//  - xx result data in the case of get_var control command
// if chan == .event
//  - 4 bytes bdc header
//  - xx bdc padding bytes (defined in BdcHeader.offset)
//  - 73 bytes of EventPacket
//  - other event bytes
// if chan == .data
//  - 4 bytes bdc header
//  - data, from this position to the end of the packet
pub const Response = extern struct {
    const Self = @This();
    pub const min_len = @sizeOf(BusHeader) + @sizeOf(CdcHeader);
    pub const empty = std.mem.zeroes(Response);

    bus: BusHeader align(4),
    buffer: [max_packet_length - @sizeOf(BusHeader)]u8,

    // Number of padding bytes after bus header before cdc/bdc header
    fn padding(self: *Self) usize {
        return self.bus.hdrlen - @sizeOf(BusHeader);
    }

    pub fn cdc(self: *Self) CdcHeader {
        assert(self.bus.chan != .data or self.bus.chan == .event);
        return @bitCast(self.buffer[self.padding()..][0..@sizeOf(CdcHeader)].*);
    }

    pub fn bdc(self: *Self) BdcHeader {
        assert(self.bus.chan != .control);
        return @bitCast(self.buffer[self.padding()..][0..@sizeOf(BdcHeader)].*);
    }

    pub fn data(self: *Self) []u8 {
        const head: usize = self.padding() + switch (self.bus.chan) {
            .control => @sizeOf(CdcHeader),
            .event, .data => @sizeOf(BdcHeader) + self.bdc().padding(),
        };
        const tail = self.bus.len - @sizeOf(BusHeader);
        if (head > tail) {
            return &.{};
        }
        return self.buffer[head..tail];
    }

    pub fn event(self: *Self) EventPacket {
        assert(self.bus.chan == .event);
        const buf = self.data();
        if (buf.len < @sizeOf(EventPacket)) {
            var zero = mem.zeroes(EventPacket);
            zero.msg.event_type = .none;
            return zero;
        }
        //if (buf.len < @sizeOf(EventPacket)) return error.IoctlEvent;
        var evt: EventPacket = @bitCast(buf[0..@sizeOf(EventPacket)].*);
        std.mem.byteSwapAllFields(EventPacket, &evt);
        return evt;
    }

    pub fn validate(self: *Self, n: u16) !void {
        if (self.bus.len != n) {
            log.err("invalid reponse len actual: {} packet: {}", .{ self.bus.len, n });
            return error.IoctlInvalidBusLen;
        }
        if (self.bus.len ^ self.bus.not_len != 0xffff) {
            log.err("invalid reponse not len len: {x} notlen: {x}", .{ self.bus.len, self.bus.not_len });
            return error.IoctlInvalidNotBusLen;
        }
    }

    pub fn as_slice(self: *Self) []u32 {
        return mem.bytesAsSlice(u32, mem.asBytes(self));
    }
};

// TODO: add 2 bytes padding to the data packet
// https://github.com/embassy-rs/embassy/blob/eb4e4100acbe03ee1d3726c948f91b6927a18125/cyw43/src/runner.rs#L320
pub const Request = extern struct {
    const Self = @This();
    pub const max_data_len = 256;
    pub const max_name_len = 32; // including sntinel

    bus: BusHeader align(4),
    hdr: CdcHeader,
    data: [max_name_len + max_data_len]u8,

    pub fn init(cmd: Cmd, name: []const u8, data: []const u8) Self {
        const name_len: usize = name.len + if (name.len > 0) @as(usize, 1) else @as(usize, 0); // name has sentinel
        const txdlen: u16 = @intCast(((name_len + data.len + 3) >> 2) * 4);
        const hdrlen: u16 = @sizeOf(BusHeader) + @sizeOf(CdcHeader);
        const txlen: u16 = hdrlen + txdlen;

        tx_seq +|= 1;
        ioctl_reqid +|= 1;
        var req = std.mem.zeroes(Self);
        req.bus = .{
            .len = txlen,
            .not_len = ~txlen,
            .seq = tx_seq,
            .chan = .control,
            .hdrlen = @sizeOf(BusHeader),
        };
        req.hdr = .{
            .cmd = cmd,
            .outlen = txdlen,
            .id = ioctl_reqid,
            .flags = if (data.len > 0) 0x02 else 0,
        };
        if (name_len > 0) {
            @memcpy(req.data[0..name.len], name);
        }
        if (data.len > 0) {
            @memcpy(req.data[name_len..][0..data.len], data);
        }
        return req;
    }

    pub fn as_slice(self: *Self) []u32 {
        return mem.bytesAsSlice(u32, mem.asBytes(self)[0..self.bus.len]);
    }
};

pub const TxMsg = extern struct {
    const Self = @This();
    //const header_size = @sizeOf(BusHeader) + 2 + @sizeOf(BdcHeader);
    const empty: TxMsg = mem.zeroes(TxMsg);

    bus: BusHeader = mem.zeroes(BusHeader),
    _padding: u16 = 0,
    bdc: BdcHeader = mem.zeroes(BdcHeader),
    //data: [max_packet_length - header_size]u8 = @splat(0),

    pub fn init(txlen: u16) Self {
        //const txlen: u16 = @sizeOf(Self) + @as(u16, @intCast(data.len));

        tx_seq +|= 1;
        var req: Self = .empty;
        req.bus = .{
            .len = txlen,
            .not_len = ~txlen,
            .seq = tx_seq,
            .chan = .data,
            .hdrlen = @sizeOf(BusHeader) + 2,
        };
        req.bdc.flags = 0x20;
        //@memcpy(req.data[0..data.len], data);
        return req;
    }

    // pub fn as_slice(self: *Self) []u32 {
    //     // round to u32, 4 bytes
    //     const round_len: u16 = @intCast(((self.bus.len + 3) / 4) * 4);
    //     return mem.bytesAsSlice(u32, mem.asBytes(self)[0..round_len]);
    // }
};

comptime {
    assert(@sizeOf(BusHeader) == 12);
    assert(@sizeOf(BdcHeader) == 4);
    assert(@sizeOf(CdcHeader) == 16);
    assert(@sizeOf(EventPacket) == 72);
    assert(@sizeOf(TxMsg) == 18);
}

test "write command" {
    {
        tx_seq = 2;
        ioctl_reqid = 2;
        var req = Request.init(.get_var, "cur_etheraddr", &.{});

        const expected = &hexToBytes("2C00D3FF0300000C00000000060100001000000000000300000000006375725F657468657261646472000000");
        const buf = mem.asBytes(&req)[0..req.bus.len];
        try std.testing.expectEqualSlices(u8, expected, buf);

        try testing.expectEqual(44, expected.len);
        try testing.expectEqual(44 / 4, req.as_slice().len);
    }
    {
        tx_seq = 6;
        ioctl_reqid = 6;
        const expected = &hexToBytes("2C00D3FF0700000C00000000070100001000000002000700000000006770696F6F7574000100000001000000");
        var data: [8]u8 = @splat(0);
        data[0] = 1;
        data[4] = 1;
        var req = Request.init(.set_var, "gpioout", &data);
        const buf = mem.asBytes(&req)[0..req.bus.len];
        try std.testing.expectEqualSlices(u8, expected, buf);
    }
}

test "parse response" {
    const expected = &hexToBytes("2CCF67F3B7EA");
    const rsp_data = &hexToBytes("0001FFFE040000DC0014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060100001400000000000300000000002CCF67F3B7EA6865726164647200000000000000");
    try testing.expectEqual(256, rsp_data.len);

    var rsp: Response = .empty;
    @memcpy(mem.asBytes(&rsp)[0..rsp_data.len], rsp_data);

    try testing.expectEqual(256, rsp.bus.len);
    try testing.expectEqual(0xffff, rsp.bus.len ^ rsp.bus.not_len);
    try testing.expectEqual(4, rsp.bus.seq);
    try testing.expectEqual(220, rsp.bus.hdrlen);
    try testing.expectEqual(20, rsp.bus.credit);
    try testing.expectEqual(0, rsp.bus.nextlen);

    const ioctl = rsp.cdc();
    try testing.expectEqual(.get_var, ioctl.cmd);
    try testing.expectEqual(20, ioctl.outlen);
    try testing.expectEqual(0, ioctl.inlen);
    try testing.expectEqual(3, ioctl.id);
    try testing.expectEqual(0, ioctl.flags);
    try testing.expectEqual(0, ioctl.status);

    try testing.expectEqualSlices(u8, expected, rsp.data()[0..expected.len]);
}

pub fn hexToBytes(comptime hex: []const u8) [hex.len / 2]u8 {
    var res: [hex.len / 2]u8 = undefined;
    _ = std.fmt.hexToBytes(&res, hex) catch unreachable;
    return res;
}

const EventPacket = extern struct {
    eth: EthernetHeader,
    hdr: EventHeader,
    msg: EventMessage,
};

// Escan result event (excluding 12-byte IOCTL header and BDC header)
const EventScanResult = extern struct {
    eth: EthernetHeader,
    hdr: EventHeader,
    msg: EventMessage,
    scan: ScanResultHeader,
    info: BssInfo,
};

// Ethernet header (sdpcm_ethernet_header_t)
const EthernetHeader = extern struct {
    dest_mac: [6]u8,
    source_mac: [6]u8,
    ether_type: u16,
};

// Vendor-specific (Broadcom) Ethernet header (sdpcm_bcmeth_header_t)
const EventHeader = extern struct {
    subtype: u16,
    len: u16,
    ver: u8,
    oui: [3]u8,
    usr_subtype: u16,
};

// Raw event header (sdpcm_raw_event_header_t)
const EventMessage = extern struct {
    version: u16,
    flags: u16,
    event_type: EventType,
    status: EventStatus,
    reason: u32,
    auth_type: u32,
    datalen: u32,
    addr: [6]u8,
    ifname: [16]u8,
    ifidx: u8,
    bsscfgidx: u8,
};

// Scan result header (part of wl_escan_result_t)
const ScanResultHeader = extern struct {
    buflen: u32,
    version: u32,
    sync_id: u16,
    bss_count: u16,
};

// BSS info from EScan (part of wl_bss_info_t)
const BssInfo = extern struct {
    version: u32, // version field
    length: u32, // byte length of data in this record, starting at version and including IEs
    bssid: [6]u8, // Unique 6-byte MAC address
    beacon_period: u16, // Interval between two consecutive beacon frames. Units are Kusec
    capability: u16, // Capability information
    ssid_len: u8, // SSID length
    ssid: [32]u8, // Array to store SSID
    nrates: u32, // Count of rates in this set
    rates: [16]u8, // rates in 500kbps units, higher bit set if basic
    channel: u16, // Channel specification for basic service set
    atim_window: u16, // Announcement traffic indication message window size. Units are Kusec
    dtim_period: u8, // Delivery traffic indication message period
    rssi: u16, // receive signal strength (in dBm)
    phy_noise: u8, // noise (in dBm)
    // The following fields assume the 'version' field is 109 (0x6D)
    n_cap: u8, // BSS is 802.11N Capable
    nbss_cap: u32, // 802.11N BSS Capabilities (based on HT_CAP_*)
    ctl_ch: u8, // 802.11N BSS control channel number
    reserved1: u32, // Reserved for expansion of BSS properties
    flags: u8, // flags
    reserved2: [3]u8, // Reserved for expansion of BSS properties
    basic_mcs: [16]u8, // 802.11N BSS required MCS set
    ie_offset: u16, // offset at which IEs start, from beginning
    ie_length: u32, // byte length of Information Elements
    snr: u16, // Average SNR(signal to noise ratio) during frame reception
    // Variable-length Information Elements follow, see cyw43_ll_wifi_parse_scan_result
};

// zig fmt: off

// Async events
const EventType = enum(u32) {
    none                           =   0xffffffff,
    set_ssid                       =   0, // indicates status of set ssid ,
    join                           =   1, // differentiates join ibss from found (wlc_e_start) ibss
    start                          =   2, // sta founded an ibss or ap started a bss
    auth                           =   3, // 802.11 auth request
    auth_ind                       =   4, // 802.11 auth indication
    deauth                         =   5, // 802.11 deauth request
    deauth_ind                     =   6, // 802.11 deauth indication
    assoc                          =   7, // 802.11 assoc request
    assoc_ind                      =   8, // 802.11 assoc indication
    reassoc                        =   9, // 802.11 reassoc request
    reassoc_ind                    =  10, // 802.11 reassoc indication
    disassoc                       =  11, // 802.11 disassoc request
    disassoc_ind                   =  12, // 802.11 disassoc indication
    quiet_start                    =  13, // 802.11h quiet period started
    quiet_end                      =  14, // 802.11h quiet period ended
    beacon_rx                      =  15, // beacons received/lost indication
    link                           =  16, // generic link indication
    mic_error                      =  17, // tkip mic error occurred
    ndis_link                      =  18, // ndis style link indication
    roam                           =  19, // roam attempt occurred: indicate status & reason
    txfail                         =  20, // change in dot11failedcount (txfail)
    pmkid_cache                    =  21, // wpa2 pmkid cache indication
    retrograde_tsf                 =  22, // current ap's tsf value went backward
    prune                          =  23, // ap was pruned from join list for reason
    autoauth                       =  24, // report autoauth table entry match for join attempt
    eapol_msg                      =  25, // event encapsulating an eapol message
    scan_complete                  =  26, // scan results are ready or scan was aborted
    addts_ind                      =  27, // indicate to host addts fail/success
    delts_ind                      =  28, // indicate to host delts fail/success
    bcnsent_ind                    =  29, // indicate to host of beacon transmit
    bcnrx_msg                      =  30, // send the received beacon up to the host
    bcnlost_msg                    =  31, // indicate to host loss of beacon
    roam_prep                      =  32, // before attempting to roam
    pfn_net_found                  =  33, // pfn network found event
    pfn_net_lost                   =  34, // pfn network lost event
    reset_complete                 =  35,
    join_start                     =  36,
    roam_start                     =  37,
    assoc_start                    =  38,
    ibss_assoc                     =  39,
    radio                          =  40,
    psm_watchdog                   =  41, // psm microcode watchdog fired
    ccx_assoc_start                =  42, // ccx association start
    ccx_assoc_abort                =  43, // ccx association abort
    probreq_msg                    =  44, // probe request received
    scan_confirm_ind               =  45,
    psk_sup                        =  46, // wpa handshake
    country_code_changed           =  47,
    exceeded_medium_time           =  48, // wmmac excedded medium time
    icv_error                      =  49, // wep icv error occurred
    unicast_decode_error           =  50, // unsupported unicast encrypted frame
    multicast_decode_error         =  51, // unsupported multicast encrypted frame
    trace                          =  52,
    bta_hci_event                  =  53, // bt-amp hci event
    i_f                            =  54, // i/f change (for wlan host notification)
    p2p_disc_listen_complete       =  55, // p2p discovery listen state expires
    rssi                           =  56, // indicate rssi change based on configured levels
    pfn_best_batching              =  57, // pfn best network batching event
    extlog_msg                     =  58,
    action_frame                   =  59, // action frame reception
    action_frame_complete          =  60, // action frame tx complete
    pre_assoc_ind                  =  61, // assoc request received
    pre_reassoc_ind                =  62, // re-assoc request received
    channel_adopted                =  63, // channel adopted (xxx: obsoleted)
    ap_started                     =  64, // ap started
    dfs_ap_stop                    =  65, // ap stopped due to dfs
    dfs_ap_resume                  =  66, // ap resumed due to dfs
    wai_sta_event                  =  67, // wai stations event
    wai_msg                        =  68, // event encapsulating an wai message
    escan_result                   =  69, // escan result event
    action_frame_off_chan_complete =  70, // action frame off channel complete   /* note - this used to be wlc_e_wake_event
    probresp_msg                   =  71, // probe response received
    p2p_probreq_msg                =  72, // p2p probe request received
    dcs_request                    =  73,
    fifo_credit_map                =  74, // credits for d11 fifos. [ac0,ac1,ac2,ac3,bc_mc,atim]
    action_frame_rx                =  75, // received action frame event with wl_event_rx_frame_data_t header
    wake_event                     =  76, // wake event timer fired, used for wake wlan test mode
    rm_complete                    =  77, // radio measurement complete
    htsfsync                       =  78, // synchronize tsf with the host
    overlay_req                    =  79, // request an overlay ioctl/iovar from the host
    csa_complete_ind               =  80,
    excess_pm_wake_event           =  81, // excess pm wake event to inform host
    pfn_scan_none                  =  82, // no pfn networks around
    pfn_scan_allgone               =  83, // last found pfn network gets lost
    gtk_plumbed                    =  84,
    assoc_ind_ndis                 =  85, // 802.11 assoc indication for ndis only
    reassoc_ind_ndis               =  86, // 802.11 reassoc indication for ndis only
    assoc_req_ie                   =  87,
    assoc_resp_ie                  =  88,
    assoc_recreated                =  89, // association recreated on resume
    action_frame_rx_ndis           =  90, // rx action frame event for ndis only
    auth_req                       =  91, // authentication request received
    tdls_peer_event                =  92, // discovered peer, connected/disconnected peer
    //mesh_dhcp_success              =  92, // dhcp handshake successful for a mesh interface
    speedy_recreate_fail           =  93, // fast assoc recreation failed
    native                         =  94, // port-specific event and payload (e.g. ndis)
    pktdelay_ind                   =  95, // event for tx pkt delay suddently jump
    awdl_aw                        =  96, // awdl aw period starts
    awdl_role                      =  97, // awdl master/slave/ne master role event
    awdl_event                     =  98, // generic awdl event
    nic_af_txs                     =  99, // nic af txstatus
    nan                            = 100, // nan event
    beacon_frame_rx                = 101,
    service_found                  = 102, // desired service found
    gas_fragment_rx                = 103, // gas fragment received
    gas_complete                   = 104, // gas sessions all complete
    p2po_add_device                = 105, // new device found by p2p offload
    p2po_del_device                = 106, // device has been removed by p2p offload
    wnm_sta_sleep                  = 107, // wnm event to notify sta enter sleep mode
    txfail_thresh                  = 108, // indication of mac tx failures (exhaustion of 802.11 retries) exceeding threshold(s)
    proxd                          = 109, // proximity detection event
    ibss_coalesce                  = 110, // ibss coalescing
    //mesh_paired                    = 110, // mesh peer found and paired
    awdl_rx_prb_resp               = 111, // awdl rx probe response
    awdl_rx_act_frame              = 112, // awdl rx action frames
    awdl_wowl_nullpkt              = 113, // awdl wowl nulls
    awdl_phycal_status             = 114, // awdl phycal status
    awdl_oob_af_status             = 115, // awdl oob af status
    awdl_scan_status               = 116, // interleaved scan status
    awdl_aw_start                  = 117, // awdl aw start
    awdl_aw_end                    = 118, // awdl aw end
    awdl_aw_ext                    = 119, // awdl aw extensions
    awdl_peer_cache_control        = 120,
    csa_start_ind                  = 121,
    csa_done_ind                   = 122,
    csa_failure_ind                = 123,
    cca_chan_qual                  = 124, // cca based channel quality report
    bssid                          = 125, // to report change in bssid while roaming
    tx_stat_error                  = 126, // tx error indication
    bcmc_credit_support            = 127, // credit check for bcmc supported
    psta_primary_intf_ind          = 128, // psta primary interface indication
    bt_wifi_handover_req           = 130, // handover request initiated
    spw_txinhibit                  = 131, // southpaw txinhibit notification
    fbt_auth_req_ind               = 132, // fbt authentication request indication
    rssi_lqm                       = 133, // enhancement addition for wlc_e_rssi
    pfn_gscan_full_result          = 134, // full probe/beacon (ies etc) results
    pfn_swc                        = 135, // significant change in rssi of bssids being tracked
    authorized                     = 136, // a sta been authroized for traffic
    probreq_msg_rx                 = 137, // probe req with wl_event_rx_frame_data_t header
    pfn_scan_complete              = 138, // pfn completed scan of network list
    rmc_event                      = 139, // rmc event
    dpsta_intf_ind                 = 140, // dpsta interface indication
    rrm                            = 141, // rrm event
    ulp                            = 146, // ulp entry event

    tko                            = 151, // TCP Keep Alive Offload Event
    ext_auth_req                   = 187, // authentication request received
    ext_auth_frame_rx              = 188, // authentication request received
    mgmt_frame_txstatus            = 189, // mgmt frame Tx complete
    _,
};

// zig fmt: on

pub const EventStatus = enum(u32) {
    /// operation was successful
    success = 0,
    /// operation failed
    fail = 1,
    /// operation timed out
    timeout = 2,
    /// failed due to no matching network found
    no_networks = 3,
    /// operation was aborted
    abort = 4,
    /// protocol failure: packet not ack'd
    no_ack = 5,
    /// AUTH or ASSOC packet was unsolicited
    unsolicited = 6,
    /// attempt to assoc to an auto auth configuration
    attempt = 7,
    /// scan results are incomplete
    partial = 8,
    /// scan aborted by another scan
    newscan = 9,
    /// scan aborted due to assoc in progress
    newassoc = 10,
    /// 802.11h quiet period started
    hquiet = 11,
    /// user disabled scanning (WLC_SET_SCANSUPPRESS)
    suppress = 12,
    /// no allowable channels to scan
    nochans = 13,
    /// scan aborted due to CCX fast roam
    ccxfastrm = 14,
    /// abort channel select
    cs_abort = 15,
    _,
};

test "pwd encode" {
    var buf: [36]u8 = @splat(0);

    try testing.expectEqualSlices(
        u8,
        &hexToBytes("0A0001005065726F5A6465726F31"),
        encode_pwd(&buf, "PeroZdero1"),
    );

    try testing.expectEqualSlices(
        u8,
        &hexToBytes("080000006E696E617A617261"),
        encode_ssid(&buf, "ninazara"),
    );
}

pub fn encode_pwd(buf: []u8, pwd: []const u8) []u8 {
    mem.writeInt(u32, buf[0..4], @intCast(pwd.len | 0x10000), .little);
    @memcpy(buf[4..][0..pwd.len], pwd);
    return buf[0 .. 4 + pwd.len];
}

pub fn encode_ssid(buf: []u8, ssid: []const u8) []u8 {
    mem.writeInt(u32, buf[0..4], @intCast(ssid.len), .little);
    @memcpy(buf[4..][0..ssid.len], ssid);
    return buf[0 .. 4 + ssid.len];
}

test "to word" {
    //const bytes: []const u8 align(4) = &hexToBytes("aabbccddeeff1122334455");
    const bytes: []const u8 align(4) = &hexToBytes("11223344");

    const words, const padding = bytes_to_words(bytes);

    // const padding_bytes_len = bytes.len & 0b11;
    // const round_len = bytes.len - padding_bytes_len;
    // const slice: []const u32 = @alignCast(mem.bytesAsSlice(u32, @constCast(bytes)[0..round_len]));

    // var padding_word: u32 = 0;
    // for (0..padding_bytes_len) |i| {
    //     const b = bytes[bytes.len - 1 - i];
    //     padding_word = (padding_word << 8) | b;
    // }

    //std.debug.print("u8: {x} {} {}\n", .{ bytes, bytes.len, padding_bytes_len });
    for (words) |w| {
        std.debug.print("slice: {x}\n", .{w});
    }
    if (padding) |p| {
        std.debug.print("padding: {x}\n", .{p});
    }
}

pub fn bytes_to_words(bytes: []const u8) struct { []const u32, ?u32 } {
    const padding_bytes = bytes.len & 0b11;
    const round_len = bytes.len - padding_bytes;
    const words: []const u32 = @alignCast(mem.bytesAsSlice(u32, @constCast(bytes)[0..round_len]));

    var padding_word: u32 = 0;
    for (0..padding_bytes) |i| {
        const b = bytes[bytes.len - 1 - i];
        padding_word = (padding_word << 8) | b;
    }
    return .{ words, if (padding_bytes == 0) null else padding_word };
}
