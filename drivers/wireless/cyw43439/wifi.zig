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

        var clr: extern struct {
            name: [8]u8 = "clmload\x00".*,
            flag: u16 = 0,
            typ: u16 = 2,
            len: u32 = 0,
            crc: u32 = 0,
        } = .{};

        var nbytes: usize = 0;
        while (nbytes < data.len) {
            const n = @min(512 - 48, data.len - nbytes);
            clr.flag = 1 << 12 | (if (nbytes > 0) @as(u16, 0) else 2) | (if (nbytes + n >= data.len) @as(u16, 4) else 0);
            clr.len = n;
            const cmd_name = std.mem.asBytes(&clr);
            // HACK: remove 1 byte from name, set_var adds sentinel, works because crc is always 0
            try self.set_var(cmd_name[0 .. cmd_name.len - 1], data[nbytes..][0..n]);
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
    var words: [256]u32 = undefined;
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
    var bytes: [512]u8 align(4) = undefined;
    var delay: usize = 0;
    while (delay < ioctl.response_wait) {
        const rsp = try self.read(&bytes) orelse {
            self.sleep_ms(ioctl.response_poll_interval);
            delay += ioctl.response_poll_interval;
            continue;
        };
        switch (rsp.sdp.chan) {
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

pub fn join(self: *Self, ssid: []const u8, pwd: []const u8) !void {
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
        // ref: https://github.com/embassy-rs/embassy/blob/96a026c73bad2ebb8dfc78e88c9690611bf2cb97/cyw43/src/structs.rs#L371
        // abbrev++rev++code in u32
        const buf = "XX\x00\x00" ++ "\xFF\xFF\xFF\xFF" ++ "XX\x00\x00";
        try self.set_var("country", buf);
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
    // Enable events
    {
        // using events list from: https://github.com/jbentham/picowi/blob/bb33b1e7a15a685f06dda6764b79e429ce9b325e/lib/picowi_join.c#L38
        // ref: https://github.com/jbentham/picowi/blob/bb33b1e7a15a685f06dda6764b79e429ce9b325e/lib/picowi_join.c#L74
        // can be something like:
        // ref: https://github.com/embassy-rs/embassy/blob/96a026c73bad2ebb8dfc78e88c9690611bf2cb97/cyw43/src/control.rs#L242
        const buf = ioctl.hexToBytes("000000008B120102004000000000800100000000000000000000");
        try self.set_var("bsscfg:event_msgs", &buf);
        self.sleep_ms(50);
    }
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

        try self.set_cmd(.set_infra, &.{1});
        try self.set_cmd(.set_auth, &.{0});
        try self.set_cmd(.set_wsec, &.{6}); // wpa security

        try self.set_var("bsscfg:sup_wpa", "\x00\x00\x00\x00\x01\x00\x00\x00");
        try self.set_var("bsscfg:sup_wpa2_eapver", "\x00\x00\x00\x00\xFF\xFF\xFF\xFF");
        try self.set_var("bsscfg:sup_wpa_tmo", "\x00\x00\x00\x00\xC4\x09\x00\x00");
        self.sleep_ms(2);

        try self.set_cmd(.set_wsec_pmk, ioctl.encode_pwd(&buf, pwd));
        try self.set_cmd(.set_infra, &.{1});
        try self.set_cmd(.set_auth, &.{0});
        try self.set_cmd(.set_wpa_auth, &.{0x80}); // wpa

        try self.set_cmd(.set_ssid, ioctl.encode_ssid(&buf, ssid));
    }

    try self.join_wait(30 * 1000);
}

fn join_wait(self: *Self, wait_ms: u32) !void {
    var delay: u32 = 0;
    var link_up: bool = false;
    var link_auth: bool = false;
    var set_ssid: bool = false;
    var buytes: [512]u8 align(4) = undefined;

    //log.debug("wifi join", .{});
    while (delay < wait_ms) {
        const rsp = try self.read(&buytes) orelse {
            self.sleep_ms(ioctl.response_poll_interval);
            delay += ioctl.response_poll_interval;
            continue;
        };
        switch (rsp.sdp.chan) {
            .event => {
                const evt = rsp.event().msg;
                // log.debug(
                //     "  event type: {s:<15}, status: {s} flags: {x}",
                //     .{ @tagName(evt.event_type), @tagName(evt.status), evt.flags },
                // );
                switch (evt.event_type) {
                    .link => {
                        if (evt.flags & 1 == 0) return error.Cyw43JoinLinkDown;
                        link_up = true;
                    },
                    .psk_sup => {
                        if (evt.status != .unsolicited) return error.Cyw43JoinWpaHandshake;
                        link_auth = true;
                    },
                    .assoc => {
                        if (evt.status != .success) return error.Cyw43JoinAssocRequest;
                    },
                    .auth => {
                        if (evt.status != .success) return error.Cyw43JoinAuthRequest;
                    },
                    .disassoc_ind => {
                        return error.Cyw43JoinDisassocIndication;
                    },
                    .set_ssid => {
                        if (evt.status != .success) return error.Cyw43JoinSetSsid;
                        set_ssid = true;
                    },
                    else => {},
                }
                if (set_ssid and link_up and link_auth) {
                    //log.debug("join OK", .{});
                    return;
                }
            },
            else => self.log_response(rsp),
        }
    }
    return error.Cyw43JoinTimeout;
}

// show unexpected command response
// can be assert also
fn log_response(self: *Self, rsp: ioctl.Response) void {
    _ = self;
    switch (rsp.sdp.chan) {
        .event => {
            const evt = rsp.event().msg;
            if (evt.event_type == .none and evt.status == .success)
                return;
            log.info(
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
/// argumen is start of that data in the buffer seconds is length.
///
pub fn recv_zc(self: *Self, buffer: []u8) !?struct { usize, usize } {
    while (true) {
        const rsp = try self.read(buffer) orelse return null;
        switch (rsp.sdp.chan) {
            .data => return rsp.data_pos(),
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
pub fn send_zc(self: *Self, buffer: []u8) !void {
    if (!self.has_credit()) return error.Cyw43NoCredit;

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
    var val = self.bus.read_int(u32, .backplane, chip.gpio.output);
    val = val ^ @as(u32, 1) << pin;
    self.bus.write_int(u32, .backplane, chip.gpio.output, val);
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
