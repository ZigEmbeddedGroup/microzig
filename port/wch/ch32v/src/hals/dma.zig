//!
//! This file implements the I²C driver for the CH32V chip family
//!
//! Reference: CH32V20x Reference Manual Section on DMA (Chapter 11)
//!
//!
const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const mdf = microzig.drivers;
const drivers = mdf.base;
const hal = microzig.hal;

const DMA1 = microzig.chip.peripherals.DMA1;
const DMA2 = microzig.chip.peripherals.DMA2;
const DmaRegs = microzig.chip.types.peripherals.DMA1;

// TODO: There are two DMA peripherals and a different number of channels
// available. Further, some registers are shared between channels e.g. INTR and
// INTFR.
pub const Regs = extern struct {
    // TODO: Use microzig.chip.types instead of TypeOf
    INTFR: *volatile @TypeOf(DMA1.INTFR),
    INTFCR: *volatile @TypeOf(DMA1.INTFCR),
    CFGR: *volatile @TypeOf(DMA1.CFGR1),
    CNTR: *volatile @TypeOf(DMA1.CNTR1),
    PADDR: *volatile @TypeOf(DMA1.PADDR1),
    MADDR: *volatile @TypeOf(DMA1.MADDR1),
};

// TODO: Maybe this should return a struct of volatile pointers, rather than a
// pointer to a struct.
// If so, we could statically allocate all of them and just return a pointer to
// the appropriate one and ensure that the unused ones don't make it into the
// binary.
pub inline fn get_regs(dma: DMA, chan: Channel) Regs {
    // TODO: Maybe get the name of the decl from the dma and channel for each
    // register and then get the address of each. This would force this to be
    // done at comptime probably.
    // NOTE: Just hardcoding for experimentation at the moment.
    _ = dma;
    _ = chan;
    return .{
        .INTFR = &DMA1.INTFR,
        .INTFCR = &DMA1.INTFCR,
        .CFGR = @ptrCast(&DMA1.CFGR4),
        .CNTR = @ptrCast(&DMA1.CNTR4),
        .PADDR = @ptrCast(&DMA1.PADDR4),
        .MADDR = @ptrCast(&DMA1.MADDR4),
    };
}

// Max transfer: 65535 bytes
// Each channel has 3 DMA data transfer modes:
// Peripheral to memory (MEM2MEM=0, DIR=0)
// Memory to peripheral (MEM2MEM=0, DIR=1)
// Memory to memory (MEM2MEM=1)
// The configuration process is as follows:
// 1. Set the initial address of the peripheral register or the memory data
//    address in the memory-to-memory mode (MEM2MEM=1) in the DMA_PADDRx
//    register. When a DMA request occurs, this address will be the source or
//    destination address of the data transmission.
// 2. Set the memory data address in the DMA_MADDRx register. When a DMA
//    request occurs, the transmitted data will be read from or written to this
//    address.
// 3. Set the number of data to be transmitted in the DMA_CNTRx register. After
//    each data transmission, this value will decrease progressively.
// 4. Set the channel priority through the PL[1:0] bits in the DMA_CFGRx
//    register.
// 5. In the DMA_CFGRx register, set the direction of data transmission, cycle
//    mode, incremental mode of peripheral and memory, data width of peripheral
//    and memory, DMA Half Transfer, DMA Transfer complete, and tDMA Transfer
//    Error interrupt enable bit,
// 6. Set the ENABLE bit in the DMA_CCRx register to enable channel x.
//
// When the application program queries the status of the DMA channel, it
// firstly accesses the GIFx bit in the DMA_INTFR register to determine which
// channel currently has a DMA event, and then process the specific DMA event
// content of the channel.
//
// Certain channels can write to certain peripherals
//
// Registers: (Format: DMAy_REGx, where y is the DMA and x is the channel)
// - DMAy_INTFR - Interrupt flag register
// - DMAy_INTFCR - Interrupt flag clear register (WO)
// - DMAy_CFGRx - Configuration register
// - DMAy_CNTRx - Transferred data register
// - DMAy_PADDRx - Peripheral address register
// - DMAy_MADDRx - Memory address register
//
// Extra features or modes we could support:
// - Cycle mode: Set DMA_CFGRx's CIRC bit to 1
// - Interrupts
// - Half transfer: Set the HTIFx bit in DMA_INTFR. If HTIE is set in the
//   DMA_CCRx register, an interrupt is generated
// - Transfer complete: Set TCIFx bit in the corresponding DMA_INTFR. If TCIE
//   is set in the DMA_CCRx register, an interrupt is generated.
// - Set the TEIFx bit in the corresponding DMA_INTFR register by the hardware.
//   Reading and writing a reserved address area results in a DMA transmission
//   error. Meanwhile, the module address/data Target: address/data Transfer
//   operation hardware automatically clears the EN bit in the DMA_CCRx
//   register corresponding to the channel where the error is generated, and
//   the channel is switched off. If TEIE is set in the DMA_CCRx register, an
//   interrupt is generated.

// TODO: Maybe rename to TransferConfig
pub const Config = struct {
    direction: enum { Mem2Mem, Mem2Periph, Periph2Mem },
    priority: enum(u2) { Low = 0, Medium = 1, High = 2, VeryHigh = 3 },
    // TODO: Better type? anypointer?
    memory_increment: bool = true,
    peripheral_increment: bool = false,
    memory_data_size: DataSize = .Byte,
    peripheral_data_size: DataSize = .Byte,
    circular_mode: bool = false,
};
const DataSize = enum { Byte, HalfWord, Word };

pub const DMA = enum(u1) {
    DMA1 = 0,
    DMA2 = 1,
    pub fn channel(comptime dma: DMA, n: u4) Channel {
        const num_channels = switch (dma) {
            .DMA1 => 7,
            .DMA2 => 11,
        };
        assert(n < num_channels);

        return @enumFromInt(n);
    }
};

// TODO: Chip support. ch32v20x only has one DMA?
// TODO: Different DMAs have different numbers of channels
pub const Channel = enum(u3) {
    // TODO: Maybe have the channel know which dma it belongs to.
    _,
    pub fn setup_transfer(
        chan: Channel,
        comptime dma: DMA,
        comptime config: Config,
        write: []u8,
        read: []u8,
    ) void {
        // TODO: Fancy get regs that selects the appropriate set of regs for the CHANNEL?
        const regs = get_regs(dma, chan);
        // Enable clocks
        // Maybe this should be done explicitly by the client, outside of this hal?
        hal.clocks.enable_peripheral_clock(switch (dma) {
            .DMA1 => .DMA1,
            .DMA2 => .DMA2,
        });

        // Disable channel before reconfiguration
        regs.CFGR.modify(.{ .EN = 0 });

        // Clear all interrupt flags for this channel. There are four
        // interrupts per channel, so we shift by 4* the channel number.
        regs.INTFCR.write_raw(@as(u32, 0b1111) << ((@intFromEnum(chan) % 7) * 4));

        // TODO: Figure out the type of the read and write
        // Set peripheral address (memory address when in mem-2-mem mode)
        regs.PADDR.write_raw(@intFromPtr(write.ptr));
        // Set memory address
        regs.MADDR.write_raw(@intFromPtr(read.ptr));
        // TODO: Set the amount of data to write
        regs.CNTR.write_raw(read.len);
        // TODO: Set the priority
        regs.CFGR.modify(.{ .PL = @intFromEnum(config.priority) });
        // TODO: Set the rest of the config
        regs.CFGR.modify(.{
            .MEM2MEM = @intFromBool(config.direction == .Mem2Mem),
            .MSIZE = @intFromEnum(config.memory_data_size),
            // TODO: Config
            .MINC = 1,
            .PSIZE = @intFromEnum(config.peripheral_data_size),
            // TODO: Config
            .PINC = 1,
            .CIRC = 0,
            // Memory to peripheral or peripheral to memory
            .DIR = 1,
            // TODO: Interrupts
            .TEIE = 0,
            .HTIE = 0,
            .TCIE = 0,
        });
        // Set enable to initiate transfer
        regs.CFGR.modify(.{ .EN = 1 });
    }

    pub fn is_busy(chan: Channel) bool {
        // TODO: Need the channel
        const regs = get_regs(.DMA1, chan);
        return regs.INTFR.read().TCIF4 == 0;
    }

    pub fn wait_for_finish_blocking(chan: Channel) void {
        while (chan.is_busy()) {
            asm volatile ("" ::: .{ .memory = true });
        }
    }

    // Other methods that might be nice:
    // is_complete
    // get_remaining_count
    // get_flags
    // clear_flags
    // wait_for_finish_timeout
    // set_memory_address
    // set_preipheral_address
    // set_count
    // stop
    // deinit
};
