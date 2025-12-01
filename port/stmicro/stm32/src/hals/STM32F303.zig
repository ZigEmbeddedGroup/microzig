pub const pins = @import("STM32F303/pins.zig");

// /--------
// | THE CODE BELOW IS OLD HAL CODE FOR UART, I2C, AND SPI
// | THAT HAS WORKED IN A PREVIOUS MICROZIG INCARNATION.
// |
// | IT SHOULD BE MOVED INTO SEPARATE FILES IN STM32F303/.
// \--------
//
// For now we keep all clock settings on the chip defaults.
// This code currently assumes the STM32F303xB / STM32F303xC clock configuration.
// TODO: Do something useful for other STM32f30x chips.
//
// Specifically, TIM6 is running on an 8 MHz clock,
// HSI = 8 MHz is the SYSCLK after reset
// default AHB prescaler = /1 (= values 0..7):
//
// ```
// RCC.CFGR.modify(.{ .HPRE = 0 });
// ```
//
// so also HCLK = 8 MHz.
// And with the default APB1 prescaler = /2:
//
// ```
// RCC.CFGR.modify(.{ .PPRE1 = 4 });
// ```
//
// results in PCLK1,
// and the resulting implicit factor *2 for TIM2/3/4/6/7
// makes TIM6 run at 8MHz/2*2 = 8 MHz.
//
// The above default configuration makes U(S)ART2..5
// (which use PCLK1 without that implicit *2 factor)
// run at 4 MHz by default.
//
// USART1 uses PCLK2, which uses the APB2 prescaler on HCLK,
// default APB2 prescaler = /1:
//
// ```
// RCC.CFGR.modify(.{ .PPRE2 = 0 });
// ```
//
// and therefore USART1 runs on 8 MHz.

const std = @import("std");

const microzig = @import("microzig");
pub const gpio = @import("STM32F303/gpio.zig");
pub const uart = @import("STM32F303/uart.zig");
pub const rcc = @import("STM32F303/rcc.zig");
pub const i2c = @import("STM32F303/i2c.zig");

const SPI1 = microzig.peripherals.SPI1;
const RCC = microzig.chip.peripherals.RCC;

const GPIOA = microzig.peripherals.GPIOA;
const GPIOB = microzig.peripherals.GPIOB;
const GPIOC = microzig.chip.peripherals.GPIOC;
const I2C1 = microzig.peripherals.I2C1;

pub const cpu = @import("cpu");

pub fn enable_fpu() void {
    microzig.cpu.peripherals.scb.CPACR.modify(.{
        .CP10 = .full_access,
        .CP11 = .full_access,
    });
    microzig.cpu.peripherals.fpu.FPCCR.modify(.{
        .ASPEN = 1,
        .LSPEN = 1,
    });
}

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
        const gpio_port = @field(microzig.peripherals, "GPIO" ++ gpio_port_name);
        const suffix = std.fmt.comptimePrint("{d}", .{pin_number});
    };
}

fn set_reg_field(reg: anytype, comptime field_name: anytype, value: anytype) void {
    var temp = reg.read();
    @field(temp, field_name) = value;
    reg.write(temp);
}

/// An STM32F303 SPI bus
pub fn SpiBus(comptime index: usize) type {
    if (!(index == 1)) @compileError("TODO: only SPI1 is currently supported");

    return struct {
        const Self = @This();

        /// Initialize and enable the bus.
        pub fn init(config: microzig.spi.BusConfig) !Self {
            _ = config; // unused for now

            // CONFIGURE SPI1
            // connected to APB2, MCU pins PA5 + PA7 + PA6 = SPC + SDI + SDO,
            // if GPIO port A is configured for alternate function 5 for these PA pins.

            // Enable the GPIO CLOCK
            RCC.AHBENR.modify(.{ .IOPAEN = 1 });

            // Configure the I2C PINs for ALternate Functions
            //  - Select Alternate Function in MODER Register
            GPIOA.MODER.modify(.{ .MODER5 = 0b10, .MODER6 = 0b10, .MODER7 = 0b10 });
            //  - Select High SPEED for the PINs
            GPIOA.OSPEEDR.modify(.{ .OSPEEDR5 = 0b11, .OSPEEDR6 = 0b11, .OSPEEDR7 = 0b11 });
            //  - Configure the Alternate Function in AFR Register
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
        pub fn switch_to_device(_: Self, comptime cs_pin: type, config: microzig.spi.DeviceConfig) void {
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
        pub fn begin_transfer(_: Self, comptime cs_pin: type, config: microzig.spi.DeviceConfig) void {
            _ = config; // for future use
            gpio.write(cs_pin, .low); // select the given device, TODO: support inverse CS devices
        }

        /// The basic operation in the current simplistic implementation:
        /// send+receive a single byte.
        /// Writing `null` writes an arbitrary byte (`undefined`), and
        /// reading into `null` ignores the value received.
        pub fn transceive_byte(_: Self, optional_write_byte: ?u8, optional_read_pointer: ?*u8) !void {

            // SPIx_DR's least significant byte is `@bitCast([dr_byte_size]u8, ...)[0]`
            const dr_byte_size = @sizeOf(@TypeOf(SPI1.DR.raw));

            // wait unril ready for write
            while (SPI1.SR.read().TXE == 0) {}

            // write
            const write_byte = if (optional_write_byte) |b| b else undefined; // dummy value
            @as([dr_byte_size]u8, @bitCast(SPI1.DR.*))[0] = write_byte;

            // wait until read processed
            while (SPI1.SR.read().RXNE == 0) {}

            // read
            const data_read = SPI1.DR.raw;
            _ = SPI1.SR.read(); // clear overrun flag
            const dr_lsb = @as([dr_byte_size]u8, @bitCast(data_read))[0];
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
            for (buffer, 0..) |_, i| {
                try self.transceive_byte(null, &buffer[i]);
            }
        }

        pub fn end_transfer(_: Self, comptime cs_pin: type, config: microzig.spi.DeviceConfig) void {
            _ = config; // for future use
            // no delay should be needed here, since we know SPIx_SR's TXE is 1

            gpio.write(cs_pin, .high); // deselect the given device, TODO: support inverse CS devices
            // HACK: wait long enough to make any device end an ongoing transfer
            var i: u8 = 255; // with the default clock, this seems to delay ~185 microseconds
            while (i > 0) : (i -= 1) {
                asm volatile ("nop");
            }
        }
    };
}
