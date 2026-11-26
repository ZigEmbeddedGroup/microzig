const builtin = @import("builtin");
const std = @import("std");
const types = @import("types.zig");
const net = std.Io.net;
const log = std.log.scoped(.DHCP);

const Reader = std.Io.Reader;
const Writer = std.Io.Writer;
const Payload = types.DHCPPayload;
const OptionCode = types.OptionCode;
const DHCPMessageType = types.DHCPMessageType;

/// Defulat DHCP server port
pub const server_port = 67;
/// Defulat DHCP client port
pub const client_port = 68;

/// Magic cookie for options as defined by RFC 2131.
const cookie: [4]u8 = .{ 99, 130, 83, 99 };
const endian = .big;

pub const PacketBuffer = extern struct {
    payload: Payload,
    options: [1024 - @sizeOf(types.DHCPPayload)]u8,

    /// Get payload buffer as a slice of bytes
    pub fn asBytes(self: *@This()) []u8 {
        return std.mem.asBytes(self);
    }

    /// Extract reponse from payload buffer as a slice of bytes.
    pub fn getResponse(self: *@This()) []u8 {
        var opt_reader: OptionReader = .{ .r = .fixed(&self.options) };
        opt_reader.r.toss(cookie.len);
        while (opt_reader.take()) |_| {}
        const end_code = self.options[opt_reader.r.seek - 1];
        std.debug.assert(end_code == @backingInt(types.OptionCode.end));
        const len = @sizeOf(Payload) + opt_reader.r.seek;
        return self.asBytes()[0..len];
    }
};

pub const Lease = struct {
    const State = enum { unused, offered, in_use, expired };
    const forever = std.math.maxInt(u32);
    const unused: @This() = .{
        .state = .unused,
        .hardware_address = undefined,
        .start = undefined,
    };

    state: State,
    hardware_address: [16]u8,
    start: i64,

    fn expired(self: @This(), duration: u32, now: i64) bool {
        if (duration == forever) {
            return false;
        }
        const deadline = self.start +| duration;
        return now >= deadline;
    }

    fn checkState(self: *@This(), duration: u32, now: i64) State {
        if (self.state == .in_use or self.state == .offered) {
            if (self.expired(duration, now)) {
                self.state = .expired;
            }
        }
        return self.state;
    }
};

const OptionWriter = struct {
    w: std.Io.Writer,

    fn write(self: *@This(), tag: OptionCode, data: []const u8) !void {
        try self.w.writeByte(@backingInt(tag));
        try self.w.writeByte(@intCast(data.len));
        try self.w.writeAll(data);
    }

    fn writeMessageType(self: *@This(), message_type: DHCPMessageType) !void {
        return self.write(.dhcp_message_type, &.{message_type.int()});
    }

    fn finish(self: *@This()) !void {
        try self.w.writeByte(@backingInt(OptionCode.end));
    }
};

const OptionReader = struct {
    const Option = struct { tag: OptionCode, data: []const u8 };

    r: std.Io.Reader,

    fn take(self: *@This()) ?Option {
        const tag = self.r.takeEnum(OptionCode, endian) catch return null;
        if (tag == .end) return null;
        const data_len = self.r.takeByte() catch return null;
        const data = self.r.take(data_len) catch return null;
        return .{ .tag = tag, .data = data };
    }

    fn search(self: *@This(), tag: OptionCode) ?[]const u8 {
        self.r.seek = 0;
        while (self.take()) |option| {
            if (option.tag == tag) {
                return option.data;
            }
        }
        return null;
    }
};

pub const ServerConfig = struct {
    subnet_mask_bits: u5 = 24,
    subnet: [4]u8 = .{ 192, 168, 4, 0 },
    lease_duration: u32 = std.time.s_per_hour * 2,
};

pub fn Server(config: ServerConfig) type {
    if (config.subnet_mask_bits > 30) {
        @compileError("Subnet mask too big, not enough bits for device address.");
    }
    const address_mask_bits = @as(u6, 32) - config.subnet_mask_bits;
    const address_backing_int = @Int(.unsigned, address_mask_bits);

    const duration = config.lease_duration;

    const T = struct {
        pub const Action = enum { respond, ignore };
        const Address = enum(address_backing_int) {
            none = 0,
            server,
            base,
            broadcast = std.math.maxInt(address_backing_int),
            _,

            fn toInt(self: @This()) address_backing_int {
                return @backingInt(self);
            }

            fn fromInt(i: u8) @This() {
                return @fromBackingInt(i);
            }

            fn checkIndexValid(i: usize) !void {
                const address = i + toInt(.base);
                if (address >= toInt(.broadcast)) {
                    return error.NoAddressAvalable;
                }
            }

            fn fromIndex(i: usize) @This() {
                const address = i + toInt(.base);
                return fromInt(@intCast(address));
            }

            fn getFull(self: @This()) [4]u8 {
                var full_address: u32 = @bitCast(subnet);
                full_address |= std.mem.nativeTo(u32, self.toInt(), endian);
                return @bitCast(full_address);
            }
        };

        pub const subnet: [4]u8 = config.subnet;
        pub const subnet_mask: [4]u8 = @bitCast(~std.mem.nativeTo(u32, std.math.maxInt(address_backing_int), endian));
        pub const server_ip_address = Address.server.getFull();

        leases: []Lease,

        pub fn init(lease_list: []Lease) !@This() {
            for (lease_list) |*lease| {
                lease.* = Lease.unused;
            }
            return .{
                .leases = lease_list,
            };
        }

        /// Parse the packet buffer, and construct a new response in place.
        /// Return value idicates if the program shoud send a response.
        pub fn parse(
            self: *@This(),
            /// Packet buffer used for both input and output.
            packet_buffer: *PacketBuffer,
            /// Current time in seconds, epoch does not matter.
            now: i64,
            /// Length of recived datagram needed to differentiate DHCP from BOOTP.
            dgrm_len: usize,
        ) !Action {
            const payload = &packet_buffer.payload;
            const options = packet_buffer.options[0 .. dgrm_len - @sizeOf(Payload)];
            var opt_reader: OptionReader = .{ .r = .fixed(options[4..]) };
            var opt_writer: OptionWriter = .{ .w = .fixed(packet_buffer.options[4..]) };

            // Validation
            if (dgrm_len < @sizeOf(Payload)) {
                log.debug("Ignoring packet too small", .{});
                return .ignore; // Invalid packet
            }
            if (payload.op != .request) { // This is fine becuase op is u8
                log.debug("Only respond to requests. Got {}", .{payload.op});
                return .ignore; // Only respond to requests
            }
            if (!(options.len > 4 and std.mem.eql(u8, options[0..4], &cookie))) {
                log.debug("Ignoring BOOTP packet. No cookie.", .{});
                return .ignore;
            }
            const type_tag = opt_reader.search(.dhcp_message_type) orelse {
                log.debug("Ignoring BOOTP packet. No DHCP message type.", .{});
                return .ignore;
            };
            if (type_tag.len != 1) {
                log.debug("Ignoring invalid DHCP type incorrect size. {x}", .{type_tag});
                return .ignore; // Invalid packet
            }

            const swap = builtin.cpu.arch.endian() != endian;
            if (swap) {
                std.mem.byteSwapAllFields(Payload, payload);
            }
            defer if (swap) {
                std.mem.byteSwapAllFields(Payload, payload);
            };

            const message_type: DHCPMessageType = @fromBackingInt(type_tag[0]);
            switch (message_type) {
                .discover => return try self.praseDiscover(payload, &opt_writer, now),
                .request => return try self.parseRequest(payload, &opt_reader, &opt_writer, now),
                .decline => return self.parseDecline(payload, &opt_reader, now),
                .release => return self.parseRelease(payload, &opt_reader, now),
                .inform => {
                    log.warn("Ignoring DHCP inform.", .{});
                    return .ignore;
                },
                .offor, .acknowledge, .no_acknowledge => |t| {
                    log.err("Ignoring DHCP packet. Unexpected message type {}.", .{t});
                    return .ignore;
                },
                _ => |t| {
                    log.err("Unhandled message type: {}", .{t});
                    return .ignore;
                },
            }
        }

        fn praseDiscover(
            self: *@This(),
            payload: *Payload,
            writer: *OptionWriter,
            now: i64,
        ) !Action {
            const maybe_lease_index = self.findLease(now, payload.chaddr);
            const lease_index = if (maybe_lease_index) |index| blk: {
                break :blk index;
            } else blk: {
                const lease_index = (self.findLeaseByState(now, .unused) orelse
                    self.findLeaseByState(now, .expired) orelse
                    return error.NoLeaseAvalable);
                try Address.checkIndexValid(lease_index);
                const lease = &self.leases[lease_index];
                lease.hardware_address = payload.chaddr;
                lease.start = now;
                lease.state = .offered;
                break :blk lease_index;
            };

            payload.op = .reply;
            payload.hops = 0;
            payload.secs = 0;
            payload.ciaddr = @splat(0);
            payload.yiaddr = Address.fromIndex(lease_index).getFull();
            payload.siaddr = server_ip_address;
            const lease_time = std.mem.nativeTo(u32, duration / 2, endian);
            try writer.writeMessageType(.offor);
            try writer.write(.dhcp_server_id, &server_ip_address);
            try writer.write(.subnet_mask, &subnet_mask);
            try writer.write(.lease_time, std.mem.asBytes(&lease_time));
            try writer.finish();
            return .respond;
        }

        fn parseRequest(
            self: @This(),
            payload: *Payload,
            reader: *OptionReader,
            writer: *OptionWriter,
            now: i64,
        ) !Action {
            const lease_index = self.findLease(now, payload.chaddr) orelse {
                try setNoAacknowledge(payload, writer);
                return .respond;
            };

            const req_address = reader.search(.requested_ip_address) orelse {
                try setNoAacknowledge(payload, writer);
                return .respond;
            };
            if (reader.search(.dhcp_server_id)) |server_id| {
                if (!std.mem.eql(u8, &server_ip_address, server_id)) {
                    self.leases[lease_index] = Lease.unused;
                    return .ignore;
                }
            }
            const ip_address = Address.fromIndex(lease_index).getFull();
            if (!std.mem.eql(u8, req_address, &ip_address)) {
                try setNoAacknowledge(payload, writer);
                return .respond;
            }
            self.leases[lease_index].start = now;
            self.leases[lease_index].state = .in_use;

            payload.op = .reply;
            payload.hops = 0;
            payload.secs = 0;
            payload.yiaddr = ip_address;
            payload.siaddr = server_ip_address;
            const lease_time = std.mem.nativeTo(u32, duration / 2, endian);
            try writer.writeMessageType(.acknowledge);
            try writer.write(.dhcp_server_id, &server_ip_address);
            try writer.write(.subnet_mask, &subnet_mask);
            try writer.write(.lease_time, std.mem.asBytes(&lease_time));
            try writer.finish();
            return .respond;
        }

        fn parseDecline(
            self: @This(),
            payload: *Payload,
            reader: *OptionReader,
            now: i64,
        ) Action {
            const lease_index = self.findLease(now, payload.chaddr) orelse {
                return .ignore;
            };
            if (reader.search(.dhcp_server_id)) |server_id| {
                if (!std.mem.eql(u8, &server_ip_address, server_id)) {
                    return .ignore;
                }
            }
            const req_address = reader.search(.requested_ip_address) orelse {
                return .ignore;
            };
            const ip_address = Address.fromIndex(lease_index).getFull();
            if (!std.mem.eql(u8, req_address, &ip_address)) {
                return .ignore;
            }

            // Set dummy lease for now, we can try it again if we run out of address
            self.leases[lease_index] = .{
                .state = .in_use,
                .start = now,
                .hardware_address = @splat(0xff),
            };
            return .ignore;
        }

        fn parseRelease(
            self: @This(),
            payload: *Payload,
            reader: *OptionReader,
            now: i64,
        ) Action {
            const lease_index = self.findLease(now, payload.chaddr) orelse {
                return .ignore;
            };
            if (reader.search(.dhcp_server_id)) |server_id| {
                if (!std.mem.eql(u8, &server_ip_address, server_id)) {
                    return .ignore;
                }
            }
            self.leases[lease_index].state = .expired;
            return .ignore;
        }

        fn setNoAacknowledge(payload: *Payload, writer: *OptionWriter) !void {
            payload.op = .reply;
            payload.hops = 0;
            payload.secs = 0;
            payload.ciaddr = @splat(0);
            payload.yiaddr = @splat(0);
            payload.siaddr = @splat(0);
            try writer.writeMessageType(.no_acknowledge);
            try writer.write(.dhcp_server_id, &server_ip_address);
            try writer.finish();
        }

        fn findLease(self: @This(), now: i64, hardware_address: [16]u8) ?usize {
            for (self.leases, 0..) |*lease, i| {
                if (lease.checkState(duration, now) != .unused and
                    std.mem.eql(u8, &lease.hardware_address, &hardware_address))
                {
                    return i;
                }
            }
            return null;
        }

        fn findLeaseByState(self: @This(), now: i64, state: Lease.State) ?usize {
            for (self.leases, 0..) |*lease, i| {
                if (lease.checkState(duration, now) == state) {
                    return i;
                }
            }
            return null;
        }
    };

    if (@as(u32, @bitCast(T.subnet)) & ~@as(u32, @bitCast(T.subnet_mask)) != 0) {
        @compileError("Subnet has bits beyond subnet mask.");
    }

    return T;
}

test "Address calculations" {
    const Server24 = Server(.{
        .subnet_mask_bits = 24,
        .subnet = .{ 192, 168, 4, 0 },
    });
    try std.testing.expectEqual([4]u8{ 255, 255, 255, 0 }, Server24.subnet_mask);
    try std.testing.expectEqual([4]u8{ 192, 168, 4, 1 }, Server24.server_ip_address);
    try std.testing.expectEqual([4]u8{ 192, 168, 4, 255 }, Server24.Address.broadcast.getFull());

    const Server16 = Server(.{
        .subnet_mask_bits = 16,
        .subnet = .{ 192, 168, 0, 0 },
    });
    try std.testing.expectEqual([4]u8{ 255, 255, 0, 0 }, Server16.subnet_mask);
    try std.testing.expectEqual([4]u8{ 192, 168, 0, 1 }, Server16.server_ip_address);
    try std.testing.expectEqual([4]u8{ 192, 168, 255, 255 }, Server16.Address.broadcast.getFull());

    const Server1 = Server(.{
        .subnet_mask_bits = 1,
        .subnet = .{ 128, 0, 0, 0 },
    });
    try std.testing.expectEqual([4]u8{ 128, 0, 0, 0 }, Server1.subnet_mask);
    try std.testing.expectEqual([4]u8{ 128, 0, 0, 1 }, Server1.server_ip_address);
    try std.testing.expectEqual([4]u8{ 255, 255, 255, 255 }, Server1.Address.broadcast.getFull());

    const Server0 = Server(.{
        .subnet_mask_bits = 0,
        .subnet = .{ 0, 0, 0, 0 },
    });
    try std.testing.expectEqual([4]u8{ 0, 0, 0, 0 }, Server0.subnet_mask);
    try std.testing.expectEqual([4]u8{ 0, 0, 0, 1 }, Server0.server_ip_address);
    try std.testing.expectEqual([4]u8{ 255, 255, 255, 255 }, Server0.Address.broadcast.getFull());
}

test "Expected response" {
    const testing = std.testing;
    const Server16 = Server(.{
        .subnet_mask_bits = 16,
        .subnet = .{ 192, 168, 0, 0 },
    });
    const psize = @sizeOf(types.DHCPPayload);

    var lease_list: [4]Lease = undefined;
    var server: Server16 = try .init(&lease_list);

    var packet: PacketBuffer = undefined;
    var payload = &packet.payload;
    var optw: OptionWriter = .{ .w = .fixed(&packet.options) };
    var optr: OptionReader = .{ .r = .fixed(packet.options[4..]) };

    // Request unassinged lease expect no acknowledge
    payload.* = .{
        .op = .request,
        .htype = .ethernet,
        .hlen = 6,
        .hops = 0,
        .xid = 4,
        .secs = 0,
        .ciaddr = @splat(0),
        .yiaddr = @splat(0),
        .giaddr = @splat(0),
        .siaddr = @splat(0),
        .chaddr = [6]u8{ 1, 2, 3, 4, 5, 6 } ++ @as([10]u8, @splat(0)),
        .sname = @splat(0),
        .file = @splat(0),
    };
    try optw.w.writeAll(&cookie);
    try optw.writeMessageType(.request);
    try optw.write(.requested_ip_address, &.{ 192, 168, 4, 2 });
    try optw.finish();
    var action = try server.parse(&packet, 0, psize + optw.w.end);
    try testing.expectEqual(.respond, action);
    try testing.expectEqual(.reply, payload.op);
    try testing.expectEqual(6, payload.hlen);
    try testing.expectEqual(4, payload.xid);
    try testing.expectEqualSlices(u8, &[6]u8{ 1, 2, 3, 4, 5, 6 }, payload.chaddr[0..6]);
    try testing.expectEqualSlices(
        u8,
        &[1]u8{@backingInt(DHCPMessageType.no_acknowledge)},
        optr.search(.dhcp_message_type).?,
    );
    try testing.expectEqualSlices(u8, &[4]u8{ 192, 168, 0, 1 }, optr.search(.dhcp_server_id).?);

    // Discover expect offor
    optw.w = .fixed(&packet.options);
    payload.op = .request;
    try optw.w.writeAll(&cookie);
    try optw.writeMessageType(.discover);
    try optw.finish();
    action = try server.parse(&packet, 0, psize + optw.w.end);
    try testing.expectEqual(.respond, action);
    try testing.expectEqual(.reply, payload.op);
    try testing.expectEqual(6, payload.hlen);
    try testing.expectEqual(4, payload.xid);
    try testing.expectEqual([4]u8{ 192, 168, 0, 1 }, payload.siaddr);
    try testing.expectEqualSlices(u8, &[6]u8{ 1, 2, 3, 4, 5, 6 }, payload.chaddr[0..6]);
    try testing.expectEqualSlices(
        u8,
        &[1]u8{@backingInt(DHCPMessageType.offor)},
        optr.search(.dhcp_message_type).?,
    );
    try testing.expect(optr.search(.lease_time) != null);
    try testing.expectEqualSlices(u8, &[4]u8{ 255, 255, 0, 0 }, optr.search(.subnet_mask).?);
    try testing.expectEqual([4]u8{ 192, 168, 0, 2 }, payload.yiaddr);

    // Request expect acknowledge
    optw.w = .fixed(&packet.options);
    payload.op = .request;
    try optw.w.writeAll(&cookie);
    try optw.writeMessageType(.request);
    try optw.write(.requested_ip_address, &.{ 192, 168, 0, 2 });
    try optw.finish();
    action = try server.parse(&packet, 0, psize + optw.w.end);
    try testing.expectEqual(.respond, action);
    try testing.expectEqual(.reply, payload.op);
    try testing.expectEqual(6, payload.hlen);
    try testing.expectEqual(4, payload.xid);
    try testing.expectEqualSlices(u8, &[6]u8{ 1, 2, 3, 4, 5, 6 }, payload.chaddr[0..6]);
    try testing.expectEqualSlices(
        u8,
        &[1]u8{@backingInt(DHCPMessageType.acknowledge)},
        optr.search(.dhcp_message_type).?,
    );
    try testing.expect(optr.search(.lease_time) != null);
    try testing.expectEqualSlices(u8, &[4]u8{ 255, 255, 0, 0 }, optr.search(.subnet_mask).?);
    try testing.expectEqual([4]u8{ 192, 168, 0, 2 }, payload.yiaddr);
}
