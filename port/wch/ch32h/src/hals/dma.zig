const microzig = @import("microzig");

const cpu = microzig.cpu;
const clocks = microzig.hal.clocks;

const DMA1 = microzig.chip.peripherals.DMA1;
const DMA2 = microzig.chip.peripherals.DMA2;
const DMAMUX = microzig.chip.peripherals.DMAMUX;
const DmaRegs = microzig.chip.types.peripherals.DMA1;

/// 1-based DMAMUX request input (RM Table 10-2).
/// The register is programmed with `request - 1` (0-based).
pub const Request = enum(u7) {
    TIM1_CH1 = 1,
    TIM1_CH2 = 2,
    TIM1_CH3 = 3,
    TIM1_CH4 = 4,
    TIM1_UP = 5,
    TIM1_COM = 6,
    TIM1_TRIG = 7,
    TIM2_CH1 = 8,
    TIM2_CH2 = 9,
    TIM2_CH3 = 10,
    TIM2_CH4 = 11,
    TIM2_UP = 12,
    TIM2_TRIG = 13,
    TIM3_CH1 = 14,
    TIM3_CH2 = 15,
    TIM3_CH3 = 16,
    TIM3_CH4 = 17,
    TIM3_UP = 18,
    TIM3_TRIG = 19,
    TIM4_CH1 = 20,
    TIM4_CH2 = 21,
    TIM4_CH3 = 22,
    TIM4_CH4 = 23,
    TIM4_UP = 24,
    TIM4_TRIG = 25,
    TIM5_CH1 = 26,
    TIM5_CH2 = 27,
    TIM5_CH3 = 28,
    TIM5_CH4 = 29,
    TIM5_UP = 30,
    TIM5_TRIG = 31,
    TIM8_CH1 = 32,
    TIM8_CH2 = 33,
    TIM8_CH3 = 34,
    TIM8_CH4 = 35,
    TIM8_UP = 36,
    TIM8_COM = 37,
    TIM8_TRIG = 38,
    TIM9_CH1 = 39,
    TIM9_CH2 = 40,
    TIM9_CH3 = 41,
    TIM9_CH4 = 42,
    TIM9_UP = 43,
    TIM9_TRIG = 44,
    TIM10_CH1 = 45,
    TIM10_CH2 = 46,
    TIM10_CH3 = 47,
    TIM10_CH4 = 48,
    TIM10_UP = 49,
    TIM10_TRIG = 50,
    TIM11_CH1 = 51,
    TIM11_CH2 = 52,
    TIM11_CH3 = 53,
    TIM11_CH4 = 54,
    TIM11_UP = 55,
    TIM11_TRIG = 56,
    TIM12_CH1 = 57,
    TIM12_CH2 = 58,
    TIM12_CH3 = 59,
    TIM12_CH4 = 60,
    TIM12_UP = 61,
    TIM12_TRIG = 62,

    SPI1_TX = 63,
    SPI1_RX = 64,
    SPI2_TX = 65,
    SPI2_RX = 66,
    SPI3_TX = 67,
    SPI3_RX = 68,
    SPI4_TX = 69,
    SPI4_RX = 70,

    QSPI1_DMA = 71,
    QSPI2_DMA = 72,

    I2C1_TX = 73,
    I2C1_RX = 74,
    I2C2_TX = 75,
    I2C2_RX = 76,
    I2C3_TX = 77,
    I2C3_RX = 78,
    I2C4_TX = 79,
    I2C4_RX = 80,

    I3C_RS = 81,
    I3C_TC = 82,
    I3C_TX = 83,
    I3X_RX = 84,

    USART1_TX = 85,
    USART1_RX = 86,
    USART2_TX = 87,
    USART2_RX = 88,
    USART3_TX = 89,
    USART3_RX = 90,
    USART4_TX = 91,
    USART4_RX = 92,
    USART5_TX = 93,
    USART5_RX = 94,
    USART6_TX = 95,
    USART6_RX = 96,
    USART7_TX = 97,
    USART7_RX = 98,
    USART8_TX = 99,
    USART8_RX = 100,

    SWPMI_TX = 101,
    SWPMI_RX = 102,

    DAC1 = 103,
    DAC2 = 104,

    DFSDM_DMA0 = 107,
    DFSDM_DMA1 = 108,

    // 109-110 reserved.

    SDIO = 111,

    SAI_A_TX = 112,
    SAI_A_RX = 113,
    SAI_B_TX = 114,
    SAI_B_RX = 115,

    // 116-119 reserved.

    ADC1 = 120,
    ADC2 = 121,

    TIM6_UP = 122,
    TIM7_UP = 123,
};

pub const Controller = enum { dma1, dma2 };

pub const Priority = enum(u2) { low, medium, high, very_high };

pub const DataSize = enum(u2) { byte, half_word, word, word_256 };

pub const Interrupts = struct {
    transfer_complete: bool = false,
    half_transfer: bool = false,
    transfer_error: bool = false,
};

pub const Flags = struct {
    global: bool = false,
    transfer_complete: bool = false,
    half_transfer: bool = false,
    transfer_error: bool = false,
};

pub const TransferError = error{TransferError};

/// Constructed by peripheral drivers which know both
/// the data register address and the matching DMAMUX request.
pub const Target = struct {
    addr: u32,
    request: Request,
};

const ChannelRegs = extern struct {
    CFGR: @FieldType(DmaRegs, "CFGR1"),
    CNTR: @FieldType(DmaRegs, "CNTR1"),
    PADDR: @FieldType(DmaRegs, "PADDR1"),
    MADDR: @FieldType(DmaRegs, "MADDR1"),
    M1ADDR: @FieldType(DmaRegs, "M1ADDR1"),
};

const channel_first_offset = 0x08;
const channel_stride = 0x14;

pub const Config = struct {
    priority: Priority = .medium,
    circular: bool = false,
    interrupts: Interrupts = .{},
};

const Direction = enum { mem2mem, mem2periph, periph2mem };

pub const Channel = struct {
    controller: Controller,
    /// 1-based, 1..8
    index: u4,

    fn regs(self: Channel) *volatile ChannelRegs {
        const base: usize = switch (self.controller) {
            .dma1 => @intFromPtr(DMA1),
            .dma2 => @intFromPtr(DMA2),
        };
        const addr = base + channel_first_offset + (@as(usize, self.index) - 1) * channel_stride;
        return @ptrFromInt(addr);
    }

    fn ctrl(self: Channel) *volatile DmaRegs {
        return switch (self.controller) {
            .dma1 => DMA1,
            .dma2 => DMA2,
        };
    }

    fn flag_shift(self: Channel) u5 {
        return (@as(u5, self.index) - 1) * 4;
    }

    pub fn set_request(self: Channel, request: Request) void {
        const mux_index: u5 = switch (self.controller) {
            .dma1 => self.index,
            .dma2 => self.index + 8,
        };
        const zero_based: u5 = mux_index - 1;
        const shift: u5 = @intCast((zero_based % 4) * 8);
        const value = (@as(u32, @backingInt(request)) - 1) << shift;
        const mask = @as(u32, 0x7F) << shift;

        switch (zero_based / 4) {
            0 => DMAMUX.DMAMUX1_4_CFGR.raw = (DMAMUX.DMAMUX1_4_CFGR.raw & ~mask) | value,
            1 => DMAMUX.DMAMUX5_8_CFGR.raw = (DMAMUX.DMAMUX5_8_CFGR.raw & ~mask) | value,
            2 => DMAMUX.DMAMUX9_12_CFGR.raw = (DMAMUX.DMAMUX9_12_CFGR.raw & ~mask) | value,
            3 => DMAMUX.DMAMUX13_16_CFGR.raw = (DMAMUX.DMAMUX13_16_CFGR.raw & ~mask) | value,
            else => unreachable,
        }
    }

    /// Configures the channel. `write`/`read` may each be a peripheral
    /// `Target` or a memory slice/array pointer of u8/u16/u32/u256. The
    /// peripheral side determines the direction; if neither is a `Target` a
    /// memory-to-memory transfer is configured. Raise a comptime error if
    /// both sides are peripherals (`Target`).
    pub fn apply(self: Channel, write: anytype, read: anytype, comptime cfg: Config) void {
        const direction = comptime blk: {
            const write_target = @TypeOf(write) == Target;
            const read_target = @TypeOf(read) == Target;
            if (write_target and read_target)
                @compileError("dma: peripheral-to-peripheral transfers are not supported");
            break :blk if (write_target)
                Direction.mem2periph
            else if (read_target)
                Direction.periph2mem
            else
                Direction.mem2mem;
        };

        const data_size = comptime switch (direction) {
            .mem2periph => memoryDataSize(@TypeOf(read)),
            .periph2mem, .mem2mem => memoryDataSize(@TypeOf(write)),
        };
        const pinc = comptime switch (direction) {
            .mem2periph, .periph2mem => false,
            .mem2mem => memoryIncrement(@TypeOf(read)),
        };
        const minc = comptime switch (direction) {
            .mem2periph => memoryIncrement(@TypeOf(read)),
            .periph2mem, .mem2mem => memoryIncrement(@TypeOf(write)),
        };

        const paddr: u32 = switch (direction) {
            .mem2periph => write.addr,
            .periph2mem => read.addr,
            .mem2mem => memoryAddr(read),
        };
        const maddr: u32 = switch (direction) {
            .mem2periph => memoryAddr(read),
            .periph2mem => memoryAddr(write),
            .mem2mem => memoryAddr(write),
        };
        const count: usize = switch (direction) {
            .mem2periph => memoryCount(read),
            .periph2mem, .mem2mem => memoryCount(write),
        };

        clocks.enable(switch (self.controller) {
            .dma1 => .DMA1,
            .dma2 => .DMA2,
        });

        const ch_regs = self.regs();
        ch_regs.CFGR.modify(.{ .EN = 0 });
        self.clear_flags(.{
            .global = true,
            .transfer_complete = true,
            .half_transfer = true,
            .transfer_error = true,
        });

        switch (direction) {
            .mem2periph => self.set_request(write.request),
            .periph2mem => self.set_request(read.request),
            .mem2mem => {},
        }

        ch_regs.PADDR.raw = paddr;
        ch_regs.MADDR.raw = maddr;
        ch_regs.CNTR.raw = @intCast(count);

        ch_regs.CFGR.modify(.{
            .DIR = if (direction == .mem2periph) 1 else 0,
            .CIRC = @intFromBool(cfg.circular),
            .PINC = @intFromBool(pinc),
            .MINC = @intFromBool(minc),
            .PSIZE = @backingInt(data_size),
            .MSIZE = @backingInt(data_size),
            .PL = @backingInt(cfg.priority),
            .MEM2MEM = @intFromBool(direction == .mem2mem),
            .TCIE = @intFromBool(cfg.interrupts.transfer_complete),
            .HTIE = @intFromBool(cfg.interrupts.half_transfer),
            .TEIE = @intFromBool(cfg.interrupts.transfer_error),
            // TODO: support double buffer mode.
            .DOUBLE_MODE = 0,
            .FLAG_CUR_MEM = 0,
        });
    }

    pub fn start(self: Channel) void {
        self.regs().CFGR.modify(.{ .EN = 1 });
    }

    pub fn stop(self: Channel) void {
        self.regs().CFGR.modify(.{ .EN = 0 });
    }

    pub fn is_busy(self: Channel) bool {
        const cfg = self.regs().CFGR.read();
        if (cfg.EN == 0) return false;
        if (cfg.CIRC == 1) return true;
        return !self.flags().transfer_complete;
    }

    pub fn remaining(self: Channel) u16 {
        return self.regs().CNTR.read().NDT;
    }

    /// Waits for a non-circular transfer to finish.
    /// For a circular channel this returns at the end of the current cycle.
    pub fn wait_blocking(self: Channel) TransferError!void {
        while (true) {
            const f = self.flags();
            if (f.transfer_error) return error.TransferError;
            if (f.transfer_complete) return;
            asm volatile ("" ::: .{ .memory = true });
        }
    }

    pub fn set_interrupts(self: Channel, cfg: Interrupts) void {
        self.regs().CFGR.modify(.{
            .TCIE = @intFromBool(cfg.transfer_complete),
            .HTIE = @intFromBool(cfg.half_transfer),
            .TEIE = @intFromBool(cfg.transfer_error),
        });
    }

    pub fn flags(self: Channel) Flags {
        const raw = self.ctrl().INTFR.raw;
        const s = self.flag_shift();
        return .{
            .global = ((raw >> s) & 1) != 0,
            .transfer_complete = ((raw >> (s + 1)) & 1) != 0,
            .half_transfer = ((raw >> (s + 2)) & 1) != 0,
            .transfer_error = ((raw >> (s + 3)) & 1) != 0,
        };
    }

    pub fn clear_flags(self: Channel, f: Flags) void {
        const s = self.flag_shift();
        var bits: u32 = 0;
        if (f.global) bits |= @as(u32, 1) << s;
        if (f.transfer_complete) bits |= @as(u32, 1) << @intCast(s + 1);
        if (f.half_transfer) bits |= @as(u32, 1) << @intCast(s + 2);
        if (f.transfer_error) bits |= @as(u32, 1) << @intCast(s + 3);
        self.ctrl().INTFCR.raw = bits;
    }

    pub inline fn irq(self: Channel) cpu.Interrupt {
        return switch (self.controller) {
            .dma1 => switch (self.index) {
                1 => .DMA1_Channel1,
                2 => .DMA1_Channel2,
                3 => .DMA1_Channel3,
                4 => .DMA1_Channel4,
                5 => .DMA1_Channel5,
                6 => .DMA1_Channel6,
                7 => .DMA1_Channel7,
                8 => .DMA1_Channel8,
                else => unreachable,
            },
            .dma2 => switch (self.index) {
                1 => .DMA2_Channel1,
                2 => .DMA2_Channel2,
                3 => .DMA2_Channel3,
                4 => .DMA2_Channel4,
                5 => .DMA2_Channel5,
                6 => .DMA2_Channel6,
                7 => .DMA2_Channel7,
                8 => .DMA2_Channel8,
                else => unreachable,
            },
        };
    }

    pub fn enable_interrupt(comptime self: Channel) void {
        cpu.interrupt.enable(self.irq());
    }

    pub fn disable_interrupt(comptime self: Channel) void {
        cpu.interrupt.disable(self.irq());
    }
};

pub const dma1_ch1 = Channel{ .controller = .dma1, .index = 1 };
pub const dma1_ch2 = Channel{ .controller = .dma1, .index = 2 };
pub const dma1_ch3 = Channel{ .controller = .dma1, .index = 3 };
pub const dma1_ch4 = Channel{ .controller = .dma1, .index = 4 };
pub const dma1_ch5 = Channel{ .controller = .dma1, .index = 5 };
pub const dma1_ch6 = Channel{ .controller = .dma1, .index = 6 };
pub const dma1_ch7 = Channel{ .controller = .dma1, .index = 7 };
pub const dma1_ch8 = Channel{ .controller = .dma1, .index = 8 };
pub const dma2_ch1 = Channel{ .controller = .dma2, .index = 1 };
pub const dma2_ch2 = Channel{ .controller = .dma2, .index = 2 };
pub const dma2_ch3 = Channel{ .controller = .dma2, .index = 3 };
pub const dma2_ch4 = Channel{ .controller = .dma2, .index = 4 };
pub const dma2_ch5 = Channel{ .controller = .dma2, .index = 5 };
pub const dma2_ch6 = Channel{ .controller = .dma2, .index = 6 };
pub const dma2_ch7 = Channel{ .controller = .dma2, .index = 7 };
pub const dma2_ch8 = Channel{ .controller = .dma2, .index = 8 };

fn memoryDataSize(comptime T: type) DataSize {
    const info = @typeInfo(T);
    if (info != .pointer)
        @compileError("dma: expected a memory slice or pointer, found " ++ @typeName(T));
    const child = info.pointer.child;
    const elem = switch (@typeInfo(child)) {
        .array => |a| a.child,
        .int => child,
        else => @compileError("dma: unsupported memory element type " ++ @typeName(child)),
    };
    const elem_info = @typeInfo(elem);
    if (elem_info != .int)
        @compileError("dma: unsupported memory element type " ++ @typeName(elem));
    return switch (elem_info.int.bits) {
        8 => .byte,
        16 => .half_word,
        32 => .word,
        256 => .word_256,
        else => @compileError("dma: unsupported element size " ++ @typeName(elem)),
    };
}

fn memoryIncrement(comptime T: type) bool {
    const info = @typeInfo(T);
    if (info != .pointer) @compileError("dma: expected a memory pointer");
    return switch (info.pointer.size) {
        .slice, .many => true,
        .one => switch (@typeInfo(info.pointer.child)) {
            .array => true,
            else => false,
        },
        else => false,
    };
}

fn memoryAddr(value: anytype) u32 {
    const info = @typeInfo(@TypeOf(value));
    return switch (info.pointer.size) {
        .slice, .many => @intFromPtr(value.ptr),
        .one => @intFromPtr(value),
        else => @compileError("dma: unsupported memory pointer"),
    };
}

fn memoryCount(value: anytype) usize {
    const info = @typeInfo(@TypeOf(value));
    return switch (info.pointer.size) {
        .slice => value.len,
        .one => switch (@typeInfo(info.pointer.child)) {
            .array => |a| a.len,
            else => 1,
        },
        .many => @compileError("dma: many-item pointers need an explicit length; pass a slice"),
        else => @compileError("dma: unsupported memory pointer"),
    };
}

// TODO: should I add test for these helpers? I think they are self-contained.
