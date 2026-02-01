//!
//! DMA HAL for the CH32V chip family (CH32V20x)
//!
//! Reference: CH32V20x Reference Manual, DMA (Chapter 11)
//!
//!
const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const mdf = microzig.drivers;
const drivers = mdf.base;
const hal = microzig.hal;

const DMA1 = microzig.chip.peripherals.DMA1;
const DMA_Regs = microzig.chip.types.peripherals.DMA1;

// TODO: There are two DMA peripherals and a different number of channels
// available. Further, some registers are shared between channels e.g. INTR and
// INTFR.
pub const Regs = extern struct {
    INTFR: *volatile @FieldType(DMA_Regs, "INTFR"),
    INTFCR: *volatile @FieldType(DMA_Regs, "INTFCR"),
    CFGR: *volatile @FieldType(DMA_Regs, "CFGR1"),
    CNTR: *volatile @FieldType(DMA_Regs, "CNTR1"),
    PADDR: *volatile @FieldType(DMA_Regs, "PADDR1"),
    MADDR: *volatile @FieldType(DMA_Regs, "MADDR1"),
};

/// Represents a peripheral register for DMA transfers
/// Use this when transferring to/from a peripheral register
pub const PeripheralTarget = struct {
    addr: u32,
};

pub const Priority = enum(u2) { Low = 0, Medium = 1, High = 2, VeryHigh = 3 };

pub const TransferConfig = struct {
    priority: Priority = .Medium,
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
        regs.INTFCR.raw = @as(u32, 0b1111) << flag_shift;

        // NOTE: DIR bit affects transfer direction even in MEM2MEM mode (undocumented behavior):
        // - Always place the peripheral address in PADDR when a peripheral is involved.
        // - DIR selects the data flow between registers:
        //     DIR=0: PADDR → MADDR (source=PADDR, dest=MADDR)
        //     DIR=1: MADDR → PADDR (source=MADDR, dest=PADDR)
        // - We choose the following mapping for clarity/alignment of increments:
        //     Mem→Periph:  MADDR=read (memory),  PADDR=write (periph), DIR=1
        //     Periph→Mem:  PADDR=read (periph),  MADDR=write (memory), DIR=0
        //     Mem→Mem:     PADDR=read (source),  MADDR=write (dest),   DIR=0
        if (H.is_peripheral(WriteType)) {
            regs.MADDR.raw = read_addr;
            regs.PADDR.raw = write_addr;
        } else {
            regs.MADDR.raw = write_addr;
            regs.PADDR.raw = read_addr;
        }
        // Set the amount of data to transfer
        regs.CNTR.raw = count;
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
            // DIR applies in all modes. Set DIR=1 only for Mem→Periph (MADDR→PADDR);
            // use DIR=0 for Periph→Mem and Mem→Mem (PADDR→MADDR).
            .DIR = if (direction == .Mem2Periph) 1 else 0,
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
        // Why not use the underlying struct?
        regs.INTFCR.raw = @as(u32, 0b0010) << flag_shift; // Clear only TCIF
    }

    pub fn get_remaining_count(comptime chan: Channel) u16 {
        const regs = chan.get_regs();
        return regs.CNTR.read().NDT;
    }
};

/// DMA peripheral mapping for CH32V203
/// Based on CH32V20x Reference Manual DMA Request Mapping Table
pub const Peripheral = enum {
    // I2C
    I2C1_TX,
    I2C1_RX,
    I2C2_TX,
    I2C2_RX,

    // SPI
    SPI1_RX,
    SPI1_TX,
    SPI2_TX,

    // USART (uncomment when UART HAL gets DMA support)
    // USART1_TX,
    // USART1_RX,
    // USART2_TX,
    // USART2_RX,
    // USART3_TX,
    // USART3_RX,
    // USART4_RX,
    // USART4_TX,
    // USART5_RX,
    // USART5_TX,
    // USART6_TX,
    // USART6_RX,

    // ADC (uncomment when ADC HAL gets DMA support)
    // ADC1,

    // Timers (uncomment when Timer HAL gets DMA support)
    // TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, TIM1_UP, TIM1_TRIG, TIM1_COM,
    // TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, TIM2_UP,
    // TIM3_CH1, TIM3_CH3, TIM3_CH4, TIM3_UP, TIM3_TRIG,
    // TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_UP,
    // TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, TIM5_UP, TIM5_TRIG,
    // TIM6_UP, TIM7_UP,
    // TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, TIM8_UP, TIM8_TRIG, TIM8_COM,
    // TIM9_UP, TIM9_CH1,
    // TIM10_CH4, TIM10_TRIG, TIM10_COM,

    // DAC (uncomment when DAC HAL gets DMA support)
    // DAC1, DAC2,

    // SDIO (uncomment when SDIO HAL gets DMA support)
    // SDIO,

    /// Get valid DMA channels for this peripheral (compile-time)
    /// Returns a slice of valid channels from TRM mapping table
    pub fn get_valid_channels(comptime self: Peripheral) []const Channel {
        return comptime switch (self) {
            // I2C mappings from CH32V203 TRM Table 11-1
            .I2C1_TX => &[_]Channel{.Ch6},
            .I2C1_RX => &[_]Channel{.Ch7},
            .I2C2_TX => &[_]Channel{.Ch4},
            .I2C2_RX => &[_]Channel{.Ch5},

            // SPI mappings from CH32V203 TRM Table 11-1
            .SPI1_RX => &[_]Channel{.Ch2},
            .SPI1_TX => &[_]Channel{.Ch3},
            .SPI2_TX => &[_]Channel{.Ch5},

            // NOTE: Add mappings here when adding support for new peripherals and uncommenting
            // enums above
            // .USART1_TX => &[_]Channel{.Ch4},
            // .USART1_RX => &[_]Channel{.Ch5},
            // .USART2_TX => &[_]Channel{.Ch7},
            // .USART2_RX => &[_]Channel{.Ch6},
            // .ADC1 => &[_]Channel{.Ch1},
            // etc...
        };
    }

    /// Validate that a channel is valid for this peripheral (testable)
    /// Returns error.InvalidChannel if the combination is invalid.
    pub fn validate_channel(
        comptime self: Peripheral,
        comptime channel: Channel,
    ) error{InvalidChannel}!void {
        const is_valid = comptime blk: {
            const valid_channels = self.get_valid_channels();
            for (valid_channels) |valid_ch| {
                if (valid_ch == channel) break :blk true;
            }
            break :blk false;
        };

        if (!is_valid) return error.InvalidChannel;
    }

    /// Validate that a channel is valid for this peripheral (compile-time)
    /// Generates helpful compile error if the combination is invalid.
    pub fn ensure_compatible_with(comptime self: Peripheral, comptime channel: Channel) void {
        self.validate_channel(channel) catch {
            // Build helpful error message showing valid options
            const valid_channels = comptime self.get_valid_channels();

            // Build list of valid channel names
            comptime var channel_list: []const u8 = "";
            inline for (valid_channels, 0..) |valid_ch, i| {
                if (i > 0) channel_list = channel_list ++ ", ";
                channel_list = channel_list ++ @tagName(valid_ch);
            }

            const msg = comptime std.fmt.comptimePrint(
                "DMA Channel {s} is not valid for {s}. Valid channels: [{s}]",
                .{ @tagName(channel), @tagName(self), channel_list },
            );

            @compileError(msg);
        };
    }
};

// ============================================================================
// Tests
// ============================================================================

test "Peripheral - valid I2C channels" {
    // I2C1 valid channels
    try Peripheral.I2C1_TX.validate_channel(.Ch6);
    try Peripheral.I2C1_RX.validate_channel(.Ch7);

    // I2C2 valid channels
    try Peripheral.I2C2_TX.validate_channel(.Ch4);
    try Peripheral.I2C2_RX.validate_channel(.Ch5);
}

test "Peripheral - invalid I2C channels" {
    // I2C1 TX invalid channels
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_TX.validate_channel(.Ch1));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_TX.validate_channel(.Ch2));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_TX.validate_channel(.Ch3));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_TX.validate_channel(.Ch4));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_TX.validate_channel(.Ch5));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_TX.validate_channel(.Ch7));

    // I2C1 RX invalid channels
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_RX.validate_channel(.Ch1));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C1_RX.validate_channel(.Ch6));

    // I2C2 TX invalid channels
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C2_TX.validate_channel(.Ch1));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C2_TX.validate_channel(.Ch5));

    // I2C2 RX invalid channels
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C2_RX.validate_channel(.Ch1));
    try std.testing.expectError(error.InvalidChannel, Peripheral.I2C2_RX.validate_channel(.Ch4));
}

test "Peripheral - get_valid_channels returns correct slices" {
    // I2C1 TX should return only Ch6
    const i2c1_tx_channels = Peripheral.I2C1_TX.get_valid_channels();
    try std.testing.expectEqual(@as(usize, 1), i2c1_tx_channels.len);
    try std.testing.expectEqual(Channel.Ch6, i2c1_tx_channels[0]);

    // I2C1 RX should return only Ch7
    const i2c1_rx_channels = Peripheral.I2C1_RX.get_valid_channels();
    try std.testing.expectEqual(@as(usize, 1), i2c1_rx_channels.len);
    try std.testing.expectEqual(Channel.Ch7, i2c1_rx_channels[0]);

    // I2C2 TX should return only Ch4
    const i2c2_tx_channels = Peripheral.I2C2_TX.get_valid_channels();
    try std.testing.expectEqual(@as(usize, 1), i2c2_tx_channels.len);
    try std.testing.expectEqual(Channel.Ch4, i2c2_tx_channels[0]);

    // I2C2 RX should return only Ch5
    const i2c2_rx_channels = Peripheral.I2C2_RX.get_valid_channels();
    try std.testing.expectEqual(@as(usize, 1), i2c2_rx_channels.len);
    try std.testing.expectEqual(Channel.Ch5, i2c2_rx_channels[0]);
}
