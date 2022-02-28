//! For now we keep all clock settings on the chip defaults.
//! This code currently assumes the STM32F303xB / STM32F303xC clock configuration.
//! TODO: Do something useful for other STM32f30x chips.
//!
//! Specifically, TIM6 is running on an 8 MHz clock,
//! HSI = 8 MHz is the SYSCLK after reset
//! default AHB prescaler = /1 (= values 0..7):
//!
//! ```
//! registers.RCC.CFGR.modify(.{ .HPRE = 0 });
//! ```
//!
//! so also HCLK = 8 MHz.
//! And with the default APB1 prescaler = /2:
//!
//! ```
//! registers.RCC.CFGR.modify(.{ .PPRE1 = 4 });
//! ```
//!
//! results in PCLK1,
//! and the resulting implicit factor *2 for TIM2/3/4/6/7
//! makes TIM6 run at 8MHz/2*2 = 8 MHz.
//!
//! The above default configuration makes U(S)ART2..5
//! (which use PCLK1 without that implicit *2 factor)
//! run at 4 MHz by default.
//!
//! USART1 uses PCLK2, which uses the APB2 prescaler on HCLK,
//! default APB2 prescaler = /1:
//!
//! ```
//! registers.RCC.CFGR.modify(.{ .PPRE2 = 0 });
//! ```
//!
//! and therefore USART1 runs on 8 MHz.

const std = @import("std");
const micro = @import("microzig");

pub const cpu = @import("cpu");
pub const registers = @import("registers.zig");

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'H')
        @compileError(invalid_format_msg);

    const pin_number: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);

    return struct {
        /// 'A'...'H'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(registers, "GPIO" ++ gpio_port_name);
        const suffix = std.fmt.comptimePrint("{d}", .{pin_number});
    };
}

fn setRegField(reg: anytype, comptime field_name: anytype, value: anytype) void {
    var temp = reg.read();
    @field(temp, field_name) = value;
    reg.write(temp);
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        setRegField(registers.RCC.AHBENR, "IOP" ++ pin.gpio_port_name ++ "EN", 1);
        setRegField(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b01);
    }

    pub fn setInput(comptime pin: type) void {
        setRegField(registers.RCC.AHBENR, "IOP" ++ pin.gpio_port_name ++ "EN", 1);
        setRegField(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b00);
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        const idr_reg = pin.gpio_port.IDR;
        const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
        return @intToEnum(micro.gpio.State, reg_value);
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        _ = pin;
        switch (state) {
            .low => setRegField(pin.gpio_port.BRR, "BR" ++ pin.suffix, 1),
            .high => setRegField(pin.gpio_port.BSRR, "BS" ++ pin.suffix, 1),
        }
    }
};

pub const uart = struct {
    pub const DataBits = enum(u4) {
        seven = 7,
        eight = 8,
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
    if (!(index == 1)) @compileError("TODO: only USART1 is currently supported");

    return struct {
        parity_read_mask: u8,

        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            // The following must all be written when the USART is disabled (UE=0).
            if (registers.USART1.CR1.read().UE == 1)
                @panic("Trying to initialize USART1 while it is already enabled");
            // LATER: Alternatively, set UE=0 at this point?  Then wait for something?
            // Or add a destroy() function which disables the USART?

            // enable the USART1 clock
            registers.RCC.APB2ENR.modify(.{ .USART1EN = 1 });
            // enable GPIOC clock
            registers.RCC.AHBENR.modify(.{ .IOPCEN = 1 });
            // set PC4+PC5 to alternate function 7, USART1_TX + USART1_RX
            registers.GPIOC.MODER.modify(.{ .MODER4 = 0b10, .MODER5 = 0b10 });
            registers.GPIOC.AFRL.modify(.{ .AFRL4 = 7, .AFRL5 = 7 });

            // clear USART1 configuration to its default
            registers.USART1.CR1.writeRaw(@as(u32, 0));
            registers.USART1.CR2.writeRaw(@as(u32, 0));
            registers.USART1.CR3.writeRaw(@as(u32, 0));

            // set word length
            // Per the reference manual, M[1:0] means
            // - 00: 8 bits (7 data + 1 parity, or 8 data), probably the chip default
            // - 01: 9 bits (8 data + 1 parity)
            // - 10: 7 bits (7 data)
            // So M1==1 means "7-bit mode" (in which
            // "the Smartcard mode, LIN master mode and Auto baud rate [...] are not supported");
            // and M0==1 means 'the 9th bit (not the 8th bit) is the parity bit'.
            const m1: u1 = if (config.data_bits == .seven and config.parity == null) 1 else 0;
            const m0: u1 = if (config.data_bits == .eight and config.parity != null) 1 else 0;
            // Note that .padding4 = bit 28 = .M1 (.svd file bug), and .M == .M0.
            registers.USART1.CR1.modify(.{ .padding4 = m1, .M = m0 });

            // set parity
            if (config.parity) |parity| {
                registers.USART1.CR1.modify(.{ .PCE = 1, .PS = @enumToInt(parity) });
            } else registers.USART1.CR1.modify(.{ .PCE = 0 }); // no parity, probably the chip default

            // set number of stop bits
            registers.USART1.CR2.modify(.{ .STOP = @enumToInt(config.stop_bits) });

            // set the baud rate
            // TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
            // from the chip, which can be affected by how the board configures the chip.
            // In our case, these are accidentally the same at chip reset,
            // if the board doesn't configure e.g. an HSE external crystal.
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            // TODO: Do a rounding div, instead of a truncating div?
            const usartdiv = @intCast(u16, @divTrunc(micro.board.cpu_frequency, config.baud_rate));
            registers.USART1.BRR.writeRaw(usartdiv);
            // Above, ignore the BRR struct fields DIV_Mantissa and DIV_Fraction,
            // those seem to be for another chipset; .svd file bug?
            // TODO: We assume the default OVER8=0 configuration above.

            // enable USART1, and its transmitter and receiver
            registers.USART1.CR1.modify(.{ .UE = 1 });
            registers.USART1.CR1.modify(.{ .TE = 1 });
            registers.USART1.CR1.modify(.{ .RE = 1 });

            // For code simplicity, at cost of one or more register reads,
            // we read back the actual configuration from the registers,
            // instead of using the `config` values.
            return readFromRegisters();
        }

        pub fn getOrInit(config: micro.uart.Config) !Self {
            if (registers.USART1.CR1.read().UE == 1) {
                // UART1 already enabled, don't reinitialize and disturb things;
                // instead read and use the actual configuration.
                return readFromRegisters();
            } else return init(config);
        }

        fn readFromRegisters() Self {
            const cr1 = registers.USART1.CR1.read();
            // As documented in `init()`, M0==1 means 'the 9th bit (not the 8th bit) is the parity bit'.
            // So we always mask away the 9th bit, and if parity is enabled and it is in the 8th bit,
            // then we also mask away the 8th bit.
            return Self{ .parity_read_mask = if (cr1.PCE == 1 and cr1.M == 0) 0x7F else 0xFF };
        }

        pub fn canWrite(self: Self) bool {
            _ = self;
            return switch (registers.USART1.ISR.read().TXE) {
                1 => true,
                0 => false,
            };
        }

        pub fn tx(self: Self, ch: u8) void {
            while (!self.canWrite()) {} // Wait for Previous transmission
            registers.USART1.TDR.modify(.{ .TDR = ch });
        }

        pub fn txflush(_: Self) void {
            while (registers.USART1.ISR.read().TC == 0) {}
        }

        pub fn canRead(self: Self) bool {
            _ = self;
            return switch (registers.USART1.ISR.read().RXNE) {
                1 => true,
                0 => false,
            };
        }

        pub fn rx(self: Self) u8 {
            while (!self.canRead()) {} // Wait till the data is received
            const data_with_parity_bit: u9 = registers.USART1.RDR.read().RDR;
            return @intCast(u8, data_with_parity_bit & self.parity_read_mask);
        }
    };
}

fn debugPrint(comptime format: []const u8, args: anytype) void {
    micro.debug.writer().print(format, args) catch {};
}

pub fn I2CMaster(comptime index: usize) type {
    if (!(index == 1)) @compileError("TODO: only I2C1 is currently supported");

    return struct {
        const Self = @This();

        pub fn init() !Self {
            // CONFIGURE I2C1
            // connected to APB1, MCU pins PB6 + PB7 = I2C1_SCL + I2C1_SDA,
            // if GPIO port B is configured for alternate function 4 for these PB pins.

            // 1. Enable the I2C CLOCK and GPIO CLOCK
            registers.RCC.APB1ENR.modify(.{ .I2C1EN = 1 });
            registers.RCC.AHBENR.modify(.{ .IOPBEN = 1 });
            debugPrint("I2C1 configuration step 1 complete\r\n", .{});

            // 2. Configure the I2C PINs for ALternate Functions
            // 	a) Select Alternate Function in MODER Register
            registers.GPIOB.MODER.modify(.{ .MODER6 = 0b10, .MODER7 = 0b10 });
            // 	b) Select Open Drain Output
            registers.GPIOB.OTYPER.modify(.{ .OT6 = 1, .OT7 = 1 });
            // 	c) Select High SPEED for the PINs
            registers.GPIOB.OSPEEDR.modify(.{ .OSPEEDR6 = 0b11, .OSPEEDR7 = 0b11 });
            // 	d) Select Pull-up for both the Pins
            registers.GPIOB.PUPDR.modify(.{ .PUPDR6 = 0b01, .PUPDR7 = 0b01 });
            // 	e) Configure the Alternate Function in AFR Register
            registers.GPIOB.AFRL.modify(.{ .AFRL6 = 4, .AFRL7 = 4 });
            debugPrint("I2C1 configuration step 2 complete\r\n", .{});

            // 3. Reset the I2C
            registers.I2C1.CR1.modify(.{ .PE = 0 });
            while (registers.I2C1.CR1.read().PE == 1) {}
            // DO NOT registers.RCC.APB1RSTR.modify(.{ .I2C1RST = 1 });
            debugPrint("I2C1 configuration step 3 complete\r\n", .{});

            // TODO: Offer config option to use stricter NOSTRETCH?

            // 4-6. Configure I2C1 timing, based on 8 MHz I2C clock, run at 100 kHz
            // (Not using https://controllerstech.com/stm32-i2c-configuration-using-registers/
            // but copying an example from the reference manual, RM0316 section 28.4.9.)
            registers.I2C1.TIMINGR.modify(.{
                .PRESC = 1,
                .SCLL = 0x13,
                .SCLH = 0xF,
                .SDADEL = 0x2,
                .SCLDEL = 0x4,
            });
            debugPrint("I2C1 configuration steps 4-6 complete\r\n", .{});

            // 7. Program the I2C_CR1 register to enable the peripheral
            registers.I2C1.CR1.modify(.{ .PE = 1 });
            debugPrint("I2C1 configuration step 7 complete\r\n", .{});

            return Self{};
        }

        pub fn write(_: Self, address: u7, bytes: []const u8) !void {
            std.debug.assert(bytes.len == 1); // TODO: Improve!

            // As master, initiate write from address, 7 bit address, 1 byte
            registers.I2C1.CR2.modify(.{
                .ADD10 = 0,
                .SADD1 = address,
                .RD_WRN = 0, // write
                .NBYTES = 1,
            });
            debugPrint("I2C1 prepared for write of 1 byte to 0b0011001\r\n", .{});

            // registers.I2C1.CR2.modify(.{ .AUTOEND = 1 });

            // Communication START
            registers.I2C1.CR2.modify(.{ .START = 1 });
            debugPrint("I2C1 TXIS={}\r\n", .{registers.I2C1.ISR.read().TXIS});
            debugPrint("I2C1 STARTed\r\n", .{});
            debugPrint("I2C1 TXIS={}\r\n", .{registers.I2C1.ISR.read().TXIS});

            // Wait for data to be acknowledged
            while (registers.I2C1.ISR.read().TXIS == 0) {
                debugPrint("I2C1 waiting for ready to send (TXIS=0)\r\n", .{});
            }
            debugPrint("I2C1 ready to send (TXIS=1)\r\n", .{});

            // Write first data byte
            registers.I2C1.TXDR.modify(.{ .TXDATA = bytes[0] });
            // waiting for TC==1 must only be done if AUTOEND is not set
            debugPrint("I2C1 TC={}\r\n", .{registers.I2C1.ISR.read().TC});
            debugPrint("I2C1 data written\r\n", .{});
            debugPrint("I2C1 TC={}\r\n", .{registers.I2C1.ISR.read().TC});
            while (registers.I2C1.ISR.read().TC == 0) {
                debugPrint("I2C1 waiting for data (TC=0)\r\n", .{});
            }

            // Communication STOP
            registers.I2C1.CR2.modify(.{ .STOP = 1 });
        }

        /// Fails with ReadError if incorrect number of bytes is received.
        pub fn read(_: Self, address: u7, buffer: []u8) !void {
            std.debug.assert(buffer.len == 1); // TODO: Improve!

            // As master, initiate read from accelerometer, 7 bit address, 1 byte
            registers.I2C1.CR2.modify(.{
                .ADD10 = 0,
                .SADD1 = address,
                .RD_WRN = 1, // read
                .NBYTES = 1,
            });
            debugPrint("I2C1 prepared for read of 1 byte from 0b0011001\r\n", .{});

            //registers.I2C1.CR2.modify(.{ .AUTOEND = 1 });

            // Communication START
            registers.I2C1.CR2.modify(.{ .START = 1 });
            debugPrint("I2C1 RXNE={}\r\n", .{registers.I2C1.ISR.read().RXNE});
            debugPrint("I2C1 STARTed\r\n", .{});
            debugPrint("I2C1 RXNE={}\r\n", .{registers.I2C1.ISR.read().RXNE});

            // Wait for data to be received
            while (registers.I2C1.ISR.read().RXNE == 0) {
                debugPrint("I2C1 waiting for data (RXNE=0)\r\n", .{});
            }
            debugPrint("I2C1 data ready (RXNE=1)\r\n", .{});

            // Read first data byte
            buffer[0] = registers.I2C1.RXDR.read().RXDATA;
            debugPrint("I2C1 data: {any}\r\n", .{buffer});

            // Communication STOP
            registers.I2C1.CR2.modify(.{ .STOP = 1 });
        }
    };
}
