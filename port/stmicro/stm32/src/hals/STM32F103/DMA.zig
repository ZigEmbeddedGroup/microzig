//basic DMA support for STM32F1xx

//NOTE: the current bdma-v1 does not include the DMA channel cluster in the DMA struct
//this happens because the DMA controller of this version does not have a fixed number of channels
//that is, it can have any amount between 1 and 7 channels
//for example, DMA2 of STM32F10x high/XL has only 5 channels
//this may have affected the code generation in bdma_v1

const microzig = @import("microzig");
const util = @import("util.zig");

const Bdma_v1 = microzig.chip.types.peripherals.bdma_v1;
const DMA = Bdma_v1.DMA;
const PriorityLevel = Bdma_v1.PL;
const DIrection = Bdma_v1.DIR;
const Size = Bdma_v1.SIZE;
const Channel = Bdma_v1.CH;
pub const Instances = util.create_peripheral_enum("DMA", "bdma_v1");
fn get_regs(comptime instance: Instances) *volatile DMA {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

pub const ChannelConfig = struct {

    //Channel Configuration
    priority: PriorityLevel = .Low,
    direction: DIrection = .FromPeripheral,
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
    mem_address: u32,
    periph_address: u32,
    transfer_count: u16,
};
pub const ChannelEvent = packed struct(u4) {
    pending_event: bool,
    transfer_complete: bool,
    half_transfer: bool,
    transfer_error: bool,
};

pub const DMAController = struct {
    controller: *volatile DMA,

    /// Channel configuration
    ///
    /// NOTE: Channels are 0-Indexed in this API (1..7 [on datasheet] == 0..6)
    /// NOTE: this function disables the DMA channel, you must use `start_channel()` to start the channel
    pub fn apply_channel(self: *const DMAController, channel: u3, config: ChannelConfig) void {

        //TODO; remove this after fixing bdma_v1 code
        const ch_offset = @as(u32, @intFromPtr(self.controller)) + 0x8 + (20 * @as(u32, channel));
        const ch_cluster: *volatile Channel = @ptrFromInt(ch_offset);
        ch_cluster.CR.modify(.{
            .EN = 0, //force disable channel before changing config MAR PAR and CNTR
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

        ch_cluster.PAR = config.periph_address;
        ch_cluster.MAR = config.mem_address;
        ch_cluster.NDTR.modify_one("NDT", config.transfer_count);
    }

    pub fn start_channel(self: *const DMAController, channel: u3) void {
        //TODO; remove this after fixing bdma_v1 code
        const ch_offset = @as(u32, @intFromPtr(self.controller)) + 0x8 + (20 * @as(u32, channel));
        const ch_cluster: *volatile Channel = @ptrFromInt(ch_offset);
        ch_cluster.CR.modify_one("EN", 1);
    }

    pub fn stop_channel(self: *const DMAController, channel: u3) void {
        //TODO; remove this after fixing bdma_v1 code
        const ch_offset = @as(u32, @intFromPtr(self.controller)) + 0x8 + (20 * @as(u32, channel));
        const ch_cluster: *volatile Channel = @ptrFromInt(ch_offset);
        ch_cluster.CR.modify_one("EN", 0);
    }

    /// NOTE: this function temporarily disables the channel
    pub fn set_memory_address(self: *const DMAController, channel: u3, MA: u32) void {
        const ch_offset = @as(u32, @intFromPtr(self.controller)) + 0x8 + (20 * @as(u32, channel));
        const ch_cluster: *volatile Channel = @ptrFromInt(ch_offset);

        const current_en = ch_cluster.CR.read().EN;

        // disables the channel before configuring a new value for count
        ch_cluster.CR.modify_one("EN", 0);
        ch_cluster.MAR = MA;
        ch_cluster.CR.modify_one("EN", current_en);
    }

    /// Changes the number of transfers
    /// NOTE: this function temporarily disables the channel
    pub fn set_channel_count(self: *const DMAController, channel: u3, count: u16) void {
        //TODO; remove this after fixing bdma_v1 code

        const ch_offset = @as(u32, @intFromPtr(self.controller)) + 0x8 + (20 * @as(u32, channel));
        const ch_cluster: *volatile Channel = @ptrFromInt(ch_offset);
        const current_en = ch_cluster.CR.read().EN;

        // disables the channel before configuring a new value for count
        ch_cluster.CR.modify_one("EN", 0);
        ch_cluster.NDTR.modify_one("NDT", count);
        ch_cluster.CR.modify_one("EN", current_en);
    }

    /// Reads the number of remaining transfers.
    /// 0 == DMA has finished all transfers.
    pub fn channel_remain_count(self: *const DMAController, channel: u3) u16 {
        //TODO; remove this after fixing bdma_v1 code

        const ch_offset = @as(u32, @intFromPtr(self.controller)) + 0x8 + (20 * @as(u32, channel));
        const ch_cluster: *volatile Channel = @ptrFromInt(ch_offset);
        return ch_cluster.NDTR.read().NDT;
    }

    pub fn read_channel_events(self: *const DMAController, channel: u3) ChannelEvent {
        const ch_evt_idx: u5 = 4 * channel;
        return @bitCast(@as(u4, @intCast((self.controller.ISR.raw >> ch_evt_idx) | 0xF)));
    }

    pub fn clear_channel_events(self: *const DMAController, channel: u3, events: ChannelEvent) void {
        const ch_evt_idx: u5 = 4 * channel;
        const bits: u32 = @as(u4, @bitCast(events));
        self.controller.IFCR.raw |= (bits & 0xF) << ch_evt_idx;
    }

    pub fn init(comptime instance: Instances) DMAController {
        return DMAController{ .controller = get_regs(instance) };
    }
};
