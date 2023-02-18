//! For now we keep all clock settings on the chip defaults.
//! This code currently assumes the STM32F303xB / STM32F303xC clock configuration.
//! TODO: Do something useful for other STM32f30x chips.
//!
//! Specifically, TIM6 is running on an 8 MHz clock,
//! HSI = 8 MHz is the SYSCLK after reset
//! default AHB prescaler = /1 (= values 0..7):
//!
//! ```
//! RCC.CFGR.modify(.{ .HPRE = 0 });
//! ```
//!
//! so also HCLK = 8 MHz.
//! And with the default APB1 prescaler = /2:
//!
//! ```
//! RCC.CFGR.modify(.{ .PPRE1 = 4 });
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
//! RCC.CFGR.modify(.{ .PPRE2 = 0 });
//! ```
//!
//! and therefore USART1 runs on 8 MHz.

const std = @import("std");
const runtime_safety = std.debug.runtime_safety;

const micro = @import("microzig");
const SPI1 = micro.peripherals.SPI1;
const RCC = micro.peripherals.RCC;
const USART1 = micro.peripherals.USART1;
const GPIOA = micro.peripherals.GPIOA;
const GPIOB = micro.peripherals.GPIOB;
const GPIOC = micro.peripherals.GPIOC;
const I2C1 = micro.peripherals.I2C1;

pub const cpu = @import("cpu");

pub const clock = struct {
    pub const Domain = enum {
        cpu,
        ahb,
        apb1,
        apb2,
    };
};

// Default clock frequencies after reset, see top comment for calculation
pub const clock_frequencies = .{
    .cpu = 8_000_000,
    .ahb = 8_000_000,
    .apb1 = 8_000_000,
    .apb2 = 8_000_000,
};

pub fn parse_pin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'H')
        @compileError(invalid_format_msg);

    const pin_number: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);

    return struct {
        /// 'A'...'H'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(micro.peripherals, "GPIO" ++ gpio_port_name);
        const suffix = std.fmt.comptimePrint("{d}", .{pin_number});
    };
}

fn set_reg_field(reg: anytype, comptime field_name: anytype, value: anytype) void {
    var temp = reg.read();
    @field(temp, field_name) = value;
    reg.write(temp);
}

pub const gpio = struct {
    pub fn set_output(comptime pin: type) void {
        set_reg_field(RCC.AHBENR, "IOP" ++ pin.gpio_port_name ++ "EN", 1);
        set_reg_field(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b01);
    }

    pub fn set_input(comptime pin: type) void {
        set_reg_field(RCC.AHBENR, "IOP" ++ pin.gpio_port_name ++ "EN", 1);
        set_reg_field(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b00);
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        const idr_reg = pin.gpio_port.IDR;
        const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
        return @intToEnum(micro.gpio.State, reg_value);
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        switch (state) {
            .low => set_reg_field(pin.gpio_port.BRR, "BR" ++ pin.suffix, 1),
            .high => set_reg_field(pin.gpio_port.BSRR, "BS" ++ pin.suffix, 1),
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

pub fn Uart(comptime index: usize, comptime pins: micro.uart.Pins) type {
    if (!(index == 1)) @compileError("TODO: only USART1 is currently supported");
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        parity_read_mask: u8,

        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            // The following must all be written when the USART is disabled (UE=0).
            if (USART1.CR1.read().UE == 1)
                @panic("Trying to initialize USART1 while it is already enabled");
            // LATER: Alternatively, set UE=0 at this point?  Then wait for something?
            // Or add a destroy() function which disables the USART?

            // enable the USART1 clock
            RCC.APB2ENR.modify(.{ .USART1EN = 1 });
            // enable GPIOC clock
            RCC.AHBENR.modify(.{ .IOPCEN = 1 });
            // set PC4+PC5 to alternate function 7, USART1_TX + USART1_RX
            GPIOC.MODER.modify(.{ .MODER4 = 0b10, .MODER5 = 0b10 });
            GPIOC.AFRL.modify(.{ .AFRL4 = 7, .AFRL5 = 7 });

            // clear USART1 configuration to its default
            USART1.CR1.raw = 0;
            USART1.CR2.raw = 0;
            USART1.CR3.raw = 0;

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
            // Note that .padding0 = bit 28 = .M1 (.svd file bug?), and .M == .M0.
            USART1.CR1.modify(.{ .padding0 = m1, .M = m0 });

            // set parity
            if (config.parity) |parity| {
                USART1.CR1.modify(.{ .PCE = 1, .PS = @enumToInt(parity) });
            } else USART1.CR1.modify(.{ .PCE = 0 }); // no parity, probably the chip default

            // set number of stop bits
            USART1.CR2.modify(.{ .STOP = @enumToInt(config.stop_bits) });

            // set the baud rate
            // TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
            // from the chip, which can be affected by how the board configures the chip.
            // In our case, these are accidentally the same at chip reset,
            // if the board doesn't configure e.g. an HSE external crystal.
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            // TODO: Do a rounding div, instead of a truncating div?
            const usartdiv = @intCast(u16, @divTrunc(micro.clock.get().apb1, config.baud_rate));
            USART1.BRR.raw = usartdiv;
            // Above, ignore the BRR struct fields DIV_Mantissa and DIV_Fraction,
            // those seem to be for another chipset; .svd file bug?
            // TODO: We assume the default OVER8=0 configuration above.

            // enable USART1, and its transmitter and receiver
            USART1.CR1.modify(.{ .UE = 1 });
            USART1.CR1.modify(.{ .TE = 1 });
            USART1.CR1.modify(.{ .RE = 1 });

            // For code simplicity, at cost of one or more register reads,
            // we read back the actual configuration from the registers,
            // instead of using the `config` values.
            return read_from_registers();
        }

        pub fn get_or_init(config: micro.uart.Config) !Self {
            if (USART1.CR1.read().UE == 1) {
                // UART1 already enabled, don't reinitialize and disturb things;
                // instead read and use the actual configuration.
                return read_from_registers();
            } else return init(config);
        }

        fn read_from_registers() Self {
            const cr1 = USART1.CR1.read();
            // As documented in `init()`, M0==1 means 'the 9th bit (not the 8th bit) is the parity bit'.
            // So we always mask away the 9th bit, and if parity is enabled and it is in the 8th bit,
            // then we also mask away the 8th bit.
            return Self{ .parity_read_mask = if (cr1.PCE == 1 and cr1.M == 0) 0x7F else 0xFF };
        }

        pub fn can_write(self: Self) bool {
            _ = self;
            return switch (USART1.ISR.read().TXE) {
                1 => true,
                0 => false,
            };
        }

        pub fn tx(self: Self, ch: u8) void {
            while (!self.can_write()) {} // Wait for Previous transmission
            USART1.TDR.modify(ch);
        }

        pub fn txflush(_: Self) void {
            while (USART1.ISR.read().TC == 0) {}
        }

        pub fn can_read(self: Self) bool {
            _ = self;
            return switch (USART1.ISR.read().RXNE) {
                1 => true,
                0 => false,
            };
        }

        pub fn rx(self: Self) u8 {
            while (!self.can_read()) {} // Wait till the data is received
            const data_with_parity_bit: u9 = USART1.RDR.read().RDR;
            return @intCast(u8, data_with_parity_bit & self.parity_read_mask);
        }
    };
}

const enable_stm32f303_debug = false;

fn debug_print(comptime format: []const u8, args: anytype) void {
    if (enable_stm32f303_debug) {
        micro.debug.writer().print(format, args) catch {};
    }
}

/// This implementation does not use AUTOEND=1
pub fn I2CController(comptime index: usize, comptime pins: micro.i2c.Pins) type {
    if (!(index == 1)) @compileError("TODO: only I2C1 is currently supported");
    if (pins.scl != null or pins.sda != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        const Self = @This();

        pub fn init(config: micro.i2c.Config) !Self {
            // CONFIGURE I2C1
            // connected to APB1, MCU pins PB6 + PB7 = I2C1_SCL + I2C1_SDA,
            // if GPIO port B is configured for alternate function 4 for these PB pins.

            // 1. Enable the I2C CLOCK and GPIO CLOCK
            RCC.APB1ENR.modify(.{ .I2C1EN = 1 });
            RCC.AHBENR.modify(.{ .IOPBEN = 1 });
            debug_print("I2C1 configuration step 1 complete\r\n", .{});
            // 2. Configure the I2C PINs for ALternate Functions
            // 	a) Select Alternate Function in MODER Register
            GPIOB.MODER.modify(.{ .MODER6 = 0b10, .MODER7 = 0b10 });
            // 	b) Select Open Drain Output
            GPIOB.OTYPER.modify(.{ .OT6 = 1, .OT7 = 1 });
            // 	c) Select High SPEED for the PINs
            GPIOB.OSPEEDR.modify(.{ .OSPEEDR6 = 0b11, .OSPEEDR7 = 0b11 });
            // 	d) Select Pull-up for both the Pins
            GPIOB.PUPDR.modify(.{ .PUPDR6 = 0b01, .PUPDR7 = 0b01 });
            // 	e) Configure the Alternate Function in AFR Register
            GPIOB.AFRL.modify(.{ .AFRL6 = 4, .AFRL7 = 4 });
            debug_print("I2C1 configuration step 2 complete\r\n", .{});

            // 3. Reset the I2C
            I2C1.CR1.modify(.{ .PE = 0 });
            while (I2C1.CR1.read().PE == 1) {}
            // DO NOT RCC.APB1RSTR.modify(.{ .I2C1RST = 1 });
            debug_print("I2C1 configuration step 3 complete\r\n", .{});

            // 4-6. Configure I2C1 timing, based on 8 MHz I2C clock, run at 100 kHz
            // (Not using https://controllerstech.com/stm32-i2c-configuration-using-registers/
            // but copying an example from the reference manual, RM0316 section 28.4.9.)
            if (config.target_speed != 100_000) @panic("TODO: Support speeds other than 100 kHz");
            I2C1.TIMINGR.modify(.{
                .PRESC = 1,
                .SCLL = 0x13,
                .SCLH = 0xF,
                .SDADEL = 0x2,
                .SCLDEL = 0x4,
            });
            debug_print("I2C1 configuration steps 4-6 complete\r\n", .{});

            // 7. Program the I2C_CR1 register to enable the peripheral
            I2C1.CR1.modify(.{ .PE = 1 });
            debug_print("I2C1 configuration step 7 complete\r\n", .{});

            return Self{};
        }

        pub const WriteState = struct {
            address: u7,
            buffer: [255]u8 = undefined,
            buffer_size: u8 = 0,

            pub fn start(address: u7) !WriteState {
                return WriteState{ .address = address };
            }

            pub fn write_all(self: *WriteState, bytes: []const u8) !void {
                debug_print("I2C1 writeAll() with {d} byte(s); buffer={any}\r\n", .{ bytes.len, self.buffer[0..self.buffer_size] });

                std.debug.assert(self.buffer_size < 255);
                for (bytes) |b| {
                    self.buffer[self.buffer_size] = b;
                    self.buffer_size += 1;
                    if (self.buffer_size == 255) {
                        try self.send_buffer(1);
                    }
                }
            }

            fn send_buffer(self: *WriteState, reload: u1) !void {
                debug_print("I2C1 sendBuffer() with {d} byte(s); RELOAD={d}; buffer={any}\r\n", .{ self.buffer_size, reload, self.buffer[0..self.buffer_size] });
                if (self.buffer_size == 0) @panic("write of 0 bytes not supported");

                std.debug.assert(reload == 0 or self.buffer_size == 255); // see TODOs below

                // As master, initiate write from address, 7 bit address
                I2C1.CR2.modify(.{
                    .ADD10 = 0,
                    .SADD1 = self.address,
                    .RD_WRN = 0, // write
                    .NBYTES = self.buffer_size,
                    .RELOAD = reload,
                });
                if (reload == 0) {
                    I2C1.CR2.modify(.{ .START = 1 });
                } else {
                    // TODO: The RELOAD=1 path is untested but doesn't seem to work yet,
                    // even though we make sure that we set NBYTES=255 per the docs.
                }
                for (self.buffer[0..self.buffer_size]) |b| {
                    // wait for empty transmit buffer
                    while (I2C1.ISR.read().TXE == 0) {
                        debug_print("I2C1 waiting for ready to send (TXE=0)\r\n", .{});
                    }
                    debug_print("I2C1 ready to send (TXE=1)\r\n", .{});
                    // Write data byte
                    I2C1.TXDR.modify(.{ .TXDATA = b });
                }
                self.buffer_size = 0;
                debug_print("I2C1 data written\r\n", .{});
                if (reload == 1) {
                    // TODO: The RELOAD=1 path is untested but doesn't seem to work yet,
                    // the following loop never seems to finish.
                    while (I2C1.ISR.read().TCR == 0) {
                        debug_print("I2C1 waiting transmit complete (TCR=0)\r\n", .{});
                    }
                    debug_print("I2C1 transmit complete (TCR=1)\r\n", .{});
                } else {
                    while (I2C1.ISR.read().TC == 0) {
                        debug_print("I2C1 waiting for transmit complete (TC=0)\r\n", .{});
                    }
                    debug_print("I2C1 transmit complete (TC=1)\r\n", .{});
                }
            }

            pub fn stop(self: *WriteState) !void {
                try self.send_buffer(0);
                // Communication STOP
                debug_print("I2C1 STOPping\r\n", .{});
                I2C1.CR2.modify(.{ .STOP = 1 });
                while (I2C1.ISR.read().BUSY == 1) {}
                debug_print("I2C1 STOPped\r\n", .{});
            }

            pub fn restart_read(self: *WriteState) !ReadState {
                try self.send_buffer(0);
                return ReadState{ .address = self.address };
            }
            pub fn restart_write(self: *WriteState) !WriteState {
                try self.send_buffer(0);
                return WriteState{ .address = self.address };
            }
        };

        pub const ReadState = struct {
            address: u7,
            read_allowed: if (runtime_safety) bool else void = if (runtime_safety) true else {},

            pub fn start(address: u7) !ReadState {
                return ReadState{ .address = address };
            }

            /// Fails with ReadError if incorrect number of bytes is received.
            pub fn read_no_eof(self: *ReadState, buffer: []u8) !void {
                if (runtime_safety and !self.read_allowed) @panic("second read call not allowed");
                std.debug.assert(buffer.len < 256); // TODO: use RELOAD to read more data

                // As master, initiate read from accelerometer, 7 bit address
                I2C1.CR2.modify(.{
                    .ADD10 = 0,
                    .SADD1 = self.address,
                    .RD_WRN = 1, // read
                    .NBYTES = @intCast(u8, buffer.len),
                });
                debug_print("I2C1 prepared for read of {} byte(s) from 0b{b:0<7}\r\n", .{ buffer.len, self.address });

                // Communication START
                I2C1.CR2.modify(.{ .START = 1 });
                debug_print("I2C1 RXNE={}\r\n", .{I2C1.ISR.read().RXNE});
                debug_print("I2C1 STARTed\r\n", .{});
                debug_print("I2C1 RXNE={}\r\n", .{I2C1.ISR.read().RXNE});

                if (runtime_safety) self.read_allowed = false;

                for (buffer) |_, i| {
                    // Wait for data to be received
                    while (I2C1.ISR.read().RXNE == 0) {
                        debug_print("I2C1 waiting for data (RXNE=0)\r\n", .{});
                    }
                    debug_print("I2C1 data ready (RXNE=1)\r\n", .{});

                    // Read first data byte
                    buffer[i] = I2C1.RXDR.read().RXDATA;
                }
                debug_print("I2C1 data: {any}\r\n", .{buffer});
            }

            pub fn stop(_: *ReadState) !void {
                // Communication STOP
                I2C1.CR2.modify(.{ .STOP = 1 });
                while (I2C1.ISR.read().BUSY == 1) {}
                debug_print("I2C1 STOPped\r\n", .{});
            }

            pub fn restart_read(self: *ReadState) !ReadState {
                debug_print("I2C1 no action for restart\r\n", .{});
                return ReadState{ .address = self.address };
            }
            pub fn restart_write(self: *ReadState) !WriteState {
                debug_print("I2C1 no action for restart\r\n", .{});
                return WriteState{ .address = self.address };
            }
        };
    };
}

/// An STM32F303 SPI bus
pub fn SpiBus(comptime index: usize) type {
    if (!(index == 1)) @compileError("TODO: only SPI1 is currently supported");

    return struct {
        const Self = @This();

        /// Initialize and enable the bus.
        pub fn init(config: micro.spi.BusConfig) !Self {
            _ = config; // unused for now

            // CONFIGURE SPI1
            // connected to APB2, MCU pins PA5 + PA7 + PA6 = SPC + SDI + SDO,
            // if GPIO port A is configured for alternate function 5 for these PA pins.

            // Enable the GPIO CLOCK
            RCC.AHBENR.modify(.{ .IOPAEN = 1 });

            // Configure the I2C PINs for ALternate Functions
            // 	- Select Alternate Function in MODER Register
            GPIOA.MODER.modify(.{ .MODER5 = 0b10, .MODER6 = 0b10, .MODER7 = 0b10 });
            // 	- Select High SPEED for the PINs
            GPIOA.OSPEEDR.modify(.{ .OSPEEDR5 = 0b11, .OSPEEDR6 = 0b11, .OSPEEDR7 = 0b11 });
            // 	- Configure the Alternate Function in AFR Register
            GPIOA.AFRL.modify(.{ .AFRL5 = 5, .AFRL6 = 5, .AFRL7 = 5 });

            // Enable the SPI1 CLOCK
            RCC.APB2ENR.modify(.{ .SPI1EN = 1 });

            SPI1.CR1.modify(.{
                .MSTR = 1,
                .SSM = 1,
                .SSI = 1,
                .RXONLY = 0,
                .SPE = 1,
            });
            // the following configuration is assumed in `transceiveByte()`
            SPI1.CR2.raw = 0;
            SPI1.CR2.modify(.{
                .DS = 0b0111, // 8-bit data frames, seems default via '0b0000 is interpreted as 0b0111'
                .FRXTH = 1, // RXNE event after 1 byte received
            });

            return Self{};
        }

        /// Switch this SPI bus to the given device.
        pub fn switch_to_device(_: Self, comptime cs_pin: type, config: micro.spi.DeviceConfig) void {
            _ = config; // for future use

            SPI1.CR1.modify(.{
                .CPOL = 1, // TODO: make configurable
                .CPHA = 1, // TODO: make configurable
                .BR = 0b111, // 1/256 the of PCLK TODO: make configurable
                .LSBFIRST = 0, // MSB first TODO: make configurable
            });
            gpio.set_output(cs_pin);
        }

        /// Begin a transfer to the given device.  (Assumes `switchToDevice()` was called.)
        pub fn begin_transfer(_: Self, comptime cs_pin: type, config: micro.spi.DeviceConfig) void {
            _ = config; // for future use
            gpio.write(cs_pin, .low); // select the given device, TODO: support inverse CS devices
            debug_print("enabled SPI1\r\n", .{});
        }

        /// The basic operation in the current simplistic implementation:
        /// send+receive a single byte.
        /// Writing `null` writes an arbitrary byte (`undefined`), and
        /// reading into `null` ignores the value received.
        pub fn transceive_byte(_: Self, optional_write_byte: ?u8, optional_read_pointer: ?*u8) !void {

            // SPIx_DR's least significant byte is `@bitCast([dr_byte_size]u8, ...)[0]`
            const dr_byte_size = @sizeOf(@TypeOf(SPI1.DR.raw));

            // wait unril ready for write
            while (SPI1.SR.read().TXE == 0) {
                debug_print("SPI1 TXE == 0\r\n", .{});
            }
            debug_print("SPI1 TXE == 1\r\n", .{});

            // write
            const write_byte = if (optional_write_byte) |b| b else undefined; // dummy value
            @bitCast([dr_byte_size]u8, SPI1.DR.*)[0] = write_byte;
            debug_print("Sent: {X:2}.\r\n", .{write_byte});

            // wait until read processed
            while (SPI1.SR.read().RXNE == 0) {
                debug_print("SPI1 RXNE == 0\r\n", .{});
            }
            debug_print("SPI1 RXNE == 1\r\n", .{});

            // read
            var data_read = SPI1.DR.raw;
            _ = SPI1.SR.read(); // clear overrun flag
            const dr_lsb = @bitCast([dr_byte_size]u8, data_read)[0];
            debug_print("Received: {X:2} (DR = {X:8}).\r\n", .{ dr_lsb, data_read });
            if (optional_read_pointer) |read_pointer| read_pointer.* = dr_lsb;
        }

        /// Write all given bytes on the bus, not reading anything back.
        pub fn write_all(self: Self, bytes: []const u8) !void {
            for (bytes) |b| {
                try self.transceive_byte(b, null);
            }
        }

        /// Read bytes to fill the given buffer exactly, writing arbitrary bytes (`undefined`).
        pub fn read_into(self: Self, buffer: []u8) !void {
            for (buffer) |_, i| {
                try self.transceive_byte(null, &buffer[i]);
            }
        }

        pub fn end_transfer(_: Self, comptime cs_pin: type, config: micro.spi.DeviceConfig) void {
            _ = config; // for future use
            // no delay should be needed here, since we know SPIx_SR's TXE is 1
            debug_print("(disabling SPI1)\r\n", .{});
            gpio.write(cs_pin, .high); // deselect the given device, TODO: support inverse CS devices
            // HACK: wait long enough to make any device end an ongoing transfer
            var i: u8 = 255; // with the default clock, this seems to delay ~185 microseconds
            while (i > 0) : (i -= 1) {
                asm volatile ("nop");
            }
        }
    };
}
