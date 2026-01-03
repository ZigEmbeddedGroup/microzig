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

/// Represents a peripheral register for DMA transfers
/// Use this when transferring to/from a peripheral register
pub const PeripheralTarget = struct {
    addr: u32,
};

pub const TransferConfig = struct {
    priority: enum(u2) { Low = 0, Medium = 1, High = 2, VeryHigh = 3 } = .Medium,
    // AKA cycle mode. NOTE: When set, the transfer will never complete and will need to be stopped
    // manually.
    // Also note that this mode is not supported in Mem2Mem mode
    circular_mode: bool = false,
};
pub const DataSize = enum(u2) { Byte = 0, HalfWord = 1, Word = 2 };

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

    /// Setup a DMA transfer with automatic type detection
    /// - write: destination (can be slice, array pointer, single pointer, or PeripheralTarget)
    /// - read: source (can be slice, array pointer, single pointer, or PeripheralTarget)
    pub fn setup_transfer(
        comptime chan: Channel,
        write: anytype,
        read: anytype,
        comptime config: TransferConfig,
    ) void {
        // Helper functions for type introspection
        const H = struct {
            fn is_peripheral(Type: type) bool {
                return Type == PeripheralTarget;
            }

            fn validate_type(Type: type) void {
                const Info = @typeInfo(Type);
                switch (Info) {
                    .@"struct" => {
                        if (!is_peripheral(Type))
                            @compileError("only PeripheralTarget and pointers are supported");
                    },
                    .pointer => {
                        if (get_data_size(Type) == null)
                            @compileError("only pointers/slices/arrays of u8/u16/u32 are supported");
                    },
                    else => @compileError(std.fmt.comptimePrint("unsupported type {}", .{Type})),
                }
            }

            inline fn get_addr(value: anytype) u32 {
                const Type = @TypeOf(value);
                const Info = @typeInfo(Type);
                switch (Info) {
                    .@"struct" => return value.addr,
                    .pointer => |ptr| {
                        switch (ptr.size) {
                            .slice, .many => return @intFromPtr(value.ptr),
                            .one => return @intFromPtr(value),
                            else => comptime unreachable,
                        }
                    },
                    else => comptime unreachable,
                }
            }

            inline fn get_count(value: anytype) u32 {
                const Type = @TypeOf(value);
                const Info = @typeInfo(Type);
                switch (Info) {
                    .pointer => |ptr| {
                        switch (ptr.size) {
                            .one => switch (@typeInfo(ptr.child)) {
                                .array => |array| return array.len,
                                else => return 1,
                            },
                            .many, .slice => return value.len,
                            .c => unreachable,
                        }
                    },
                    .@"struct" => return 1, // Peripheral is single register
                    else => unreachable,
                }
            }

            inline fn get_increment(Type: type) bool {
                const Info = @typeInfo(Type);
                return switch (Info) {
                    .pointer => |ptr| switch (ptr.size) {
                        .one => switch (@typeInfo(ptr.child)) {
                            .array => true,
                            else => false,
                        },
                        .many, .slice => true,
                        .c => unreachable,
                    },
                    .@"struct" => false, // Peripheral doesn't increment
                    else => unreachable,
                };
            }

            fn type_to_data_size(Type: type) ?DataSize {
                return switch (Type) {
                    u8, i8 => .Byte,
                    u16, i16 => .HalfWord,
                    u32, i32 => .Word,
                    else => null,
                };
            }

            fn get_data_size(Type: type) ?DataSize {
                const Info = @typeInfo(Type);
                const ChildType = Info.pointer.child;
                return switch (@typeInfo(ChildType)) {
                    .array => |array| type_to_data_size(array.child),
                    .int => type_to_data_size(ChildType),
                    else => null,
                };
            }
        };

        const WriteType = @TypeOf(write);
        const ReadType = @TypeOf(read);

        comptime H.validate_type(WriteType);
        comptime H.validate_type(ReadType);

        const write_addr = H.get_addr(write);
        const read_addr = H.get_addr(read);

        comptime if (H.is_peripheral(ReadType) and H.is_peripheral(WriteType))
            @compileError("peripheral-to-peripheral DMA is unsupported");

        const data_size = comptime if (H.is_peripheral(WriteType))
            H.get_data_size(ReadType).?
        else
            H.get_data_size(WriteType).?;

        const count = blk: {
            if (comptime H.is_peripheral(WriteType))
                break :blk H.get_count(read)
            else
                break :blk H.get_count(write);
        };

        const direction: enum { Mem2Mem, Mem2Periph, Periph2Mem } = comptime blk: {
            if (H.is_peripheral(WriteType)) break :blk .Mem2Periph;
            if (H.is_peripheral(ReadType)) break :blk .Periph2Mem;
            break :blk .Mem2Mem;
        };

        const memory_increment = comptime if (H.is_peripheral(WriteType))
            H.get_increment(ReadType)
        else
            H.get_increment(WriteType);

        const peripheral_increment = comptime if (H.is_peripheral(WriteType))
            H.get_increment(WriteType)
        else
            H.get_increment(ReadType);

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
        regs.MADDR.write_raw(read_addr); // source
        regs.PADDR.write_raw(write_addr); // destination
        // Set the amount of data to transfer
        regs.CNTR.write_raw(count);
        // Set the priority
        regs.CFGR.modify(.{ .PL = @intFromEnum(config.priority) });
        // Set the rest of the config
        regs.CFGR.modify(.{
            .MEM2MEM = @intFromBool(direction == .Mem2Mem),
            .MSIZE = @intFromEnum(data_size),
            .MINC = @intFromBool(memory_increment),
            .PSIZE = @intFromEnum(data_size),
            .PINC = @intFromBool(peripheral_increment),
            .CIRC = @intFromBool(config.circular_mode),
            // DIR affects transfer direction even in MEM2MEM mode (undocumented)
            // DIR=1: MADDR→PADDR, DIR=0: PADDR→MADDR
            .DIR = if (direction == .Periph2Mem) 0 else 1,
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
        const cfg = regs.CFGR.read();

        // Channel must be enabled to be busy
        if (cfg.EN == 0) return false;

        // In circular mode, channel is always busy while enabled
        if (cfg.CIRC == 1) return true;

        // In normal mode, check if transfer is complete
        const flag_shift: u5 = (@as(u5, @intFromEnum(chan)) - 1) * 4;
        const tcif_bit: u5 = flag_shift + 1;
        const tcif_mask: u32 = @as(u32, 1) << tcif_bit;
        const tcif = (regs.INTFR.raw & tcif_mask) != 0;

        // Not busy if transfer complete flag is set
        return !tcif;
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

    /// Check if transfer is complete (for non-circular mode)
    /// In circular mode, use has_completed_cycle() instead
    pub fn is_complete(comptime chan: Channel) bool {
        return chan.get_remaining_count() == 0;
    }

    /// Check if a transfer cycle has completed (useful for circular mode)
    /// This flag is set after each cycle in circular mode, or once in normal mode
    pub fn has_completed_cycle(comptime chan: Channel) bool {
        const regs = chan.get_regs();
        const flag_shift: u5 = (@as(u5, @intFromEnum(chan)) - 1) * 4;
        const tcif_bit: u5 = flag_shift + 1;
        const tcif_mask: u32 = @as(u32, 1) << tcif_bit;
        return (regs.INTFR.raw & tcif_mask) != 0;
    }

    /// Clear the transfer complete flag (useful in circular mode to detect next cycle)
    pub fn clear_complete_flag(comptime chan: Channel) void {
        const regs = chan.get_regs();
        const flag_shift: u5 = (@as(u5, @intFromEnum(chan)) - 1) * 4;
        regs.INTFCR.write_raw(@as(u32, 0b0010) << flag_shift); // Clear only TCIF
    }

    pub fn get_remaining_count(comptime chan: Channel) u16 {
        const regs = chan.get_regs();
        return regs.CNTR.read().NDT;
    }
};
