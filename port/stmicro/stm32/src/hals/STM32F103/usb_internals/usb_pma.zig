const std = @import("std");
const microzig = @import("microzig");
const USB = microzig.chip.peripherals.USB;
const PMA_BASE: u32 = 0x40006000;

const pma_data = packed struct(u32) {
    low_byte: u8,
    high_byte: u8,
    _res: u16 = 0,
};

//PMA(u16) <==> CPU(u32)
const PMA_value = packed struct(u32) {
    value: u16,
    _reserved: u16 = 0,
};

const BTABLEDescriptor = extern struct {
    TX_addr: PMA_value,
    TX_count: PMA_value,
    RX_addr: PMA_value,
    RX_count: PMA_value,
};

pub const BlockSize = enum {
    @"2bytes",
    @"32bytes",
};
pub const RX_size = struct {
    block_size: BlockSize,
    block_qtd: usize,

    pub fn calc_rx_size(size: *const RX_size) usize {
        const mul: usize = if (@intFromEnum(size.block_size) == 0) 2 else 32;
        return mul * size.block_qtd;
    }

    pub fn to_RXcount(size: *const RX_size) u16 {
        const SL_bit: u16 = @as(u16, @intFromEnum(size.block_size)) << 15;
        const pkg_qtd: u16 = @as(u16, @intCast(size.block_qtd)) << 10;
        return SL_bit | pkg_qtd;
    }

    pub fn from_bytes(bytes: usize) RX_size {
        if (bytes > 62) {
            const block_qtd: usize = @intFromFloat(@ceil(@as(f32, @floatFromInt(bytes)) / 32));
            return .{ .block_qtd = block_qtd - 1, .block_size = .@"32bytes" };
        } else {
            const block_qtd: usize = @intFromFloat(@ceil(@as(f32, @floatFromInt(bytes)) / 2));
            return .{ .block_qtd = block_qtd, .block_size = .@"2bytes" };
        }
    }
};
//the memory will be rounded to the nearest number of blocks to the value
pub const EntryMetadata = struct {
    tx_max_size: usize,
    rx_max_size: RX_size,
};

pub const Config = struct {
    pub const Error = error{InvalidEndpoint};
    EP0: ?EntryMetadata = null,
    EP1: ?EntryMetadata = null,
    EP2: ?EntryMetadata = null,
    EP3: ?EntryMetadata = null,
    EP4: ?EntryMetadata = null,
    EP5: ?EntryMetadata = null,
    EP6: ?EntryMetadata = null,
    EP7: ?EntryMetadata = null,

    pub fn set_config(self: *Config, endpoint: usize, config: EntryMetadata) Error!void {
        switch (endpoint) {
            0 => self.EP0 = config,
            1 => self.EP1 = config,
            2 => self.EP2 = config,
            3 => self.EP3 = config,
            4 => self.EP4 = config,
            5 => self.EP5 = config,
            6 => self.EP6 = config,
            7 => self.EP7 = config,
            else => {
                return error.InvalidEndpoint;
            },
        }
    }
};

pub const BTABLEError = error{
    PMAOverflow,
};

const BTABLE: *volatile [8]BTABLEDescriptor = @ptrFromInt(PMA_BASE);

var metadata: [8]?EntryMetadata = undefined;
var init = false;
pub fn btable_init(config: Config) BTABLEError!void {
    try load_and_check(config);

    var offset: usize = 32;

    USB.BTABLE.raw = 0;

    //init BTABLE;
    for (0..8) |i| {
        if (metadata[i]) |data| {
            BTABLE[i].TX_addr.value = @intCast(offset);
            BTABLE[i].TX_count.value = 0;
            offset += calc_offset(data.tx_max_size);
            BTABLE[i].RX_addr.value = @intCast(offset);
            BTABLE[i].RX_count.value = data.rx_max_size.to_RXcount();
            offset += calc_offset(data.rx_max_size.calc_rx_size());
        }
    }
}

//load config into metadata and check if the SUM of all buffer can fit into the PMA
fn load_and_check(config: Config) BTABLEError!void {
    //load metadata
    metadata[0] = config.EP0;
    metadata[1] = config.EP1;
    metadata[2] = config.EP2;
    metadata[3] = config.EP3;
    metadata[4] = config.EP4;
    metadata[5] = config.EP5;
    metadata[6] = config.EP6;
    metadata[7] = config.EP7;

    var available_memory: usize = 512 - 64;

    for (metadata) |ep_data| {
        if (ep_data) |data| {
            const entry_size = data.tx_max_size + data.rx_max_size.calc_rx_size();
            if (entry_size < available_memory) {
                available_memory -= entry_size;
            } else {
                return error.PMAOverflow;
            }
        }
    }
}

fn calc_offset(bytes: usize) usize {
    return @intFromFloat(@ceil(@as(f32, @floatFromInt(bytes)) / 2));
}

pub inline fn RX_recv_size(EP: usize) usize {
    return BTABLE[EP].RX_count.value & 0x3FF;
}

pub fn RX_to_buffer(buffer: []u8, EP: usize) []const u8 {
    const PMA_buf = BTABLE[EP];
    const count = RX_recv_size(EP);
    if (count == 0) {
        return buffer[0..0];
    }

    const to_read = @min(count, buffer.len) / 2;
    const addr = PMA_BASE + PMA_buf.RX_addr.value * 2;
    const data = @as([*]volatile pma_data, @ptrFromInt(addr))[0..to_read];

    for (0..data.len) |i| {
        buffer[i * 2] = data[i].low_byte;
        buffer[i * 2 + 1] = data[i].high_byte;
    }
    return buffer[0 .. to_read * 2];
}

pub fn buffer_to_TX(buffer: []const u8, EP: usize) void {
    const len = buffer.len;
    const addr = PMA_BASE + BTABLE[EP].TX_addr.value * 2;
    var data = @as([*]u32, @ptrFromInt(addr));
    if (len == 0) {
        BTABLE[EP].TX_count.value = 0;
        return;
    }
    BTABLE[EP].TX_count.value = @intCast((len));

    for (0..(len / 2)) |i| {
        const lb = buffer[i * 2];
        const high_index = i * 2 + 1;
        const hb = if (high_index < len) buffer[high_index] else 0;
        const hold = pma_data{
            .low_byte = lb,
            .high_byte = hb,
        };
        data[i] = @bitCast(hold);
    }

    if (len % 2 != 0) {
        const lb = buffer[len - 1];
        const hold = pma_data{
            .low_byte = lb,
            .high_byte = 0,
        };
        data[len / 2] = @bitCast(hold);
    }
}
