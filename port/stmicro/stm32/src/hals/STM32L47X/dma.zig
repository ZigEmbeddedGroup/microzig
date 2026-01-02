const dma = @import("../common/bdma_v2.zig");
pub const Channel = dma.Channel;
pub const ChannelEvent = dma.ChannelEvent;
pub const ChannelNumber = dma.ChannelNumber;
pub const DMA1_Channel1 = dma.DMA(.DMA1, .Channel1);
pub const DMA1_Channel2 = dma.DMA(.DMA1, .Channel2);
pub const DMA1_Channel3 = dma.DMA(.DMA1, .Channel3);
pub const DMA1_Channel4 = dma.DMA(.DMA1, .Channel4);
pub const DMA1_Channel5 = dma.DMA(.DMA1, .Channel5);
pub const DMA1_Channel6 = dma.DMA(.DMA1, .Channel6);
pub const DMA1_Channel7 = dma.DMA(.DMA1, .Channel7);

pub const DMA2_Channel1 = dma.DMA(.DMA2, .Channel1);
pub const DMA2_Channel2 = dma.DMA(.DMA2, .Channel2);
pub const DMA2_Channel3 = dma.DMA(.DMA2, .Channel3);
pub const DMA2_Channel4 = dma.DMA(.DMA2, .Channel4);
pub const DMA2_Channel5 = dma.DMA(.DMA2, .Channel5);
