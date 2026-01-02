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
const DmaRegs = microzig.chip.types.peripherals.DMA1;

// TODO: There are two DMA peripherals and a different number of channels
// available. Further, some registers are shared between channels e.g. INTR and
// INTFR.
pub const Regs = extern struct {
    INTFR: *volatile @FieldType(DmaRegs, "INTFR"),
    INTFCR: *volatile @FieldType(DmaRegs, "INTFCR"),
    CFGR: *volatile @FieldType(DmaRegs, "CFGR1"),
    CNTR: *volatile @FieldType(DmaRegs, "CNTR1"),
    PADDR: *volatile @FieldType(DmaRegs, "PADDR1"),
    MADDR: *volatile @FieldType(DmaRegs, "MADDR1"),
};

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

pub const TransferConfig = struct {
    direction: enum { Mem2Mem, Mem2Periph, Periph2Mem },
    priority: enum(u2) { Low = 0, Medium = 1, High = 2, VeryHigh = 3 },
    memory_increment: bool = true,
    peripheral_increment: bool = false,
    memory_data_size: DataSize = .Byte,
    peripheral_data_size: DataSize = .Byte,
    circular_mode: bool = false,
};
const DataSize = enum { Byte, HalfWord, Word };

// TODO: CH32V30x has DMA2 with 11 channels - will need refactoring to support
// For now, CH32V203 only has DMA1 with 7 channels
pub const Channel = enum(u3) {
    Ch1 = 1,
    Ch2 = 2,
    Ch3 = 3,
    Ch4 = 4,
    Ch5 = 5,
    Ch6 = 6,
    Ch7 = 7,
    /// Get the register pointers for a specific DMA channel
    /// Currently supports DMA1 channels 1-7 only (CH32V203)
    pub inline fn get_regs(comptime chan: Channel) Regs {
        const chan_num = @intFromEnum(chan);
        const cfgr_name = std.fmt.comptimePrint("CFGR{d}", .{chan_num});
        const cntr_name = std.fmt.comptimePrint("CNTR{d}", .{chan_num});
        const paddr_name = std.fmt.comptimePrint("PADDR{d}", .{chan_num});
        const maddr_name = std.fmt.comptimePrint("MADDR{d}", .{chan_num});

        return .{
            .INTFR = &DMA1.INTFR, // Shared across all channels
            .INTFCR = &DMA1.INTFCR, // Shared across all channels
            .CFGR = @ptrCast(&@field(DMA1, cfgr_name)),
            .CNTR = @ptrCast(&@field(DMA1, cntr_name)),
            .PADDR = @ptrCast(&@field(DMA1, paddr_name)),
            .MADDR = @ptrCast(&@field(DMA1, maddr_name)),
        };
    }

    pub fn setup_transfer(
        comptime chan: Channel,
        comptime config: TransferConfig,
        write: []u8,
        read: []u8,
    ) void {
        const regs = chan.get_regs();

        // Enable DMA1 clock
        // NOTE: Maybe this should be done explicitly by the client, outside of this hal?
        hal.clocks.enable_peripheral_clock(.DMA1);

        // Disable channel before reconfiguration
        regs.CFGR.modify(.{ .EN = 0 });

        // Clear all interrupt flags for this channel. There are four interrupts per channel, so we
        // shift by 4 * (channel - 1). Channel enum is 1-indexed, so subtract 1 for bit position.
        const flag_shift: u5 = (@as(u5, @intFromEnum(chan)) - 1) * 4;
        regs.INTFCR.write_raw(@as(u32, 0b1111) << flag_shift);

        // NOTE: DIR bit affects transfer direction even in MEM2MEM mode (undocumented behavior):
        //   DIR=0: PADDR→MADDR (peripheral/source to memory/destination)
        //   DIR=1: MADDR→PADDR (memory/source to peripheral/destination)
        // For typical memory copy with DIR=1: MADDR=source, PADDR=destination
        regs.MADDR.write_raw(@intFromPtr(read.ptr)); // source
        regs.PADDR.write_raw(@intFromPtr(write.ptr)); // destination
        // Set the amount of data to write
        regs.CNTR.write_raw(read.len);
        // Set the priority
        regs.CFGR.modify(.{ .PL = @intFromEnum(config.priority) });
        // Set the rest of the config
        regs.CFGR.modify(.{
            .MEM2MEM = @intFromBool(config.direction == .Mem2Mem),
            .MSIZE = @intFromEnum(config.memory_data_size),
            .MINC = @intFromBool(config.memory_increment),
            .PSIZE = @intFromEnum(config.peripheral_data_size),
            .PINC = @intFromBool(config.peripheral_increment),
            .CIRC = @intFromBool(config.circular_mode),
            // DIR affects transfer direction even in MEM2MEM mode (undocumented)
            // DIR=1: MADDR→PADDR, DIR=0: PADDR→MADDR
            .DIR = if (config.direction == .Periph2Mem) 0 else 1,
            // TODO: Add (optional?) support for interrupts
            // Transfer error interrupt
            .TEIE = 0,
            // Half transfer interrupt
            .HTIE = 0,
            // Transfer complete interrupt
            .TCIE = 0,
        });
        // Set enable to initiate transfer
        regs.CFGR.modify(.{ .EN = 1 });
    }

    pub fn is_busy(comptime chan: Channel) bool {
        const regs = chan.get_regs();

        // Each channel has 4 flag bits: GIF, TCIF, HTIF, TEIF
        // TCIF (Transfer Complete) is bit 1 of each 4-bit group
        // Channel is 1-indexed, so subtract 1 for bit position
        const flag_shift: u5 = (@as(u5, @intFromEnum(chan)) - 1) * 4;
        const tcif_bit: u5 = flag_shift + 1;
        const tcif_mask: u32 = @as(u32, 1) << tcif_bit;

        // Busy if transfer NOT complete (TCIF == 0)
        return (regs.INTFR.raw & tcif_mask) == 0;
    }

    pub fn wait_for_finish_blocking(comptime chan: Channel) void {
        while (chan.is_busy()) {
            asm volatile ("" ::: .{ .memory = true });
        }
    }

    pub fn stop(comptime chan: Channel) void {
        const regs = chan.get_regs();
        regs.CFGR.modify(.{ .EN = 0 });
    }

    pub fn is_complete(comptime chan: Channel) bool {
        const regs = chan.get_regs();
        return regs.CNTR.read().NDT == 0;
    }

    // Other methods that might be nice:
    // get_remaining_count
    // get_flags
    // clear_flags
    // wait_for_finish_timeout
    // set_memory_address
    // set_preipheral_address
    // set_count
    // deinit
};
