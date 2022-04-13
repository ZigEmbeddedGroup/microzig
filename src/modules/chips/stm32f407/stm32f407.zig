//! For now we keep all clock settings on the chip defaults.
//! This code currently assumes the STM32F405xx / STM32F407xx clock configuration.
//! TODO: Do something useful for other STM32F40x chips.
//!
//! Specifically, TIM6 is running on a 16 MHz clock,
//! HSI = 16 MHz is the SYSCLK after reset
//! default AHB prescaler = /1 (= values 0..7):
//!
//! ```
//! regs.RCC.CFGR.modify(.{ .HPRE = 0 });
//! ```
//!
//! so also HCLK = 16 MHz.
//! And with the default APB1 prescaler = /1:
//!
//! ```
//! regs.RCC.CFGR.modify(.{ .PPRE1 = 0 });
//! ```
//!
//! results in PCLK1 = 16 MHz.
//!
//! The above default configuration makes U(S)ART2..5
//! receive a 16 MHz clock by default.
//!
//! USART1 and USART6 use PCLK2, which uses the APB2 prescaler on HCLK,
//! default APB2 prescaler = /1:
//!
//! ```
//! regs.RCC.CFGR.modify(.{ .PPRE2 = 0 });
//! ```
//!
//! and therefore USART1 and USART6 receive a 16 MHz clock.
//!

const std = @import("std");
const micro = @import("microzig");
const chip = @import("registers.zig");
const regs = chip.registers;

pub usingnamespace chip;

// Default clock frequencies after reset, see top comment for calculation
// TODO: these would need to change when we support multiple clock configurations
pub const ahb_frequency = 16_000_000;
pub const apb1_frequency = 16_000_000;
pub const apb2_frequency = 16_000_000;

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'I')
        @compileError(invalid_format_msg);

    return struct {
        const pin_number: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);
        /// 'A'...'I'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(regs, "GPIO" ++ gpio_port_name);
        const suffix = std.fmt.comptimePrint("{d}", .{pin_number});
    };
}

fn setRegField(reg: anytype, comptime field_name: anytype, value: anytype) void {
    var temp = reg.read();
    @field(temp, field_name) = value;
    reg.write(temp);
}

pub const gpio = struct {
    pub const AlternateFunction = enum(u4) {
        af0,
        af1,
        af2,
        af3,
        af4,
        af5,
        af6,
        af7,
        af8,
        af9,
        af10,
        af11,
        af12,
        af13,
        af14,
        af15,
    };

    pub fn setOutput(comptime pin: type) void {
        setRegField(regs.RCC.AHB1ENR, "GPIO" ++ pin.gpio_port_name ++ "EN", 1);
        setRegField(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b01);
    }

    pub fn setInput(comptime pin: type) void {
        setRegField(regs.RCC.AHB1ENR, "GPIO" ++ pin.gpio_port_name ++ "EN", 1);
        setRegField(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b00);
    }

    pub fn setAlternateFunction(comptime pin: type, af: AlternateFunction) void {
        setRegField(regs.RCC.AHB1ENR, "GPIO" ++ pin.gpio_port_name ++ "EN", 1);
        setRegField(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b10);
        if (pin.pin_number < 8) {
            setRegField(@field(pin.gpio_port, "AFRL"), "AFRL" ++ pin.suffix, @enumToInt(af));
        } else {
            setRegField(@field(pin.gpio_port, "AFRH"), "AFRH" ++ pin.suffix, @enumToInt(af));
        }
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        const idr_reg = pin.gpio_port.IDR;
        const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
        return @intToEnum(micro.gpio.State, reg_value);
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        _ = pin;
        switch (state) {
            .low => setRegField(pin.gpio_port.BSRR, "BR" ++ pin.suffix, 1),
            .high => setRegField(pin.gpio_port.BSRR, "BS" ++ pin.suffix, 1),
        }
    }
};

pub const uart = struct {
    pub const DataBits = enum {
        seven,
        eight,
        nine,
    };

    /// uses the values of USART_CR2.STOP
    pub const StopBits = enum(u2) {
        one = 0b00,
        half = 0b01,
        two = 0b10,
        one_and_half = 0b11,
    };

    /// uses the values of USART_CR1.PS
    pub const Parity = enum(u1) {
        even = 0,
        odd = 1,
    };
};

pub fn Uart(comptime index: usize) type {
    if (index < 1 or index > 6) @compileError("Valid USART index are 1..6");

    const usart_name = std.fmt.comptimePrint("USART{d}", .{index});
    // TODO: support alternative pins
    const pins = switch (index) {
        1 => .{ .tx = micro.Pin("PA9"), .rx = micro.Pin("PA10") },
        2 => .{ .tx = micro.Pin("PA2"), .rx = micro.Pin("PA3") },
        3 => .{ .tx = micro.Pin("PD8"), .rx = micro.Pin("PD9") },
        4 => .{ .tx = micro.Pin("PC10"), .rx = micro.Pin("PC11") },
        5 => .{ .tx = micro.Pin("PC12"), .rx = micro.Pin("PD2") },
        6 => .{ .tx = micro.Pin("PC6"), .rx = micro.Pin("PC7") },
        else => unreachable,
    };
    const tx_gpio = micro.Gpio(pins.tx, .{
        .mode = .alternate_function,
        .alternate_function = .af7,
    });
    const rx_gpio = micro.Gpio(pins.rx, .{
        .mode = .alternate_function,
        .alternate_function = .af7,
    });

    return struct {
        parity_read_mask: u8,

        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            // The following must all be written when the USART is disabled (UE=0).
            if (@field(regs, usart_name).CR1.read().UE == 1)
                @panic("Trying to initialize " ++ usart_name ++ " while it is already enabled");
            // LATER: Alternatively, set UE=0 at this point?  Then wait for something?
            // Or add a destroy() function which disables the USART?

            // enable the USART clock
            const clk_enable_reg = switch (index) {
                1, 6 => regs.RCC.APB2ENR,
                2...5 => regs.RCC.APB1ENR,
                else => unreachable,
            };
            setRegField(clk_enable_reg, usart_name ++ "EN", 1);

            tx_gpio.init();
            rx_gpio.init();

            // clear USART configuration to its default
            @field(regs, usart_name).CR1.raw = 0;
            @field(regs, usart_name).CR2.raw = 0;
            @field(regs, usart_name).CR3.raw = 0;

            // Return error for unsupported combinations
            if (config.data_bits == .nine and config.parity != null) {
                // TODO: should we consider this an unsupported word size or unsupported parity?
                return error.UnsupportedWordSize;
            } else if (config.data_bits == .seven and config.parity == null) {
                // TODO: should we consider this an unsupported word size or unsupported parity?
                return error.UnsupportedWordSize;
            }

            // set word length
            // Per the reference manual, M means
            // - 0: 1 start bit, 8 data bits (7 data + 1 parity, or 8 data), n stop bits, the chip default
            // - 1: 1 start bit, 9 data bits (8 data + 1 parity, or 9 data), n stop bits
            const m: u1 = if (config.data_bits == .nine or (config.data_bits == .eight and config.parity != null)) 1 else 0;
            @field(regs, usart_name).CR1.modify(.{ .M = m });

            // set parity
            if (config.parity) |parity| {
                @field(regs, usart_name).CR1.modify(.{ .PCE = 1, .PS = @enumToInt(parity) });
            } // otherwise, no need to set no parity since we reset Control Registers above, and it's the default

            // set number of stop bits
            @field(regs, usart_name).CR2.modify(.{ .STOP = @enumToInt(config.stop_bits) });

            // set the baud rate
            // Despite the reference manual talking about fractional calculation and other buzzwords,
            // it is actually just a simple divider. Just ignore DIV_Mantissa and DIV_Fraction and
            // set the result of the division as the lower 16 bits of BRR.
            // TODO: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            // TODO: Do a rounding div, instead of a truncating div?
            const usartdiv = @intCast(u16, @divTrunc(apb1_frequency, config.baud_rate));
            @field(regs, usart_name).BRR.raw = usartdiv;

            // enable USART, and its transmitter and receiver
            @field(regs, usart_name).CR1.modify(.{ .UE = 1 });
            @field(regs, usart_name).CR1.modify(.{ .TE = 1 });
            @field(regs, usart_name).CR1.modify(.{ .RE = 1 });

            // For code simplicity, at cost of one or more register reads,
            // we read back the actual configuration from the registers,
            // instead of using the `config` values.
            return readFromRegisters();
        }

        pub fn getOrInit(config: micro.uart.Config) !Self {
            if (@field(regs, usart_name).CR1.read().UE == 1) {
                // UART1 already enabled, don't reinitialize and disturb things;
                // instead read and use the actual configuration.
                return readFromRegisters();
            } else return init(config);
        }

        fn readFromRegisters() Self {
            const cr1 = @field(regs, usart_name).CR1.read();
            // As documented in `init()`, M0==1 means 'the 9th bit (not the 8th bit) is the parity bit'.
            // So we always mask away the 9th bit, and if parity is enabled and it is in the 8th bit,
            // then we also mask away the 8th bit.
            return Self{ .parity_read_mask = if (cr1.PCE == 1 and cr1.M == 0) 0x7F else 0xFF };
        }

        pub fn canWrite(self: Self) bool {
            _ = self;
            return switch (@field(regs, usart_name).SR.read().TXE) {
                1 => true,
                0 => false,
            };
        }

        pub fn tx(self: Self, ch: u8) void {
            while (!self.canWrite()) {} // Wait for Previous transmission
            @field(regs, usart_name).DR.modify(ch);
        }

        pub fn txflush(_: Self) void {
            while (@field(regs, usart_name).SR.read().TC == 0) {}
        }

        pub fn canRead(self: Self) bool {
            _ = self;
            return switch (@field(regs, usart_name).SR.read().RXNE) {
                1 => true,
                0 => false,
            };
        }

        pub fn rx(self: Self) u8 {
            while (!self.canRead()) {} // Wait till the data is received
            const data_with_parity_bit: u9 = @field(regs, usart_name).DR.read();
            return @intCast(u8, data_with_parity_bit & self.parity_read_mask);
        }
    };
}
