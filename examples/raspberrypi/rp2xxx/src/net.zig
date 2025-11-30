const std = @import("std");
const mem = std.mem;
const assert = std.debug.assert;
const testing = std.testing;
const builtin = @import("builtin");
const native_endian = builtin.cpu.arch.endian();

const log = std.log.scoped(.net);

const broadcast_mac: Mac = .{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
const broadcast_ip: Ip = .{ 0xff, 0xff, 0xff, 0xff };

pub const Net = struct {
    const Self = @This();

    identification: u16 = 0,
    mac: Mac,
    ip: IpAddr,
    driver: struct {
        tx_buffer: []u8,
        ptr: *anyopaque,
        recv: *const fn (*anyopaque, u32) anyerror!?[]const u8,
        send: *const fn (*anyopaque, []const u8, []const u8) anyerror!void,
    },

    fn ip_identification(self: *Self) u16 {
        self.identification +%= 1;
        return self.identification;
    }

    // recv packets until there is no packet for wait_ms
    pub fn poll(self: *Self, wait_ms: u32) !void {
        while (try self.recv(wait_ms)) |bytes| {
            try self.handle(bytes);
        }
    }

    fn send(self: *Self, header: []const u8, payload: []const u8) !void {
        try self.driver.send(self.driver.ptr, header, payload);
    }

    fn recv(self: *Self, wait_ms: u32) !?[]const u8 {
        return try self.driver.recv(self.driver.ptr, wait_ms);
    }

    pub fn get_mac(self: *Self, ip: IpAddr) !Mac {
        try self.poll(0);
        for (0..10) |_| {
            try self.send_arp_request(ip);
            while (try self.recv(100)) |bytes| {
                if (try parse_arp_response(bytes, ip)) |mac| return mac;
                try self.handle(bytes);
            }
        }
        return error.Timeout;
    }

    pub fn send_arp_request(self: *Self, ip: IpAddr) !void {
        var header: [@sizeOf(Ethernet) + @sizeOf(Arp)]u8 = undefined;
        var eth_rsp: Ethernet = .{
            .destination = broadcast_mac,
            .source = self.mac,
            .protocol = .arp,
        };
        var arp_rsp: Arp = .{
            .opcode = .request,
            .sender_mac = self.mac,
            .sender_ip = self.ip,
            .target_mac = broadcast_mac,
            .target_ip = ip,
        };
        _ = try arp_rsp.encode(header[try eth_rsp.encode(&header)..]);
        try self.send(&header, &.{});
    }

    fn parse_arp_response(rx_bytes: []const u8, ip: IpAddr) !?Mac {
        var bytes: []const u8 = rx_bytes;
        const eth = try Ethernet.decode(bytes);
        bytes = bytes[@sizeOf(Ethernet)..];
        if (eth.protocol == .arp) {
            const arp = try Arp.decode(bytes);
            bytes = bytes[@sizeOf(Arp)..];
            if (arp.opcode == .response and mem.eql(u8, &ip, &arp.sender_ip)) {
                return arp.sender_mac;
            }
        }
        return null;
    }

    fn handle(self: *Self, rx_bytes: []const u8) !void {
        var bytes: []const u8 = rx_bytes;
        const eth = try Ethernet.decode(bytes);
        bytes = bytes[@sizeOf(Ethernet)..];

        if (eth.protocol == .arp) {
            const arp = try Arp.decode(bytes);
            bytes = bytes[@sizeOf(Arp)..];

            if (arp.opcode == .request and mem.eql(u8, &arp.target_ip, &self.ip)) {
                log.debug("arp request from ip: {any} mac: {x}", .{ arp.sender_ip[0..4], arp.sender_mac[0..6] });
                var header: [@sizeOf(Ethernet) + @sizeOf(Arp)]u8 = undefined;
                var eth_rsp: Ethernet = .{
                    .destination = arp.sender_mac,
                    .source = self.mac,
                    .protocol = .arp,
                };
                var arp_rsp: Arp = .{
                    .opcode = .response,
                    .sender_mac = self.mac,
                    .sender_ip = self.ip,
                    .target_mac = arp.sender_mac,
                    .target_ip = arp.sender_ip,
                };
                _ = try arp_rsp.encode(header[try eth_rsp.encode(&header)..]);
                try self.send(&header, &.{});
                return;
            }

            if (arp.opcode == .response) {
                log.debug("arp response from ip: {any} mac: {x} arp: {}", .{
                    arp.sender_ip[0..4],
                    arp.sender_mac[0..6],
                    arp,
                });
            }
        }
        if (eth.protocol == .ip) {
            const ip = try Ip.decode(bytes);
            if (bytes.len < ip.total_length) return error.InsufficientBuffer;
            if (ip.fragment.mf) return error.IpFragmented;

            bytes = bytes[0..ip.total_length][@sizeOf(Ip)..];
            if (ip.protocol == .icmp and mem.eql(u8, &ip.destination, &self.ip)) {
                const icmp = try Icmp.decode(bytes);
                const data = bytes[@sizeOf(Icmp)..];
                if (icmp.typ == .request) {
                    log.debug("ping request from ip: {any} mac: {x}", .{ ip.source[0..4], eth.source[0..6] });

                    var header: [@sizeOf(Ethernet) + @sizeOf(Ip)]u8 = undefined;
                    var eth_rsp: Ethernet = .{
                        .destination = eth.source,
                        .source = self.mac,
                        .protocol = .ip,
                    };
                    var ip_rsp: Ip = .{
                        .service = ip.service,
                        .identification = ip.identification,
                        .protocol = .icmp,
                        .source = ip.destination,
                        .destination = ip.source,
                        .total_length = ip.total_length,
                    };
                    _ = try ip_rsp.encode(header[try eth_rsp.encode(header[0..])..]);

                    var payload: [512]u8 align(4) = undefined;
                    var icmp_rsp: Icmp = .{
                        .typ = .reply,
                        .identifier = icmp.identifier,
                        .sequence = icmp.sequence,
                    };
                    const n = @min(payload.len, data.len);
                    @memcpy(payload[@sizeOf(Icmp)..][0..n], data[0..n]);
                    _ = try icmp_rsp.encode(payload[0 .. n + @sizeOf(Icmp)]);

                    try self.send(&header, payload[0 .. n + @sizeOf(Icmp)]);
                    return;
                }
            }
        }
    }
};

pub const Udp = struct {
    const Self = @This();
    net: *Net,
    port: u16,
    destination: struct {
        ip: IpAddr,
        mac: Mac,
        port: u16,
    },

    pub fn send(self: *Self, payload: []const u8) !void {
        var header: [@sizeOf(Ethernet) + @sizeOf(Ip) + @sizeOf(UdpHeader)]u8 = undefined;
        var eth: Ethernet = .{
            .destination = self.destination.mac,
            .source = self.net.mac,
            .protocol = .ip,
        };
        var ip: Ip = .{
            .identification = self.net.ip_identification(),
            .protocol = .udp,
            .source = self.net.ip,
            .destination = self.destination.ip,
            .total_length = @intCast(@sizeOf(Ip) + @sizeOf(UdpHeader) + payload.len),
        };
        var udp: UdpHeader = .{
            .source_port = self.port,
            .destination_port = self.destination.port,
            .length = @intCast(@sizeOf(UdpHeader) + payload.len),
            .checksum = 0,
        };
        var pos = try eth.encode(header[0..]);
        pos += try ip.encode(header[pos..]);
        pos += try udp.encode(header[pos..]);

        try self.net.send(header[0..pos], payload);
    }
};

const Mac = [6]u8;
const IpAddr = [4]u8;

pub const Ethernet = extern struct {
    const Self = @This();

    const Protocol = enum(u16) {
        arp = 0x0806,
        ip = 0x0800,
        _,
    };

    destination: Mac,
    source: Mac,
    protocol: Protocol,

    pub fn decode(bytes: []const u8) !Self {
        return try decodeAny(Self, bytes, 0);
    }

    pub fn encode(self: *Self, bytes: []u8) !usize {
        return try encodeAny(Self, self, bytes, 0);
    }
};

pub const Arp = extern struct {
    const Self = @This();

    const Hardware = enum(u16) {
        ethernet = 0x0001,
        _,
    };

    const Protocol = enum(u16) {
        ipv4 = 0x0800,
        _,
    };

    const Opcode = enum(u16) {
        unknown = 0,
        request = 0x0001,
        response = 0x0002,
        rarp_request = 0x0003,
        rarp_response = 0x0004,
        _,
    };

    hardware: Hardware = .ethernet,
    protocol: Protocol = .ipv4,
    hardware_size: u8 = 6,
    protocol_size: u8 = 4,
    opcode: Opcode,
    sender_mac: Mac,
    sender_ip: IpAddr,
    target_mac: Mac,
    target_ip: IpAddr,

    pub fn decode(bytes: []const u8) !Self {
        return try decodeAny(Self, bytes, 0);
    }

    pub fn encode(self: *Self, bytes: []u8) !usize {
        return try encodeAny(Self, self, bytes, 0);
    }
};

pub const Ip = extern struct {
    const Self = @This();

    const Protocol = enum(u8) {
        icmp = 0x01,
        igmp = 0x02,
        tcp = 0x06,
        udp = 0x11,
        _,
    };
    // fields reference: tcp/ip illustrated, page 183

    header: packed struct {
        length: u4 = 5, // number of 4 byte words in this header
        version: u4 = 4, // 4 for ip v4
    } = .{},
    service: packed struct { // used for special processing when it is forwarded
        ecn: u2 = 0, // explicit congestion notification
        ds: u6 = 0, // differentiated services field
    } = .{},
    total_length: u16, // this header and payload length
    identification: u16, // all fragments have same identification
    fragment: packed struct {
        offset: u13 = 0,
        mf: bool = false, // more fragment follows (this is not the last fragment)
        df: bool = true, // don't fragment, this is the only/last fragment
        _: u1 = 0,
    } = .{},
    ttl: u8 = 64, // time to live
    protocol: Protocol, // type of data found in payload
    checksum: u16 = 0, // checksum of the this header only
    source: IpAddr, // source ip address
    destination: IpAddr, // destintaion ip address

    pub fn decode(bytes: []const u8) !Self {
        const header_length: u8 = (bytes[0] & 0x0f) * 4;
        if (bytes.len < header_length) return error.InsufficientBuffer;
        return try decodeAny(Self, bytes[0..header_length], header_length);
    }

    pub fn encode(self: *Self, bytes: []u8) !usize {
        self.checksum = 0;
        return try encodeAny(Self, self, bytes, @sizeOf(Self));
    }

    pub fn payload_length(self: Self) u16 {
        return self.total_length - @as(u16, self.header.length) * 4;
    }

    pub fn options_length(self: Self) u16 {
        return @as(u16, self.header.length) * 4 - @sizeOf(Ip);
    }
};

pub const Icmp = extern struct {
    const Self = @This();

    const Type = enum(u8) {
        reply = 0,
        request = 8,
        unreahable = 3,
        _,
    };

    typ: Type,
    code: u8 = 0,
    checksum: u16 = 0,
    identifier: u16,
    sequence: u16,

    pub fn decode(bytes: []const u8) !Self {
        return try decodeAny(Self, bytes, bytes.len);
    }

    pub fn encode(self: *Self, bytes: []u8) !usize {
        self.checksum = 0;
        return try encodeAny(Self, self, bytes, bytes.len);
    }
};

pub const UdpHeader = extern struct {
    const Self = @This();

    source_port: u16,
    destination_port: u16,
    length: u16, // udp header and payload in bytes
    checksum: u16,

    pub fn encode(self: *Self, bytes: []u8) !usize {
        self.checksum = 0;
        return try encodeAny(Self, self, bytes, 0);
    }
};

comptime {
    assert(@sizeOf(Ethernet) == 14);
    assert(@sizeOf(Arp) == 28);
    assert(@sizeOf(Ip) == 20);
    assert(@sizeOf(Icmp) == 8);
}

// c_len number of bytes for checksum calculation
fn decodeAny(T: type, bytes: []const u8, c_len: usize) !T {
    if (c_len > 0) {
        if (0xffff ^ add_csum(0, bytes[0..c_len]) != 0) return error.Checksum;
    }
    if (bytes.len < @sizeOf(T)) return error.InsufficientBuffer;

    var t: T = @bitCast(bytes[0..@sizeOf(T)].*);
    if (native_endian == .little) {
        std.mem.byteSwapAllFields(T, &t);
    }
    return t;
}

fn add_csum(prev: u16, bytes: []const u8) u16 {
    const round_len = (bytes.len & ~@as(usize, 0x01));
    const slice = mem.bytesAsSlice(u16, bytes[0..round_len]);

    var sum: u16 = prev;
    var last: u16 = prev;
    for (slice) |v| {
        sum +%= v;
        if (sum < last) sum +%= 1;
        last = sum;
    }
    if (bytes.len & 1 > 0)
        sum += bytes[bytes.len - 1];
    if (sum < last) sum +%= 1;
    return sum;
}

pub fn encodeAny(T: type, t: *T, bytes: []u8, c_len: usize) !usize {
    if (bytes.len < @sizeOf(T)) return error.InsufficientBuffer;
    if (native_endian == .little) {
        std.mem.byteSwapAllFields(T, t);
    }
    @memcpy(bytes[0..@sizeOf(T)], mem.asBytes(t));

    if (@hasField(T, "checksum") and c_len > 0) {
        mem.writeInt(u16, bytes[@offsetOf(T, "checksum")..][0..2], 0xffff ^ add_csum(0, bytes[0..c_len]), .little);
    }
    return @sizeOf(T);
}

test "arp request" {
    const data = hexToBytes("5847ca75fdbc1ae829c3ec78080600010800060400011ae829c3ec78c0a8be01000000000000c0a8beeb000000000000000000000000000000000000");

    const eth = try Ethernet.decode(&data);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x58, 0x47, 0xca, 0x75, 0xfd, 0xbc }, &eth.destination);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x1a, 0xe8, 0x29, 0xc3, 0xec, 0x78 }, &eth.source);
    try testing.expectEqual(.arp, eth.protocol);

    const arp = try Arp.decode(data[@sizeOf(Ethernet)..]);
    try testing.expectEqual(.ethernet, arp.hardware);
    try testing.expectEqual(.ipv4, arp.protocol);
    try testing.expectEqual(6, arp.hardware_size);
    try testing.expectEqual(4, arp.protocol_size);

    try testing.expectEqual(.request, arp.opcode);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x1a, 0xe8, 0x29, 0xc3, 0xec, 0x78 }, &arp.sender_mac);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }, &arp.target_mac);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 1 }, &arp.sender_ip);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 235 }, &arp.target_ip);
    {
        const local_mac = .{ 0x58, 0x47, 0xca, 0x75, 0xfd, 0xbc };
        const local_ip: IpAddr = .{ 192, 168, 190, 235 };
        var eth_rsp: Ethernet = .{
            .destination = arp.sender_mac,
            .source = local_mac,
            .protocol = .arp,
        };
        var arp_rsp: Arp = .{
            .opcode = .response,
            .sender_mac = local_mac,
            .sender_ip = local_ip,
            .target_mac = arp.sender_mac,
            .target_ip = arp.sender_ip,
        };

        var buffer: [128]u8 = undefined;
        var pos: usize = try eth_rsp.encode(&buffer);
        pos += try arp_rsp.encode(buffer[pos..]);
        const rsp = buffer[0..pos];

        const expected = hexToBytes("1ae829c3ec785847ca75fdbc080600010800060400025847ca75fdbcc0a8beeb1ae829c3ec78c0a8be01");
        try testing.expectEqualSlices(u8, &expected, rsp);
    }
}

test "decode arp reponse" {
    const data = hexToBytes("1ae829c3ec785847ca75fdbc080600010800060400025847ca75fdbcc0a8beeb1ae829c3ec78c0a8be01");
    const eth = try Ethernet.decode(&data);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x1a, 0xe8, 0x29, 0xc3, 0xec, 0x78 }, &eth.destination);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x58, 0x47, 0xca, 0x75, 0xfd, 0xbc }, &eth.source);
    try testing.expectEqual(.arp, eth.protocol);

    const arp = try Arp.decode(data[@sizeOf(Ethernet)..]);
    try testing.expectEqual(.ethernet, arp.hardware);
    try testing.expectEqual(.ipv4, arp.protocol);
    try testing.expectEqual(6, arp.hardware_size);
    try testing.expectEqual(4, arp.protocol_size);

    try testing.expectEqual(.response, arp.opcode);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x58, 0x47, 0xca, 0x75, 0xfd, 0xbc }, &arp.sender_mac);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x1a, 0xe8, 0x29, 0xc3, 0xec, 0x78 }, &arp.target_mac);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 235 }, &arp.sender_ip);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 1 }, &arp.target_ip);
}

test "ip decode/encode" {
    const net_bytes = hexToBytes("45000054b055400040018bbcc0a8beebc0a8be5a");
    var ip = try Ip.decode(&net_bytes);
    try testing.expectEqual(4, ip.header.version);
    try testing.expectEqual(5, ip.header.length);
    try testing.expectEqual(84, ip.total_length);
    try testing.expectEqual(0xb055, ip.identification);
    try testing.expect(ip.fragment.df);
    try testing.expectEqual(64, ip.ttl);
    try testing.expectEqual(.icmp, ip.protocol);
    try testing.expectEqual(0x8bbc, ip.checksum);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 235 }, &ip.source);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 90 }, &ip.destination);

    // test checksum calculation
    var bytes: [net_bytes.len]u8 = @splat(0);
    const pos = try ip.encode(&bytes);
    try testing.expectEqualSlices(u8, &net_bytes, bytes[0..pos]);
}

test "icmp decode" {
    const bytes = hexToBytes("0800eb870007002f0bf02569000000001c16000000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637");
    const icmp = try Icmp.decode(&bytes);

    try testing.expectEqual(.request, icmp.typ);
    try testing.expectEqual(0, icmp.code);
    try testing.expectEqual(0xeb87, icmp.checksum);
    try testing.expectEqual(47, icmp.sequence);
    try testing.expectEqual(7, icmp.identifier);

    const data = bytes[@sizeOf(Icmp)..];
    try testing.expectEqual(56, data.len);
}

test "decode whole icmp packet" {
    const net_bytes = hexToBytes("2ccf67f3b7ea5847ca75fdbc080045000054b055400040018bbcc0a8beebc0a8be5a0800eb870007002f0bf02569000000001c16000000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637");
    var bytes: []const u8 = &net_bytes;

    // ethernet
    var eth = try Ethernet.decode(bytes);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x58, 0x47, 0xca, 0x75, 0xfd, 0xbc }, &eth.source);
    try testing.expectEqualSlices(u8, &[_]u8{ 0x2c, 0xcf, 0x67, 0xf3, 0xb7, 0xea }, &eth.destination);
    try testing.expectEqual(.ip, eth.protocol);

    // ip
    bytes = bytes[@sizeOf(Ethernet)..];
    var ip = try Ip.decode(bytes);
    try testing.expectEqual(4, ip.header.version);
    try testing.expectEqual(5, ip.header.length);
    try testing.expectEqual(84, ip.total_length);
    try testing.expectEqual(0xb055, ip.identification);
    try testing.expect(ip.fragment.df);
    try testing.expectEqual(64, ip.ttl);
    try testing.expectEqual(.icmp, ip.protocol);
    try testing.expectEqual(0x8bbc, ip.checksum);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 235 }, &ip.source);
    try testing.expectEqualSlices(u8, &[_]u8{ 192, 168, 190, 90 }, &ip.destination);

    // icmp
    try testing.expectEqual(bytes.len, ip.total_length);
    bytes = bytes[0..ip.total_length][@sizeOf(Ip)..];
    var icmp = try Icmp.decode(bytes);
    try testing.expectEqual(.request, icmp.typ);
    try testing.expectEqual(0, icmp.code);
    try testing.expectEqual(0xeb87, icmp.checksum);
    try testing.expectEqual(47, icmp.sequence);
    try testing.expectEqual(7, icmp.identifier);

    // data
    const data = bytes[@sizeOf(Icmp)..];
    try testing.expectEqual(56, data.len);

    var buffer: [128]u8 = undefined;
    var pos = try eth.encode(&buffer);
    pos += try ip.encode(buffer[pos..]);
    @memcpy(buffer[pos + @sizeOf(Icmp) ..][0..data.len], data);
    pos += try icmp.encode(buffer[pos..][0 .. data.len + @sizeOf(Icmp)]);
    pos += data.len;
    try testing.expectEqualSlices(u8, &net_bytes, buffer[0..pos]);
}

pub fn hexToBytes(comptime hex: []const u8) [hex.len / 2]u8 {
    var res: [hex.len / 2]u8 = undefined;
    _ = std.fmt.hexToBytes(&res, hex) catch unreachable;
    return res;
}

test "ip with options" {
    var bytes: []const u8 = &hexToBytes("01005e0000fb1ae829c3ec78080046c00020f3d700000102d09ac0a8be01e00000fb9404000011640da0e00000fb");

    const eth = try Ethernet.decode(bytes);
    bytes = bytes[@sizeOf(Ethernet)..];
    const ip = try Ip.decode(bytes);

    try testing.expectEqual(.ip, eth.protocol);
    try testing.expectEqual(6, ip.header.length); // 24 bytes header instead of default 20
    try testing.expectEqual(32, ip.total_length);
    try testing.expectEqual(4, ip.options_length());
    try testing.expectEqual(8, ip.payload_length());
    try testing.expectEqual(.igmp, ip.protocol);
}
