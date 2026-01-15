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
status: ?Status = null,
log_state: LogState = .{},
events: Events = .{},

const ioctl_request_bytes_len = 1024;

pub fn init(self: *Self) !void {
    const bus = self.bus;

    // Init ALP (Active Low Power) clock
    {
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
    // Upload firmware
    {
        self.core_disable(.wlan);
        self.core_reset(.socram);

        // this is 4343x specific stuff: Disable remap for SRAM_3
        bus.write_int(u32, .backplane, chip.socsram_base_address + 0x10, 3);
        bus.write_int(u32, .backplane, chip.socsram_base_address + 0x44, 0);

        const firmware = @embedFile("../cyw43/firmware/43439A0_7_95_61.bin");
        bus.backplane_write(chip.atcm_ram_base_address, firmware);
    }
    // Load nvram
    {
        const nvram_len = ((NVRAM.len + 3) >> 2) * 4; // Round up to 4 bytes.
        const addr_magic = chip.atcm_ram_base_address + chip.chip_ram_size - 4;
        const addr = addr_magic - nvram_len;
        bus.backplane_write(addr, NVRAM);

        const nvram_len_words = (nvram_len >> 2);
        const nvram_len_magic = (~nvram_len_words << 16) | nvram_len_words;
        bus.write_int(u32, .backplane, addr_magic, nvram_len_magic);
    }
    // starting up core...
    self.core_reset(.wlan);
    try self.core_is_up(.wlan);

    // wait until HT clock is available; takes about 29ms
    while (bus.read_int(u8, .backplane, Bus.backplane.chip_clock_csr) & 0x80 == 0) {}

    // "Set up the interrupt mask and enable interrupts"
    const sdio_int_host_mask: u32 = 0x24;
    const i_hmb_sw_mask: u32 = 0x000000f0;
    bus.write_int(
        u32,
        .backplane,
        chip.sdiod_core_base_address + sdio_int_host_mask,
        i_hmb_sw_mask,
    );
    bus.write_int(u16, .bus, Bus.reg.interrupt_enable, @bitCast(Bus.Irq{ .f2_packet_available = true }));

    // "Lower F2 Watermark to avoid DMA Hang in F2 when SD Clock is stopped."
    bus.write_int(u8, .backplane, Bus.backplane.function2_watermark, 0x20);

    // waiting for F2 to be ready...
    while (true) {
        const status: Status = @bitCast(self.bus.read_int(u32, .bus, Bus.reg.status));
        if (status.f2_rx_ready) break;
    }

    // clear pad pulls
    bus.write_int(u8, .backplane, Bus.backplane.pull_up, 0);
    _ = bus.read_int(u8, .backplane, Bus.backplane.pull_up);

    // start HT clock
    bus.write_int(u8, .backplane, Bus.backplane.chip_clock_csr, 0x10);
    while (bus.read_int(u8, .backplane, Bus.backplane.chip_clock_csr) & 0x80 == 0) {}

    // Load Country Locale Matrix (CLM)
    {
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
    self.log_init();
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
        const rsp = try self.read(&bytes) orelse {
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
    country: Country = .{},

    pub const Security = enum {
        open,
        wpa_psk,
        wpa2_psk,
        wpa3_sae,
    };

    // ref: https://github.com/embassy-rs/embassy/blob/96a026c73bad2ebb8dfc78e88c9690611bf2cb97/cyw43/src/structs.rs#L371
    pub const Country = struct {
        code: [2]u8 = "XX".*, // Worldwide
        revision: i32 = -1,
    };
};

/// Blocking wifi network join
pub fn join(self: *Self, ssid: []const u8, pwd: []const u8, opt: JoinOptions) !void {
    var jp = try self.join_poller(ssid, pwd, opt);
    try jp.wait(30 * 1000);
}

pub fn join_poller(self: *Self, ssid: []const u8, pwd: []const u8, opt: JoinOptions) !JoinPoller {
    const bus = self.bus;

    // Clear pullups
    {
        bus.write_int(u8, .backplane, Bus.backplane.pull_up, 0xf);
        bus.write_int(u8, .backplane, Bus.backplane.pull_up, 0);
        _ = self.bus.read_int(u8, .backplane, Bus.backplane.pull_up);
    }
    // Clear data unavail error
    {
        const val = self.bus.read_int(u16, .bus, Bus.reg.interrupt);
        if (val & 1 > 0)
            self.bus.write_int(u16, .bus, Bus.reg.interrupt, val);
    }
    // Set sleep KSO (should poll to check for success)
    {
        bus.write_int(u8, .backplane, Bus.backplane.sleep_csr, 1);
        bus.write_int(u8, .backplane, Bus.backplane.sleep_csr, 1);
        _ = self.bus.read_int(u8, .backplane, Bus.backplane.pull_up);
        //log.debug("REG_BACKPLANE_SLEEP_CSR value: {}", .{val});
    }
    // Set country
    {
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
    try self.set_cmd(.set_antdiv, &.{0});
    // Data aggregation
    {
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
        .deauth,
        .deauth_ind,
    });

    var buf: [64]u8 = @splat(0); // space for 10 addresses
    // Enable multicast
    {
        @memcpy(buf[0..4], &[_]u8{ 0x01, 0x00, 0x00, 0x00 }); // number of addresses
        @memcpy(buf[4..][0..6], &[_]u8{ 0x01, 0x00, 0x5E, 0x00, 0x00, 0xFB }); // address
        try self.set_var("mcast_list", &buf);
        self.sleep_ms(50);
    }
    // join_restart function
    {
        try self.set_cmd(.up, &.{});
        try self.set_cmd(.set_gmode, &.{1});
        try self.set_cmd(.set_band, &.{0});
        try self.set_var("pm2_sleep_ret", &.{0xc8});
        try self.set_var("bcn_li_bcn", &.{1});
        try self.set_var("bcn_li_dtim", &.{1});
        try self.set_var("assoc_listen", &.{0x0a});

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
    }
    if (opt.security == .open) {
        self.events.psk_sup = .success;
    }

    return .{ .wifi = self };
}

pub fn connected(self: Self) bool {
    return self.events.connected();
}

pub const JoinPoller = struct {
    wifi: *Self,

    // Join to open network events:
    //   [1.824251] type: .auth,     status: .success
    //   [1.859136] type: .assoc,    status: .success
    //   [1.876234] type: .link,     status: .success
    //   [1.893244] type: .join,     status: .success
    //   [1.910249] type: .set_ssid, status: .success
    // Join to wpa2 network events:
    //   [4.039611] type: .auth,     status: .success
    //   [4.073556] type: .assoc,    status: .success
    //   [4.090268] type: .link,     status: .success
    //   [4.106842] type: .psk_sup,  status: .unsolicited
    //   [4.124026] type: .join,     status: .success
    //   [4.140596] type: .set_ssid, status: .success

    // On disconnect:
    //   [10.410040] type: .deauth_ind, status: .success
    //   [11.456022] type: .auth,       status: .fail
    //   [20.875620] type: .link,       status: .success
    // On reconnect
    //   [39.896166] type: .auth,    status: .success
    //   [39.910309] type: .reassoc, status: .success
    //   [39.917245] type: .link,    status: .success
    //   [40.202375] type: .join,    status: .success

    pub fn poll(jp: *JoinPoller) !bool {
        const events = &jp.wifi.events;
        if (events.connected()) return false;

        var bytes: [512]u8 align(4) = undefined;
        const rsp = try jp.wifi.read(&bytes) orelse return true;

        switch (rsp.sdp.channel()) {
            .event => jp.wifi.handle_event(&rsp.event().msg),
            else => jp.wifi.log_response(rsp),
        }
        try events.err();
        return !events.connected();
    }

    pub fn wait(jp: *JoinPoller, wait_ms: u32) !void {
        var delay: u32 = 0;
        try jp.poll();
        while (delay < wait_ms and !jp.is_connected()) {
            jp.wifi.sleep_ms(ioctl.response_poll_interval);
            delay += ioctl.response_poll_interval;
            try jp.poll();
        }
        return error.Cyw43JoinTimeout;
    }
};

fn handle_event(self: *Self, evt: *const ioctl.EventMessage) void {
    const events = &self.events;
    const state = Events.State.from;
    // log.debug(
    //     "poll event type: {}, status: {} ",
    //     .{ evt.event_type, evt.status },
    // );
    switch (evt.event_type) {
        .link => {
            events.link = state(evt.status == .success and evt.flags & 1 > 0);
        },
        .psk_sup => {
            events.psk_sup =
                state(evt.status == .success or evt.status == .unsolicited);
        },
        .assoc, .reassoc => {
            events.assoc = state(evt.status == .success);
        },
        .disassoc_ind, .disassoc => {
            events.assoc = .fail;
        },
        .auth => {
            events.auth = state(evt.status == .success);
        },
        .deauth_ind, .deauth => {
            events.auth = .fail;
        },
        .set_ssid => {
            events.set_ssid = state(evt.status == .success);
        },
        .join => {
            events.join = state(evt.status == .success);
        },
        .none => {},
        else => {
            log.warn(
                "unhandled event type: {}, status: {} ",
                .{ evt.event_type, evt.status },
            );
        },
    }
}

const ScanParams = extern struct {
    version: u32 = 1,
    action: u16 = 1,
    sync_id: u16 = 0x1,

    ssid_len: u32 = 0,
    ssid: [32]u8 = @splat(0),

    bssid: [6]u8 = .{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
    bss_type: u8 = 2,
    scan_type: u8 = 1, // passive

    nprobes: u32 = 0xff_ff_ff_ff,
    active_time: u32 = 0xff_ff_ff_ff,
    passive_time: u32 = 0xff_ff_ff_ff,
    home_time: u32 = 0xff_ff_ff_ff,

    nchans: u16 = 0,
    nssids: u16 = 0,

    chans: [14][2]u8 = @splat(@splat(0)),
    ssids: [1][32]u8 = @splat(@splat(0)),
};

fn enable_events(self: *Self, events: []const ioctl.EventType) !void {
    const mask = ioctl.EventType.mask(events);
    try self.set_var("bsscfg:event_msgs", &mask);
    self.sleep_ms(50);
}

/// Init scan and return poller
pub fn scan_poller(self: *Self) !ScanPoller {
    try self.enable_events(&.{ .escan_result, .set_ssid });

    try self.set_cmd(.set_scan_channel_time, &.{40});
    try self.set_var("pm2_sleep_ret", &.{0xc8});
    try self.set_var("bcn_li_bcn", &.{1});
    try self.set_var("bcn_li_dtim", &.{1});
    try self.set_var("assoc_listen", &.{0x0a});
    try self.set_cmd(.set_band, &.{0});
    try self.set_cmd(.up, &.{0});
    var scan_params: ScanParams = .{};
    try self.set_var("escan", mem.asBytes(&scan_params));

    return .{
        .wifi = self,
    };
}

pub const ScanPoller = struct {
    wifi: *Self,
    res: ioctl.EventScanResult = undefined,
    done: bool = false,

    const Result = struct {
        ssid: []const u8 = &.{},
        ap_mac: [6]u8 = @splat(0),
        security: ioctl.Security = .{},
        channel: u16 = 0,

        pub fn empty(res: Result) bool {
            return res.ssid.len == 0;
        }
    };

    pub fn poll(sp: *ScanPoller) !?Result {
        if (sp.done) return null;
        var bytes: [1280]u8 align(4) = undefined;
        if (try sp.wifi.read(&bytes)) |rsp| {
            switch (rsp.sdp.channel()) {
                .event => {
                    const evt = rsp.event().msg;
                    switch (evt.event_type) {
                        .escan_result => {
                            if (evt.status == .success) {
                                sp.done = true;
                                return null;
                            }
                            const security = try rsp.event_scan_result(&sp.res);
                            if (sp.res.info.ssid_len == 0) return .{};
                            return .{
                                .ap_mac = sp.res.info.bssid,
                                .ssid = sp.res.info.ssid[0..sp.res.info.ssid_len],
                                .security = security,
                                .channel = sp.res.info.channel,
                            };
                        },
                        else => sp.wifi.log_response(rsp),
                    }
                },
                else => sp.wifi.log_response(rsp),
            }
        }
        return .{};
    }
};

// show unexpected command response
fn log_response(self: *Self, rsp: ioctl.Response) void {
    _ = self;
    switch (rsp.sdp.channel()) {
        .event => {
            const evt = rsp.event().msg;
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
            log.err("unexpected data:", .{});
            log.err("  bus: {}", .{rsp.sdp});
            log.err("  bdc: {}", .{rsp.bdc()});
            log.err("  data: {x}", .{rsp.data()});
        },
    }
}

fn sleep_ms(self: *Self, delay: u32) void {
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
///
pub fn recv_zc(self: *Self, buffer: []u8) !?struct { usize, usize } {
    while (true) {
        const rsp = try self.read(buffer) orelse return null;
        switch (rsp.sdp.channel()) {
            .data => return rsp.data_pos(),
            .event => self.handle_event(&rsp.event().msg),
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
    if (!self.has_credit()) return error.OutOfMemory;

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

// Read packet from the wifi chip. Assuming that this is used in the loop
// until it returns null. That way we can cache status from previous read.
fn read(self: *Self, buffer: []u8) !?ioctl.Response {
    if (self.status == null) self.read_status();
    const status = self.status.?;
    self.status = null;
    if (status.f2_packet_available and status.packet_length > 0) {
        const words_len: usize = ((status.packet_length + 3) >> 2) + 1; // add one word for the status
        const words = as_words(buffer, words_len);

        self.bus.read(.wlan, 0, status.packet_length, words);
        // last word is status
        self.status = @bitCast(words[words.len - 1]);
        // parse response
        const rsp = try ioctl.response(mem.sliceAsBytes(words)[0..status.packet_length]);
        // update credit
        self.credit = rsp.sdp.credit;
        return rsp;
    }
    return null;
}

fn as_words(bytes: []u8, len: usize) []u32 {
    var words: []u32 = undefined;
    words.ptr = @ptrCast(@alignCast(@constCast(bytes.ptr)));
    words.len = len;
    return words;
}

fn read_status(self: *Self) void {
    self.status = @bitCast(self.bus.read_int(u32, .bus, Bus.reg.status));
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

// ref: datasheet 'Table 5. gSPI Status Field Details'
const Status = packed struct {
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

const Events = struct {
    pub const State = enum(u2) {
        none,
        success,
        fail,

        fn from(ok: bool) State {
            return if (ok) .success else .fail;
        }
    };

    link: State = .none,
    psk_sup: State = .none,
    set_ssid: State = .none,
    assoc: State = .none,
    auth: State = .none,
    join: State = .none,

    pub fn err(e: Events) !void {
        if (e.link == .fail) return error.Cyw43LinkDown;
        if (e.psk_sup == .fail) return error.Cyw43WpaHandshake;
        if (e.set_ssid == .fail) return error.Cyw43SetSsid;
        if (e.assoc == .fail) return error.Cyw43AssocRequest;
        if (e.auth == .fail) return error.Cyw43AuthRequest;
        if (e.join == .fail) return error.Cyw43Join;
    }

    pub fn connected(e: Events) bool {
        return e.link == .success and
            e.psk_sup == .success and
            e.set_ssid == .success and
            e.assoc == .success and
            e.auth == .success and
            e.join == .success;
    }
};

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
