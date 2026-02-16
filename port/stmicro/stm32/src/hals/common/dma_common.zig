const microzig = @import("microzig");
// bdma_v1 and  v2 has the same cluster definition
// Type would coerce.
const bdma_v1 = microzig.chip.types.peripherals.bdma_v1;

const PriorityLevel = bdma_v1.PL;
const Direction = bdma_v1.DIR;
const Size = bdma_v1.SIZE;
const CH = bdma_v1.CH;

pub const Error = error{
    BufferOverflow,
};

pub const ChannelEvent = packed struct(u4) {
    pending_event: bool,
    transfer_complete: bool,
    half_transfer: bool,
    transfer_error: bool,
};

pub const Config = struct {

    //Channel Configuration
    priority: PriorityLevel = .Low,
    direction: Direction = .FromPeripheral,
    peripheral_size: Size = .Bits8,
    memory_size: Size = .Bits8,

    //Channel Control Flags
    peripheral_increment: bool = false,
    memory_increment: bool = false,
    circular_mode: bool = false,
    memory_to_memory: bool = false,
    transfer_complete_interrupt: bool = false,
    half_transfer_interrupt: bool = false,
    transfer_error_interrupt: bool = false,

    //Channel Transfer Parameters
    mem_address: ?u32 = null,
    periph_address: u32,
    transfer_count: ?u16 = null,
};

pub const Channel = struct {
    const Self = @This();
    reg_channel: *volatile CH,
    in_progress: bool,
    dma_buffer: []u8,

    pub fn apply(self: *const Self, config: Config) void {
        self.reg_channel.CR.modify(.{
            .EN = 0,
            .DIR = config.direction,
            .CIRC = @intFromBool(config.circular_mode),
            .PINC = @intFromBool(config.peripheral_increment),
            .MINC = @intFromBool(config.memory_increment),
            .PSIZE = config.peripheral_size,
            .MSIZE = config.memory_size,
            .PL = config.priority,
            .MEM2MEM = @intFromBool(config.memory_to_memory),
            .TCIE = @intFromBool(config.transfer_complete_interrupt),
            .HTIE = @intFromBool(config.half_transfer_interrupt),
            .TEIE = @intFromBool(config.transfer_error_interrupt),
        });

        if (config.mem_address) |address| {
            self.reg_channel.MAR.raw = address;
        }
        if (config.transfer_count) |count| {
            self.reg_channel.NDTR.modify_one("NDT", count);
        }
        self.reg_channel.PAR.raw = config.periph_address;
    }

    pub fn start(self: *Self) void {
        self.in_progress = true;
        self.reg_channel.CR.modify_one("EN", 1);
    }

    pub fn stop(self: *Self) void {
        self.in_progress = false;
        self.reg_channel.CR.modify_one("EN", 0);
    }

    pub fn is_in_progress(self: *const Self) bool {
        return self.in_progress;
    }

    pub fn deliver_event(self: *Self, event: ChannelEvent) void {
        if (event.transfer_complete) {
            self.in_progress = false;
        }

        if (event.transfer_error) {
            self.in_progress = false;
            // TODO: Find a better solution: https://github.com/ZigEmbeddedGroup/microzig/issues/806
            @panic("DMA transfer errored, make sur device is correctly configure and memory bus can be reach by DMA");
        }
    }

    pub fn load_memeory_data(self: *const Self, buffer: []const u8) Error!void {
        if (buffer.len > self.dma_buffer.len) {
            return Error.BufferOverflow;
        }
        @memcpy(self.dma_buffer[0..buffer.len], buffer);

        self.reg_channel.NDTR.modify_one("NDT", @as(u16, @intCast(buffer.len)));
        self.reg_channel.MAR.raw = @intFromPtr(self.dma_buffer.ptr);
    }

    /// Reads the number of remaining transfers.
    /// 0 == DMA has finished all transfers.
    pub inline fn channel_remain_count(self: *const Self) u16 {
        return self.reg_channel.NDTR.read().NDT;
    }
};
