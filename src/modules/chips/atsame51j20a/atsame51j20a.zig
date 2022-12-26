pub const std = @import("std");
pub const cpu = @import("cpu");
pub const micro = @import("microzig");
pub const chip = @import("registers.zig");

const regs = chip.registers;
pub usingnamespace chip;

pub const chip_name = "ATSAME51J20A";

pub const clock_frequencies = .{
    // On any reset the synchronous clocks start to their initial state:
    //   * DFLL48M is enabled and configured to run at 48 MHz
    //   * Generic Generator 0 uses DFLL48M as source  and generates GCLK_MAIN
    //   * CPU and BUS clocks are undivided
    // i.e. GENCTRL0 = 0x00000106
    .cpu = 48_000_000,
};

/// Get access to the pin specified by `spec`.
///
/// - `spec`: P{port}{pin}
///     - `port`: A, B
///     - `pin`: 0..31
pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'B') // J = 64 Pins; 2 Ports
        @compileError("Unknown port '" ++ spec[1..2] ++ "'. Supported ports: A, B.");

    return struct {
        // Try to parse the given pin number as u5, i.e. a value in '0'..'31'.
        const pin_number: u5 = @import("std").fmt.parseInt(u5, spec[2..], 10) catch @compileError(invalid_format_msg);
        const pin_mask: u32 = (1 << pin_number);
        // Port is either 'A' or 'B'.
        const port_number: usize = if (spec[1] == 'A') 0 else 1;
        const gpio_port = @field(regs.PORT, "GROUP");
    };
}

pub const gpio = struct {
    // See SAM D5x/E5x Family Data Sheet page 807.

    /// Configure the given pin as output with input disabled.
    pub fn setOutput(comptime pin: type) void {
        // To use pin Pxy as an output, write bit y of the DIR register to '1'. This
        // can also be done by writing bit y int the DIRSET register to '1' - this
        // will avoid disturbing the configuration of other pins (datasheet p. 803).
        pin.gpio_port[pin.port_number].DIRSET = pin.pin_mask;
        // Disable input for the given pin.
        pin.gpio_port[pin.port_number].PINCFG[pin.pin_number].modify(.{ .INEN = 0 });
    }

    /// Configure the given pin as input.
    pub fn setInput(comptime pin: type) void {
        // To use pin Pxy as an input, bit y in the DIR register must be written to '0'.
        // This can also be done by writing bit y in the DIRCLR register to '1'.
        pin.gpio_port[pin.port_number].DIRCLR = pin.pin_mask;
        // The input value can be read from bit y in register IN as soon as the INEN bit in the pin
        // configuratation register is written to '1' to enable the pins input buffer.
        pin.gpio_port[pin.port_number].PINCFG[pin.pin_number].modify(.{ .INEN = 1 });
    }

    /// Configure the given pin as input with pull-up.
    pub fn setInputPullUp(comptime pin: type) void {
        setInput(pin);
        pin.gpio_port[pin.port_number].PINCFG[pin.pin_number].modify(.{ .PULLEN = 1 });
        // When enabling input with pull-up, bit y must be set to '1'.
        write(pin, .high);
    }

    /// Configure the given pin as input with pull-down.
    pub fn setInputPullDown(comptime pin: type) void {
        setInput(pin);
        pin.gpio_port[pin.port_number].PINCFG[pin.pin_number].modify(.{ .PULLEN = 1 });
        // When enabling input with pull-down, bit y must be set to '0'.
        write(pin, .low);
    }

    /// Check if the given pin is configured as output.
    /// Returns true on success, false otherwise.
    pub fn isOutput(comptime pin: type) bool {
        return (pin.gpio_port[pin.port_number].DIR & pin.pin_mask) != 0;
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        return if ((pin.gpio_port[pin.port_number].IN & pin.pin_mask) != 0)
            micro.gpio.State.high
        else
            micro.gpio.State.low;
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        switch (state) {
            .high => pin.gpio_port[pin.port_number].OUTSET = pin.pin_mask,
            .low => pin.gpio_port[pin.port_number].OUTCLR = pin.pin_mask,
        }
    }

    pub fn toggle(comptime pin: type) void {
        pin.gpio_port[pin.port_number].OUTTGL = pin.pin_mask;
    }
};

// #############################################################################
// Nonvolotile Memory Controller - NVMCTRL
// #############################################################################

pub fn nvmctrlInit() void {
    regs.NVMCTRL.CTRLA.modify(.{
        .RWS = 5, // Number of wait states for a read operation
        .AUTOWS = 1, // Enable wait states
    });
}

// #############################################################################
// Generic Clock Controller - GCLK
// #############################################################################

pub fn gclk2Init() void {
    regs.GCLK.GENCTRL[2].modify(.{
        .DIV = 1,
        .SRC = 6, // DFLL48M generator clock source
        .GENEN = 1, // Enable generator
    });

    while (regs.GCLK.SYNCBUSY.read().GENCTRL & 2 != 0) {
        // wait for sync
    }
}

// #############################################################################
// UART
// #############################################################################

/// Calculate the BAUD register value based on the the expected output frequency
/// `fbaud` and the baud reference frequency `fref` (see data sheet p. 830).
pub fn asyncArithmeticBaudToRegister(fbaud: u32, fref: u32) u16 {
    const fb = @intToFloat(f64, fbaud);
    const fr = @intToFloat(f64, fref);
    const res = 65536.0 * (1.0 - 16.0 * (fb / fr));

    return @floatToInt(u16, res);
}

/// Unique definitions for the chip, used by the microzig.uart.Config struct.
pub const uart = struct {
    /// USART character size (p. 859).
    pub const DataBits = enum(u3) {
        eight = 0,
        nine = 1,
        five = 5,
        six = 6,
        seven = 7,
    };

    /// USART stop bits (p. 859).
    pub const StopBits = enum(u1) {
        one = 0,
        tow = 1,
    };

    /// USART parity mode (p. 858).
    pub const Parity = enum(u1) {
        even = 0,
        odd = 1,
    };
};

/// Instantiate a new USART interface.
///
/// * `index` - SERCOM{index} should be used for UART
/// * `pins` - Not supported. Please use `.{ .tx = null, .rx = null }`
pub fn Uart(comptime index: usize, comptime pins: micro.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("SAMD/E5x doesn't support custom pins");

    return struct {
        const UARTn = switch (index) {
            5 => regs.SERCOM5.USART_INT,
            else => @compileError("Currently only SERCOM5:USART_INT supported."),
        };
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            switch (index) {
                5 => {
                    gclk2Init();

                    regs.GCLK.PCHCTRL[35].modify(.{
                        .GEN = 2, // Generic clock generator 2 (see p. 156)
                        .CHEN = 1, // Enable peripheral channel
                    });

                    // When the APB clock is not provided to a module, its
                    // registers cannot be read or written.
                    regs.MCLK.APBDMASK.modify(.{ .SERCOM5_ = 1 });

                    // Enable the peripheral multiplexer selection.
                    regs.PORT.GROUP[1].PINCFG[16].modify(.{ .PMUXEN = 1 });
                    regs.PORT.GROUP[1].PINCFG[17].modify(.{ .PMUXEN = 1 });

                    // Multiplex PB16 and PB17 to peripheral function C, i.e.
                    // SERCOM5 (see page 32 and 823).
                    regs.PORT.GROUP[1].PMUX[8].modify(.{ .PMUXE = 2, .PMUXO = 2 });
                },
                else => unreachable,
            }

            // Some of the registers are enable-protected, meaning they can only
            // be written when the USART is disabled.
            UARTn.CTRLA.modify(.{ .ENABLE = 0 });

            // Wait until synchronized.
            while (UARTn.SYNCBUSY.read().ENABLE != 0) {}

            // Select USART with internal clock (0x1).
            UARTn.CTRLA.modify(.{
                .MODE = 1, // Select USART with internal clock (0x01)
                .CMODE = 0, // Select asynchronous communication mode (0x00)
                // Pin selection (data sheet p. 854)
                .RXPO = 1, // SERCOM PAD[1] is used for data reception
                .TXPO = 0, // SERCOM PAD[0] is used for data transmition
                .DORD = 1, // Configure data order (MSB = 0, LSB = 1)
                .IBON = 1, // Immediate buffer overflow notification
                .SAMPR = 0, // 16x over-sampling using arithmetic baud rate generation
            });

            // Configure parity mode.
            if (config.parity != null) {
                // Enable parity mode.
                UARTn.CTRLA.modify(.{ .FORM = 1 }); // USART frame with parity
                UARTn.CTRLB.modify(.{ .PMODE = @enumToInt(config.parity.?) });
            } else {
                // Disable parity mode.
                UARTn.CTRLA.modify(.{ .FORM = 0 }); // USART frame
            }

            // Write the Baud register (internal clock mode) to generate the
            // desired baud rate.
            UARTn.BAUD.* = asyncArithmeticBaudToRegister(config.baud_rate, 48_000_000); //@intCast(u16, config.baud_rate);

            UARTn.CTRLB.modify(.{
                .CHSIZE = @enumToInt(config.data_bits), // Configure the character size filed.
                .SBMODE = @enumToInt(config.stop_bits), // Configure the number of stop bits.
                .RXEN = 1, // Enable the receiver
                .TXEN = 1, // Enable the transmitter
            });

            //UARTn.INTENSET.modify(.{ .DRE = 1, .TXC = 1, .RXC = 1, .CTSIC = 1 });

            while (UARTn.SYNCBUSY.raw != 0) {}

            // Enable the peripheral.
            UARTn.CTRLA.modify(.{ .ENABLE = 1 });
            while (UARTn.SYNCBUSY.raw != 0) {}

            return Self{};
        }

        pub fn canWrite(self: Self) bool {
            _ = self;
            // The DRE flag ist set when DATA is empty and ready to be written.
            // The DATA register should only be written to when INTFLAG.DRE is set.
            return UARTn.INTFLAG.read().DRE == 1;
        }
        pub fn tx(self: Self, ch: u8) void {
            while (!self.canWrite()) {} // Wait for Previous transmission
            UARTn.DATA.* = ch; // Load the data to be transmitted
        }

        pub fn canRead(self: Self) bool {
            _ = self;
            // The RXC flag ist set when there are unread data in DATA.
            return UARTn.INTFLAG.read().RXC == 1;
        }
        pub fn rx(self: Self) u8 {
            while (!self.canRead()) {} // Wait till the data is received
            return @intCast(u8, UARTn.DATA.*); // Read received data
        }
    };
}

// #############################################################################
// Crypto
// #############################################################################

pub fn enableTrng() void {
    // Enable the TRNG bus clock.
    regs.MCLK.APBCMASK.modify(.{ .TRNG_ = 1 });
}

pub const crypto = struct {
    pub const random = struct {
        /// Fill the given slice with random data.
        pub fn getBlock(buffer: []u8) void {
            var rand: u32 = undefined;

            var i: usize = 0;
            while (i < buffer.len) : (i += 1) {
                if (i % 4 == 0) {
                    // Get a fresh 32 bit integer every 4th iteration.
                    rand = getWord();
                }

                // The shift value is always between 0 and 24, i.e. int cast will always succeed.
                buffer[i] = @intCast(u8, (rand >> @intCast(u5, (8 * (i % 4)))) & 0xff);
            }
        }

        /// Get a real 32 bit random integer.
        ///
        /// In most cases you'll want to use `getBlock` instead.
        pub fn getWord() u32 {
            regs.TRNG.CTRLA.modify(.{ .ENABLE = 1 });
            while (regs.TRNG.INTFLAG.read().DATARDY == 0) {
                // a new random number is generated every
                // 84 CLK_TRNG_APB clock cycles (p. 1421).
            }
            regs.TRNG.CTRLA.modify(.{ .ENABLE = 0 });
            return regs.TRNG.DATA.*;
        }

        /// Get a real 8 bit random integer.
        ///
        /// In most cases you'll want to use `getBlock` instead.
        pub fn getByte() u8 {
            return @intCast(u8, getWord() & 0xFF);
        }
    };
};
