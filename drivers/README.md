# MicroZig Driver Framework

A collection of device drivers and driver abstractions for embedded systems using MicroZig.

## Table of Contents

- [Introduction](#introduction)
- [Available Drivers](#available-drivers)
- [Base Interfaces](#base-interfaces)
  - [Datagram_Device](#datagram_device)
  - [Stream_Device](#stream_device)
  - [Digital_IO](#digital_io)
  - [I2C_Device](#i2c_device)
  - [Clock_Device](#clock_device)
  - [Block_Memory](#block_memory)
- [Writing a Simple Driver](#writing-a-simple-driver)
- [Zero-Cost Abstraction Pattern](#zero-cost-abstraction-pattern)
  - [The Problem](#the-problem)
  - [The Solution](#the-solution)
  - [Helper Init Functions](#helper-init-functions)
  - [Conditional Fields](#conditional-fields)
- [Real-World Examples](#real-world-examples)
- [HAL Implementation Guide](#hal-implementation-guide)
- [Performance Considerations](#performance-considerations)

## Introduction

The MicroZig driver framework provides a set of base interfaces that enable portable, reusable
drivers for embedded peripherals. These interfaces abstract common communication patterns (SPI, I2C,
UART, GPIO, etc.) so that drivers can work across different microcontroller families.

### Two Usage Modes

The framework (typically) supports two modes of operation:

1. **Vtable Mode (Runtime Polymorphism)**: Default mode using interface types with virtual function
   tables. Provides maximum flexibility and code reuse at the cost of one pointer dereference per
   method call.
2. **Zero-Cost Mode (Compile-Time Specialization)**: Accepts concrete struct types instead of
   interfaces, eliminating all vtable overhead through compile-time duck typing. The compiler
   verifies that the concrete type has the required methods at compile time.

### When to Use Each Mode

**Use Vtable Mode when:**
- You need runtime polymorphism (e.g., swapping devices at runtime)
- Code size is more important than performance
- The overhead of a pointer dereference is negligible for your use case
- You want maximum compatibility with different HAL implementations
- Your HAL peripheral doesn't implement all the methods in the interface
  - For example, some SPI HALs don't hold a handle to the `CS` pin, since they are stateless enums,
    so `connect` and `disconnect` are not implemented for them

**Use Zero-Cost Mode when:**
- Every cycle counts (e.g., WS2812 bit-banging, high-speed SPI)
- You know the concrete types at compile time
- You want to enable aggressive compiler optimizations (inlining, constant propagation)
- You're working on resource-constrained systems

## Available Drivers

Drivers with a checkmark are already implemented, drivers without are missing:

- **Input**
  - [x] Keyboard Matrix
  - [x] Rotary Encoder
  - [x] Debounced Button
  - Touch
    - [ ] [XPT2046](https://github.com/ZigEmbeddedGroup/microzig/issues/247)

- **Display**
  - [x] SSD1306 (I²C works, [3-wire SPI](https://github.com/ZigEmbeddedGroup/microzig/issues/251) and [4-wire SPI](https://github.com/ZigEmbeddedGroup/microzig/issues/252) are missing)
  - [x] Sharp ls0xx
  - [ ] [ST7735](https://github.com/ZigEmbeddedGroup/microzig/issues/250) (WIP)
  - [ ] [ILI9488](https://github.com/ZigEmbeddedGroup/microzig/issues/249)

- **LED**
  - [x] WS2812

- **Wireless**
  - [ ] CYW43 (WIP)
  - [ ] [SX1276, SX1278](https://github.com/ZigEmbeddedGroup/microzig/issues/248)

- **Stepper Motors**
  - [x] A4988
  - [x] DRV8825 (Implemented but untested)
  - [x] ULN2003

## Base Interfaces

All base interfaces are located in `drivers/base/` and are re-exported through `microzig.drivers.base.*`.

### Datagram_Device

**Purpose**: Abstract packet-oriented communication devices where data is transferred in fixed-size
packets with known boundaries.

**Common use cases**: SPI, Ethernet, datagram sockets

**Structure**:
```zig
pub const Datagram_Device = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        connect_fn: ?*const fn (*anyopaque) ConnectError!void,
        disconnect_fn: ?*const fn (*anyopaque) void,
        writev_fn: ?*const fn (*anyopaque, datagrams: []const []const u8) WriteError!void,
        readv_fn: ?*const fn (*anyopaque, datagrams: []const []u8) ReadError!usize,
        writev_then_readv_fn: ?*const fn (
            *anyopaque,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) (WriteError || ReadError)!void = null,
    };
};
```

**Error Types**:
- `ConnectError = {IoError, Timeout, DeviceBusy}`
- `WriteError = {IoError, Timeout, Unsupported, NotConnected}`
- `ReadError = {IoError, Timeout, Unsupported, NotConnected, BufferOverrun}`

**Key Methods**:
- `connect()` - Establish connection (e.g., assert chip-select for SPI)
- `disconnect()` - Release device (e.g., deassert chip-select)
- `write(data)` / `writev(chunks)` - Write single or multiple datagrams
- `read(buffer)` / `readv(buffers)` - Read datagrams, returns bytes read
- `write_then_read(src, dst)` - Atomic write-then-read in single transaction
- `writev_then_readv(write_chunks, read_chunks)` - Vectored write-then-read

**Usage Example**:
```zig
const mdf = microzig.drivers;

// Using vtable interface
var spi_dd = spi_dev.datagram_device();
try spi_dd.connect();
defer spi_dd.disconnect();

const cmd: []const u8 = &.{0x03, 0x00, 0x00, 0x00}; // Read command
var data: [256]u8 = undefined;
try spi_dd.write_then_read(cmd, &data);
```

---

### Stream_Device

**Purpose**: Abstract stream-oriented communication devices with continuous data flow and no packet
boundaries.

**Common use cases**: UART, character devices, streaming protocols

**Structure**:
```zig
pub const Stream_Device = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        connect_fn: ?*const fn (*anyopaque) ConnectError!void,
        disconnect_fn: ?*const fn (*anyopaque) void,
        writev_fn: ?*const fn (*anyopaque, datagram: []const []const u8) WriteError!usize,
        readv_fn: ?*const fn (*anyopaque, datagram: []const []u8) ReadError!usize,
    };
};
```

**Error Types**:
- `ConnectError = {IoError, Timeout, DeviceBusy}`
- `WriteError = {IoError, Timeout, Unsupported, NotConnected}`
- `ReadError = {IoError, Timeout, Unsupported, NotConnected}`

**Key Methods**:
- `connect()` / `disconnect()`
- `write(data)` / `writev(chunks)` - Returns actual bytes written (may be partial)
- `read(buffer)` / `readv(buffers)` - Returns actual bytes read (may be partial)
- `writer()` - Returns `std.io.Writer` compatible wrapper
- `reader()` - Returns `std.io.Reader` compatible wrapper

**Usage Example**:
```zig
var uart_sd = uart.stream_device();
try uart_sd.connect();

// Direct write
_ = try uart_sd.write("Hello, World!\r\n");

// Or use std.io.Writer interface
var writer = uart_sd.writer();
try writer.print("Temperature: {d}°C\r\n", .{temperature});
```

---

### Digital_IO

**Purpose**: Abstract single digital pin control (GPIO).

**Common use cases**: LED control, button input, chip-select pins, reset lines

**Key Types**:
```zig
pub const State = enum(u1) {
    low = 0,
    high = 1,

    pub fn invert(state: State) State;
    pub fn value(state: State) u1;
};

pub const Direction = enum { input, output };
```

**Structure**:
```zig
pub const Digital_IO = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        set_direction_fn: *const fn (*anyopaque, dir: Direction) SetDirError!void,
        set_bias_fn: *const fn (*anyopaque, bias: ?State) SetBiasError!void,
        write_fn: *const fn (*anyopaque, state: State) WriteError!void,
        read_fn: *const fn (*anyopaque) ReadError!State,
    };
};
```

**Error Types**:
- `SetDirError = {IoError, Timeout, Unsupported}`
- `SetBiasError = {IoError, Timeout, Unsupported}`
- `WriteError = {IoError, Timeout, Unsupported}`
- `ReadError = {IoError, Timeout, Unsupported}`

**Key Methods**:
- `set_direction(Direction)` - Configure as input or output
- `set_bias(?State)` - Configure pull-ups/pull-downs (`null` for no bias)
- `write(State)` - Drive pin low or high
- `read()` - Read current pin state

**Usage Example**:
```zig
var led_pin = pin.digital_io();

// Configure as output
try led_pin.set_direction(.output);

// Blink LED
while (true) {
    try led_pin.write(.high);
    hal.time.sleep_ms(500);
    try led_pin.write(.low);
    hal.time.sleep_ms(500);
}
```

---

### I2C_Device

**Purpose**: Abstract I2C (Inter-Integrated Circuit) protocol interface with address-based
communication.

**Common use cases**: Sensors, EEPROMs, display controllers, IO expanders

**Key Types**:
```zig
pub const Address = enum(u7) {
    _,
    pub const general_call: Address = @enumFromInt(0x00);

    // Validates address is not reserved (0x00-0x07, 0x78-0x7F)
    pub fn check_reserved(addr: Address) Error!void;
};

pub const Error = error{
    DeviceNotPresent,
    NoAcknowledge,
    Timeout,
    TargetAddressReserved,
    NoData,
    BufferOverrun,
    UnknownAbort,
    IllegalAddress,
};
```

**Structure**:
```zig
pub const I2C_Device = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        writev_fn: ?*const fn (*anyopaque, Address, datagrams: []const []const u8) InterfaceError!void,
        readv_fn: ?*const fn (*anyopaque, Address, datagrams: []const []u8) InterfaceError!usize,
        writev_then_readv_fn: ?*const fn (
            *anyopaque,
            Address,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) InterfaceError!void = null,
    };
};
```

**Key Methods**:
- `write(address, data)` / `writev(address, chunks)` - Write to I2C device
- `read(address, buffer)` / `readv(address, buffers)` - Read from I2C device
- `write_then_read(address, src, dst)` - Atomic write-then-read with repeated START
- `writev_then_readv(address, write_chunks, read_chunks)` - Vectored variant

**Usage Example**:
```zig
const SENSOR_ADDR: I2C_Device.Address = @enumFromInt(0x48);
const TEMP_REG: u8 = 0x00;

var i2c = i2c_device.i2c_device();

// Read temperature register (register address + 2 bytes data)
var temp_data: [2]u8 = undefined;
try i2c.write_then_read(SENSOR_ADDR, &.{TEMP_REG}, &temp_data);

const temp_raw = (@as(u16, temp_data[0]) << 8) | temp_data[1];
const temp_celsius = @as(f32, @intCast(temp_raw)) * 0.0625;
```

---

### Clock_Device

**Purpose**: Provide time tracking and sleep functionality for drivers that need timing.

**Common use cases**: Timeouts, delays, periodic events, deadline checking

**Key Types** (from `microzig.drivers.time`):
```zig
pub const Absolute = enum(u64) {
    _,
    pub fn from_us(us: u64) Absolute;
    pub fn to_us(abs: Absolute) u64;
    pub fn is_reached_by(deadline: Absolute, point: Absolute) bool;
    pub fn diff(future: Absolute, past: Absolute) Duration;
    pub fn add_duration(abs: Absolute, dur: Duration) Absolute;
};

pub const Duration = enum(u64) {
    _,
    pub fn from_us(us: u64) Duration;
    pub fn from_ms(ms: u64) Duration;
    pub fn to_us(duration: Duration) u64;
    pub fn less_than(self: Duration, other: Duration) bool;
};

pub const Deadline = struct {
    pub const no_deadline: Deadline = .init_absolute(null);

    pub fn init_absolute(abs: ?Absolute) Deadline;
    pub fn init_relative(since: Absolute, dur: ?Duration) Deadline;
    pub fn is_reached_by(deadline: Deadline, now: Absolute) bool;
    pub fn check(deadline: Deadline, now: Absolute) error{Timeout}!void;
};
```

**Structure**:
```zig
pub const Clock_Device = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        get_time_since_boot: *const fn (*anyopaque) mdf.time.Absolute,
        sleep: ?*const fn (*anyopaque, u64) void = null,
    };
};
```

**Key Methods**:
- `get_time_since_boot()` - Returns microseconds since boot as `Absolute` time
- `sleep_us(time_us)` - Sleep for N microseconds (polls if no custom sleep)
- `sleep_ms(time_ms)` - Sleep for N milliseconds
- `make_timeout(duration)` - Create deadline from current time + duration
- `is_reached(absolute_time)` - Check if time point has passed

**Usage Example**:
```zig
var clock = hal.drivers.clock_device();

// Create timeout
const timeout = clock.make_timeout(mdf.time.Duration.from_ms(100));

// Poll with timeout
while (!is_ready()) {
    if (clock.is_reached(timeout)) {
        return error.Timeout;
    }
}

// Or just sleep
clock.sleep_ms(10);
```

---

### Block_Memory

**Purpose**: Abstract flash/block memory operations with sector-based erase and write.

**Common use cases**: Flash memory, EEPROM, SD cards, on-chip flash

**Error Types**:
```zig
pub const BaseError = error{ Unsupported, InvalidSector };
pub const WriteError = BaseError || error{ SectorOverrun, WriteDisabled };
pub const ReadError = BaseError || error{ReadDisabled};
```

**Structure**:
```zig
pub const Block_Memory = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        enable_write_fn: ?*const fn (*anyopaque) BaseError!void,
        disable_write_fn: ?*const fn (*anyopaque) BaseError!void,
        erase_fn: ?*const fn (*anyopaque, sector: u32) WriteError!void,
        write_fn: ?*const fn (*anyopaque, sector: u32, data: []u8) WriteError!void,
        read_fn: ?*const fn (*anyopaque, offset: u32, data: []u8) ReadError!usize,
        sector_size_fn: ?*const fn (*anyopaque, sector: u32) BaseError!u32,
    };
};
```

**Key Methods**:
- `enable_write()` / `disable_write()` - Control write protection
- `erase_sector(sector)` - Erase a sector (required before writing)
- `write(sector, data)` - Write to sector (automatically erases first, checks bounds)
- `read(offset, buffer)` - Read from memory, returns bytes read
- `sector_size(sector)` - Get sector capacity in bytes

**Usage Example**:
```zig
var flash = dev.block_memory();

// Write to sector 0
const data = "Configuration data...";
try flash.enable_write();
defer flash.disable_write() catch {};

try flash.write(0, data);

// Read back
var buffer: [256]u8 = undefined;
const bytes_read = try flash.read(0, &buffer);
```

---

## Writing a Simple Driver

Let's create a simple LED driver that demonstrates the basic pattern. This driver will control an
LED using a Digital_IO interface with optional compile-time specialization.

### Driver Structure

```zig
const std = @import("std");
const mdf = @import("microzig").drivers;

/// Configuration options for LED driver
pub const LED_Driver_Options = struct {
    /// Digital I/O interface type (defaults to vtable interface)
    Digital_IO: type = mdf.base.Digital_IO,
    /// Whether LED is active-high (true) or active-low (false)
    active_high: bool = true,
};

/// Create an LED driver instance
pub fn LED_Driver(comptime options: LED_Driver_Options) type {
    return struct {
        const Self = @This();

        /// The pin controlling the LED
        pin: options.Digital_IO,

        /// Initialize the LED driver
        pub fn init(pin: options.Digital_IO) !Self {
            var self = Self{ .pin = pin };

            // Configure pin as output
            try self.pin.set_direction(.output);

            // Start with LED off
            try self.off();

            return self;
        }

        /// Turn LED on
        pub fn on(self: Self) !void {
            const state = if (options.active_high) .high else .low;
            try self.pin.write(state);
        }

        /// Turn LED off
        pub fn off(self: Self) !void {
            const state = if (options.active_high) .low else .high;
            try self.pin.write(state);
        }

        /// Toggle LED state
        pub fn toggle(self: Self) !void {
            const current = try self.pin.read();
            try self.pin.write(current.invert());
        }
    };
}
```

### Usage - Vtable Mode

This mode uses the default vtable interface, allowing runtime flexibility:

```zig
const hal = microzig.hal;

// Get GPIO pin and wrap in Digital_IO interface
var gpio_pin = hal.gpio.Pin.init(0, 13); // PA13
var digital_io = gpio_pin.digital_io();  // Returns vtable interface

// Create LED driver with default options (uses vtable)
const LED = LED_Driver(.{});
var led = try LED.init(digital_io);

// Use the LED
try led.on();
hal.time.sleep_ms(500);
try led.off();
```

### Usage - Zero-Cost Mode

This mode uses concrete types, eliminating vtable overhead:

```zig
const hal = microzig.hal;

// Get GPIO pin (concrete type, no vtable)
var gpio_pin = hal.gpio.Pin.init(0, 13); // PA13

// Create LED driver specialized for concrete Pin type
const LED = LED_Driver(.{
    .Digital_IO = hal.drivers.GPIO_Device, // Concrete type!
    .active_high = true,
});
var led = try LED.init(gpio_pin);  // Pass concrete pin directly

// Use the LED (all calls are direct, no vtable indirection)
try led.on();
hal.time.sleep_ms(500);
try led.off();
```

The compiler will verify that `hal.gpio.Pin` has the required methods (`set_direction`, `write`,
`read`) with compatible signatures. If the interface doesn't match, you'll get a compile error.

---

## Zero-Cost Abstraction Pattern

This section explores the comptime type parameter pattern in depth, showing how MicroZig drivers
achieve zero-cost abstraction.

### The Problem

Traditional interface-based designs face a trade-off:

1. **Vtable Interfaces**: Flexible and reusable, but incur runtime overhead (pointer dereference per call)
2. **Concrete Types**: Zero overhead, but require code duplication for each platform

For high-performance drivers (e.g., WS2812 LED timing, high-speed SPI), the vtable overhead can be significant.

### The Solution

Zig's comptime system enables a third approach: **type parameters with defaults**. The driver
accepts a `type` parameter that defaults to the vtable interface but can be overridden with a
concrete struct type.

```zig
pub const Driver_Options = struct {
    // Defaults to vtable interface
    Device_Interface: type = mdf.base.Datagram_Device,
    // Other configuration...
};

pub fn Driver(comptime options: Driver_Options) type {
    return struct {
        // Field uses the provided type (vtable or concrete)
        dev: options.Device_Interface,

        pub fn init(dev: options.Device_Interface) !@This() {
            return .{ .dev = dev };
        }

        pub fn operation(self: @This()) !void {
            // Call method - direct if concrete, vtable if interface
            try self.dev.connect();
            defer self.dev.disconnect();
            // ...
        }
    };
}
```

**How it works:**

1. **Default behavior**: `Driver(.{})` uses vtable interface (backward compatible)
2. **Zero-cost mode**: `Driver(.{ .Device_Interface = ConcreteType })` uses concrete type
3. **Compile-time verification**: Compiler checks that concrete type has required methods
4. **No runtime penalty**: Direct method calls when using concrete types

### Helper Init Functions

A common pattern is to provide a helper `init()` function that infers the concrete type from the
argument using `@TypeOf()` (for example, in the [PCA9685 driver](io_expander/pca9685.zig):

```zig
const std = @import("std");
const mdf = @import("microzig").drivers;

pub const Display_Options = struct {
    width: comptime_int,
    height: comptime_int,
    Datagram_Device: type = mdf.base.Datagram_Device,
};

/// Helper init function that infers type from argument
pub fn init(
    comptime width: comptime_int,
    comptime height: comptime_int,
    datagram_device: anytype,  // Accept any type
) !Display(.{
    .width = width,
    .height = height,
    .Datagram_Device = @TypeOf(datagram_device),  // Infer concrete type
}) {
    // Create specialized type
    const Type = Display(.{
        .width = width,
        .height = height,
        .Datagram_Device = @TypeOf(datagram_device),
    });

    // Forward to actual init
    return Type.init(datagram_device);
}

/// Main generic driver
pub fn Display(comptime options: Display_Options) type {
    return struct {
        const Self = @This();
        dd: options.Datagram_Device,

        pub fn init(dd: options.Datagram_Device) !Self {
            return .{ .dd = dd };
        }

        // ... driver implementation
    };
}
```

**Usage with type inference:**

```zig
const hal = microzig.hal;

// Create concrete SPI device
var spi_dev = hal.drivers.SPI_Datagram_Device(...).init(...);

// Type is inferred from spi_dev - no need to specify!
var display = try init(160, 68, spi_dev);
//                                ^^^^^^
//                        Type inferred as @TypeOf(spi_dev)

// Equivalent to manually specifying:
// var display = Display(.{
//     .width = 160,
//     .height = 68,
//     .Datagram_Device = @TypeOf(spi_dev),
// }).init(spi_dev);
```

This pattern provides the best of both worlds: zero-cost abstraction with ergonomic usage.

### Conditional Fields

You can use comptime to include or exclude fields based on configuration, achieving true zero-cost
for unused features:

```zig
pub const Display_Config = struct {
    width: comptime_int,
    height: comptime_int,
    vcom_mode: enum { none, software },  // VCOM toggling mode
    Datagram_Device: type = mdf.base.Datagram_Device,
    Digital_IO: ?type = null,  // Optional display enable pin
};

pub fn Display(comptime config: Display_Config) type {
    return struct {
        const Self = @This();

        dd: config.Datagram_Device,

        // Pin field only exists if Digital_IO is provided
        disp_pin: if (config.Digital_IO) |T| T else void,

        // VCOM state only exists if software VCOM is enabled
        vcom_state: if (config.vcom_mode == .software) bool else void,

        pub fn init(
            dd: config.Datagram_Device,
            disp_pin: if (config.Digital_IO) |T| T else void,
        ) !Self {
            var self = Self{
                .dd = dd,
                .disp_pin = disp_pin,
                .vcom_state = if (config.vcom_mode == .software) false else {},
            };

            // Enable display if Digital_IO is provided
            if (comptime config.Digital_IO != null) {
                try self.disp_pin.write(.high);
            }

            return self;
        }

        /// Toggle VCOM (no-op if vcom_mode == .none)
        pub fn toggle_vcom(self: *Self) !void {
            if (comptime config.vcom_mode == .software) {
                self.vcom_state = !self.vcom_state;
                // ... send VCOM command
            }
            // If vcom_mode == .none, this function compiles to nothing
        }
    };
}
```

**Benefits:**

- **Zero overhead**: Unused fields don't exist in the struct
- **Zero code**: Disabled features compile away completely
- **Type safety**: Compiler enforces correct usage at compile time

**Usage:**

```zig
// Display with no VCOM, no enable pin - minimal overhead
const DisplayBasic = Display(.{
    .width = 160,
    .height = 68,
    .vcom_mode = .none,
    .Digital_IO = null,
});

// Display with VCOM and enable pin - only pays for what you use
const DisplayFull = Display(.{
    .width = 400,
    .height = 240,
    .vcom_mode = .software,
    .Digital_IO = hal.gpio.Pin,
});
```

---

## Real-World Examples

This section shows excerpts from actual MicroZig drivers demonstrating various patterns.

### Sharp Memory LCD - Optional Features

**File**: `drivers/display/sharp_memory_lcd.zig`

This driver demonstrates conditional fields and compile-time feature selection:

```zig
pub const Config = struct {
    width: comptime_int,
    height: comptime_int,
    vcom_mode: VCOM_Mode = .none,
    Datagram_Device: type = mdf.base.Datagram_Device,
    Digital_IO: ?type = null,
};

pub fn Sharp_Memory_LCD(comptime config: Config) type {
    return struct {
        const Self = @This();

        dd: config.Datagram_Device,

        // Pin only exists if Digital_IO is provided
        disp_pin: if (config.Digital_IO) |T| T else void,

        // VCOM state only exists if software VCOM is enabled
        vcom_state: if (config.vcom_mode == .software) bool else void,

        /// Get command byte with optional VCOM bit (zero-cost when disabled)
        fn get_command_byte(self: *Self, base_cmd: Cmd) u8 {
            if (comptime config.vcom_mode == .software) {
                // Toggle VCOM state
                self.vcom_state = !self.vcom_state;
                return @intFromEnum(base_cmd) |
                       if (self.vcom_state) @intFromEnum(Cmd.VCOM) else 0;
            }
            // No VCOM overhead for displays that don't need it
            return @intFromEnum(base_cmd);
        }
    };
}
```

**Usage:**

```zig
// nice!view display - no VCOM needed
const Display = mdf.display.Sharp_Memory_LCD(.{
    .width = 160,
    .height = 68,
    .vcom_mode = .none,  // Feature disabled at compile time
    .Datagram_Device = @TypeOf(spi_dev),  // Zero-cost concrete type
});
```

### WS2812 - Multiple Type Parameters

**File**: `drivers/led/ws2812.zig`

This driver accepts multiple interface types:

```zig
pub fn WS2812(options: struct {
    max_led_count: usize = 1,
    Datagram_Device: type = mdf.base.Datagram_Device,
    Clock_Device: type = mdf.base.Clock_Device,
}) type {
    return struct {
        const Self = @This();

        dev: options.Datagram_Device,
        clock_dev: options.Clock_Device,

        pub fn init(
            dev: options.Datagram_Device,
            clock_dev: options.Clock_Device,
        ) Self {
            return .{
                .dev = dev,
                .clock_dev = clock_dev,
            };
        }

        pub fn write(self: Self, colors: []const Color) !void {
            // Use clock for timing
            const deadline = self.clock_dev.make_timeout(
                mdf.time.Duration.from_us(50)
            );

            // Use datagram device for SPI transfer
            try self.dev.connect();
            defer self.dev.disconnect();

            for (colors) |color| {
                // Encode and send RGB data
                try self.dev.write(&encode_color(color));
            }

            // Wait for latch
            while (!self.clock_dev.is_reached(deadline)) {}
        }
    };
}
```

**Usage with concrete types:**

```zig
// Create with concrete types for maximum performance
var ws2812: WS2812(.{
    .max_led_count = 1,
    .Datagram_Device = hal.drivers.SPI_Device,
    .Clock_Device = hal.drivers.Clock,
}) = .init(spi_dev, clock);

const red: Color = .{ .r = 255, .g = 0, .b = 0 };
try ws2812.write(&.{red});
```

### PCA9685 - Helper Init with @TypeOf

**File**: `drivers/io_expander/pca9685.zig`

This driver provides a helper init function that infers the type:

```zig
pub const PCA9685_Config = struct {
    Datagram_Device: type = mdf.base.Datagram_Device,
    oscillator_frequency: u32 = 25_000_000,
};

/// Helper function that infers concrete type from argument
pub fn init(
    datagram_device: anytype,
    frequency: u32,
) !PCA9685(.{ .Datagram_Device = @TypeOf(datagram_device) }) {
    const Type = PCA9685(.{
        .Datagram_Device = @TypeOf(datagram_device),
        //                  ^^^^^^ Type inference!
    });

    return Type.init(datagram_device, frequency);
}

/// Main generic driver
pub fn PCA9685(comptime config: PCA9685_Config) type {
    return struct {
        const Self = @This();
        dd: config.Datagram_Device,

        fn init(dd: config.Datagram_Device, frequency: u32) !Self {
            var self = Self{ .dd = dd };
            try self.reset();
            try self.set_pwm_freq(frequency);
            return self;
        }

        // ... PWM control methods
    };
}
```

**Usage:**

```zig
// Type is automatically inferred from i2c_dev
var pwm = try pca9685.init(i2c_dev, 50);  // 50 Hz for servos

// Equivalent to manually specifying:
// var pwm = pca9685.PCA9685(.{
//     .Datagram_Device = @TypeOf(i2c_dev),
// }).init(i2c_dev, 50);
```

### SSD1306 - Mode-Dependent Types

**File**: `drivers/display/ssd1306.zig`

This driver adjusts struct fields based on the communication mode:

```zig
pub const Driver_Mode = enum { i2c, spi_3wire, spi_4wire, dynamic };

pub const SSD1306_Options = struct {
    mode: Driver_Mode,
    Datagram_Device: type = mdf.base.Datagram_Device,
    Digital_IO: type = mdf.base.Digital_IO,
};

pub fn SSD1306_Generic(comptime options: SSD1306_Options) type {
    return struct {
        const Self = @This();
        const Datagram_Device = options.Datagram_Device;

        // Digital_IO only exists for 4-wire SPI mode
        const Digital_IO = switch (options.mode) {
            .spi_4wire, .dynamic => options.Digital_IO,
            .i2c, .spi_3wire => void,  // Not used - no overhead
        };

        dd: Datagram_Device,
        dev_pin: Digital_IO,  // Will be 'void' for I2C/3-wire SPI

        // Init varies by mode
        pub fn init_without_io(dd: Datagram_Device) !Self {
            return .{
                .dd = dd,
                .dev_pin = {},  // void for I2C/3-wire modes
            };
        }

        pub fn init_with_io(dd: Datagram_Device, pin: Digital_IO) !Self {
            return .{
                .dd = dd,
                .dev_pin = pin,
            };
        }
    };
}
```

### Keyboard Matrix - Arrays of Concrete Types

**File**: `drivers/input/keyboard-matrix.zig`

This driver uses arrays of concrete Digital_IO types:

```zig
pub const Keyboard_Matrix_Options = struct {
    rows: usize,
    columns: usize,
    Digital_IO: type = mdf.base.Digital_IO,
};

pub fn Keyboard_Matrix(comptime options: Keyboard_Matrix_Options) type {
    return struct {
        const Matrix = @This();
        const Digital_IO: type = options.Digital_IO;

        // Arrays of concrete types
        cols: [options.columns]Digital_IO,
        rows: [options.rows]Digital_IO,

        pub fn init(
            cols: [options.columns]Digital_IO,
            rows: [options.rows]Digital_IO,
        ) !Matrix {
            var self = Matrix{
                .cols = cols,
                .rows = rows,
            };

            // Configure all pins
            for (&self.cols) |*col| {
                try col.set_direction(.output);
                try col.write(.high);
            }
            for (&self.rows) |*row| {
                try row.set_direction(.input);
                try row.set_bias(.high);
            }

            return self;
        }

        pub fn scan(self: *Matrix) !u64 {
            var state: u64 = 0;
            for (self.cols, 0..) |*col, col_idx| {
                try col.write(.low);

                for (self.rows, 0..) |*row, row_idx| {
                    const pin_state = try row.read();
                    if (pin_state == .low) {
                        const key = row_idx * options.columns + col_idx;
                        state |= (@as(u64, 1) << @intCast(key));
                    }
                }

                try col.write(.high);
            }
            return state;
        }
    };
}
```

---

## HAL Implementation Guide

This section shows how to create HAL wrappers that implement the base interfaces.

### Creating a Concrete Implementation

Here's how the CH32V port implements `SPI_Datagram_Device`:

**File**: `port/wch/ch32v/src/hals/drivers.zig`

```zig
const spi = @import("./spi.zig");
const gpio = @import("./gpio.zig");
const mdf = microzig.drivers;

/// SPI Datagram Device implementation
/// Generic over SPI configuration to enable compile-time DMA optimization
pub fn SPI_Datagram_Device(comptime config: spi.Config) type {
    return struct {
        const Self = @This();
        // ... Add required fields

        pub fn init(...) Self {
            return .{...};
        }

        /// Create vtable interface from this concrete type
        pub fn datagram_device(dev: *Self) Datagram_Device {
            return .{
                .ptr = dev,
                .vtable = &datagram_vtable,
            };
        }

        // Direct method implementations (for zero-cost mode)
        pub fn connect(dev: Self) !void {
            ...
        }

        pub fn disconnect(dev: Self) void {
            ...
        }

        pub fn writev(dev: Self, chunks: []const []const u8) !void {
            ...
        }

        pub fn readv(dev: Self, chunks: []const []u8) !usize {
            ...
        }

        pub fn writev_then_readv(
            dev: Self,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) !void {
            ...
        }

        // Vtable implementation (for runtime polymorphism mode)

        const datagram_vtable = Datagram_Device.VTable{
            .connect_fn = connect_fn,
            .disconnect_fn = disconnect_fn,
            .writev_fn = writev_fn,
            .readv_fn = readv_fn,
            .writev_then_readv_fn = writev_then_readv_fn,
        };

        fn connect_fn(dd: *anyopaque) !void {
            ...
        }

        fn disconnect_fn(dd: *anyopaque) void {
            ...
        }

        fn writev_fn(dd: *anyopaque, chunks: []const []const u8) !void {
            ...
        }

        fn readv_fn(dd: *anyopaque, chunks: []const []u8) !usize {
            ...
        }

        fn writev_then_readv_fn(
            dd: *anyopaque,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) !void {
            ...
        }
    };
}
```

### Key Points

1. **Concrete struct**: Define a regular struct with the actual implementation
2. **Direct methods**: Implement methods directly on the struct (e.g., `connect()`, `writev()`)
3. **Error mapping**: Map HAL-specific errors to interface error types
4. **Vtable wrapper**: Provide `_fn` wrapper functions that extract the pointer and call the direct methods
5. **VTable const**: Define a const VTable instance with pointers to wrapper functions
6. **Helper function**: Provide a function (e.g., `datagram_device()`) to create the vtable interface

### Usage Patterns

```zig
// Pattern 1: Use vtable interface (runtime polymorphism)
var spi_dev = SPI_DD.init(spi1, cs_pin, false, timeout);
var datagram_if = spi_dev.datagram_device();  // Get vtable interface

const Display = Sharp_Memory_LCD(.{});  // Uses default vtable type
var display = Display.init(datagram_if, {});

// Pattern 2: Use concrete type directly (zero-cost)
const SPI_DD = hal.drivers.SPI_Datagram_Device(spi_config);
var spi_dev = SPI_DD.init(spi1, cs_pin, false, timeout);

const Display = Sharp_Memory_LCD(.{
    .Datagram_Device = SPI_DD,  // Concrete type
});
var display = Display.init(spi_dev, {});

```

---

## Performance Considerations

### Overhead Analysis

**Vtable Mode:**
- Each method call requires one pointer dereference: `vtable.method_fn(ptr, args...)`
- Typically 1-4 CPU cycles of overhead per call
- Prevents inlining and constant propagation across the interface boundary
- Code size: one vtable per implementation (~6-8 pointers)

**Zero-Cost Mode:**
- Direct method calls resolved at compile time
- Zero runtime overhead - identical to hand-written code
- Enables full compiler optimizations (inlining, constant propagation, dead code elimination)
- Code size: potentially larger due to monomorphization (one copy per concrete type)

### When Overhead Matters

**Vtable overhead is negligible for:**
- Infrequent operations (initialization, configuration)
- I/O-bound operations (the communication time dominates)
- Operations with error handling overhead
- Most typical embedded use cases

**Vtable overhead is significant for:**
- Timing-critical bit-banging (WS2812, software SPI, 1-Wire)
- High-frequency polling loops
- Operations inside interrupt handlers
- Real-time signal processing

### Optimization Guidelines

1. **Start with vtable mode** - It's simpler and usually fast enough
2. **Measure first** - Profile before optimizing
3. **Use zero-cost mode when:**
   - Profiling shows interface calls are a bottleneck
   - Timing is critical (e.g., nanosecond-level precision)
   - Code size is not a constraint
4. **Consider hybrid approach:**
   ```zig
   // I2C uses vtable (plenty fast)
   i2c_dev: mdf.base.I2C_Device,

   // Clock uses concrete type (called frequently in tight loops)
   clock_dev: hal.Clock,
   ```

### Measuring Performance

```zig
const start = clock.get_time_since_boot();

// Your operation
for (0..1000) |_| {
    try device.operation();
}

const elapsed = clock.get_time_since_boot().to_us() - start.to_us();
std.log.info("Average time: {} us per operation", .{elapsed / 1000});
```

Compare vtable vs zero-cost to quantify the difference for your specific use case.
