//basic DMA support for STM32F1xx

//NOTE: the current bdma-v1 does not include the DMA channel cluster in the DMA struct
//this happens because the DMA controller of this version does not have a fixed number of channels
//that is, it can have any amount between 1 and 7 channels
//for example, DMA2 of STM32F10x high/XL has only 5 channels
//this may have affected the code generation in bdma_v1

const microzig = @import("microzig");
const util = @import("../common/util.zig");

const Bdma_v1 = microzig.chip.types.peripherals.bdma_v1;
const DMA = Bdma_v1.DMA;
const PriorityLevel = Bdma_v1.PL;
const DIrection = Bdma_v1.DIR;
const Size = Bdma_v1.SIZE;
const Channel_t = Bdma_v1.CH;
pub const Instances = util.create_peripheral_enum("DMA", "bdma_v1");
fn get_regs(comptime instance: Instances) *volatile DMA {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

pub const Config = struct {

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

pub const Channel = struct {
    ch_cluster: *volatile Channel_t,
    ch_num: u3,

    /// NOTE: Channels are 0-Indexed in this API (1..7 [on datasheet] == 0..6)
    pub fn init(comptime dma_ctrl: Instances, ch: u3) Channel {
        const base: usize = @intFromPtr(get_regs(dma_ctrl)) + 0x8 + (20 * @as(usize, ch));
        return Channel{
            .ch_cluster = @ptrFromInt(base),
            .ch_num = ch,
        };
    }

    pub fn clear_events(self: *const Channel, events: ChannelEvent) void {
        const IFCR_base = (@as(usize, @intFromPtr(self.ch_cluster)) & 0xFFFFFF00) | 0x4;
        const IFCR: *volatile @TypeOf(DMA.IFCR) = @ptrFromInt(IFCR_base);
        const ch_evt_idx: u5 = 4 * self.ch_num;
        const bits: u32 = @as(u4, @bitCast(events));
        IFCR.raw |= (bits & 0xF) << ch_evt_idx;
    }

    pub fn read_events(self: *const Channel) ChannelEvent {
        const ISR_base = (@as(usize, @intFromPtr(self.ch_cluster)) & 0xFFFFFF00);
        const ISR: *volatile @TypeOf(DMA.ISR) = @ptrFromInt(ISR_base);
        const ch_evt_idx: u5 = 4 * self.ch_num;
        return @bitCast(@as(u4, @intCast((ISR.raw >> ch_evt_idx) | 0xF)));
    }

    /// Channel configuration
    ///
    /// NOTE: this function disables the DMA channel, you must use `start()` to start the channel
    pub fn apply(self: *const Channel, config: Config) void {
        self.ch_cluster.CR.modify(.{
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

        self.ch_cluster.PAR = config.periph_address;
        self.ch_cluster.MAR = config.mem_address;
        self.ch_cluster.NDTR.modify_one("NDT", config.transfer_count);
    }

    pub fn start(self: *const Channel) void {
        self.ch_cluster.CR.modify_one("EN", 1);
    }

    pub fn stop(self: *const Channel) void {
        self.ch_cluster.CR.modify_one("EN", 0);
    }
    ///changes the memory address.
    ///
    /// NOTE: this function temporarily disables the channel
    pub fn set_memory_address(self: *const Channel, MA: u32) void {
        const current_en = self.ch_cluster.CR.read().EN;

        // disables the channel before configuring a new value for count
        self.ch_cluster.CR.modify_one("EN", 0);
        self.ch_cluster.MAR = MA;
        self.ch_cluster.CR.modify_one("EN", current_en);
    }

    /// Changes the number of transfers.
    ///
    /// NOTE: this function temporarily disables the channel
    pub fn set_count(self: *const Channel, count: u16) void {
        const current_en = self.ch_cluster.CR.read().EN;

        // disables the channel before configuring a new value for count
        self.ch_cluster.CR.modify_one("EN", 0);
        self.ch_cluster.NDTR.modify_one("NDT", count);
        self.ch_cluster.CR.modify_one("EN", current_en);
    }

    /// Reads the number of remaining transfers.
    /// 0 == DMA has finished all transfers.
    pub inline fn channel_remain_count(self: *const Channel) u16 {
        return self.ch_cluster.NDTR.read().NDT;
    }
};
