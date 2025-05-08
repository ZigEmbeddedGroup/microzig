const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const DMA = microzig.chip.peripherals.DMA;
pub const Dreq = microzig.chip.types.peripherals.DMA.Dreq;
pub const DataSize = microzig.chip.types.peripherals.DMA.DataSize;

const chip = @import("compatibility.zig").chip;

const hw = @import("hw.zig");

const num_channels = switch (chip) {
    .RP2040 => 12,
    .RP2350 => 16,
};
var claimed_channels = microzig.concurrency.AtomicStaticBitSet(num_channels){};
const MaskType = std.meta.Int(.unsigned, num_channels);

pub fn channel(n: u4) Channel {
    assert(n < num_channels);

    return @enumFromInt(n);
}

pub fn claim_unused_channel() ?Channel {
    const ch = claimed_channels.set_first_available() catch {
        return null;
    };
    return channel(@intCast(ch));
}

pub fn multi_channel_trigger(channels: []const Channel) void {
    var value: MaskType = 0;

    for (channels) |chan| {
        value |= chan.mask();
    }

    DMA.MULTI_CHAN_TRIGGER.write(.{
        .MULTI_CHAN_TRIGGER = value,
    });
}

pub const DMA_ReadTarget = struct {
    dreq: Dreq,
    addr: u32,
};

pub const DMA_WriteTarget = struct {
    dreq: Dreq,
    addr: u32,
};

pub const ChannelError = error{AlreadyClaimed};

pub const Channel = enum(u4) {
    _,

    pub fn claim(chan: Channel) ChannelError!void {
        if (!claimed_channels.set(@intFromEnum(chan)))
            return ChannelError.AlreadyClaimed;
    }

    pub fn unclaim(chan: Channel) void {
        const result = claimed_channels.reset(@intFromEnum(chan));
        std.debug.assert(result);
    }

    pub fn is_claimed(chan: Channel) bool {
        return claimed_channels.test_bit(@intFromEnum(chan)) == 1;
    }

    pub fn mask(chan: Channel) MaskType {
        return @as(MaskType, 1) << @intFromEnum(chan);
    }

    const Regs = extern struct {
        read_addr: u32,
        write_addr: u32,
        trans_count: u32,
        ctrl_trig: @TypeOf(DMA.CH0_CTRL_TRIG),

        // alias 1
        al1_ctrl: @TypeOf(DMA.CH0_CTRL_TRIG),
        al1_read_addr: u32,
        al1_write_addr: u32,
        al1_trans_count_trig: u32,

        // alias 2
        al2_ctrl: @TypeOf(DMA.CH0_CTRL_TRIG),
        al2_trans_count: u32,
        al2_read_addr: u32,
        al2_write_addr_trig: u32,

        // alias 3
        al3_ctrl: @TypeOf(DMA.CH0_CTRL_TRIG),
        al3_write_addr: u32,
        al3_trans_count: u32,
        al3_read_addr_trig: u32,
    };

    fn get_regs(chan: Channel) *volatile Regs {
        const regs = @as(*volatile [num_channels]Regs, @ptrCast(&DMA.CH0_READ_ADDR));
        return &regs[@intFromEnum(chan)];
    }

    pub const TransferConfig = struct {
        trigger: bool = true,
        data_size: DataSize,
        enable: bool,
        read_increment: bool,
        write_increment: bool,
        dreq: Dreq,

        // TODO:
        // chain to
        // ring
        // byte swapping
    };

    pub fn setup_transfer_raw(
        chan: Channel,
        write_addr: u32,
        read_addr: u32,
        count: u32,
        config: TransferConfig,
    ) void {
        const regs = chan.get_regs();
        regs.read_addr = read_addr;
        regs.write_addr = write_addr;
        regs.trans_count = count;
        if (config.trigger) {
            regs.ctrl_trig.modify(.{
                .EN = @intFromBool(config.enable),
                .DATA_SIZE = config.data_size,
                .INCR_READ = @intFromBool(config.read_increment),
                .INCR_WRITE = @intFromBool(config.write_increment),
                .TREQ_SEL = config.dreq,
            });
        } else {
            regs.al1_ctrl.modify(.{
                .EN = @intFromBool(config.enable),
                .DATA_SIZE = config.data_size,
                .INCR_READ = @intFromBool(config.read_increment),
                .INCR_WRITE = @intFromBool(config.write_increment),
                .TREQ_SEL = config.dreq,
            });
        }
    }

    pub const SetupTransferConfig = struct {
        trigger: bool = false,
        enable: bool,
    };

    pub fn setup_transfer(
        chan: Channel,
        write: anytype,
        read: anytype,
        config: SetupTransferConfig,
    ) !void {
        const H = struct {
            fn is_peripheral(Type: type) bool {
                return Type == DMA_ReadTarget or Type == DMA_WriteTarget;
            }

            fn validate_type(Type: type) void {
                const Info = @typeInfo(Type);
                switch (Info) {
                    .@"struct" => {
                        if (!is_peripheral(Type))
                            @compileError("only peripherals and pointers are supported");
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
                    .@"struct" => {
                        return value.addr;
                    },
                    .pointer => {
                        return @intFromPtr(value);
                    },
                    else => comptime unreachable,
                }
            }

            inline fn get_dreq(value: anytype) Dreq {
                const Type = @TypeOf(value);
                const Info = @typeInfo(Type);
                switch (Info) {
                    .@"struct" => {
                        return value.dreq;
                    },
                    .pointer => {
                        return .permanent;
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
                                .array => |array| {
                                    return array.len;
                                },
                                else => return 1,
                            },
                            .many, .slice => return value.len,
                            .c => unreachable,
                        }
                    },
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
                    else => comptime if (is_peripheral(Type)) false else unreachable,
                };
            }

            fn type_to_data_size(Type: type) ?DataSize {
                return switch (Type) {
                    u8, i8 => .size_8,
                    u16, i16 => .size_16,
                    u32, i32 => .size_32,
                    else => null,
                };
            }

            fn get_data_size(Type: type) ?DataSize {
                // at this point we are guarnteed that we have pointer type
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
            @compileError("cross peripheral dma is unsupported");

        const data_size = comptime if (H.is_peripheral(WriteType))
            H.get_data_size(ReadType).?
        else
            H.get_data_size(WriteType).?;

        const dreq = if (comptime H.is_peripheral(WriteType)) H.get_dreq(write) else H.get_dreq(read);

        const count = blk: {
            if (comptime H.is_peripheral(WriteType))
                break :blk H.get_count(read)
            else if (comptime H.is_peripheral(ReadType))
                break :blk H.get_count(write)
            else {
                const write_count = H.get_count(write);
                const read_count = H.get_count(read);

                // OPTIMIZATION: do this check at comptime, so we can avoid the read_count call
                if (read_count == 1) // handle memset
                    break :blk write_count
                else if (read_count == write_count)
                    break :blk read_count
                else
                    return error.LengthMismatch;
            }
        };

        std.log.warn("channel: {}, write_addr: {} read_addr: {} dreq: {s} count: {} data_size: {}", .{
            chan,
            write_addr,
            read_addr,
            @tagName(dreq),
            count,
            data_size,
        });

        chan.setup_transfer_raw(
            write_addr,
            read_addr,
            count,
            .{
                .trigger = config.trigger,
                .enable = config.enable,
                .read_increment = comptime H.get_increment(ReadType),
                .write_increment = comptime H.get_increment(WriteType),
                .data_size = data_size,
                .dreq = dreq,
            },
        );
        //
    }

    pub fn set_irq0_enabled(chan: Channel, enabled: bool) void {
        if (enabled) {
            const inte0_set = hw.set_alias_raw(&DMA.INTE0);
            inte0_set.* = @as(u32, 1) << @intFromEnum(chan);
        } else {
            const inte0_clear = hw.clear_alias_raw(&DMA.INTE0);
            inte0_clear.* = @as(u32, 1) << @intFromEnum(chan);
        }
    }

    pub fn acknowledge_irq0(chan: Channel) void {
        const ints0_set = hw.set_alias_raw(&DMA.INTS0);
        ints0_set.* = @as(u32, 1) << @intFromEnum(chan);
    }

    pub fn is_busy(chan: Channel) bool {
        const regs = chan.get_regs();
        return regs.ctrl_trig.read().BUSY == 1;
    }

    pub fn wait_for_finish_blocking(chan: Channel) void {
        while (chan.is_busy()) {
            hw.tight_loop_contents();
        }
    }
};
