// Low level wifi operations for CYW43
// Based on embassy-rs/cyw43 and Infineon wifi-host-driver

const std = @import("std");
const cyw43_bus = @import("bus.zig");
const sdpcm = @import("sdpcm.zig");
const consts = @import("consts.zig");

const log = std.log.scoped(.wifi);

// Ioctl commands
const IOCTL_UP: u32 = 2;
const IOCTL_SET_INFRA: u32 = 20;
const IOCTL_SET_AUTH: u32 = 22;
const IOCTL_SET_SSID: u32 = 26;
const IOCTL_SET_ANTDIV: u32 = 64;
const IOCTL_SET_GMODE: u32 = 110;
const IOCTL_SET_WSEC: u32 = 134;
const IOCTL_SET_BAND: u32 = 142;
const IOCTL_SET_WPA_AUTH: u32 = 165;
const IOCTL_GET_VAR: u32 = 262;
const IOCTL_SET_VAR: u32 = 263;
const IOCTL_SET_WSEC_PMK: u32 = 268;

// Security constants
const WSEC_TKIP: u32 = 0x02;
const WSEC_AES: u32 = 0x04;
const AUTH_OPEN: u32 = 0x00;
const AUTH_SAE: u32 = 0x03;
const WPA_AUTH_DISABLED: u32 = 0x0000;
const WPA_AUTH_WPA_PSK: u32 = 0x0004;
const WPA_AUTH_WPA2_PSK: u32 = 0x0080;
const WPA_AUTH_WPA3_SAE_PSK: u32 = 0x40000;
const MFP_NONE: u32 = 0;
const MFP_CAPABLE: u32 = 1;
const MFP_REQUIRED: u32 = 2;

/// WiFi event types for use with enableEvent/disableEvent
pub const Event = struct {
    pub const SET_SSID: u32 = 0;
    pub const AUTH: u32 = 3;
    pub const DEAUTH: u32 = 5;
    pub const DEAUTH_IND: u32 = 6;
    pub const DISASSOC: u32 = 11;
    pub const DISASSOC_IND: u32 = 12;
    pub const LINK: u32 = 16;
    pub const ROAM: u32 = 19;
    pub const RADIO: u32 = 40;
    pub const PSK_SUP: u32 = 46;
    pub const IF: u32 = 54;
    pub const PROBREQ_MSG: u32 = 68;
    pub const ESCAN_RESULT: u32 = 69;
    pub const PROBREQ_MSG_RX: u32 = 70;
    pub const PROBRESP_MSG: u32 = 71;
};

// Event status values
const EVENT_STATUS_SUCCESS: u32 = 0;
const EVENT_STATUS_PARTIAL: u32 = 8;

// CLM loading flags
const CLM_FLAG_HANDLER_VER: u16 = 0x1000;
const CLM_FLAG_BEGIN: u16 = 0x0002;
const CLM_FLAG_END: u16 = 0x0004;
const CLM_TYPE: u16 = 2;
const CLM_CHUNK_SIZE: usize = 1024;

const CountryInfo = extern struct {
    country_abbrev: [4]u8,
    revision: i32,
    country_code: [4]u8,
};

const SsidInfo = extern struct {
    len: u32,
    ssid: [32]u8,
};

const PassphraseInfo = extern struct {
    len: u16,
    flags: u16,
    passphrase: [64]u8,
};

/// SAE passphrase info for WPA3
const SaePassphraseInfo = extern struct {
    len: u16,
    passphrase: [128]u8,
};

/// WiFi security mode
pub const Security = enum {
    open,
    wpa_psk,
    wpa2_psk,
    wpa3_sae,
};

/// CLM download header
const DownloadHeader = extern struct {
    flags: u16,
    type_: u16,
    len: u32,
    crc: u32,
};

pub const CYW43_Wifi = struct {
    const Self = @This();

    transport: sdpcm.Sdpcm,

    mac_address: [6]u8 = .{ 0, 0, 0, 0, 0, 0 },
    mac_valid: bool = false,
    connected: bool = false,
    link_up: bool = false,
    event_mask: [24]u8 = .{0xFF} ** 24,
    scan_ctx: ScanCtx = .{},

    const clm_data = @embedFile("firmware/43439A0_clm.bin");

    pub fn init(bus: *cyw43_bus.Cyw43_Bus) CYW43_Wifi {
        return CYW43_Wifi{
            .transport = sdpcm.Sdpcm.init(bus),
        };
    }

    /// Enable WiFi with country code (e.g., "GB", "US")
    pub fn enable(self: *Self, country: []const u8) !void {
        log.info("Initializing WiFi...", .{});

        // Enable F2 packet available interrupt
        self.transport.bus.write16(.bus, consts.REG_BUS_INTERRUPT_ENABLE, consts.IRQ_F2_PACKET_AVAILABLE);

        try self.loadClm();

        // Disable TX glomming
        try self.transport.set_iovar_u32("bus:txglom", 0);
        self.transport.bus.internal_delay_ms(10);

        // Enable APSTA mode
        try self.transport.set_iovar_u32("apsta", 1);
        self.transport.bus.internal_delay_ms(10);

        try self.initMacAddress();
        try self.setCountry(country);
        self.transport.bus.internal_delay_ms(100);

        // Configure antenna
        try self.transport.ioctl_set_u32(IOCTL_SET_ANTDIV, 0, 0);
        self.transport.bus.internal_delay_ms(10);

        // Set AMPDU parameters
        try self.transport.set_iovar_u32("ampdu_ba_wsize", 8);
        self.transport.bus.internal_delay_ms(10);
        try self.transport.set_iovar_u32("ampdu_mpdu", 4);
        self.transport.bus.internal_delay_ms(10);

        try self.sendEventMask();

        // Disable spammy events by default, following embassy-rs/cyw43.
        // Users can re-enable with enableEvents() if needed.
        try self.disableEvents(&.{
            Event.RADIO,
            Event.ROAM,
            Event.IF,
            Event.PROBREQ_MSG,
            Event.PROBREQ_MSG_RX,
            Event.PROBRESP_MSG,
        });

        // Bring interface up
        try self.transport.ioctl(IOCTL_UP, 0, true, &[_]u8{});
        self.transport.bus.internal_delay_ms(10);

        // Set G-mode to auto
        try self.transport.ioctl_set_u32(IOCTL_SET_GMODE, 0, 1);
        self.transport.bus.internal_delay_ms(10);

        // Set band to any
        try self.transport.ioctl_set_u32(IOCTL_SET_BAND, 0, 0);
        self.transport.bus.internal_delay_ms(10);

        log.info("WiFi initialized", .{});
    }

    pub const BssInfo = struct {
        bssid: [6]u8,
        rssi: i16,
        channel: u16,
        ssid_len: u8,
        ssid: [32]u8,
    };

    const ScanState = enum { idle, running, done, failed };

    const ScanCtx = struct {
        state: ScanState = .idle,

        /// How many results were written into `out`
        stored: usize = 0,

        /// Total APs observed during the scan (may exceed `out.len`)
        seen: usize = 0,

        truncated: bool = false,

        out: []BssInfo = &.{},
    };

    pub const ScanType = enum(u8) { active = 0, passive = 1 };

    pub const ScanParams = struct {
        ssid: ?[]const u8 = null,
        bssid: ?[6]u8 = null,
        bss_type: u8 = 2,
        scan_type: ScanType = .active,

        nprobes: ?u32 = null,
        active_time: ?u32 = null,
        passive_time: ?u32 = null,
        home_time: ?u32 = null,
    };

    const ScanParamsWire = extern struct {
        version: u32,
        action: u16,
        sync_id: u16,

        ssid_len: u32,
        ssid: [32]u8,

        bssid: [6]u8,
        bss_type: u8,
        scan_type: u8,

        nprobes: u32,
        active_time: u32,
        passive_time: u32,
        home_time: u32,

        channel_num: u32,
    };

    fn packScanParams(out: []u8, params: ScanParams, channels: []const u16) ![]const u8 {
        const wire_len = @sizeOf(ScanParamsWire);
        const total = wire_len + channels.len * @sizeOf(u16);
        if (total > out.len) return error.PayloadTooLarge;

        @memset(out[0..total], 0);

        const wire: *ScanParamsWire = @ptrCast(@alignCast(out[0..wire_len].ptr));

        wire.version = 1;
        wire.action = 1;
        wire.sync_id = 1;

        if (params.ssid) |ssid| {
            const n = @min(ssid.len, 32);
            wire.ssid_len = @as(u32, @intCast(n));
            std.mem.copyForwards(u8, wire.ssid[0..n], ssid[0..n]);
        }

        wire.bssid = params.bssid orelse .{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
        wire.bss_type = params.bss_type;
        wire.scan_type = switch (params.scan_type) {
            .active => 0,
            .passive => 0x01,
        };

        const minus_one: u32 = 0xFFFF_FFFF;
        wire.nprobes = params.nprobes orelse minus_one;
        wire.active_time = params.active_time orelse minus_one;
        wire.passive_time = params.passive_time orelse minus_one;
        wire.home_time = params.home_time orelse minus_one;

        wire.channel_num = @as(u32, @intCast(channels.len));

        std.mem.copyForwards(u8, out[wire_len..total], std.mem.sliceAsBytes(channels));
        return out[0..total];
    }

    pub const ScanResults = struct {
        bsss: []BssInfo,
        seen: usize,
        truncated: bool,
    };

    fn startScan(self: *Self, params: ScanParams, channels: []const u16, out: []BssInfo) !void {
        if (self.scan_ctx.state == .running)
            return error.ScanAlreadyRunning;

        self.scan_ctx = .{
            .state = .running,
            .stored = 0,
            .seen = 0,
            .truncated = false,
            .out = out,
        };

        const max_payload = 1280 - ("escan".len + 1);
        var payload_buf: [max_payload]u8 = undefined;

        const payload = try packScanParams(&payload_buf, params, channels);
        try self.transport.set_iovar("escan", payload);
    }

    pub fn scan(
        self: *Self,
        params: ScanParams,
        channels: []const u16,
        out: []BssInfo,
    ) !ScanResults {
        try self.startScan(params, channels, out);
        errdefer self.scan_ctx.state = .failed;

        while (self.scan_ctx.state == .running) {
            _ = try self.poll();
        }

        if (self.scan_ctx.state == .failed) return error.ScanFailed;

        return .{
            .bsss = out[0..self.scan_ctx.stored],
            .seen = self.scan_ctx.seen,
            .truncated = self.scan_ctx.truncated,
        };
    }

    /// Join a WiFi network
    pub fn join(self: *Self, ssid: []const u8, password: []const u8, security: Security) !void {
        log.info("Joining network: {s} (security={s})", .{ ssid, @tagName(security) });

        if (security == .open) {
            try self.transport.ioctl_set_u32(IOCTL_SET_WSEC, 0, 0);
            self.transport.bus.internal_delay_ms(10);

            try self.transport.set_iovar_u32x2("bsscfg:sup_wpa", 0, 0);
            self.transport.bus.internal_delay_ms(10);

            try self.transport.ioctl_set_u32(IOCTL_SET_INFRA, 0, 1);
            self.transport.bus.internal_delay_ms(10);

            try self.transport.ioctl_set_u32(IOCTL_SET_AUTH, 0, AUTH_OPEN);
            self.transport.bus.internal_delay_ms(10);

            try self.transport.ioctl_set_u32(IOCTL_SET_WPA_AUTH, 0, WPA_AUTH_DISABLED);
            self.transport.bus.internal_delay_ms(10);
        } else {
            const wsec: u32 = switch (security) {
                .wpa_psk => WSEC_TKIP,
                .wpa2_psk, .wpa3_sae => WSEC_AES,
                .open => unreachable,
            };
            try self.transport.ioctl_set_u32(IOCTL_SET_WSEC, 0, wsec);
            self.transport.bus.internal_delay_ms(10);

            // Enable WPA supplicant
            try self.transport.set_iovar_u32x2("bsscfg:sup_wpa", 0, 1);
            self.transport.bus.internal_delay_ms(10);

            try self.transport.set_iovar_u32x2("bsscfg:sup_wpa2_eapver", 0, @bitCast(@as(i32, -1)));
            self.transport.bus.internal_delay_ms(10);

            try self.transport.set_iovar_u32x2("bsscfg:sup_wpa_tmo", 0, 2500);
            self.transport.bus.internal_delay_ms(10);

            if (security == .wpa3_sae) {
                var sae = SaePassphraseInfo{
                    .len = @intCast(password.len),
                    .passphrase = .{0} ** 128,
                };
                const pwd_len = @min(password.len, 128);
                @memcpy(sae.passphrase[0..pwd_len], password[0..pwd_len]);
                try self.transport.set_iovar("sae_password", std.mem.asBytes(&sae));
                self.transport.bus.internal_delay_ms(10);
            } else {
                var pmk = PassphraseInfo{
                    .len = @intCast(password.len),
                    .flags = 1,
                    .passphrase = .{0} ** 64,
                };
                const pwd_len = @min(password.len, 64);
                @memcpy(pmk.passphrase[0..pwd_len], password[0..pwd_len]);
                try self.transport.ioctl(IOCTL_SET_WSEC_PMK, 0, true, std.mem.asBytes(&pmk));
                self.transport.bus.internal_delay_ms(10);
            }

            try self.transport.ioctl_set_u32(IOCTL_SET_INFRA, 0, 1);
            self.transport.bus.internal_delay_ms(10);

            // Auth mode and MFP settings per security type
            const auth_mode: u32 = if (security == .wpa3_sae) AUTH_SAE else AUTH_OPEN;
            try self.transport.ioctl_set_u32(IOCTL_SET_AUTH, 0, auth_mode);
            self.transport.bus.internal_delay_ms(10);

            const mfp: u32 = switch (security) {
                .wpa_psk => MFP_NONE,
                .wpa2_psk => MFP_CAPABLE,
                .wpa3_sae => MFP_REQUIRED,
                .open => unreachable,
            };
            try self.transport.set_iovar_u32("mfp", mfp);
            self.transport.bus.internal_delay_ms(10);

            const wpa_auth: u32 = switch (security) {
                .wpa_psk => WPA_AUTH_WPA_PSK,
                .wpa2_psk => WPA_AUTH_WPA2_PSK,
                .wpa3_sae => WPA_AUTH_WPA3_SAE_PSK,
                .open => unreachable,
            };
            try self.transport.ioctl_set_u32(IOCTL_SET_WPA_AUTH, 0, wpa_auth);
            self.transport.bus.internal_delay_ms(10);
        }

        var ssid_info = SsidInfo{
            .len = @intCast(ssid.len),
            .ssid = .{0} ** 32,
        };
        const len = @min(ssid.len, 32);
        @memcpy(ssid_info.ssid[0..len], ssid[0..len]);
        try self.transport.ioctl(IOCTL_SET_SSID, 0, true, std.mem.asBytes(&ssid_info));

        log.debug("Join command sent, waiting for connection...", .{});
    }

    /// Poll for events and process them. Returns data packet if one was received.
    pub fn poll(self: *Self) !?[]const u8 {
        const result = (try self.transport.poll()) orelse return null;

        switch (result) {
            .control => |ctrl| {
                self.handleControlResponse(ctrl);
                return null;
            },
            .event => |event| {
                self.handleEvent(event);
                return null;
            },
            .data => |data| {
                if (!self.connected) self.connected = true;
                return data;
            },
        }
    }

    /// Send data packet (Ethernet frame)
    pub fn send(self: *Self, frame: []const u8) !void {
        try self.transport.send_data_frame(frame);
    }

    /// Check if connected
    pub fn is_connected(self: *Self) bool {
        return self.connected;
    }

    /// Get MAC address
    pub fn get_mac_address(self: *Self) ![6]u8 {
        if (!self.mac_valid) {
            return error.MacNotAvailable;
        }
        return self.mac_address;
    }

    /// Handle control channel response (log errors)
    fn handleControlResponse(self: *Self, ctrl: sdpcm.ControlResponse) void {
        _ = self;
        if (ctrl.is_error) {
            log.warn("Ioctl error: cmd={} status={}", .{ ctrl.cmd, ctrl.status });
        } else {
            log.debug("Ioctl OK: cmd={}", .{ctrl.cmd});
        }
    }

    /// Parse an escan partial result into a BssInfo struct
    fn parseEscanPartial(payload: []const u8) ?BssInfo {
        // wl_escan_result_t prefix:
        // u32 buflen, u32 version, u16 sync_id, u16 bss_count  => 12 bytes
        const escan_hdr_len: usize = 12;
        if (payload.len < escan_hdr_len) return null;

        const bss = payload[escan_hdr_len..];

        // wl_bss_info_t (common prefix):
        // u32 version, u32 length, then fields...
        if (bss.len < 20) return null; // enough for ssid_len offset below

        const bss_len = std.mem.readInt(u32, bss[4..8], .little);
        if (bss_len < 20) return null;
        if (bss.len < bss_len) return null; // ensure the whole record is present

        // Offsets in wl_bss_info_t:
        // 0..4  version
        // 4..8  length
        // 8..14 bssid[6]
        // 14..16 beacon_period
        // 16..18 capability
        // 18     ssid_len
        // 19..51 ssid[32]
        const bssid_off: usize = 8;
        const ssid_len_off: usize = 18;
        const ssid_off: usize = 19;

        var out: BssInfo = std.mem.zeroes(BssInfo);

        @memcpy(out.bssid[0..6], bss[bssid_off .. bssid_off + 6]);

        const n_raw: usize = bss[ssid_len_off];
        const n: usize = @min(n_raw, 32);
        out.ssid_len = @intCast(n);
        @memcpy(out.ssid[0..n], bss[ssid_off .. ssid_off + n]);

        const RSSI_OFF: usize = 78; // i16
        const CTL_CH_OFF: usize = 88; // u8

        const rssi_p: *const [2]u8 = @ptrCast(bss.ptr + RSSI_OFF);
        out.rssi = std.mem.readInt(i16, rssi_p, .little);
        out.channel = @as(u16, bss[CTL_CH_OFF]);

        return out;
    }

    /// Handle event from chip
    fn handleEvent(self: *Self, evt: []const u8) void {
        if (evt.len < @sizeOf(sdpcm.EventMessage)) {
            return;
        }

        const em: *const sdpcm.EventMessage = @ptrCast(@alignCast(evt.ptr));

        const event_type = std.mem.readInt(u32, &em.event_type, .big);
        const status = std.mem.readInt(u32, &em.status, .big);
        const data_len = std.mem.readInt(u32, &em.data_len, .big);

        const off = @sizeOf(sdpcm.EventMessage);
        const n: usize = @intCast(data_len);
        if (evt.len < off + n) {
            return;
        }

        const payload = evt[off .. off + n];

        switch (event_type) {
            Event.AUTH => {
                log.info("Auth event: status={}", .{status});
            },
            Event.LINK => {
                self.link_up = (status == EVENT_STATUS_SUCCESS);
                log.info("Link event: up={}", .{self.link_up});
            },
            Event.SET_SSID => {
                if (status == EVENT_STATUS_SUCCESS) {
                    log.info("SSID set success", .{});
                } else {
                    log.warn("SSID set failed: status={}", .{status});
                }
            },
            Event.PSK_SUP => {
                if (status == EVENT_STATUS_SUCCESS or status == 6) {
                    self.connected = true;
                    log.info("WPA handshake complete, connected!", .{});
                }
            },
            Event.DISASSOC, Event.DISASSOC_IND => {
                self.connected = false;
                self.link_up = false;
                log.info("Disassociated", .{});
            },
            Event.DEAUTH, Event.DEAUTH_IND => {
                self.connected = false;
                self.link_up = false;
                log.info("Deauthenticated", .{});
            },
            Event.ESCAN_RESULT => {
                log.debug("Got escan result", .{});
                if (self.scan_ctx.state != .running) {
                    return;
                }

                if (status == EVENT_STATUS_PARTIAL) {
                    log.debug("Scan result (partial)", .{});
                    // you should already have `payload` as the event payload slice
                    if (parseEscanPartial(payload)) |bss| {
                        self.scan_ctx.seen += 1;

                        if (self.scan_ctx.stored < self.scan_ctx.out.len) {
                            self.scan_ctx.out[self.scan_ctx.stored] = bss;
                            self.scan_ctx.stored += 1;
                        } else {
                            self.scan_ctx.truncated = true;
                        }
                    }
                    return;
                }

                log.info("Scan complete", .{});
                self.scan_ctx.state = .done;
            },
            else => {
                log.info("Got unknown event: {}, {}", .{ event_type, status });
            },
        }
    }

    /// Set GPIO (useful for Raspberry Pi Pico 2 W which requires this to enable/disable the LED)
    pub fn gpio_set(self: *Self, gpio_num: u3, value: bool) !void {
        const mask: u32 = @as(u32, 1) << gpio_num;
        const val: u32 = if (value) mask else 0;

        var data: [8]u8 = undefined;
        @memcpy(data[0..4], std.mem.asBytes(&mask));
        @memcpy(data[4..8], std.mem.asBytes(&val));

        try self.transport.set_iovar("gpioout", &data);
    }

    /// Load CLM data
    fn loadClm(self: *Self) !void {
        log.info("Loading CLM data ({} bytes)...", .{clm_data.len});

        var offset: usize = 0;
        var is_first = true;

        while (offset < clm_data.len) {
            const remaining = clm_data.len - offset;
            const chunk_len = @min(CLM_CHUNK_SIZE, remaining);
            const is_last = (offset + chunk_len >= clm_data.len);

            var flags: u16 = CLM_FLAG_HANDLER_VER;
            if (is_first) flags |= CLM_FLAG_BEGIN;
            if (is_last) flags |= CLM_FLAG_END;

            var header = DownloadHeader{
                .flags = flags,
                .type_ = CLM_TYPE,
                .len = @intCast(chunk_len),
                .crc = 0,
            };

            var buf: [1280]u8 = undefined;
            const header_bytes = std.mem.asBytes(&header);
            @memcpy(buf[0..@sizeOf(DownloadHeader)], header_bytes);
            @memcpy(buf[@sizeOf(DownloadHeader)..][0..chunk_len], clm_data[offset..][0..chunk_len]);

            try self.transport.set_iovar("clmload", buf[0 .. @sizeOf(DownloadHeader) + chunk_len]);

            offset += chunk_len;
            is_first = false;
            self.transport.bus.internal_delay_ms(10);
        }

        log.info("CLM loaded", .{});
    }

    /// Initialize MAC address from chip
    fn initMacAddress(self: *Self) !void {
        var buf: [64]u8 = undefined;
        const name = "cur_etheraddr";
        @memcpy(buf[0..name.len], name);
        buf[name.len] = 0;

        try self.transport.ioctl(IOCTL_GET_VAR, 0, false, buf[0 .. name.len + 1]);

        if (self.transport.get_last_control_data()) |data| {
            if (data.len >= 6) {
                @memcpy(&self.mac_address, data[0..6]);
                self.mac_valid = true;
                log.info("MAC address: {x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}", .{
                    self.mac_address[0], self.mac_address[1], self.mac_address[2],
                    self.mac_address[3], self.mac_address[4], self.mac_address[5],
                });
                return;
            }
        }

        log.warn("MAC address not received, using fallback", .{});
        self.mac_address = .{ 0x28, 0xCD, 0xC1, 0x00, 0x00, 0x00 };
        self.mac_valid = true;
    }

    /// Set country code
    fn setCountry(self: *Self, country: []const u8) !void {
        var info = CountryInfo{
            .country_abbrev = .{ 0, 0, 0, 0 },
            .revision = -1,
            .country_code = .{ 0, 0, 0, 0 },
        };

        const len = @min(country.len, 2);
        for (0..len) |i| {
            info.country_abbrev[i] = country[i];
            info.country_code[i] = country[i];
        }

        try self.transport.set_iovar("country", std.mem.asBytes(&info));
    }

    /// Send the current event mask to the chip.
    fn sendEventMask(self: *Self) !void {
        // Buffer format: 4 bytes interface index + 24 bytes mask
        var buf: [28]u8 = undefined;
        @memcpy(buf[0..4], &[_]u8{ 0, 0, 0, 0 }); // interface 0
        @memcpy(buf[4..28], &self.event_mask);
        try self.transport.set_iovar("bsscfg:event_msgs", &buf);
    }

    /// Enable event types. Use Event.* constants.
    pub fn enableEvents(self: *Self, events: []const u32) !void {
        for (events) |event| {
            const byte_idx = event / 8;
            const bit_idx: u3 = @intCast(event % 8);
            self.event_mask[byte_idx] |= (@as(u8, 1) << bit_idx);
        }
        try self.sendEventMask();
    }

    /// Disable event types. Use Event.* constants.
    pub fn disableEvents(self: *Self, events: []const u32) !void {
        for (events) |event| {
            const byte_idx = event / 8;
            const bit_idx: u3 = @intCast(event % 8);
            self.event_mask[byte_idx] &= ~(@as(u8, 1) << bit_idx);
        }
        try self.sendEventMask();
    }
};
