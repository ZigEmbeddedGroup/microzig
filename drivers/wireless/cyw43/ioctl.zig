const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const IOCTL_MAX_BLKLEN = 1600;
var ioctl_reqid: u16 = 0;
var tx_seq: u8 = 0;

// SDIO/SPI Bus Layer (SDPCM) header
// ref: https://iosoft.blog/2022/12/06/picowi_part3/
const BusHeader = extern struct {
    len: u16,
    notlen: u16,
    seq: u8,
    chan: Chan,
    nextlen: u8 = 0,
    hdrlen: u8,
    flow: u8 = 0,
    credit: u8 = 0,
    _reserved: u16 = 0,

    const Chan = enum(u8) {
        control = 0,
        event = 1,
        data = 2,
    };
};

const IoctlHeader = extern struct {
    cmd: Cmd,
    outlen: u16,
    inlen: u16 = 0,
    flags: u16 = 0,
    id: u16,
    status: u32 = 0,

    const Cmd = enum(u32) {
        get_var = 262,
        set_var = 263,
        _,
    };
};

pub const BcdHeader = extern struct {
    flags: u8,
    priority: u8,
    flags2: u8,
    offset: u8,
};

pub const Response = extern struct {
    const Self = @This();
    pub const min_len = @sizeOf(BusHeader) + @sizeOf(IoctlHeader);
    pub const empty = std.mem.zeroes(Response);

    bus: BusHeader align(4),
    buffer: [IOCTL_MAX_BLKLEN - @sizeOf(BusHeader)]u8,

    pub fn ioctl_pos(self: *Self) usize {
        return self.bus.hdrlen - @sizeOf(BusHeader);
    }

    pub fn ioctl(self: *Self) IoctlHeader {
        return @bitCast(self.buffer[self.ioctl_pos()..][0..@sizeOf(IoctlHeader)].*);
    }

    pub fn data(self: *Self, data_len: usize) []const u8 {
        const pos = self.ioctl_pos() + @sizeOf(IoctlHeader);
        const len = self.bus.len - @sizeOf(IoctlHeader);
        if (pos < len) {
            const data_buf = self.buffer[pos..len];
            return data_buf[0..@min(data_len, data_buf.len)];
        }
        return &.{};
    }

    pub fn as_slice(self: *Self) []u32 {
        return mem.bytesAsSlice(u32, mem.asBytes(self));
        // var buf: []u32 = undefined;
        // buf.ptr = @ptrCast(@alignCast(self));
        // buf.len = @intCast(@sizeOf(Self) / 4);
        // return buf;
    }
};

pub const Request = extern struct {
    const Self = @This();
    bus: BusHeader align(4),
    hdr: IoctlHeader,
    data: [IOCTL_MAX_BLKLEN - @sizeOf(BusHeader) - @sizeOf(IoctlHeader)]u8,

    pub fn init(cmd: IoctlHeader.Cmd, name: []const u8, set: bool, data: []const u8) Self {
        const txdlen: u16 = @intCast(((name.len + 1 + data.len + 3) / 4) * 4); // name has 0 sentinel that's why (+1)
        const hdrlen: u16 = @sizeOf(BusHeader) + @sizeOf(IoctlHeader);
        const txlen: u16 = hdrlen + txdlen;

        tx_seq +|= 1;
        ioctl_reqid +|= 1;
        var rsp = std.mem.zeroes(Self);
        rsp.bus = .{
            .len = txlen,
            .notlen = ~txlen,
            .seq = tx_seq,
            .chan = .control,
            .hdrlen = @sizeOf(BusHeader),
        };
        rsp.hdr = .{
            .cmd = cmd,
            .outlen = txdlen,
            .id = ioctl_reqid,
            .flags = if (set) 0x02 else 0,
        };
        if (name.len > 0) {
            @memcpy(rsp.data[0..name.len], name);
        }
        if (data.len > 0 and set) {
            @memcpy(rsp.data[name.len + 1 ..][0..data.len], data);
        }
        return rsp;
    }

    pub fn as_slice(self: *Self) []u32 {
        return mem.bytesAsSlice(u32, mem.asBytes(self)[0..self.bus.len]);
        // var buf: []u32 = undefined;
        // buf.ptr = @ptrCast(@alignCast(self));
        // buf.len = @intCast(self.bus.len / 4);
        // return buf;
    }
};

// pub const Msg = extern struct {
//     const min_len = @sizeOf(BusHeader) + @sizeOf(IoctlHeader);

//     bus: BusHeader,
//     hdr: IoctlHeader,
//     data: [IOCTL_MAX_BLKLEN]u8,

//     pub const empty = std.mem.zeroes(Msg);

//     pub fn initRead(cmd: IoctlHeader.Cmd, name: []const u8, data: []const u8) Msg {
//         return init(cmd, name, data);
//     }

//     pub fn initWrite(cmd: IoctlHeader.Cmd, name: []const u8, data: []const u8) Msg {
//         var ioctl = init(cmd, name, data);
//         ioctl.flags |= 2;
//         if (data.len > 0) {
//             @memcpy(ioctl.data[name.len + 1 ..][0..data.len], data);
//         }
//         return ioctl;
//     }

//     fn init(cmd: IoctlHeader.Cmd, name: []const u8, data: []const u8) Msg {
//         const txdlen: u16 = @intCast(((name.len + data.len + 3) / 4) * 4);
//         const hdrlen: u16 = @sizeOf(BusHeader) + @sizeOf(IoctlHeader);
//         const txlen: u16 = hdrlen + txdlen;

//         tx_seq +|= 1;
//         ioctl_reqid +|= 1;
//         var ioctl = std.mem.zeroes(Msg);
//         ioctl.bus = .{
//             .len = txlen,
//             .notlen = ~txlen,
//             .seq = tx_seq,
//             .chan = .control,
//             .hdrlen = @sizeOf(BusHeader),
//         };
//         ioctl.hdr = .{
//             .cmd = cmd,
//             .outlen = txdlen,
//             .id = ioctl_reqid,
//         };
//         if (name.len > 0) {
//             @memcpy(ioctl.data[0..name.len], name);
//         }
//         // if (write and data.len > 0) {
//         //     @memcpy(ioctl.data[name.len..][0..data.len], data);
//         // }
//         return ioctl;
//     }
// };

test "write command" {
    {
        const mac: [6]u8 = undefined;

        tx_seq = 2;
        ioctl_reqid = 2;
        var req = Request.init(.get_var, "cur_etheraddr", false, &mac);

        const expected = &hexToBytes("3000CFFF0300000C00000000060100001400000000000300000000006375725F65746865726164647200000000000000");
        const buf = mem.asBytes(&req)[0..req.bus.len];
        try std.testing.expectEqualSlices(u8, expected, buf);

        try testing.expectEqual(48, expected.len);
        try testing.expectEqual(48 / 4, req.as_slice().len);
    }
    {
        tx_seq = 6;
        ioctl_reqid = 6;
        const expected = &hexToBytes("2C00D3FF0700000C00000000070100001000000002000700000000006770696F6F7574000100000001000000");
        var data: [8]u8 = @splat(0);
        data[0] = 1;
        data[4] = 1;
        var req = Request.init(.set_var, "gpioout", true, &data);
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
    try testing.expectEqual(0xffff, rsp.bus.len ^ rsp.bus.notlen);
    try testing.expectEqual(4, rsp.bus.seq);
    try testing.expectEqual(220, rsp.bus.hdrlen);
    try testing.expectEqual(20, rsp.bus.credit);
    try testing.expectEqual(0, rsp.bus.nextlen);

    const ioctl = rsp.ioctl();
    try testing.expectEqual(.get_var, ioctl.cmd);
    try testing.expectEqual(20, ioctl.outlen);
    try testing.expectEqual(0, ioctl.inlen);
    try testing.expectEqual(3, ioctl.id);
    try testing.expectEqual(0, ioctl.flags);
    try testing.expectEqual(0, ioctl.status);

    try testing.expectEqualSlices(u8, expected, rsp.data(expected.len));
}

test "parse response2" {
    const expected = &hexToBytes("2CCF67F3B7EA");
    const rsp_data = &hexToBytes("0001fffe020000dc0012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060100001400000000000100000000002ccf67f3b7ea6865726164647200000000000000");
    var rsp: Response = .empty;
    @memcpy(mem.asBytes(&rsp)[0..rsp_data.len], rsp_data);

    try testing.expectEqual(256, rsp.bus.len);
    try testing.expectEqual(0xffff, rsp.bus.len ^ rsp.bus.notlen);
    try testing.expectEqual(2, rsp.bus.seq);
    try testing.expectEqual(220, rsp.bus.hdrlen);
    try testing.expectEqual(18, rsp.bus.credit);
    try testing.expectEqual(0, rsp.bus.nextlen);

    const ioctl = rsp.ioctl();
    try testing.expectEqual(.get_var, ioctl.cmd);
    try testing.expectEqual(20, ioctl.outlen);
    try testing.expectEqual(0, ioctl.inlen);
    try testing.expectEqual(1, ioctl.id);
    try testing.expectEqual(0, ioctl.flags);
    try testing.expectEqual(0, ioctl.status);

    try testing.expectEqualSlices(u8, expected, rsp.data(6));
}

fn hexToBytes(comptime hex: []const u8) [hex.len / 2]u8 {
    var res: [hex.len / 2]u8 = undefined;
    _ = std.fmt.hexToBytes(&res, hex) catch unreachable;
    return res;
}
