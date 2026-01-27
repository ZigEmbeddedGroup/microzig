const std = @import("std");
const NVRAM = @import("nvram.zig").NVRAM;
const Bus = @import("bus.zig");
const ioctl = @import("ioctl.zig");
const assert = std.debug.assert;
const mem = std.mem;

const log = std.log.scoped(.cyw43_wifi);

const Self = @This();

bus: *Bus,
request_id: u16 = 0,
credit: u8 = 0,
tx_sequence: u8 = 0,
log_state: LogState = .{},

event_log: EventLog = .{},
join_state: JoinState = .none,
scan_state: ScanState = .none,
scan_result: ?ScanResult = null,
err: ?anyerror = null,

const ioctl_request_bytes_len = 1024;

pub const InitOptions = struct {
    country: Country = .{},

    // List of available countries:
    // https://github.com/georgerobotics/cyw43-driver/blob/13004039ffe127519f33824bf7d240e1f23fbdcd/src/cyw43_country.h#L59
    pub const Country = struct {
        code: [2]u8 = "XX".*, // Worldwide
        revision: i32 = -1,
    };
};

pub fn init(self: *Self, opt: InitOptions) !void {
    const bus = self.bus;

    { // Init ALP (Active Low Power) clock
        _ = bus.write_int(u8, .backplane, Bus.backplane.chip_clock_csr, Bus.backplane.alp_avail_req);
        _ = bus.write_int(u8, .backplane, Bus.backplane.function2_watermark, 0x10);
        const watermark = bus.read_int(u8, .backplane, Bus.backplane.function2_watermark);
        if (watermark != 0x10) {
            log.err("unexpected watermark {x}", .{watermark});
            return error.Cyw43Watermark;
        }
        // waiting for clock...
        while (bus.read_int(u8, .backplane, Bus.backplane.chip_clock_csr) & Bus.backplane.alp_avail == 0) {}
        // clear request for ALP
        bus.write_int(u8, .backplane, Bus.backplane.chip_clock_csr, 0);

        // const chip_id = bus.read_int(u16, .backplane, chip.pmu_base_address);
        // log.debug("chip ID: 0x{X}", .{chip_id});
    }

    { // Upload firmware
        self.core_disable(.wlan);
        self.core_reset(.socram);

        // this is 4343x specific stuff: Disable remap for SRAM_3
        bus.write_int(u32, .backplane, chip.socsram_base_address + 0x10, 3);
        bus.write_int(u32, .backplane, chip.socsram_base_address + 0x44, 0);

        const firmware = @embedFile("../cyw43/firmware/43439A0_7_95_61.bin");
        bus.backplane_write(chip.atcm_ram_base_address, firmware);
    }

    { // Load nvram
        const nvram_len = ((NVRAM.len + 3) >> 2) * 4; // Round up to 4 bytes.
        const addr_magic = chip.atcm_ram_base_address + chip.chip_ram_size - 4;
        const addr = addr_magic - nvram_len;
        bus.backplane_write(addr, NVRAM);

        const nvram_len_words = (nvram_len >> 2);
        const nvram_len_magic = (~nvram_len_words << 16) | nvram_len_words;
        bus.write_int(u32, .backplane, addr_magic, nvram_len_magic);
    }

    // Starting up core...
    self.core_reset(.wlan);
    try self.core_is_up(.wlan);

    // Wait until HT clock is available; takes about 29ms
    while (bus.read_int(u8, .backplane, Bus.backplane.chip_clock_csr) & 0x80 == 0) {}

    { // Set up the interrupt mask and enable interrupts
        const sdio_int_host_mask: u32 = 0x24;
        const i_hmb_sw_mask: u32 = 0x000000f0;
        bus.write_int(
            u32,
            .backplane,
            chip.sdiod_core_base_address + sdio_int_host_mask,
            i_hmb_sw_mask,
        );
        bus.write_int(u16, .bus, Bus.reg.interrupt_enable, @bitCast(Bus.Irq{ .f2_packet_available = true }));
    }

    // "Lower F2 Watermark to avoid DMA Hang in F2 when SD Clock is stopped."
    bus.write_int(u8, .backplane, Bus.backplane.function2_watermark, 0x20);

    // Waiting for F2 to be ready...
    while (true) {
        const status: BusStatus = @bitCast(bus.read_int(u32, .bus, Bus.reg.status));
        if (status.f2_rx_ready) break;
    }

    { // Clear pad pulls
        bus.write_int(u8, .backplane, Bus.backplane.pull_up, 0);
        _ = bus.read_int(u8, .backplane, Bus.backplane.pull_up);
    }

    { // start HT clock
        bus.write_int(u8, .backplane, Bus.backplane.chip_clock_csr, 0x10);
        while (bus.read_int(u8, .backplane, Bus.backplane.chip_clock_csr) & 0x80 == 0) {}
    }

    { // Load Country Locale Matrix (CLM)
        const data = @embedFile("../cyw43/firmware/43439A0_clm.bin");

        const ClmLoadControl = extern struct {
            flag: u16 = 0,
            typ: u16 = 2,
            len: u32 = 0,
            crc: u32 = 0,
        };

        var nbytes: usize = 0;
        while (nbytes < data.len) {
            const head_len = @sizeOf(ClmLoadControl);
            var clr: ClmLoadControl = .{};
            var chunk: [ioctl_request_bytes_len - 64]u8 = undefined;
            const n = @min(chunk.len - head_len, data.len - nbytes);
            clr.flag = 1 << 12 | (if (nbytes > 0) @as(u16, 0) else 2) | (if (nbytes + n >= data.len) @as(u16, 4) else 0);
            clr.len = n;
            @memcpy(chunk[0..head_len], mem.asBytes(&clr));
            @memcpy(chunk[head_len..][0..n], data[nbytes..][0..n]);
            try self.set_var("clmload", chunk[0 .. head_len + n]);
            nbytes += n;
        }
    }

    { // Clear data unavail error
        const val = bus.read_int(u16, .bus, Bus.reg.interrupt);
        if (val & 1 > 0)
            bus.write_int(u16, .bus, Bus.reg.interrupt, val);
    }

    { // Set sleep KSO (keep SDIO on), cyw43_kso_set
        bus.write_int(u8, .backplane, Bus.backplane.sleep_csr, 1);
        bus.write_int(u8, .backplane, Bus.backplane.sleep_csr, 1);
        _ = bus.read_int(u8, .backplane, Bus.backplane.sleep_csr);
    }

    { // cyw43_ll_wifi_on

        { // Set country
            const code = opt.country.code;
            var val = extern struct {
                abbrev: [4]u8,
                revision: i32,
                code: [4]u8,
            }{
                .abbrev = .{ code[0], code[1], 0, 0 },
                .revision = opt.country.revision,
                .code = .{ code[0], code[1], 0, 0 },
            };
            self.set_var("country", mem.asBytes(&val)) catch |err| switch (err) {
                error.Cyw43InvalidCommandStatus => {
                    log.err(
                        "invalid country code: {s}, revision: {}",
                        .{ opt.country.code, opt.country.revision },
                    );
                    return error.Cyw43InvalidCountryCode;
                },
                else => return err,
            };
        }

        // Set antenna to chip antenna
        try self.set_cmd(.set_antdiv, &.{0});

        { // Set some WiFi config
            try self.set_var("bus:txglom", &.{0x00});
            try self.set_var("apsta", &.{0x01});
            try self.set_var("ampdu_ba_wsize", &.{0x08});
            try self.set_var("ampdu_mpdu", &.{0x04});
            try self.set_var("ampdu_rx_factor", &.{0x00});
            self.sleep_ms(150);
        }

        try self.enable_events(&.{
            .join,
            .assoc,
            .reassoc,
            .set_ssid,
            .link,
            .auth,
            .psk_sup,
            .disassoc_ind,
            .disassoc,
            .deauth_ind,
            .escan_result,
        });

        // Set the interface as "up"
        try self.set_cmd(.up, &.{});
    }

    { // Set power mode parameters cyw43_ll_wifi_pm
        try self.set_var("pm2_sleep_ret", &.{0xc8});
        try self.set_var("bcn_li_bcn", &.{1});
        try self.set_var("bcn_li_dtim", &.{1});
        try self.set_var("assoc_listen", &.{0x0a});
        try self.set_cmd(.set_gmode, &.{1}); // auto
        try self.set_cmd(.set_band, &.{0}); // any
        // try self.set_cmd(.set_pm, &.{2});// power mode
    }

    self.log_init();
}

fn enable_events(self: *Self, events: []const ioctl.EventType) !void {
    const mask = ioctl.EventType.mask(events);
    try self.set_var("bsscfg:event_msgs", &mask);
    self.sleep_ms(50);
}

fn core_disable(self: *Self, core: Core) void {
    const base = core.base_addr();
    // Dummy read?
    _ = self.bus.read_int(u8, .backplane, base + ai.resetctrl_offset);
    // Check it isn't already reset
    const r = self.bus.read_int(u8, .backplane, base + ai.resetctrl_offset);
    if (r & ai.resetctrl_bit_reset != 0) {
        return;
    }
    self.bus.write_int(u8, .backplane, base + ai.ioctrl_offset, 0);
    _ = self.bus.read_int(u8, .backplane, base + ai.ioctrl_offset);
    self.sleep_ms(1);
    self.bus.write_int(u8, .backplane, base + ai.resetctrl_offset, ai.resetctrl_bit_reset);
    _ = self.bus.read_int(u8, .backplane, base + ai.resetctrl_offset);
}

fn core_reset(self: *Self, core: Core) void {
    self.core_disable(core);
    const base = core.base_addr();
    self.bus.write_int(u8, .backplane, base + ai.ioctrl_offset, ai.ioctrl_bit_fgc | ai.ioctrl_bit_clock_en);
    _ = self.bus.read_int(u8, .backplane, base + ai.ioctrl_offset);
    self.bus.write_int(u8, .backplane, base + ai.resetctrl_offset, 0);
    self.sleep_ms(1);
    self.bus.write_int(u8, .backplane, base + ai.ioctrl_offset, ai.ioctrl_bit_clock_en);
    _ = self.bus.read_int(u8, .backplane, base + ai.ioctrl_offset);
    self.sleep_ms(1);
}

fn core_is_up(self: *Self, core: Core) !void {
    const base = core.base_addr();
    const io = self.bus.read_int(u8, .backplane, base + ai.ioctrl_offset);
    if (io & (ai.ioctrl_bit_fgc | ai.ioctrl_bit_clock_en) != ai.ioctrl_bit_clock_en) {
        log.err("core_is_up fail due to bad ioctrl 0x{X}", .{io});
        return error.Cyw43CoreIsUp;
    }
    const r = self.bus.read_int(u8, .backplane, base + ai.resetctrl_offset);
    if (r & (ai.resetctrl_bit_reset) != 0) {
        log.err("core_is_up fail due to bad resetctrl 0x{X}", .{r});
        return error.Cyw43CoreIsUp;
    }
}

fn log_init(self: *Self) void {
    const addr = chip.atcm_ram_base_address + chip.chip_ram_size - 4 - chip.socram_srmem_size;
    const shared_addr = self.bus.read_int(u32, .backplane, addr);
    var shared: SharedMemData = undefined;
    self.bus.backplane_read(shared_addr, std.mem.asBytes(&shared));
    self.log_state.addr = shared.console_addr + 8;
}

pub fn log_read(self: *Self) void {
    const chip_log = std.log.scoped(.cyw43_chip);

    var shared: SharedMemLog = undefined;
    self.bus.backplane_read(self.log_state.addr, std.mem.asBytes(&shared));
    if (shared.idx == self.log_state.idx) return;

    var buf: [1024]u8 align(4) = undefined;
    self.bus.backplane_read(shared.buf, &buf);
    if (shared.idx == 0 or buf[shared.idx - 1] != '\n') return;

    const tail = if (shared.idx < self.log_state.idx) buf.len else shared.idx;
    var iter = mem.splitAny(u8, buf[self.log_state.idx..tail], &.{ '\r', '\n' });
    while (iter.next()) |line| {
        if (line.len == 0) continue;
        chip_log.debug("{s}", .{line});
    }
    self.log_state.idx = if (tail == buf.len) 0 else tail;
}

pub fn set_var(self: *Self, name: []const u8, data: []const u8) !void {
    self.request(.set_var, name, data);
    _ = try self.response_poll(.set_var, null);
}

pub fn set_cmd(self: *Self, cmd: ioctl.Cmd, data: []const u8) !void {
    self.request(cmd, "", data);
    _ = try self.response_poll(cmd, null);
}

pub fn get_var(self: *Self, name: []const u8, data: []u8) !usize {
    self.request(.get_var, name, data);
    return try self.response_poll(.get_var, data);
}

fn request(self: *Self, cmd: ioctl.Cmd, name: []const u8, data: []const u8) void {
    self.request_id +%= 1;
    self.tx_sequence +%= 1;
    var words: [ioctl_request_bytes_len / 4]u32 = undefined;
    const bytes = ioctl.request(
        mem.sliceAsBytes(words[1..]), // 1 word reserved for ioctl cmd
        cmd,
        name,
        data,
        self.request_id,
        self.tx_sequence,
    );
    const words_len = ((bytes.len + 3) >> 2) + 1;
    self.bus.write(.wlan, 0, @intCast(bytes.len), words[0..words_len]);
}

fn response_poll(self: *Self, cmd: ioctl.Cmd, data: ?[]u8) !usize {
    var bytes: [ioctl_request_bytes_len]u8 align(4) = undefined;
    var delay: usize = 0;
    while (delay < ioctl.response_wait) {
        const rsp, _ = try self.read(&bytes) orelse {
            self.sleep_ms(ioctl.response_poll_interval);
            delay += ioctl.response_poll_interval;
            continue;
        };
        switch (rsp.sdp.channel()) {
            .control => {
                const cdc = rsp.cdc();
                if (cdc.id == self.request_id) {
                    if (cdc.cmd == cmd and cdc.status_ok()) {
                        if (data) |d| {
                            const rsp_data = rsp.data();
                            const n = @min(rsp_data.len, d.len);
                            @memcpy(d[0..n], rsp_data[0..n]);
                            return n;
                        }
                        return 0;
                    }
                    self.log_response(rsp);
                    return error.Cyw43InvalidCommandStatus;
                }
            },
            else => self.log_response(rsp),
        }
    }
    log.err("ioctl: missing response in response_poll", .{});
    return error.Cyw43NoResponse;
}

pub const JoinOptions = struct {
    security: Security = .wpa2_psk,
    wait_ms: u32 = 30 * 1000,

    pub const Security = enum {
        open,
        wpa_psk,
        wpa2_psk,
        wpa3_sae,
    };
};

pub fn join(self: *Self, ssid: []const u8, pwd: []const u8, opt: JoinOptions) !JoinPoller {
    self.err = null;

    var buf: [64]u8 = @splat(0); // space for 10 addresses
    // Enable multicast
    {
        @memcpy(buf[0..4], &[_]u8{ 0x01, 0x00, 0x00, 0x00 }); // number of addresses
        @memcpy(buf[4..][0..6], &[_]u8{ 0x01, 0x00, 0x5E, 0x00, 0x00, 0xFB }); // address
        try self.set_var("mcast_list", &buf);
        self.sleep_ms(50);
    }

    try self.set_cmd(.set_wsec, &.{switch (opt.security) {
        .wpa_psk => 2,
        .wpa2_psk, .wpa3_sae => 6,
        .open => 0,
    }});
    switch (opt.security) {
        .open => {
            try self.set_var("bsscfg:sup_wpa", &.{ 0, 0, 0, 0, 0, 0, 0, 0 });
        },
        else => {
            try self.set_var("bsscfg:sup_wpa", &.{ 0, 0, 0, 0, 1, 0, 0, 0 });
            try self.set_var("bsscfg:sup_wpa2_eapver", &.{ 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff });
            try self.set_var("bsscfg:sup_wpa_tmo", &.{ 0, 0, 0, 0, 0xc4, 0x09, 0, 0 });
        },
    }
    self.sleep_ms(2);

    switch (opt.security) {
        .open => {},
        .wpa3_sae => {
            try self.set_var("sae_password", ioctl.encode_sae_pwd(&buf, pwd));
        },
        else => {
            try self.set_cmd(.set_wsec_pmk, ioctl.encode_pwd(&buf, pwd));
        },
    }
    try self.set_cmd(.set_infra, &.{1});

    try self.set_cmd(.set_auth, &.{switch (opt.security) {
        .wpa3_sae => 3,
        else => 0,
    }});
    try self.set_var("mfp", &.{switch (opt.security) {
        .wpa_psk => 0,
        .wpa2_psk => 1,
        .wpa3_sae => 2,
        .open => 0,
    }});
    try self.set_cmd(.set_wpa_auth, switch (opt.security) {
        .wpa_psk => &.{ 0x04, 0, 0, 0 },
        .wpa2_psk => &.{ 0x80, 0, 0, 0 },
        .wpa3_sae => &.{ 0, 0, 0x04, 0 },
        .open => &.{ 0, 0, 0, 0 },
    });

    try self.set_cmd(.set_ssid, ioctl.encode_ssid(&buf, ssid));

    if (opt.security == .open) {
        self.event_log.psk_sup = .success;
    }

    self.join_state = .joining;
    return .{ .parent = self };
}

pub fn connected(self: Self) bool {
    return self.join_state == .joined;
}

pub const JoinPoller = struct {
    parent: *Self,

    // Typical events flow:
    //
    // Join to open network events:
    //   [1.824251] type: .auth,     status: .success
    //   [1.859136] type: .assoc,    status: .success
    //   [1.876234] type: .link,     status: .success
    //   [1.893244] type: .join,     status: .success
    //   [1.910249] type: .set_ssid, status: .success
    //
    // Join to wpa2 network events:
    //   [4.039611] type: .auth,     status: .success
    //   [4.073556] type: .assoc,    status: .success
    //   [4.090268] type: .link,     status: .success
    //   [4.106842] type: .psk_sup,  status: .unsolicited
    //   [4.124026] type: .join,     status: .success
    //   [4.140596] type: .set_ssid, status: .success
    //
    // On disconnect:
    //   [10.410040] type: .deauth_ind, status: .success
    //   [11.456022] type: .auth,       status: .fail
    //   [20.875620] type: .link,       status: .success
    //
    // On reconnect:
    //   [39.896166] type: .auth,    status: .success
    //   [39.910309] type: .reassoc, status: .success
    //   [39.917245] type: .link,    status: .success
    //   [40.202375] type: .join,    status: .success
    //
    // Joining with wrong password:
    //   [3.759191] type: .auth,     status: .success
    //   [3.785954] type: .assoc,    status: .success
    //   [3.802674] type: .link,     status: .success
    //   [3.829335] type: .join,     status: .success
    //   [3.845951] type: .set_ssid, status: .success
    //   [6.276576] type: .psk_sup,  status: .partial
    //   [6.283378] error: error.Cyw43WpaHandshake
    //
    // Wrong network ssid
    // [1.555841] type: .set_ssid, status: .no_networks
    // [1.563185] error: error.Cyw43SetSsid
    //
    // Wrong security open/wpa_psk/wpa3_sae instad of wpa2_psk
    // [1.525449] type: .set_ssid, status: .fail
    // [1.532186] error: error.Cyw43SetSsid
    //
    pub fn poll(jp: *JoinPoller) !bool {
        if (jp.parent.join_state == .joining) {
            try jp.parent.poll();
            try jp.parent.event_log.err();
        }
        return jp.parent.join_state == .joining;
    }

    pub fn wait(jp: *JoinPoller, wait_ms: u32) !void {
        var delay: u32 = 0;
        while (delay < wait_ms and try jp.poll()) {
            jp.parent.sleep_ms(ioctl.response_poll_interval);
            delay += ioctl.response_poll_interval;
        }
        if (jp.parent.join_state == .joined) return;
        return error.Cyw43JoinTimeout;
    }
};

pub fn poll(self: *Self) !void {
    var bytes: [ioctl_request_bytes_len]u8 align(4) = undefined;
    const rsp, _ = try self.read(&bytes) orelse return;
    switch (rsp.sdp.channel()) {
        .event => self.handle_event(rsp),
        else => self.log_response(rsp),
    }
}

fn handle_event(self: *Self, rsp: ioctl.Response) void {
    const evt = (rsp.event() orelse return).msg;
    const event_log = &self.event_log;
    const state = EventLog.EventState.from;
    const debug_log = false;
    if (debug_log)
        log.debug(
            "handle event type: {}, status: {} ",
            .{ evt.event_type, evt.status },
        );
    switch (evt.event_type) {
        .link => {
            event_log.link = state(evt.status == .success and evt.flags & 1 > 0);
        },
        .psk_sup => {
            event_log.psk_sup =
                state(evt.status == .success or evt.status == .unsolicited);
        },
        .assoc, .reassoc => {
            event_log.assoc = state(evt.status == .success);
        },
        .disassoc_ind, .disassoc => {
            event_log.assoc = .fail;
        },
        .auth => {
            event_log.auth = state(evt.status == .success);
        },
        .deauth_ind => {
            event_log.auth = .fail;
        },
        .set_ssid => {
            event_log.set_ssid = state(evt.status == .success);
        },
        .join => {
            event_log.join = state(evt.status == .success);
        },
        .escan_result => {
            self.scan_result = null;
            self.scan_state = switch (evt.status) {
                .success, .newassoc, .ccxfastrm => .success,
                .partial, .newscan => .running,
                else => .fail,
            };
            if (evt.status == .partial) {
                self.handle_scan_event(rsp);
            }
        },
        .none => return,
        else => {
            log.warn(
                "unhandled event type: {}, status: {} ",
                .{ evt.event_type, evt.status },
            );
            return;
        },
    }
    const new_state = event_log.join_state();
    if (debug_log and new_state != self.join_state) {
        log.debug("state changed old: {}, new: {}", .{ self.join_state, new_state });
        log.debug("event log: {}", .{self.event_log});
    }
    if (self.join_state == .joining and new_state == .disjoined) {
        event_log.err() catch |err| {
            self.err = err;
        };
    }
    self.join_state = new_state;
}

fn handle_scan_event(self: *Self, rsp: ioctl.Response) void {
    const res, const security = rsp.event_scan_result() catch |err| {
        log.err("fail to parse event scan result {}", .{err});
        return;
    };
    if (res.ssid_len == 0) return; // skip zero length ssid
    self.scan_result = .{};
    const sr = &self.scan_result.?;
    sr.ssid_buf = res.ssid;
    sr.ap_mac = res.bssid;
    sr.ssid = sr.ssid_buf[0..res.ssid_len];
    sr.security = security;
    sr.channel = res.channel;
}

const ScanParams = extern struct {
    version: u32 = 1,
    action: u16 = 1,
    sync_id: u16 = 0x1,

    // ssid to scan for, 0 - all
    ssid_len: u32 = 0,
    ssid: [32]u8 = @splat(0),

    bssid: [6]u8 = @splat(0xff),
    bss_type: u8 = 2, // 2 - bss type any
    scan_type: u8 = 0, // 0=active, 1=passive

    nprobes: u32 = 0xff_ff_ff_ff,
    active_time: u32 = 0xff_ff_ff_ff,
    passive_time: u32 = 0xff_ff_ff_ff,
    home_time: u32 = 0xff_ff_ff_ff,

    channel_num: u32 = 0,
    channel_list: [1]u16 = @splat(0),
};

/// Init scan and return poller
pub fn scan(self: *Self) !ScanPoller {
    self.err = null;
    // Params can be used to choose active/passive scan type or to set specific
    // ssid to scan for.
    var params: ScanParams = .{};
    try self.set_var("escan", mem.asBytes(&params));
    self.scan_state = .running;

    return .{
        .parent = self,
    };
}

pub const ScanPoller = struct {
    parent: *Self,

    /// Buffer for last x seen ssid's. Used for de-duplication of scan results.
    seen_buf: [8][6]u8 = undefined,
    seen_idx: usize = 0,

    /// Returns true if scan is not finished.
    /// If poll finds new ssid result is not null.
    ///
    /// Intended usage:
    ///   while (try scan.poll()) {
    ///     if (scan.result()) |res| { ...
    pub fn poll(sp: *ScanPoller) !bool {
        if (sp.parent.scan_state == .running) {
            try sp.parent.poll();
        }
        return sp.parent.scan_state == .running;
    }

    pub fn result(sp: *ScanPoller) ?ScanResult {
        const res = sp.parent.scan_result orelse return null;
        // Check if access point mac is already seen
        for (0..@min(sp.seen_idx, sp.seen_buf.len)) |i| {
            if (std.mem.eql(u8, &sp.seen_buf[i], &res.ap_mac)) {
                return null;
            }
        }
        // Store in seen list
        sp.seen_buf[sp.seen_idx % sp.seen_buf.len] = res.ap_mac;
        sp.seen_idx +%= 1;
        return res;
    }

    pub fn state(sp: ScanPoller) ScanState {
        return sp.parent.scan_state;
    }
};

// show unexpected command response
fn log_response(self: Self, rsp: ioctl.Response) void {
    switch (rsp.sdp.channel()) {
        .event => {
            const evt = (rsp.event() orelse return).msg;
            if (evt.event_type == .none and evt.status == .success)
                return;
            log.debug(
                "unhandled event type: {}, status: {} ",
                .{ evt.event_type, evt.status },
            );
        },
        .control => {
            log.err("unexpected command response:", .{});
            log.err("  bus: {}", .{rsp.sdp});
            log.err("  cdc: {}", .{rsp.cdc()});
            log.err("  data: {x}", .{rsp.data()});
        },
        .data => {
            if (self.join_state == .joining) return;
            log.err("unexpected data:", .{});
            log.err("  bus: {}", .{rsp.sdp});
            log.err("  bdc: {}", .{rsp.bdc()});
            log.err("  data: {x}", .{rsp.data()});
        },
    }
}

fn sleep_ms(self: Self, delay: u32) void {
    self.bus.sleep_ms(delay);
}

/// buffer.len should be 1540 bytes. Last 4 bytes are for the status which is
/// writen after each read. 22 bytes at the start is bus header, 18 bytes header
/// + 4 bytes padding. After that is layer 2, ethernet, packet; 14 bytes of
/// ethernet header and 1500 bytes of layer 3 mtu.
///
///   22 bytes bus header (18 + padding)
///   14 bytes ethernet header
/// 1500 bytes layer 3 mtu
///    4 bytes status
/// 1540 bytes total
///
/// Layer 2 header+payload position is passed to the caller. First return
/// argument is start of that data in the buffer second is length.
pub fn recv_zc(self: *Self, buffer: []u8) !struct { usize, usize, bool } {
    while (true) {
        const rsp, const rx_ready = try self.read(buffer) orelse return .{ 0, 0, false };
        switch (rsp.sdp.channel()) {
            .data => {
                const head, const len = rsp.data_pos();
                return .{ head, len, rx_ready };
            },
            .event => self.handle_event(rsp),
            else => self.log_response(rsp),
        }
    }
}

/// Buffer has to have 22 bytes headroom for ioctl command (4 bytes) and bus
/// header (18 bytes). After that layer 2 should be prepared, 14 bytes ethernet
/// header and up to 1500 bytes layer 3 mtu.
///
///    22 bytes headroom for ioctl command and bus header
///    14 bytes ethernet header
///  1500 bytes layer 3 mtu
///  1536 bytes total
///
/// Buffer has to be 4 bytes aligned and it will be extended in as_words to the
/// word boundary!
pub fn send_zc(self: *Self, buffer: []u8) anyerror!void {
    const eth_frame_len = buffer.len - 22;
    // add bus header
    self.tx_sequence +%= 1;
    buffer[4..][0..18].* = ioctl.tx_header(@intCast(eth_frame_len), self.tx_sequence);

    // bus write
    const bytes_len = 18 + eth_frame_len;
    const words_len = ((bytes_len + 3) >> 2) + 1; // round and add 1 for bus command

    self.bus.write(.wlan, 0, @intCast(bytes_len), as_words(buffer, words_len));
}

pub fn has_credit(self: *Self) bool {
    return self.tx_sequence != self.credit and (self.credit -% self.tx_sequence) & 0x80 == 0;
}

// Read packet from the WiFi chip. Returns bus response and indication if there
// is more data packets available. Returns null if there are no packets ready.
fn read(self: *Self, buffer: []u8) !?struct { ioctl.Response, bool } {
    var status = self.read_bus_status();
    defer {
        if (status.f2_interrupt and !status.f2_packet_available and self.join_state != .none) {
            // Reading all packets clears interrupt, notify upstream that it is
            // cleared now.
            self.bus.spi.irq_cleared();
        }
    }
    if (status.f2_packet_available and status.packet_length > 0) {
        const words_len: usize = ((status.packet_length + 3) >> 2) + 1; // add one word for the status
        const words = as_words(buffer, words_len);
        self.bus.read(.wlan, 0, status.packet_length, words);
        // parse response
        const rsp = try ioctl.response(mem.sliceAsBytes(words)[0..status.packet_length]);
        // last word is status
        status = @bitCast(words[words.len - 1]);
        // update credit
        self.credit = rsp.sdp.credit;
        return .{ rsp, status.f2_packet_available };
    }
    return null;
}

fn as_words(bytes: []u8, len: usize) []u32 {
    var words: []u32 = undefined;
    words.ptr = @ptrCast(@alignCast(@constCast(bytes.ptr)));
    words.len = len;
    return words;
}

fn read_bus_status(self: *Self) BusStatus {
    return @bitCast(self.bus.read_int(u32, .bus, Bus.reg.status));
}

pub fn gpio_enable(self: *Self, pin: u2) void {
    self.bus.write_int(u32, .backplane, chip.gpio.enable, @as(u32, 1) << pin);
}

pub fn gpio_toggle(self: *Self, pin: u2) void {
    var reg = self.bus.read_int(u32, .backplane, chip.gpio.output);
    reg = reg ^ @as(u32, 1) << pin;
    self.bus.write_int(u32, .backplane, chip.gpio.output, reg);
}

pub fn gpio_put(self: *Self, pin: u2, value: u1) void {
    var reg = self.bus.read_int(u32, .backplane, chip.gpio.output);
    reg = reg | @as(u32, value) << pin;
    self.bus.write_int(u32, .backplane, chip.gpio.output, reg);
}

// to set gpio pin by sending command
pub fn gpio_out(self: *Self, pin: u2, on: bool) !void {
    var data: [8]u8 = @splat(0);
    data[0] = @as(u8, 1) << pin;
    data[4] = if (on) 1 else 0;
    try self.set_var("gpioout", &data);
}

fn show_clm_ver(self: *Self) !void {
    var data: [128]u8 = @splat(0);
    const n = try self.get_var("clmver", &data);
    var iter = mem.splitScalar(u8, data[0..n], 0x0a);
    log.debug("clmver:", .{});
    while (iter.next()) |line| {
        if (line.len == 0 or line[0] == 0x00) continue;
        log.debug("  {s}", .{line});
    }
}

pub fn read_mac(self: *Self) ![6]u8 {
    var mac: [6]u8 = @splat(0);
    const n = try self.get_var("cur_etheraddr", &mac);
    if (n != mac.len) {
        log.err("read_mac unexpected read bytes: {}", .{n});
        return error.ReadMacFailed;
    }
    return mac;
}

// ref: datasheet 'Table 5. gSPI Status Field Details'
const BusStatus = packed struct {
    data_not_available: bool, //  The requested read data is not available.
    underflow: bool, //           FIFO underflow occurred due to current (F2, F3) read command.
    overflow: bool, //            FIFO overflow occurred due to current (F1, F2, F3) write command.
    f2_interrupt: bool, //        F2 channel interrupt.
    _reserved1: u1,
    f2_rx_ready: bool, //         F2 FIFO is ready to receive data (FIFO empty).
    _reserved2: u2,
    f2_packet_available: bool, // Packet is available/ready in F2 TX FIFO.
    packet_length: u11, //        Length of packet available in F2 FIFO,
    _reserved3: u12,
};

pub const ScanResult = struct {
    ssid: []const u8 = &.{},
    ap_mac: [6]u8 = @splat(0),
    security: ioctl.Security = .{},
    channel: u16 = 0,
    ssid_buf: [32]u8 = @splat(0),
};

pub const ScanState = enum {
    none,
    running,
    success,
    fail,
};

// Log of the join events
const EventLog = packed struct {
    pub const EventState = enum(u2) {
        none = 0b00,
        success = 0b01,
        fail = 0b10,

        fn from(ok: bool) EventState {
            return if (ok) .success else .fail;
        }
    };

    // essential join events
    auth: EventState = .none,
    link: EventState = .none,
    psk_sup: EventState = .none,
    set_ssid: EventState = .none,
    // other join events
    assoc: EventState = .none,
    join: EventState = .none,

    pub fn err(e: EventLog) !void {
        if (e.auth == .fail) return error.Cyw43Authentication;
        if (e.link == .fail) return error.Cyw43LinkDown;
        if (e.psk_sup == .fail) return error.Cyw43WpaHandshake;
        if (e.set_ssid == .fail) return error.Cyw43SetSsid;
    }

    pub fn join_state(e: EventLog) JoinState {
        var i: u12 = @bitCast(e);
        i &= 0b00_00_11_11_11_11; // filter essential join events
        const fail_mask = 0b10_10_10_10;
        const succ_mask = 0b01_01_01_01;
        if (i == 0) return .none;
        if (i & fail_mask > 0) return .disjoined; // any failed
        if (i & succ_mask == succ_mask) return .joined; // all success
        return .joining;
    }
};

pub const JoinState = enum {
    none,
    joining,
    joined,
    disjoined,
};

const testing = std.testing;

test "events to join_state" {
    var e: EventLog = .{};
    try testing.expectEqual(.none, e.join_state());
    e.auth = .success;
    try testing.expectEqual(.joining, e.join_state());
    e.link = .success;
    e.psk_sup = .success;
    try testing.expectEqual(.joining, e.join_state());
    try testing.expectEqual(0b00_01_01_01, @as(u12, @bitCast(e)));
    e.set_ssid = .success;
    try testing.expectEqual(.joined, e.join_state());
    e.auth = .fail;
    try testing.expectEqual(.disjoined, e.join_state());
    e.auth = .none;
    try testing.expectEqual(.joining, e.join_state());
    e.auth = .success;
    try testing.expectEqual(.joined, e.join_state());
}

// CYW43439 chip values
const chip = struct {
    const wrapper_register_offset: u32 = 0x100000;

    const arm_core_base_address: u32 = 0x18003000 + wrapper_register_offset;
    const socsram_base_address: u32 = 0x18004000;
    const bluetooth_base_address: u32 = 0x19000000;
    const socsram_wrapper_base_address: u32 = 0x18004000 + wrapper_register_offset;
    const sdiod_core_base_address: u32 = 0x18002000;
    const pmu_base_address: u32 = 0x18000000;
    const chip_ram_size: u32 = 512 * 1024;
    const atcm_ram_base_address: u32 = 0;
    const socram_srmem_size: u32 = 64 * 1024;
    const chanspec_band_mask: u32 = 0xc000;
    const chanspec_band_2g: u32 = 0x0000;
    const chanspec_band_5g: u32 = 0xc000;
    const chanspec_band_shift: u32 = 14;
    const chanspec_bw_10: u32 = 0x0800;
    const chanspec_bw_20: u32 = 0x1000;
    const chanspec_bw_40: u32 = 0x1800;
    const chanspec_bw_mask: u32 = 0x3800;
    const chanspec_bw_shift: u32 = 11;
    const chanspec_ctl_sb_lower: u32 = 0x0000;
    const chanspec_ctl_sb_upper: u32 = 0x0100;
    const chanspec_ctl_sb_none: u32 = 0x0000;
    const chanspec_ctl_sb_mask: u32 = 0x0700;

    const gpio = struct {
        pub const output = (pmu_base_address + 0x64);
        pub const enable = (pmu_base_address + 0x68);
    };
};

// Broadcom AMBA (Advanced Microcontroller Bus Architecture) Interconnect
const ai = struct {
    const ioctrl_offset: u32 = 0x408;
    const ioctrl_bit_fgc: u8 = 0x0002;
    const ioctrl_bit_clock_en: u8 = 0x0001;
    const ioctrl_bit_cpuhalt: u8 = 0x0020;

    const resetctrl_offset: u32 = 0x800;
    const resetctrl_bit_reset: u8 = 1;

    const resetstatus_offset: u32 = 0x804;
};

const Core = enum(u2) {
    wlan = 0,
    socram = 1,
    sdiod = 2,

    fn base_addr(self: Core) u32 {
        return switch (self) {
            .wlan => chip.arm_core_base_address,
            .socram => chip.socsram_wrapper_base_address,
            .sdiod => chip.sdiod_core_base_address,
        };
    }
};

const LogState = struct {
    addr: u32 = 0,
    idx: usize = 0,
};

const SharedMemData = extern struct {
    flags: u32,
    trap_addr: u32,
    assert_exp_addr: u32,
    assert_file_addr: u32,
    assert_line: u32,
    console_addr: u32,
    msgtrace_addr: u32,
    fwid: u32,
};

const SharedMemLog = extern struct {
    buf: u32,
    buf_size: u32,
    idx: u32,
    out_idx: u32,
};
