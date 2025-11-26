const std = @import("std");
const mem = std.mem;
const testing = std.testing;
const builtin = @import("builtin");
const native_endian = builtin.cpu.arch.endian();

const log = std.log.scoped(.net);

var local: struct {
    mac: Mac = @splat(0),
    ip: IpAddr = @splat(0),
} = .{};

pub fn set(mac: Mac, ip: IpAddr) void {
    local.mac = mac;
    local.ip = ip;
}

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
        icmp = 1,
    };

    version__header_length: u8,
    service: u8,
    total_length: u16,
    identification: u16,
    flags__fragment_offset: u16,
    ttl: u8,
    protocol: Protocol,
    checksum: u16,
    source: IpAddr,
    destination: IpAddr,

    pub fn version(self: Ip) u4 {
        return @truncate((self.version__header_length & 0xf0) >> 4);
    }

    pub fn header_length(self: Ip) u8 {
        return (self.version__header_length & 0x0f) * 4;
    }

    pub fn flags(self: Ip) u3 {
        return @truncate((self.flags__fragment_offset & 0b1110_0000_0000_0000) >> 13);
    }

    pub fn fragment_offset(self: Ip) u13 {
        return @truncate((self.flags__fragment_offset & 0b0001_1111_1111_1111));
    }

    pub fn decode(bytes: []const u8) !Self {
        return try decodeAny(Self, bytes, @sizeOf(Self));
    }

    pub fn encode(self: *Self, bytes: []u8) !usize {
        self.checksum = 0;
        return try encodeAny(Self, self, bytes, @sizeOf(Self));
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
    code: u8,
    checksum: u16,
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
    const slice = mem.bytesAsSlice(u16, bytes);

    var sum: u16 = prev;
    var last: u16 = prev;
    for (slice) |v| {
        sum +%= v;
        if (sum < last) sum +%= 1;
        last = sum;
    }
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
        set(.{ 0x58, 0x47, 0xca, 0x75, 0xfd, 0xbc }, .{ 192, 168, 190, 235 });
        var eth_rsp: Ethernet = .{
            .destination = arp.sender_mac,
            .source = local.mac,
            .protocol = .arp,
        };
        var arp_rsp: Arp = .{
            .opcode = .response,
            .sender_mac = local.mac,
            .sender_ip = local.ip,
            .target_mac = arp.sender_mac,
            .target_ip = arp.sender_ip,
        };

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
    try testing.expectEqual(4, ip.version());
    try testing.expectEqual(20, ip.header_length());
    try testing.expectEqual(84, ip.total_length);
    try testing.expectEqual(0xb055, ip.identification);
    try testing.expectEqual(0x2, ip.flags());
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
    try testing.expectEqual(4, ip.version());
    try testing.expectEqual(20, ip.header_length());
    try testing.expectEqual(84, ip.total_length);
    try testing.expectEqual(0xb055, ip.identification);
    try testing.expectEqual(0x2, ip.flags());
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

pub fn handle(rx_bytes: []const u8) !?[]const u8 {
    var bytes: []const u8 = rx_bytes;
    const eth = try Ethernet.decode(bytes);
    bytes = bytes[@sizeOf(Ethernet)..];

    if (eth.protocol == .arp) {
        const arp = try Arp.decode(bytes);
        bytes = bytes[@sizeOf(Arp)..];

        if (arp.opcode == .request and mem.eql(u8, &arp.target_ip, &local.ip)) {
            log.debug("arp request from ip: {any} mac: {x}", .{ arp.sender_ip[0..4], arp.sender_mac[0..6] });

            var eth_rsp: Ethernet = .{
                .destination = arp.sender_mac,
                .source = local.mac,
                .protocol = .arp,
            };
            var arp_rsp: Arp = .{
                .opcode = .response,
                .sender_mac = local.mac,
                .sender_ip = local.ip,
                .target_mac = arp.sender_mac,
                .target_ip = arp.sender_ip,
            };

            var pos: usize = try eth_rsp.encode(&buffer);
            pos += try arp_rsp.encode(buffer[pos..]);
            return buffer[0..pos];
        }
    }
    return null;
}

var buffer: [128]u8 = @splat(0);
