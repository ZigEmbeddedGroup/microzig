// The current bdma-v1 does not include the DMA channel cluster in the DMA struct
// This is due to the way embassy represent cluster in the json definition.
// We need to fix this in the embassy gen from regz.
const std = @import("std");
const microzig = @import("microzig");
const util = @import("../common/util.zig");
const dma_common = @import("dma_common.zig");
pub const Instances = @import("./enums.zig").DMA_V1_Type;

const hal = microzig.hal;
const DMA_Peripheral = microzig.chip.types.peripherals.bdma_v1.DMA;

fn get_regs(comptime instance: Instances) *volatile DMA_Peripheral {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

pub const Error = error{
    BufferOverflow,
};

pub const ChannelNumber = enum(u3) {
    Channel1,
    Channel2,
    Channel3,
    Channel4,
    Channel5,
    Channel6,
    Channel7,
};

pub const Channel = dma_common.Channel;
pub const ChannelEvent = dma_common.ChannelEvent;

// Buffer place in region that is accesssible to DMA
// There is 14 channel max.
const countDmaChannel = microzig.chip.properties.dma_channel_count orelse 14;

var dma_buffer: [countDmaChannel * 100]u8 linksection(".dma_buffer") = undefined;

const DMA1_InteruptName = .{
    "DMA1_Channel1",
    "DMA1_Channel2",
    "DMA1_Channel3",
    "DMA1_Channel4",
    "DMA1_Channel5",
    "DMA1_Channel6",
    "DMA1_Channel7",
};

const DMA2_InteruptName = .{
    "DMA2_Channel1",
    "DMA2_Channel2",
    "DMA2_Channel3",
    "DMA2_Channel4",
    "DMA2_Channel5",
    "DMA2_Channel6",
    "DMA2_Channel7",
};

const DMA_InterputName = .{
    DMA1_InteruptName,
    DMA2_InteruptName,
};

pub fn DMA(comptime dma_ctrl: Instances, comptime ch: ChannelNumber) type {
    const reg_dma = get_regs(dma_ctrl);

    const buffer_idx = (@intFromEnum(dma_ctrl) - 1) * 7 + @intFromEnum(ch);
    const start = buffer_idx * 100;

    // Here we are not able to use comptimeFmt since it will introduce dependency loop
    // due to std_options.
    const interrupt_name = DMA_InterputName[@intFromEnum(dma_ctrl) - 1][@intFromEnum(ch)];
    const interrupt_index = blk: for (microzig.chip.interrupts) |*interrupt| {
        if (std.mem.eql(u8, interrupt_name, interrupt.name)) {
            break :blk interrupt.index;
        }
    } else @panic("Interrupt index not found");

    return struct {
        var channel: ?Channel = null;

        pub fn DMA_Handler() callconv(.c) void {
            const event = read_events();
            clear_events(event);
            if (channel) |*init_chan| {
                init_chan.deliver_event(event);
            }
        }

        pub fn clear_events(events: ChannelEvent) void {
            const ch_evt_idx: u5 = 4 * @as(u5, @intCast(@intFromEnum(ch)));
            const bits: u32 = @as(u4, @bitCast(events));
            reg_dma.IFCR.raw |= (bits & 0xF) << ch_evt_idx;
        }

        pub fn read_events() ChannelEvent {
            const ch_evt_idx: u5 = 4 * @as(u5, @intCast(@intFromEnum(ch)));
            return @bitCast(@as(u4, @truncate(reg_dma.ISR.raw >> ch_evt_idx)));
        }

        pub fn enable_interrupt() void {
            if (microzig.cpu.using_ram_vector_table) {
                @field(microzig.cpu.ram_vector_table, interrupt_name) = .{ .c = DMA_Handler };
            } else {
                const vector_table: *microzig.cpu.VectorTable = @ptrFromInt(0x0);
                std.debug.assert(@field(vector_table, interrupt_name).* == @intFromPtr(&DMA_Handler));
            }
            microzig.interrupt.enable(@as(microzig.cpu.ExternalInterrupt, @enumFromInt(interrupt_index)));
        }

        pub fn get_channel() *Channel {
            if (channel) |*init_ch| {
                return init_ch;
            }
            hal.rcc.enable_dma(dma_ctrl);
            const channel_base: usize = @intFromPtr(reg_dma) + 0x8 + (20 * @as(usize, @intFromEnum(ch)));

            channel = Channel{
                .reg_channel = @ptrFromInt(channel_base),
                .in_progress = false,
                .dma_buffer = dma_buffer[start..][0..100],
            };
            return &channel.?;
        }
    };
}
