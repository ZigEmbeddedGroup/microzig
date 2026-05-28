//! SDPCM (Secure Data Path Control Message) transport layer for CYW43.
//!
//! Implements the control and data path protocol between the host and CYW43
//! WiFi chip over SPI. Handles ioctl commands, events, and data frames.
//!
//! embassy-rs/cyw43 and Infineon WHD were used as references.
//!
//! Three logical channels are multiplexed over the SPI bus. The SDPCM header's
//! channel field (see CHANNEL_* constants) indicates which type of payload follows:
//!
//!   CHANNEL_CONTROL (0) - Bidirectional. Send ioctl commands, receive responses.
//!                         Used for configuration (set country, join network, etc.)
//!   CHANNEL_EVENT (1)   - Chip to host only. Async notifications (e.g. auth result,
//!                         link up/down, scan results).
//!   CHANNEL_DATA (2)    - Bidirectional. Network traffic (ethernet frames).
//!
//! Control channel:
//! ┌──────────────┬────────────┬─────────────┐
//! │ SDPCM Header │ CDC Header │ Ioctl Data  │
//! │   12 bytes   │  16 bytes  │  variable   │
//! └──────────────┴────────────┴─────────────┘
//!
//! Event channel:
//! ┌──────────────┬────────────┬──────────┬─────────────┬───────────────┐
//! │ SDPCM Header │ BDC Header │ Ethernet │ EventHeader │ Event Message │
//! │   12 bytes   │  4 bytes   │ 14 bytes │  10 bytes   │   variable    │
//! └──────────────┴────────────┴──────────┴─────────────┴───────────────┘
//!
//! Data channel:
//! ┌──────────────┬─────┬────────────┬────────────────┐
//! │ SDPCM Header │ Pad │ BDC Header │ Ethernet Frame │
//! │   12 bytes   │  2  │  4 bytes   │    variable    │
//! └──────────────┴─────┴────────────┴────────────────┘

const std = @import("std");
const cyw43_bus = @import("bus.zig");
const consts = @import("consts.zig");

const log = std.log.scoped(.sdpcm);

// Channel types
const CHANNEL_CONTROL: u8 = 0;
const CHANNEL_EVENT: u8 = 1;
const CHANNEL_DATA: u8 = 2;

// Ioctl commands
const IOCTL_SET_VAR: u32 = 263;

// BDC (Broadcom Data Channel) constants
const BDC_VERSION: u8 = 2;

// Broadcom OUI for event validation
const BROADCOM_OUI: [3]u8 = .{ 0x00, 0x10, 0x18 };

/// SDPCM Header (12 bytes)
const SDPCM_Header = extern struct {
    const ChannelAndFlags = packed struct(u8) {
        channel: u4,
        flags: u4 = 0,
    };

    len: u16,
    len_inv: u16, // ~len for validation
    sequence: u8,
    channel_and_flags: ChannelAndFlags,
    next_length: u8,
    header_length: u8,
    wireless_flow_control: u8,
    bus_data_credit: u8,
    reserved: [2]u8,

    fn validate(self: *const SDPCM_Header) bool {
        return self.len == ~self.len_inv;
    }
};

/// CDC Header (16 bytes)
const CDC_Header = extern struct {
    const Flags = packed struct(u16) {
        is_error: bool = false,
        is_set: bool,
        _reserved: u10 = 0,
        interface: u4,
    };

    cmd: u32,
    len: u32,
    flags: Flags,
    request_id: u16,
    status: u32,
};

/// BDC Header (4 bytes)
const BDC_Header = extern struct {
    const Flags = packed struct(u8) {
        flags: u4 = 0,
        version: u4,
    };

    const Priority = packed struct(u8) {
        priority: u3 = 0, // 802.1d priority
        _reserved: u5 = 0,
    };

    const Flags2 = packed struct(u8) {
        interface: u4 = 0,
        _reserved: u4 = 0,
    };

    flags: Flags,
    priority: Priority,
    flags2: Flags2,
    data_offset: u8, // in 4-byte words
};

/// Event message structure. Multi-byte fields are big-endian.
pub const EventMessage = extern struct {
    version: [2]u8,
    flags: [2]u8,
    event_type: [4]u8,
    status: [4]u8,
    reason: [4]u8,
    auth_type: [4]u8,
    data_len: [4]u8,
    addr: [6]u8,
    ifname: [16]u8,
    ifidx: u8,
    bsscfgidx: u8,
};

/// Control channel response from ioctl
pub const ControlResponse = struct {
    cmd: u32,
    status: u32,
    is_error: bool,
    data: []const u8,
};

/// Result from polling - what type of packet was received
pub const PollResult = union(enum) {
    control: ControlResponse,
    event: []const u8,
    data: []const u8,
};

pub const SDPCM = struct {
    const Self = @This();

    pub const Error = error{
        PacketTooLarge,
        FrameTooLarge,
        IovarTooLarge,
        MacNotAvailable,
        NoCredit,
    };

    bus: *cyw43_bus.Cyw43_Bus,

    // Sequence numbers and flow control
    tx_seq: u8 = 0,
    ioctl_id: u16 = 0,
    bus_credit: u8 = 1,

    // Buffers for received packets (valid until next poll)
    rx_control_buf: [256]u8 = undefined,
    rx_control_len: usize = 0,
    rx_event_buf: [512]u8 align(@alignOf(EventMessage)) = undefined,
    rx_data_buf: [1600]u8 = undefined,
    rx_data_len: usize = 0,

    // Last control response from ioctl (stored for caller to retrieve)
    last_control_cmd: u32 = 0,
    last_control_status: u32 = 0,
    last_control_valid: bool = false,

    pub fn init(bus: *cyw43_bus.Cyw43_Bus) SDPCM {
        return SDPCM{
            .bus = bus,
        };
    }

    /// Check if we have credit to send a packet.
    /// Credit is granted by the chip via bus_data_credit in SDPCM headers.
    fn has_credit(self: *const Self) bool {
        return self.tx_seq != self.bus_credit and
            (self.bus_credit -% self.tx_seq) & 0x80 == 0;
    }

    /// Send a control packet (ioctl). Builds directly into TX buffer to avoid extra copy.
    fn send_control(self: *Self, cmd: u32, iface: u4, is_set: bool, data: []const u8) !void {
        if (!self.has_credit()) {
            return error.NoCredit;
        }

        const sdpcm_len = @sizeOf(SDPCM_Header);
        const cdc_len = @sizeOf(CDC_Header);
        const total_len = sdpcm_len + cdc_len + data.len;
        const tx_bytes = self.bus.get_wlan_tx_buffer();

        if (total_len > tx_bytes.len) {
            return error.PacketTooLarge;
        }

        log.debug("TX ioctl: cmd={} set={} len={}", .{ cmd, is_set, data.len });

        // Build SDPCM header
        const sdpcm: *SDPCM_Header = @ptrCast(@alignCast(tx_bytes.ptr));
        sdpcm.* = .{
            .len = @intCast(total_len),
            .len_inv = @intCast(~@as(u16, @intCast(total_len))),
            .sequence = self.tx_seq,
            .channel_and_flags = .{ .channel = CHANNEL_CONTROL },
            .next_length = 0,
            .header_length = sdpcm_len,
            .wireless_flow_control = 0,
            .bus_data_credit = 0,
            .reserved = .{ 0, 0 },
        };

        // Build CDC header
        const cdc: *CDC_Header = @ptrCast(@alignCast(tx_bytes[sdpcm_len..].ptr));
        cdc.* = .{
            .cmd = cmd,
            .len = @intCast(data.len),
            .flags = .{
                .is_set = is_set,
                .interface = iface,
            },
            .request_id = self.ioctl_id,
            .status = 0,
        };

        // Copy ioctl data
        @memcpy(tx_bytes[sdpcm_len + cdc_len ..][0..data.len], data);

        // Send and update sequence numbers
        self.bus.wlan_send(total_len);
        self.tx_seq +%= 1;

        self.ioctl_id +%= 1;
    }

    /// Poll for an available packet.
    pub fn poll(self: *Self) !?PollResult {
        // TODO: Make bus return error unions?
        const status = self.bus.read32(.bus, consts.REG_BUS_STATUS);

        const pkt_avail = (status & consts.STATUS_F2_PKT_AVAILABLE) != 0;
        if (!pkt_avail) {
            return null;
        }

        log.info("poll: pkt available, status=0x{x}", .{status});

        const pkt_len = (status & consts.STATUS_F2_PKT_LEN_MASK) >> @intCast(consts.STATUS_F2_PKT_LEN_SHIFT);
        const len: usize = @intCast(pkt_len);
        if (len == 0) {
            log.warn("Invalid packet len: {}", .{len});
            return null;
        }

        // Read packet via bus
        const rx_data = self.bus.wlan_recv(len);

        if (len < @sizeOf(SDPCM_Header)) {
            log.warn("Packet too short: {}", .{len});
            return null;
        }

        const header: *const SDPCM_Header = @ptrCast(@alignCast(rx_data.ptr));

        if (!header.validate()) {
            log.warn("Invalid SDPCM: len={} len_inv={}", .{ header.len, header.len_inv });
            return null;
        }

        self.bus_credit = header.bus_data_credit;

        const channel = header.channel_and_flags.channel;
        const data_offset = header.header_length;

        log.info("RX: chan={} len={} offset={}", .{ channel, len, data_offset });

        if (data_offset >= len) {
            return null;
        }

        const payload = rx_data[data_offset..len];

        switch (channel) {
            CHANNEL_CONTROL => return self.parse_control_response(payload),
            CHANNEL_EVENT => return self.parse_event(payload),
            CHANNEL_DATA => {
                log.info("RX DATA frame: payload.len={}", .{payload.len});
                return self.parse_data_packet(payload);
            },
            else => {
                log.warn("Unknown channel: {}", .{channel});
                return null;
            },
        }
    }

    /// Parse control channel response
    fn parse_control_response(self: *Self, payload: []const u8) ?PollResult {
        if (payload.len < @sizeOf(CDC_Header)) {
            return null;
        }

        const cdc: *const CDC_Header = @ptrCast(@alignCast(payload.ptr));
        const cdc_len = @sizeOf(CDC_Header);

        log.debug("Ioctl response: cmd={} status={} err={}", .{ cdc.cmd, cdc.status, cdc.flags.is_error });

        // Copy response data to buffer
        const data_len = if (payload.len > cdc_len) payload.len - cdc_len else 0;
        const copy_len = @min(data_len, self.rx_control_buf.len);
        if (copy_len > 0) {
            @memcpy(self.rx_control_buf[0..copy_len], payload[cdc_len..][0..copy_len]);
        }
        self.rx_control_len = copy_len;

        return .{ .control = .{
            .cmd = cdc.cmd,
            .status = cdc.status,
            .is_error = cdc.flags.is_error,
            .data = self.rx_control_buf[0..copy_len],
        } };
    }

    /// Parse event channel packet. Returns event if valid Broadcom event found.
    /// Structure: [BDC Header][Ethernet Header][EventHeader][EventMessage][event payload...]
    fn parse_event(self: *Self, payload: []const u8) ?PollResult {
        const bdc_len = @sizeOf(BDC_Header);
        const eth_len: usize = 14;
        const event_header_len: usize = 10; // subtype(2) + length(2) + version(1) + oui(3) + user_subtype(2)

        if (payload.len < bdc_len) return null;

        // Read BDC header to get data_offset
        const bdc: *const BDC_Header = @ptrCast(@alignCast(payload.ptr));
        const data_offset = @as(usize, bdc.data_offset) * 4;

        const eth_start = bdc_len + data_offset;
        const event_header_start = eth_start + eth_len;
        const event_msg_start = event_header_start + event_header_len;

        const header_len = @sizeOf(EventMessage);
        if (payload.len < event_msg_start + header_len) return null;

        // Check Broadcom OUI in EventHeader (at offset 5 from event_header_start)
        if (payload.len < event_header_start + 5 + 3) return null;
        const oui = payload[event_header_start + 5 .. event_header_start + 8];
        if (!std.mem.eql(u8, oui, &BROADCOM_OUI)) return null;

        // Read event payload length (EventMessage.data_len is BE u32 at offset 20..24)
        const p: *const [4]u8 = @ptrCast(payload.ptr + event_msg_start + 20);
        const n_u32 = std.mem.readInt(u32, p, .big);
        const n: usize = @intCast(n_u32);

        // Ensure the full [EventMessage + payload] is present
        if (payload.len < event_msg_start + header_len + n) return null;

        // Ensure our scratch buffer can hold it
        if (header_len + n > self.rx_event_buf.len) return null;

        // Copy into aligned/stable buffer and return bytes slice
        const frame = payload[event_msg_start .. event_msg_start + header_len + n];
        @memcpy(self.rx_event_buf[0 .. header_len + n], frame);

        return .{ .event = self.rx_event_buf[0 .. header_len + n] };
    }

    /// Parse data channel packet. Returns Ethernet frame if valid.
    fn parse_data_packet(self: *Self, payload: []const u8) ?PollResult {
        const bdc_len = @sizeOf(BDC_Header);

        if (payload.len < bdc_len) {
            return null;
        }

        const bdc: *const BDC_Header = @ptrCast(@alignCast(payload.ptr));
        const data_offset = @as(usize, bdc.data_offset) * 4;

        const frame_start = bdc_len + data_offset;
        if (frame_start >= payload.len) {
            return null;
        }

        const frame = payload[frame_start..];

        // Copy to buffer and return slice
        const copy_len = @min(frame.len, self.rx_data_buf.len);
        @memcpy(self.rx_data_buf[0..copy_len], frame[0..copy_len]);
        self.rx_data_len = copy_len;

        return .{ .data = self.rx_data_buf[0..copy_len] };
    }

    /// Send a data frame (Ethernet frame). Builds directly into TX buffer to avoid extra copy.
    pub fn send_data_frame(self: *Self, frame: []const u8) !void {
        log.debug("TX data frame: len={} credit={} tx_seq={}", .{ frame.len, self.bus_credit, self.tx_seq });
        if (!self.has_credit()) {
            log.warn("TX: no credit!", .{});
            return error.NoCredit;
        }

        const sdpcm_len = @sizeOf(SDPCM_Header);
        const pad_len: usize = 2;
        const bdc_len = @sizeOf(BDC_Header);
        const total_len = sdpcm_len + pad_len + bdc_len + frame.len;
        const tx_bytes = self.bus.get_wlan_tx_buffer();

        if (total_len > tx_bytes.len) {
            return error.FrameTooLarge;
        }

        // Build SDPCM header
        const sdpcm: *SDPCM_Header = @ptrCast(@alignCast(tx_bytes.ptr));
        sdpcm.* = .{
            .len = @intCast(total_len),
            .len_inv = @intCast(~@as(u16, @intCast(total_len))),
            .sequence = self.tx_seq,
            .channel_and_flags = .{ .channel = CHANNEL_DATA },
            .next_length = 0,
            .header_length = sdpcm_len + pad_len, // Data packets have 2-byte padding
            .wireless_flow_control = 0,
            .bus_data_credit = 0,
            .reserved = .{ 0, 0 },
        };

        // 2-byte padding (required between SDPCM and BDC for data packets)
        tx_bytes[sdpcm_len] = 0;
        tx_bytes[sdpcm_len + 1] = 0;

        // BDC header
        const bdc: *BDC_Header = @ptrCast(@alignCast(tx_bytes[sdpcm_len + pad_len ..].ptr));
        bdc.* = .{
            .flags = .{ .version = BDC_VERSION },
            .priority = .{},
            .flags2 = .{},
            .data_offset = 0,
        };

        // Copy Ethernet frame
        @memcpy(tx_bytes[sdpcm_len + pad_len + bdc_len ..][0..frame.len], frame);

        // Send and update sequence
        self.bus.wlan_send(total_len);
        self.tx_seq +%= 1;
        log.debug("TX sent: total_len={}", .{total_len});
    }

    /// Send ioctl command and poll for response.
    /// Control response is stored and can be retrieved via get_last_control_data().
    pub fn ioctl(self: *Self, cmd: u32, iface: u4, is_set: bool, data: []const u8) !void {
        self.last_control_valid = false;
        try self.send_control(cmd, iface, is_set, data);

        // Poll to receive response and update credits
        var attempts: u32 = 0;
        while (attempts < 100) : (attempts += 1) {
            // TODO: Events and data packets received while waiting for the control response
            // are currently dropped. Could add per-channel ring buffers to preserve them.
            if (try self.poll()) |result| {
                if (result == .control) {
                    // Store the control response for caller to retrieve
                    self.last_control_cmd = result.control.cmd;
                    self.last_control_status = result.control.status;
                    self.last_control_valid = true;
                    return;
                }
            }
            self.bus.internal_delay_ms(1);
        }
    }

    /// Get the data from the last control response.
    /// Valid after ioctl() returns, until next poll() or ioctl() call.
    pub fn get_last_control_data(self: *Self) ?[]const u8 {
        if (self.last_control_valid and self.rx_control_len > 0) {
            return self.rx_control_buf[0..self.rx_control_len];
        }
        return null;
    }

    /// Set a 32-bit ioctl value
    pub fn ioctl_set_u32(self: *Self, cmd: u32, iface: u4, value: u32) !void {
        const data = std.mem.asBytes(&value);
        try self.ioctl(cmd, iface, true, data);
    }

    /// Set an iovar (named variable)
    pub fn set_iovar(self: *Self, name: []const u8, data: []const u8) !void {
        var buf: [1280]u8 = undefined;
        if (name.len + 1 + data.len > buf.len) {
            return error.IovarTooLarge;
        }

        @memcpy(buf[0..name.len], name);
        buf[name.len] = 0;
        @memcpy(buf[name.len + 1 ..][0..data.len], data);

        try self.ioctl(IOCTL_SET_VAR, 0, true, buf[0 .. name.len + 1 + data.len]);
    }

    /// Set a u32 iovar
    pub fn set_iovar_u32(self: *Self, name: []const u8, value: u32) !void {
        const data = std.mem.asBytes(&value);
        try self.set_iovar(name, data);
    }

    /// Set a (u32, u32) iovar
    pub fn set_iovar_u32x2(self: *Self, name: []const u8, val1: u32, val2: u32) !void {
        var data: [8]u8 = undefined;
        @memcpy(data[0..4], std.mem.asBytes(&val1));
        @memcpy(data[4..8], std.mem.asBytes(&val2));
        try self.set_iovar(name, &data);
    }
};
