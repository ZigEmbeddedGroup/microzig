//! For now we keep all clock settings on the chip defaults.
//! This code currently assumes the STM32F405xx / STM32F407xx clock configuration.
//! TODO: Do something useful for other STM32F40x chips.
//!
//! Specifically, TIM6 is running on a 16 MHz clock,
//! HSI = 16 MHz is the SYSCLK after reset
//! default AHB prescaler = /1 (= values 0..7):
//!
//! ```
//! RCC.CFGR.modify(.{ .HPRE = 0 });
//! ```
//!
//! so also HCLK = 16 MHz.
//! And with the default APB1 prescaler = /1:
//!
//! ```
//! RCC.CFGR.modify(.{ .PPRE1 = 0 });
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
//! RCC.CFGR.modify(.{ .PPRE2 = 0 });
//! ```
//!
//! and therefore USART1 and USART6 receive a 16 MHz clock.
//!

const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.peripherals;
const RCC = peripherals.RCC;

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
    .cpu = 16_000_000,
    .ahb = 16_000_000,
    .apb1 = 16_000_000,
    .apb2 = 16_000_000,
};

pub fn parse_pin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'I')
        @compileError(invalid_format_msg);

    return struct {
        const pin_number: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);
        /// 'A'...'I'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(peripherals, "GPIO" ++ gpio_port_name);
        const suffix = std.fmt.comptimePrint("{d}", .{pin_number});
    };
}

fn set_reg_field(reg: anytype, comptime field_name: anytype, value: anytype) void {
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

    pub fn set_output(comptime pin: type) void {
        set_reg_field(RCC.AHB1ENR, "GPIO" ++ pin.gpio_port_name ++ "EN", 1);
        set_reg_field(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b01);
    }

    pub fn set_input(comptime pin: type) void {
        set_reg_field(RCC.AHB1ENR, "GPIO" ++ pin.gpio_port_name ++ "EN", 1);
        set_reg_field(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b00);
    }

    pub fn set_alternate_function(comptime pin: type, af: AlternateFunction) void {
        set_reg_field(RCC.AHB1ENR, "GPIO" ++ pin.gpio_port_name ++ "EN", 1);
        set_reg_field(@field(pin.gpio_port, "MODER"), "MODER" ++ pin.suffix, 0b10);
        if (pin.pin_number < 8) {
            set_reg_field(@field(pin.gpio_port, "AFRL"), "AFRL" ++ pin.suffix, @intFromEnum(af));
        } else {
            set_reg_field(@field(pin.gpio_port, "AFRH"), "AFRH" ++ pin.suffix, @intFromEnum(af));
        }
    }

    pub fn read(comptime pin: type) microzig.gpio.State {
        const idr_reg = pin.gpio_port.IDR;
        const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
        return @as(microzig.gpio.State, @enumFromInt(reg_value));
    }

    pub fn write(comptime pin: type, state: microzig.gpio.State) void {
        switch (state) {
            .low => set_reg_field(pin.gpio_port.BSRR, "BR" ++ pin.suffix, 1),
            .high => set_reg_field(pin.gpio_port.BSRR, "BS" ++ pin.suffix, 1),
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

    const PinDirection = std.meta.FieldEnum(microzig.uart.Pins);

    /// Checks if a pin is valid for a given uart index and direction
    pub fn is_valid_pin(comptime pin: type, comptime index: usize, comptime direction: PinDirection) bool {
        const pin_name = pin.name;

        return switch (direction) {
            .tx => switch (index) {
                1 => std.mem.eql(u8, pin_name, "PA9") or std.mem.eql(u8, pin_name, "PB6"),
                2 => std.mem.eql(u8, pin_name, "PA2") or std.mem.eql(u8, pin_name, "PD5"),
                3 => std.mem.eql(u8, pin_name, "PB10") or std.mem.eql(u8, pin_name, "PC10") or std.mem.eql(u8, pin_name, "PD8"),
                4 => std.mem.eql(u8, pin_name, "PA0") or std.mem.eql(u8, pin_name, "PC10"),
                5 => std.mem.eql(u8, pin_name, "PC12"),
                6 => std.mem.eql(u8, pin_name, "PC6") or std.mem.eql(u8, pin_name, "PG14"),
                else => unreachable,
            },
            // Valid RX pins for the UARTs
            .rx => switch (index) {
                1 => std.mem.eql(u8, pin_name, "PA10") or std.mem.eql(u8, pin_name, "PB7"),
                2 => std.mem.eql(u8, pin_name, "PA3") or std.mem.eql(u8, pin_name, "PD6"),
                3 => std.mem.eql(u8, pin_name, "PB11") or std.mem.eql(u8, pin_name, "PC11") or std.mem.eql(u8, pin_name, "PD9"),
                4 => std.mem.eql(u8, pin_name, "PA1") or std.mem.eql(u8, pin_name, "PC11"),
                5 => std.mem.eql(u8, pin_name, "PD2"),
                6 => std.mem.eql(u8, pin_name, "PC7") or std.mem.eql(u8, pin_name, "PG9"),
                else => unreachable,
            },
        };
    }
};

pub fn Uart(comptime index: usize, comptime pins: microzig.uart.Pins) type {
    if (index < 1 or index > 6) @compileError("Valid USART index are 1..6");

    const usart_name = std.fmt.comptimePrint("USART{d}", .{index});
    const tx_pin =
        if (pins.tx) |tx|
        if (uart.is_valid_pin(tx, index, .tx))
            tx
        else
            @compileError(std.fmt.comptimePrint("Tx pin {s} is not valid for UART{}", .{ tx.name, index }))
    else switch (index) {
        // Provide default tx pins if no pin is specified
        1 => microzig.Pin("PA9"),
        2 => microzig.Pin("PA2"),
        3 => microzig.Pin("PB10"),
        4 => microzig.Pin("PA0"),
        5 => microzig.Pin("PC12"),
        6 => microzig.Pin("PC6"),
        else => unreachable,
    };

    const rx_pin =
        if (pins.rx) |rx|
        if (uart.is_valid_pin(rx, index, .rx))
            rx
        else
            @compileError(std.fmt.comptimePrint("Rx pin {s} is not valid for UART{}", .{ rx.name, index }))
    else switch (index) {
        // Provide default rx pins if no pin is specified
        1 => microzig.Pin("PA10"),
        2 => microzig.Pin("PA3"),
        3 => microzig.Pin("PB11"),
        4 => microzig.Pin("PA1"),
        5 => microzig.Pin("PD2"),
        6 => microzig.Pin("PC7"),
        else => unreachable,
    };

    // USART1..3 are AF7, USART 4..6 are AF8
    const alternate_function = if (index <= 3) .af7 else .af8;

    const tx_gpio = microzig.Gpio(tx_pin, .{
        .mode = .alternate_function,
        .alternate_function = alternate_function,
    });
    const rx_gpio = microzig.Gpio(rx_pin, .{
        .mode = .alternate_function,
        .alternate_function = alternate_function,
    });

    return struct {
        parity_read_mask: u8,

        const Self = @This();

        pub fn init(config: microzig.uart.Config) !Self {
            // The following must all be written when the USART is disabled (UE=0).
            if (@field(peripherals, usart_name).CR1.read().UE == 1)
                @panic("Trying to initialize " ++ usart_name ++ " while it is already enabled");
            // LATER: Alternatively, set UE=0 at this point?  Then wait for something?
            // Or add a destroy() function which disables the USART?

            // enable the USART clock
            const clk_enable_reg = switch (index) {
                1, 6 => RCC.APB2ENR,
                2...5 => RCC.APB1ENR,
                else => unreachable,
            };
            set_reg_field(clk_enable_reg, usart_name ++ "EN", 1);

            tx_gpio.init();
            rx_gpio.init();

            // clear USART configuration to its default
            @field(peripherals, usart_name).CR1.raw = 0;
            @field(peripherals, usart_name).CR2.raw = 0;
            @field(peripherals, usart_name).CR3.raw = 0;

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
            @field(peripherals, usart_name).CR1.modify(.{ .M = m });

            // set parity
            if (config.parity) |parity| {
                @field(peripherals, usart_name).CR1.modify(.{ .PCE = 1, .PS = @intFromEnum(parity) });
            } // otherwise, no need to set no parity since we reset Control Registers above, and it's the default

            // set number of stop bits
            @field(peripherals, usart_name).CR2.modify(.{ .STOP = @intFromEnum(config.stop_bits) });

            // set the baud rate
            // Despite the reference manual talking about fractional calculation and other buzzwords,
            // it is actually just a simple divider. Just ignore DIV_Mantissa and DIV_Fraction and
            // set the result of the division as the lower 16 bits of BRR.
            // TODO: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            // TODO: Do a rounding div, instead of a truncating div?
            const clocks = microzig.clock.get();
            const bus_frequency = switch (index) {
                1, 6 => clocks.apb2,
                2...5 => clocks.apb1,
                else => unreachable,
            };
            const usartdiv = @as(u16, @intCast(@divTrunc(bus_frequency, config.baud_rate)));
            @field(peripherals, usart_name).BRR.raw = usartdiv;

            // enable USART, and its transmitter and receiver
            @field(peripherals, usart_name).CR1.modify(.{ .UE = 1 });
            @field(peripherals, usart_name).CR1.modify(.{ .TE = 1 });
            @field(peripherals, usart_name).CR1.modify(.{ .RE = 1 });

            // For code simplicity, at cost of one or more register reads,
            // we read back the actual configuration from the registers,
            // instead of using the `config` values.
            return read_from_registers();
        }

        pub fn get_or_init(config: microzig.uart.Config) !Self {
            if (@field(peripherals, usart_name).CR1.read().UE == 1) {
                // UART1 already enabled, don't reinitialize and disturb things;
                // instead read and use the actual configuration.
                return read_from_registers();
            } else return init(config);
        }

        fn read_from_registers() Self {
            const cr1 = @field(peripherals, usart_name).CR1.read();
            // As documented in `init()`, M0==1 means 'the 9th bit (not the 8th bit) is the parity bit'.
            // So we always mask away the 9th bit, and if parity is enabled and it is in the 8th bit,
            // then we also mask away the 8th bit.
            return Self{ .parity_read_mask = if (cr1.PCE == 1 and cr1.M == 0) 0x7F else 0xFF };
        }

        pub fn can_write(self: Self) bool {
            _ = self;
            return switch (@field(peripherals, usart_name).SR.read().TXE) {
                1 => true,
                0 => false,
            };
        }

        pub fn tx(self: Self, ch: u8) void {
            while (!self.can_write()) {} // Wait for Previous transmission
            @field(peripherals, usart_name).DR.modify(ch);
        }

        pub fn txflush(_: Self) void {
            while (@field(peripherals, usart_name).SR.read().TC == 0) {}
        }

        pub fn can_read(self: Self) bool {
            _ = self;
            return switch (@field(peripherals, usart_name).SR.read().RXNE) {
                1 => true,
                0 => false,
            };
        }

        pub fn rx(self: Self) u8 {
            while (!self.can_read()) {} // Wait till the data is received
            const data_with_parity_bit: u9 = @field(peripherals, usart_name).DR.read();
            return @as(u8, @intCast(data_with_parity_bit & self.parity_read_mask));
        }
    };
}

pub const i2c = struct {
    const PinLine = std.meta.FieldEnum(microzig.i2c.Pins);

    /// Checks if a pin is valid for a given i2c index and line
    pub fn is_valid_pin(comptime pin: type, comptime index: usize, comptime line: PinLine) bool {
        const pin_name = pin.name;

        return switch (line) {
            .scl => switch (index) {
                1 => std.mem.eql(u8, pin_name, "PB6") or std.mem.eql(u8, pin_name, "PB8"),
                2 => std.mem.eql(u8, pin_name, "PB10") or std.mem.eql(u8, pin_name, "PF1") or std.mem.eql(u8, pin_name, "PH4"),
                3 => std.mem.eql(u8, pin_name, "PA8") or std.mem.eql(u8, pin_name, "PH7"),
                else => unreachable,
            },
            // Valid RX pins for the UARTs
            .sda => switch (index) {
                1 => std.mem.eql(u8, pin_name, "PB7") or std.mem.eql(u8, pin_name, "PB9"),
                2 => std.mem.eql(u8, pin_name, "PB11") or std.mem.eql(u8, pin_name, "PF0") or std.mem.eql(u8, pin_name, "PH5"),
                3 => std.mem.eql(u8, pin_name, "PC9") or std.mem.eql(u8, pin_name, "PH8"),
                else => unreachable,
            },
        };
    }
};

pub fn I2CController(comptime index: usize, comptime pins: microzig.i2c.Pins) type {
    if (index < 1 or index > 3) @compileError("Valid I2C index are 1..3");

    const i2c_name = std.fmt.comptimePrint("I2C{d}", .{index});
    const scl_pin =
        if (pins.scl) |scl|
        if (uart.is_valid_pin(scl, index, .scl))
            scl
        else
            @compileError(std.fmt.comptimePrint("SCL pin {s} is not valid for I2C{}", .{ scl.name, index }))
    else switch (index) {
        // Provide default scl pins if no pin is specified
        1 => microzig.Pin("PB6"),
        2 => microzig.Pin("PB10"),
        3 => microzig.Pin("PA8"),
        else => unreachable,
    };

    const sda_pin =
        if (pins.sda) |sda|
        if (uart.is_valid_pin(sda, index, .sda))
            sda
        else
            @compileError(std.fmt.comptimePrint("SDA pin {s} is not valid for UART{}", .{ sda.name, index }))
    else switch (index) {
        // Provide default sda pins if no pin is specified
        1 => microzig.Pin("PB7"),
        2 => microzig.Pin("PB11"),
        3 => microzig.Pin("PC9"),
        else => unreachable,
    };

    const scl_gpio = microzig.Gpio(scl_pin, .{
        .mode = .alternate_function,
        .alternate_function = .af4,
    });
    const sda_gpio = microzig.Gpio(sda_pin, .{
        .mode = .alternate_function,
        .alternate_function = .af4,
    });

    // Base field of the specific I2C peripheral
    const i2c_base = @field(peripherals, i2c_name);

    return struct {
        const Self = @This();

        pub fn init(config: microzig.i2c.Config) !Self {
            // Configure I2C

            // 1. Enable the I2C CLOCK and GPIO CLOCK
            RCC.APB1ENR.modify(.{ .I2C1EN = 1 });
            RCC.AHB1ENR.modify(.{ .GPIOBEN = 1 });

            // 2. Configure the I2C PINs
            // This takes care of setting them alternate function mode with the correct AF
            scl_gpio.init();
            sda_gpio.init();

            // TODO: the stuff below will probably use the microzig gpio API in the future
            const scl = scl_pin.source_pin;
            const sda = sda_pin.source_pin;
            // Select Open Drain Output
            set_reg_field(@field(scl.gpio_port, "OTYPER"), "OT" ++ scl.suffix, 1);
            set_reg_field(@field(sda.gpio_port, "OTYPER"), "OT" ++ sda.suffix, 1);
            // Select High Speed
            set_reg_field(@field(scl.gpio_port, "OSPEEDR"), "OSPEEDR" ++ scl.suffix, 0b10);
            set_reg_field(@field(sda.gpio_port, "OSPEEDR"), "OSPEEDR" ++ sda.suffix, 0b10);
            // Activate Pull-up
            set_reg_field(@field(scl.gpio_port, "PUPDR"), "PUPDR" ++ scl.suffix, 0b01);
            set_reg_field(@field(sda.gpio_port, "PUPDR"), "PUPDR" ++ sda.suffix, 0b01);

            // 3. Reset the I2C
            i2c_base.CR1.modify(.{ .PE = 0 });
            while (i2c_base.CR1.read().PE == 1) {}

            // 4. Configure I2C timing
            const bus_frequency_hz = microzig.clock.get().apb1;
            const bus_frequency_mhz: u6 = @as(u6, @intCast(@divExact(bus_frequency_hz, 1_000_000)));

            if (bus_frequency_mhz < 2 or bus_frequency_mhz > 50) {
                return error.InvalidBusFrequency;
            }

            // .FREQ is set to the bus frequency in Mhz
            i2c_base.CR2.modify(.{ .FREQ = bus_frequency_mhz });

            switch (config.target_speed) {
                10_000...100_000 => {
                    // CCR is bus_freq / (target_speed * 2). We use floor to avoid exceeding the target speed.
                    const ccr = @as(u12, @intCast(@divFloor(bus_frequency_hz, config.target_speed * 2)));
                    i2c_base.CCR.modify(.{ .CCR = ccr });
                    // Trise is bus frequency in Mhz + 1
                    i2c_base.TRISE.modify(bus_frequency_mhz + 1);
                },
                100_001...400_000 => {
                    // TODO: handle fast mode
                    return error.InvalidSpeed;
                },
                else => return error.InvalidSpeed,
            }

            // 5. Program the I2C_CR1 register to enable the peripheral
            i2c_base.CR1.modify(.{ .PE = 1 });

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
                std.debug.assert(self.buffer_size < 255);
                for (bytes) |b| {
                    self.buffer[self.buffer_size] = b;
                    self.buffer_size += 1;
                    if (self.buffer_size == 255) {
                        try self.send_buffer();
                    }
                }
            }

            fn send_buffer(self: *WriteState) !void {
                if (self.buffer_size == 0) @panic("write of 0 bytes not supported");

                // Wait for the bus to be free
                while (i2c_base.SR2.read().BUSY == 1) {}

                // Send start
                i2c_base.CR1.modify(.{ .START = 1 });

                // Wait for the end of the start condition, master mode selected, and BUSY bit set
                while ((i2c_base.SR1.read().SB == 0 or
                    i2c_base.SR2.read().MSL == 0 or
                    i2c_base.SR2.read().BUSY == 0))
                {}

                // Write the address to bits 7..1, bit 0 stays at 0 to indicate write operation
                i2c_base.DR.modify(@as(u8, @intCast(self.address)) << 1);

                // Wait for address confirmation
                while (i2c_base.SR1.read().ADDR == 0) {}

                // Read SR2 to clear address condition
                _ = i2c_base.SR2.read();

                for (self.buffer[0..self.buffer_size]) |b| {
                    // Write data byte
                    i2c_base.DR.modify(b);
                    // Wait for transfer finished
                    while (i2c_base.SR1.read().BTF == 0) {}
                }
                self.buffer_size = 0;
            }

            pub fn stop(self: *WriteState) !void {
                try self.send_buffer();
                // Communication STOP
                i2c_base.CR1.modify(.{ .STOP = 1 });
                while (i2c_base.SR2.read().BUSY == 1) {}
            }

            pub fn restart_read(self: *WriteState) !ReadState {
                try self.send_buffer();
                return ReadState{ .address = self.address };
            }
            pub fn restart_write(self: *WriteState) !WriteState {
                try self.send_buffer();
                return WriteState{ .address = self.address };
            }
        };

        pub const ReadState = struct {
            address: u7,

            pub fn start(address: u7) !ReadState {
                return ReadState{ .address = address };
            }

            /// Fails with ReadError if incorrect number of bytes is received.
            pub fn read_no_eof(self: *ReadState, buffer: []u8) !void {
                std.debug.assert(buffer.len < 256);

                // Send start and enable ACK
                i2c_base.CR1.modify(.{ .START = 1, .ACK = 1 });

                // Wait for the end of the start condition, master mode selected, and BUSY bit set
                while ((i2c_base.SR1.read().SB == 0 or
                    i2c_base.SR2.read().MSL == 0 or
                    i2c_base.SR2.read().BUSY == 0))
                {}

                // Write the address to bits 7..1, bit 0 set to 1 to indicate read operation
                i2c_base.DR.modify((@as(u8, @intCast(self.address)) << 1) | 1);

                // Wait for address confirmation
                while (i2c_base.SR1.read().ADDR == 0) {}

                // Read SR2 to clear address condition
                _ = i2c_base.SR2.read();

                for (buffer, 0..) |_, i| {
                    if (i == buffer.len - 1) {
                        // Disable ACK
                        i2c_base.CR1.modify(.{ .ACK = 0 });
                    }

                    // Wait for data to be received
                    while (i2c_base.SR1.read().RxNE == 0) {}

                    // Read data byte
                    buffer[i] = i2c_base.DR.read();
                }
            }

            pub fn stop(_: *ReadState) !void {
                // Communication STOP
                i2c_base.CR1.modify(.{ .STOP = 1 });
                while (i2c_base.SR2.read().BUSY == 1) {}
            }

            pub fn restart_read(self: *ReadState) !ReadState {
                return ReadState{ .address = self.address };
            }
            pub fn restart_write(self: *ReadState) !WriteState {
                return WriteState{ .address = self.address };
            }
        };
    };
}
