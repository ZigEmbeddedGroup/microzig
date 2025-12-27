# TODO Analysis - Batch 06

**Batch**: Items 184-208 (port directory - STM32 and ESP32)
**Total TODOs**: 25

---

### TODO #184: Better system to detect if hal is present

**Location**: `port/stmicro/stm32/src/generate.zig:253`  
**Author**: Matt Knight (2024-07-28)  
**Commit**: 3a0c2e51 - "stm32: port target generation over to builder, more idiomatic"

**Original Comment**:
```zig
// TODO: Better system to detect if hal is present.
```

**Code Context**:
```zig
     243:             },
     244:         },
     245: 
     246:         .hal = .{
     247:             .root_source_file = b.path("src/hals/STM32F103.zig"),
     248:         },
     249: 
     250:     };
     251: 
     252: 
>>> 253:         // TODO: Better system to detect if hal is present.
     254:         if (std.mem.startsWith(u8, chip_file.name, "STM32F103")) {
     255:             try writer.writeAll(
     256:                 \\        .hal = .{
     257:                 \\            .root_source_file = b.path("src/hals/STM32F103.zig"),
     258:                 \\        },
     259:                 \\
     260:             );
     261:         }
     262:         if (std.mem.startsWith(u8, chip_file.name, "STM32L47")) {
     263:             try writer.writeAll(
```

**Analysis**:

- **Purpose**: Create a more robust mechanism to determine which STM32 chips have HAL implementations available, rather than hardcoding string prefix checks
- **Why Incomplete**: Code generation script was ported to new build system but HAL detection logic remained simplistic. A proper mapping/registry system would be better but requires more infrastructure
- **Complexity**: Medium - needs design of HAL registry or metadata system
- **Related Items**: Related to chip generation and HAL architecture

**Recommendation**: Create a configuration file (JSON/Zig) that maps chip families to their HAL implementations, or implement a file-system based discovery mechanism that checks for HAL file existence

---

### TODO #185: Define UsbErrorStatus struct

**Location**: `port/stmicro/stm32/src/hals/STM32F103/usb_internals/usb_ll.zig:174`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
const UsbErrorStatus = struct {}; //TODO
```

**Code Context**:
```zig
     164: };
     165: 
     166: const UsbStatus = struct {
     167:     count: u10,
     168:     nak: bool,
     169:     double_buffer: bool,
     170:     completed: bool,
     171: };
     172: 
     173: ///TODO: fill the error status struct
>>> 174: const UsbErrorStatus = struct {}; //TODO
     175: 
     176: pub const UsbEndpoint = struct {
     177:     btable: []volatile u16,
     178:     addr: u8,
     179:     dir: UsbDir,
     180:     pending: bool,
     181:     ep_type: UsbEpType,
     182:     data_buf: []u8,
     183:     last_setup: usb.types.SetupPacket,
     184:
```

**Analysis**:

- **Purpose**: Define the USB error status structure to track USB communication errors (overruns, CRC errors, timeout, etc.)
- **Why Incomplete**: Basic USB functionality works without detailed error tracking; error handling was deferred for initial implementation
- **Complexity**: Low - straightforward struct definition based on STM32F103 USB peripheral registers
- **Related Items**: Part of STM32F103 USB low-level driver implementation

**Recommendation**: Review STM32F103 reference manual USB section for error status bits and populate struct with appropriate fields (bit_stuff_error, crc_error, timeout, etc.)

---

### TODO #186: Implement SPI modes (3-Wire, Slave, bidirectional)

**Location**: `port/stmicro/stm32/src/hals/STM32F103/spi.zig:28`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
///TODO: 3-Wire mode, Slave mode, bidirectional mode
```

**Code Context**:
```zig
      18: ///    - Full-Duplex Master Mode
      19: ///    - NSS (Hardware/Software) configuration
      20: ///    - 8/16 bit mode
      21: ///- Missing SPI features:
      22: ///    - Slave mode
      23: ///    - I2S mode
      24: ///    - CRC
      25: ///    - TI and Motorola modes
      26: ///    - DMA
      27: ///    - interrupts
>>> 28: ///TODO: 3-Wire mode, Slave mode, bidirectional mode
      29: 
      30: const hal = @import("../hal.zig");
      31: const regs = hal.regs;
      32: const common = hal.common;
      33: 
      34: pub const SPI = struct {
      35:     id: SpiId,
      36:     cfg: Config,
      37:     enabled: bool,
      38:
```

**Analysis**:

- **Purpose**: Extend SPI driver to support additional communication modes beyond full-duplex master
- **Why Incomplete**: Initial implementation focused on most common use case (full-duplex master); other modes require different initialization and data transfer logic
- **Complexity**: Medium - each mode requires different register configuration and potentially different APIs
- **Related Items**: Part of comprehensive SPI driver feature set

**Recommendation**: Implement modes incrementally as needed: start with bidirectional mode (half-duplex), then slave mode, finally 3-wire. Each requires different Config options and potentially separate transfer functions

---

### TODO #187: Implement UART Half-Duplex mode

**Location**: `port/stmicro/stm32/src/hals/STM32F103/uart.zig:1`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
//TODO: Half-Duplex (Single-Wire mode)
```

**Code Context**:
```zig
>>> 1: //TODO: Half-Duplex (Single-Wire mode)
    2: //TODO: Synchronous mode (For USART only)
    3: //TODO: Interrupts
    4: //TODO: DMA
    5: 
    6: const std = @import("std");
    7: const hal = @import("../hal.zig");
    8: const Pin = hal.Pin;
    9: 
   10: pub const Usart = struct {
   11:     usart: UsartId,
```

**Analysis**:

- **Purpose**: Add support for single-wire half-duplex UART communication mode
- **Why Incomplete**: Full-duplex mode covers most use cases; half-duplex requires different pin configuration and TX/RX switching logic
- **Complexity**: Low-Medium - requires setting HDSEL bit in CR3 register and managing direction switching
- **Related Items**: Related to TODO #188 (Synchronous mode) - both are advanced UART features

**Recommendation**: Add half_duplex flag to config, set CR3.HDSEL during init, provide separate send/receive functions that handle direction switching

---

### TODO #188: Implement UART Synchronous mode

**Location**: `port/stmicro/stm32/src/hals/STM32F103/uart.zig:2`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
//TODO: Synchronous mode (For USART only)
```

**Code Context**:
```zig
    1: //TODO: Half-Duplex (Single-Wire mode)
>>> 2: //TODO: Synchronous mode (For USART only)
    3: //TODO: Interrupts
    4: //TODO: DMA
    5: 
    6: const std = @import("std");
    7: const hal = @import("../hal.zig");
    8: const Pin = hal.Pin;
    9: 
   10: pub const Usart = struct {
   11:     usart: UsartId,
   12:     baud_rate: u32,
```

**Analysis**:

- **Purpose**: Add synchronous mode where USART generates clock signal for synchronized communication
- **Why Incomplete**: Asynchronous mode is sufficient for most UART use cases; synchronous mode is less commonly needed
- **Complexity**: Medium - requires clock pin configuration, CLKEN bit, and clock polarity/phase settings
- **Related Items**: Only applicable to USART peripherals (not basic UART)

**Recommendation**: Add synchronous config option including clock polarity (CPOL), clock phase (CPHA), and last bit clock pulse (LBCL) settings. Requires CK pin configuration.

---

### TODO #189: Handle 10-bit I2C addresses in STM32 HAL

**Location**: `port/stmicro/stm32/src/hals/STM32F103/drivers.zig:12`  
**Author**: Matt Knight (2024-11-15)  
**Commit**: c8fa6fce - "i2c: introduce device interface, and make it testable"

**Original Comment**:
```zig
// TODO: The STM HAL still has its own I2CAddress type, since it supports 10 bit addresses. For now
```

**Code Context**:
```zig
      2: 
      3: // Drivers for common peripherals like I2C, SPI, UART
      4: 
      5: const drivers = @import("microzig").drivers;
      6: const I2CDevice = drivers.I2CDevice;
      7: const I2CController = drivers.I2CController;
      8: 
      9: const hal = @import("hal.zig");
     10: const i2c = hal.i2c;
     11: 
>>> 12: // TODO: The STM HAL still has its own I2CAddress type, since it supports 10 bit addresses. For now
     13: // it just wraps a 7 bit address. We should also wrap 10 bit addresses, and handle them properly, somehow.
     14: 
     15: pub const I2C = struct {
     16:     internal: i2c.I2C,
     17: 
     18:     pub fn initController(config: i2c.I2C.ControllerConfig) !I2C {
     19:         return .{
     20:             .internal = try i2c.I2C.initController(config),
     21:         };
     22:     }
```

**Analysis**:

- **Purpose**: Unify I2C address handling to support both 7-bit and 10-bit I2C addressing modes
- **Why Incomplete**: Most I2C devices use 7-bit addressing; 10-bit support was deferred during refactoring to common driver interface
- **Complexity**: Medium - requires updating I2CDevice interface and STM32 HAL to discriminate address types
- **Related Items**: Part of microzig drivers standardization effort

**Recommendation**: Extend I2CAddress type to be a tagged union (7-bit/10-bit), update STM32 I2C HAL to handle 10-bit addressing protocol (send 11110XX address header)

---

### TODO #190: Use deadline instead of timeout for I2C operations

**Location**: `port/stmicro/stm32/src/hals/STM32F103/drivers.zig:209`  
**Author**: Matt Knight (2024-11-15)  
**Commit**: c8fa6fce - "i2c: introduce device interface, and make it testable"

**Original Comment**:
```zig
// TODO: Should be a deadline since the timeout is doubled with two calls
```

**Code Context**:
```zig
     199:     }
     200: 
     201:     pub fn writeRegister(device: I2CDevice, register_address: u8, byte: u8) !void {
     202:         const controller: *I2C = @ptrCast(@alignCast(device.controller));
     203: 
     204:         try controller.internal.write(device.address, &.{register_address, byte});
     205:     }
     206: 
     207:     pub fn writeVectorized(device: I2CDevice, iov: []const I2CController.Message, timeout_us: u32) !void {
     208:         const controller: *I2C = @ptrCast(@alignCast(device.controller));
>>> 209:         // TODO: Should be a deadline since the timeout is doubled with two calls
     210:         for (iov) |msg| {
     211:             switch (msg) {
     212:                 .write => |payload| try controller.internal.write_timeout(device.address, payload, timeout_us),
     213:                 .read => |payload| try controller.internal.read_timeout(device.address, payload, timeout_us),
     214:                 .write_restart_read => |payload| {
     215:                     try controller.internal.write_timeout(device.address, payload.write, timeout_us);
     216:                     try controller.internal.read_timeout(device.address, payload.read, timeout_us);
     217:                 },
     218:             }
     219:         }
```

**Analysis**:

- **Purpose**: Change timeout mechanism from per-operation timeout to absolute deadline to avoid cumulative timeout issues
- **Why Incomplete**: Current implementation uses timeout per call, which means total time can exceed intended limit in vectorized operations
- **Complexity**: Low - change parameter from timeout_us to deadline and adjust internal calls
- **Related Items**: Affects all I2C timeout-based operations

**Recommendation**: Change writeVectorized signature to accept absolute deadline timestamp, calculate remaining time before each operation to ensure total operation stays within deadline

---

### TODO #191: Handle pin mode TODO

**Location**: `port/stmicro/stm32/src/hals/STM32F103/pins.zig:54`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
@panic("TODO");
```

**Code Context**:
```zig
     44:         fn write(self: Pin, state: State) void {
     45:             if (state == .high) {
     46:                 self.port.regs.BSRR.write_raw(self.mask);
     47:             } else {
     48:                 self.port.regs.BRR.write_raw(self.mask);
     49:             }
     50:         }
     51: 
     52:         fn read(self: Pin) State {
     53:             if (self.getMode() != .input) {
>>> 54:                 @panic("TODO");
     55:             }
     56: 
     57:             return if ((self.port.regs.IDR.raw & self.mask) != 0)
     58:                 State.high
     59:             else
     60:                 State.low;
     61:         }
     62: 
     63:         fn setMode(self: Pin, mode: Mode) void {
     64:             const cr = if (self.num > 7) &self.port.regs.CRH else &self.port.regs.CRL;
```

**Analysis**:

- **Purpose**: Implement reading from output pins (reading ODR register instead of IDR)
- **Why Incomplete**: Panic placeholder left during initial implementation; reading output state requires different register access
- **Complexity**: Low - simple conditional to check mode and read from ODR vs IDR
- **Related Items**: Basic GPIO functionality

**Recommendation**: Replace panic with code to read from ODR register when pin is in output mode: `return if ((self.port.regs.ODR.raw & self.mask) != 0) State.high else State.low;`

---

### TODO #192: Ensure only one input function instance exists

**Location**: `port/stmicro/stm32/src/hals/STM32F103/pins.zig:191`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
// TODO: ensure only one instance of an input function exists
```

**Code Context**:
```zig
     181:     }
     182: 
     183:     pub fn Input(comptime pin: type, comptime config: microzig.hal.pin.Input.Config) type {
     184:         const pin_config: Pin.Config = switch (config.mode) {
     185:             .floating => .{ .input = .floating },
     186:             .pull_up => .{ .input = .pull_up },
     187:             .pull_down => .{ .input = .pull_down },
     188:         };
     189: 
     190:         const gpio_pin = pin.source_pin.init(pin_config);
>>> 191:         // TODO: ensure only one instance of an input function exists
     192:         return microzig.hal.pin.InputVtable.apply(pin, struct {
     193:             fn read(_: type) microzig.hal.pin.State {
     194:                 return gpio_pin.read();
     195:             }
     196:         });
     197:     }
     198: 
     199:     pub fn Output(comptime pin: type, comptime config: microzig.hal.pin.Output.Config) type {
     200:         const pin_config: Pin.Config = switch (config.initial_state) {
     201:             .floating => .{ .output_2MHz = .push_pull },
```

**Analysis**:

- **Purpose**: Add compile-time validation to prevent multiple conflicting Input instances for same physical pin
- **Why Incomplete**: Runtime conflicts would cause hardware issues, but compile-time detection is complex in current architecture
- **Complexity**: Medium - requires compile-time tracking of pin configurations, possibly using comptime variable or @compileError
- **Related Items**: Related to pin configuration safety across the HAL

**Recommendation**: Use comptime map or global variable to track configured pins, emit @compileError if pin already configured. Consider using Zig's type system to make this impossible by design.

---

### TODO #193: Add support for STM32F105/107 devices

**Location**: `port/stmicro/stm32/src/hals/STM32F103/rcc.zig:2`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
//TODO: Add support for 105/107
```

**Code Context**:
```zig
>>> 2: //TODO: Add support for 105/107
    3: //TODO: External crystal
    4: //TODO: PLL2 and PLL3 for 105/107
    5: //TODO: USB clock
    6: //TODO: I2S clock
    7: 
    8: const std = @import("std");
    9: const hal = @import("../hal.zig");
   10: const regs = hal.regs;
   11: const common = hal.common;
   12:
```

**Analysis**:

- **Purpose**: Extend RCC (Reset and Clock Control) module to support connectivity line devices (STM32F105/107) with different clock configuration
- **Why Incomplete**: F105/107 have additional PLL2/PLL3, different clock tree, requires separate initialization logic
- **Complexity**: Medium-High - connectivity line has significantly different RCC features
- **Related Items**: Related to TODO #194 (F105/107 peripherals), may need separate HAL file

**Recommendation**: Either extend current RCC with conditional compilation for F105/107 features, or create separate RCC module for connectivity line devices

---

### TODO #194: Add STM32F105/107 device peripherals

**Location**: `port/stmicro/stm32/src/hals/STM32F103/rcc.zig:284`  
**Author**: Vesim (2024-03-29)  
**Commit**: ae4fb6e7 - "stm32: Update to Zig version 0.12.0-dev.3180+83e578a18"

**Original Comment**:
```zig
//TODO: Add STM32F105/7 devices peri
```

**Code Context**:
```zig
     274:             },
     275:             .TIM12 => .{
     276:                 .bus = .APB1,
     277:                 .enable_offset = 6,
     278:             },
     279:             .TIM13 => .{
     280:                 .bus = .APB1,
     281:                 .enable_offset = 7,
     282:             },
     283:             .TIM14 => .{
>>> 284:                 //TODO: Add STM32F105/7 devices peri
     285:                 .bus = .APB1,
     286:                 .enable_offset = 8,
     287:             },
     288:             .WWDG => .{
     289:                 .bus = .APB1,
     290:                 .enable_offset = 11,
     291:             },
     292:             .SPI2 => .{
     293:                 .bus = .APB1,
     294:                 .enable_offset = 14,
```

**Analysis**:

- **Purpose**: Add peripheral clock enable definitions for STM32F105/107-specific peripherals (CAN2, OTG FS, Ethernet, etc.)
- **Why Incomplete**: Initial HAL targeted standard F103 line; connectivity line peripherals were not included
- **Complexity**: Low-Medium - need to add peripheral enum values and their RCC bit positions
- **Related Items**: Part of TODO #193 (F105/107 RCC support)

**Recommendation**: Add connectivity line peripherals to PeripheralId enum (CAN2, OTG_FS_DEVICE, OTG_FS_HOST, AFIO, etc.) with appropriate RCC register offsets from reference manual

---

### TODO #195: Implement timer sync and TRGI modes

**Location**: `port/stmicro/stm32/src/hals/common/timer_v1.zig:169`  
**Author**: Vesim (2023-08-15)  
**Commit**: 73ab86fc - "port: stm32: more hal work"

**Original Comment**:
```zig
///- sync and TRGI modes for synchronization with other timers (TODO).
```

**Code Context**:
```zig
     159: ///- Input mode functions:
     160: ///  - Set input mode (configure channel as either input
     161: ///  - capture, compare, or pwm).
     162: ///
     163: ///  - Set input capture parameters (e.g., filter, prescaler, edge)
     164: ///  - Read captured value
     165: ///- Advanced-control features (For TIM1 and TIM8 only):
     166: ///  - Set repetition count
     167: ///  - Set break and dead-time configuration
     168: ///  - Enable/disable complementary outputs
>>> 169: ///- sync and TRGI modes for synchronization with other timers (TODO).
     170: ///- One-pulse mode configuration (TODO).
     171: ///- Encoder mode configuration (TODO).
     172: ///- DMA burst support for update and compare events (TODO).
     173: ///- Timer-based hall sensor interface (TODO).
     174: 
     175: const hal = @import("../../hal.zig");
     176: const regs = hal.regs;
     177: const common = hal.common;
     178: const TriggerOutput = common.timer.TriggerOutput;
     179:
```

**Analysis**:

- **Purpose**: Add timer synchronization features allowing one timer to trigger/control another (master-slave configuration)
- **Why Incomplete**: Basic timer functionality (PWM, counting) was priority; advanced synchronization features deferred
- **Complexity**: Medium - requires configuring trigger sources (TS bits), slave mode (SMS bits), and master mode (MMS bits)
- **Related Items**: Related to other advanced timer TODOs #196 (DMA burst support)

**Recommendation**: Add sync configuration to timer setup including master/slave mode selection, trigger source configuration, and slave mode control (reset, gated, trigger mode, external clock)

---

### TODO #196: Implement DMA burst support for timers

**Location**: `port/stmicro/stm32/src/hals/common/timer_v1.zig:172`  
**Author**: Vesim (2023-08-15)  
**Commit**: 73ab86fc - "port: stm32: more hal work"

**Original Comment**:
```zig
///- DMA burst support for update and compare events (TODO).
```

**Code Context**:
```zig
     162: ///  - capture, compare, or pwm).
     163: ///
     164: ///  - Set input capture parameters (e.g., filter, prescaler, edge)
     165: ///  - Read captured value
     166: ///- Advanced-control features (For TIM1 and TIM8 only):
     167: ///  - Set repetition count
     168: ///  - Set break and dead-time configuration
     169: ///  - Enable/disable complementary outputs
     170: ///- sync and TRGI modes for synchronization with other timers (TODO).
     171: ///- One-pulse mode configuration (TODO).
     172: ///- Encoder mode configuration (TODO).
>>> 172: ///- DMA burst support for update and compare events (TODO).
     173: ///- Timer-based hall sensor interface (TODO).
     174: 
     175: const hal = @import("../../hal.zig");
     176: const regs = hal.regs;
     177: const common = hal.common;
     178: const TriggerOutput = common.timer.TriggerOutput;
     179: const Alignment = common.timer.Alignment;
     180: const CenterAlignedMode = common.timer.CenterAlignedMode;
     181: const CountMode = common.timer.CountMode;
     182:
```

**Analysis**:

- **Purpose**: Enable DMA to automatically update multiple timer registers in burst mode for efficiency
- **Why Incomplete**: DMA integration with timers is advanced feature, basic polling/interrupt mode sufficient initially
- **Complexity**: Medium-High - requires DMA setup, timer DMA request configuration, and burst register (DCR/DMAR) handling
- **Related Items**: Part of comprehensive timer feature set, relates to DMA controller integration

**Recommendation**: Add DMA burst configuration including base address selection (DBA), burst length (DBL), and DMA request enables for update/compare events

---

### TODO #197: Check I2C timing parameter range (v2)

**Location**: `port/stmicro/stm32/src/hals/common/i2c_v2.zig:69`  
**Author**: Matt Knight (2024-11-15)  
**Commit**: c8fa6fce - "i2c: introduce device interface, and make it testable"

**Original Comment**:
```zig
// TODO check fi max value is less the 1 and return an error
```

**Code Context**:
```zig
     59:         return .{
     60:             .presc = @intCast(presc),
     61:             .scll = @intCast(t_low - 1),
     62:             .sclh = @intCast(t_high - 1),
     63:             .sdadel = @intCast(t_sdadel),
     64:             .scldel = @intCast(t_scldel),
     65:         };
     66:     }
     67: 
     68:     fn computeTimingFastMode(i2c_clk_mhz: comptime_int) TimingConfig {
>>> 69:         // TODO check fi max value is less the 1 and return an error
     70:         const presc: comptime_int = if (i2c_clk_mhz < 32) 0 else (i2c_clk_mhz / 32);
     71:         const i2cclk = i2c_clk_mhz / (presc + 1);
     72:         const t_presc: comptime_int = 1000 / i2cclk;
     73: 
     74:         const t_low: comptime_int = @divTrunc(1300, t_presc);
     75:         const t_high: comptime_int = @divTrunc(600, t_presc);
     76: 
     77:         const t_sdadel: comptime_int = @divTrunc(100, t_presc);
     78:         const t_scldel: comptime_int = @divTrunc(400, t_presc);
     79:
>>> 80:         // TODO check fi max value is less the 1 and return an error
     81:         return .{
     82:             .presc = @intCast(presc),
     83:             .scll = @intCast(t_low - 1),
     84:             .sclh = @intCast(t_high - 1),
     85:             .sdadel = @intCast(t_sdadel),
     86:             .scldel = @intCast(t_scldel),
     87:         };
     88:     }
```

**Analysis**:

- **Purpose**: Add validation that computed I2C timing values are within valid register field ranges
- **Why Incomplete**: Timing calculation works for typical clock speeds but edge cases not validated
- **Complexity**: Low - add comptime asserts or return error if values exceed field width
- **Related Items**: Also TODO #198 (same issue at line 80)

**Recommendation**: Add comptime asserts to validate presc, scll, sclh, sdadel, scldel are within their respective register field maximum values (typically 4-bit or 8-bit fields)

---

### TODO #198: Check I2C timing parameter range (v2 duplicate)

**Location**: `port/stmicro/stm32/src/hals/common/i2c_v2.zig:80`  
**Author**: Matt Knight (2024-11-15)  
**Commit**: c8fa6fce - "i2c: introduce device interface, and make it testable"

**Original Comment**:
```zig
// TODO check fi max value is less the 1 and return an error
```

**Code Context**:
```zig
     70:         const presc: comptime_int = if (i2c_clk_mhz < 32) 0 else (i2c_clk_mhz / 32);
     71:         const i2cclk = i2c_clk_mhz / (presc + 1);
     72:         const t_presc: comptime_int = 1000 / i2cclk;
     73: 
     74:         const t_low: comptime_int = @divTrunc(1300, t_presc);
     75:         const t_high: comptime_int = @divTrunc(600, t_presc);
     76: 
     77:         const t_sdadel: comptime_int = @divTrunc(100, t_presc);
     78:         const t_scldel: comptime_int = @divTrunc(400, t_presc);
     79: 
>>> 80:         // TODO check fi max value is less the 1 and return an error
     81:         return .{
     82:             .presc = @intCast(presc),
     83:             .scll = @intCast(t_low - 1),
     84:             .sclh = @intCast(t_high - 1),
     85:             .sdadel = @intCast(t_sdadel),
     86:             .scldel = @intCast(t_scldel),
     87:         };
     88:     }
     89: 
     90:     pub fn initController(config: ControllerConfig) !I2C {
```

**Analysis**:

- **Purpose**: Same as TODO #197 - validate timing parameters are in valid range
- **Why Incomplete**: Duplicate of #197, should be addressed together
- **Complexity**: Low
- **Related Items**: Duplicate of #197

**Recommendation**: Same as #197 - add validation for all computed timing values

---

### TODO #199: Complete I2C configuration

**Location**: `port/stmicro/stm32/src/hals/common/i2c_v2.zig:113`  
**Author**: Matt Knight (2024-11-15)  
**Commit**: c8fa6fce - "i2c: introduce device interface, and make it testable"

**Original Comment**:
```zig
// TODO this should configure
```

**Code Context**:
```zig
     103:         const timing_cfg = if (config.clock_config.speed == .fast_400kHz)
     104:             computeTimingFastMode(i2c_clk_mhz)
     105:         else
     106:             computeTimingStandardMode(i2c_clk_mhz);
     107: 
     108:         const clk_cfg = config.clock_config;
     109:         switch (self.num) {
     110:             inline else => |num| {
     111:                 const periph = @field(regs, std.fmt.comptimePrint("I2C{d}", .{num + 1}));
     112: 
>>> 113:                 // TODO this should configure
     114:                 // - ANFOFF: disable analog filter
     115:                 // - DNF: digital noise filter
     116: 
     117:                 periph.CR1.modify(.{
     118:                     .PE = 0,
     119:                 });
     120: 
     121:                 periph.TIMINGR.modify(.{
     122:                     .PRESC = timing_cfg.presc,
     123:                     .SCLL = timing_cfg.scll,
```

**Analysis**:

- **Purpose**: Add configuration options for I2C analog filter disable and digital noise filter settings
- **Why Incomplete**: Basic I2C operation works with default filter settings; advanced filter config left for future enhancement
- **Complexity**: Low - add config fields and set ANFOFF and DNF bits in CR1 register
- **Related Items**: Part of comprehensive I2C configuration

**Recommendation**: Add analog_filter_disable and digital_noise_filter fields to ControllerConfig, apply settings in CR1 register during initialization

---

### TODO #200: Use USART-specific frequency instead of board frequency

**Location**: `port/stmicro/stm32/src/hals/common/uart_v3.zig:80`  
**Author**: Vesim (2023-08-15)  
**Commit**: 73ab86fc - "port: stm32: more hal work"

**Original Comment**:
```zig
// TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
```

**Code Context**:
```zig
     70:         if (uart_num <= 1) {
     71:             switch (regs.RCC.CFGR3.read().USART1SW) {
     72:                 0b00 => {},
     73:                 0b01 => {},
     74:                 0b10 => {},
     75:                 0b11 => {},
     76:             }
     77:         }
     78: 
     79:         // calculate baudrate
>>> 80:         // TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
     81:         const freq = microzig.hal.peripherals.clock.get().cpu; // this is probably wrong!
     82:         // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
     83:         const uartdiv = @divTrunc(freq + (baud / 2), baud);
     84: 
     85:         // TODO: We assume the default OVER8=0 configuration above.
     86:         //
     87:         //  We also assume the default value of ONE_BIT_SAMPLING is 0:
     88:         //
     89:         // TODO: Document what the 4 MSBs and 11 LSBs are
     90:         switch (uart_num) {
```

**Analysis**:

- **Purpose**: Use actual USART peripheral clock frequency instead of CPU frequency for accurate baud rate calculation
- **Why Incomplete**: Different USARTs can be clocked from different sources (PCLK1, PCLK2, HSI, etc.) but code uses simplified CPU clock
- **Complexity**: Medium - need to query RCC CFGR3 register to determine USART clock source and calculate actual frequency
- **Related Items**: Related to TODO #201, #202 (baud rate validation and OVER8 configuration)

**Recommendation**: Implement clock source detection based on USART number and CFGR3 register, calculate actual peripheral frequency from appropriate clock source

---

### TODO #201: Validate baud rate is achievable

**Location**: `port/stmicro/stm32/src/hals/common/uart_v3.zig:82`  
**Author**: Vesim (2023-08-15)  
**Commit**: 73ab86fc - "port: stm32: more hal work"

**Original Comment**:
```zig
// TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
```

**Code Context**:
```zig
     72:                 0b00 => {},
     73:                 0b01 => {},
     74:                 0b10 => {},
     75:                 0b11 => {},
     76:             }
     77:         }
     78: 
     79:         // calculate baudrate
     80:         // TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
     81:         const freq = microzig.hal.peripherals.clock.get().cpu; // this is probably wrong!
>>> 82:         // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
     83:         const uartdiv = @divTrunc(freq + (baud / 2), baud);
     84: 
     85:         // TODO: We assume the default OVER8=0 configuration above.
     86:         //
     87:         //  We also assume the default value of ONE_BIT_SAMPLING is 0:
     88:         //
     89:         // TODO: Document what the 4 MSBs and 11 LSBs are
     90:         switch (uart_num) {
     91:             0 => regs.USART1.BRR.modify(.{ .BRR = @as(u16, @truncate(uartdiv)) }),
     92:             1 => regs.USART2.BRR.modify(.{ .BRR = @as(u16, @truncate(uartdiv)) }),
```

**Analysis**:

- **Purpose**: Add validation that requested baud rate can be achieved with available clock frequency and divider resolution
- **Why Incomplete**: Basic calculation works for typical cases but edge cases (very high/low baud rates) not validated
- **Complexity**: Low - check that uartdiv is within valid range (typically 16-65535 for OVER8=0)
- **Related Items**: Related to TODO #200 (correct frequency) and #202 (OVER8 mode)

**Recommendation**: Add checks that uartdiv >= 16 (minimum for OVER8=0 mode) and <= 65535 (register width), return error if out of range or suggest OVER8=1 mode for high baud rates

---

### TODO #202: Document OVER8 assumption and support OVER8=1

**Location**: `port/stmicro/stm32/src/hals/common/uart_v3.zig:85`  
**Author**: Vesim (2023-08-15)  
**Commit**: 73ab86fc - "port: stm32: more hal work"

**Original Comment**:
```zig
// TODO: We assume the default OVER8=0 configuration above.
```

**Code Context**:
```zig
     75:                 0b11 => {},
     76:             }
     77:         }
     78: 
     79:         // calculate baudrate
     80:         // TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
     81:         const freq = microzig.hal.peripherals.clock.get().cpu; // this is probably wrong!
     82:         // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
     83:         const uartdiv = @divTrunc(freq + (baud / 2), baud);
     84: 
>>> 85:         // TODO: We assume the default OVER8=0 configuration above.
     86:         //
     87:         //  We also assume the default value of ONE_BIT_SAMPLING is 0:
     88:         //
     89:         // TODO: Document what the 4 MSBs and 11 LSBs are
     90:         switch (uart_num) {
     91:             0 => regs.USART1.BRR.modify(.{ .BRR = @as(u16, @truncate(uartdiv)) }),
     92:             1 => regs.USART2.BRR.modify(.{ .BRR = @as(u16, @truncate(uartdiv)) }),
     93:             2 => regs.USART3.BRR.modify(.{ .BRR = @as(u16, @truncate(uartdiv)) }),
     94:         }
```

**Analysis**:

- **Purpose**: Support OVER8=1 mode (8x oversampling) for higher baud rates with lower clock frequencies
- **Why Incomplete**: 16x oversampling (OVER8=0) sufficient for most use cases; 8x mode adds complexity to BRR calculation
- **Complexity**: Low-Medium - add config option, adjust BRR calculation formula, set OVER8 bit in CR1
- **Related Items**: Related to TODO #201 (baud rate validation)

**Recommendation**: Add oversampling mode to config (over8 or over16), adjust uartdiv calculation (divide by 8 instead of 16 for OVER8=1), set CR1.OVER8 bit accordingly

---

### TODO #203: Add more clock calculations for STM32F429

**Location**: `port/stmicro/stm32/src/hals/STM32F429.zig:21`  
**Author**: Matt Knight (2023-09-20)  
**Commit**: c80a53e9 - "hal,rp2xxx: cleanup timer impl"

**Original Comment**:
```zig
//! TODO: add more clock calculations when adding Uart
```

**Code Context**:
```zig
     11: 
     12: const microzig = @import("microzig");
     13: const regs = microzig.chip.peripherals;
     14: const clocks = microzig.hal.peripherals.clock;
     15: 
     16: pub fn init() void {
     17:     regs.RCC.AHB1ENR.modify(.{ .GPIOBEN = 1 });
     18: }
     19: 
     20: pub const clock = struct {
>>> 21:     //! TODO: add more clock calculations when adding Uart
     22:     pub fn get() Clocks {
     23:         return .{
     24:             .cpu = 16_000_000, // HSI Clock
     25:         };
     26:     }
     27: };
     28: 
     29: const Clocks = struct {
     30:     cpu: u32,
     31: };
```

**Analysis**:

- **Purpose**: Implement comprehensive clock calculation for all STM32F429 clock domains (AHB, APB1, APB2, USB, etc.) needed for UART and other peripherals
- **Why Incomplete**: Initial HAL only needed CPU clock; peripheral clocks deferred until needed
- **Complexity**: Medium - need to parse RCC registers to calculate all clock tree frequencies
- **Related Items**: Essential for accurate UART baud rate calculation and peripheral initialization

**Recommendation**: Extend Clocks struct to include ahb, apb1, apb2 frequencies, implement RCC register parsing to calculate actual clock values based on PLL configuration

---

### TODO #204: Extract getRegField utility function

**Location**: `port/stmicro/stm32/src/hals/STM32F429.zig:82`  
**Author**: Matt Knight (2023-09-20)  
**Commit**: c80a53e9 - "hal,rp2xxx: cleanup timer impl"

**Original Comment**:
```zig
const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
```

**Code Context**:
```zig
     72:     }
     73: 
     74:     pub const Pin = struct {
     75:         port: *volatile types.GPIO,
     76:         gpio_num: u4,
     77: 
     78:         pub fn read(self: Pin) u1 {
     79:             const idr_reg = self.port.IDR;
     80:             const pin = num_to_pin(self.gpio_num);
     81: 
>>> 82:             const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
     83:             return @intCast(reg_value);
     84:         }
     85: 
     86:         pub fn put(self: Pin, value: u1) void {
     87:             const pin = num_to_pin(self.gpio_num);
     88: 
     89:             self.port.BSRR.write_raw(
     90:                 @as(u32, 1) << if (value == 1)
     91:                     @intFromEnum(pin.num)
     92:                 else
```

**Analysis**:

- **Purpose**: Create reusable utility function to access dynamically-named register fields instead of inline @field usage
- **Why Incomplete**: Code works but not DRY; would benefit from abstraction for readability
- **Complexity**: Low - simple wrapper function around @field
- **Related Items**: Could be part of general register access utilities

**Recommendation**: Create `getRegField(reg: anytype, comptime prefix: []const u8, suffix: []const u8)` helper function, use throughout HAL for cleaner code

---

### TODO #205: Support other STM32F40x chips

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:3`  
**Author**: Matt Knight (2023-09-20)  
**Commit**: c80a53e9 - "hal,rp2xxx: cleanup timer impl"

**Original Comment**:
```zig
//! TODO: Do something useful for other STM32F40x chips.
```

**Code Context**:
```zig
>>> 3: //! TODO: Do something useful for other STM32F40x chips.
    4: //! e.g. For the STM32F405, the ethernet registers should not be included.
    5: //! This will require moving the registers into their own files and
    6: //! having specialized init functions that choose which ones are present.
    7: 
    8: const std = @import("std");
    9: const microzig = @import("microzig");
   10: const regs = microzig.chip.peripherals;
   11: const GPIO = microzig.chip.types.GPIO;
   12: const USART = microzig.chip.types.USART1;
   13:
```

**Analysis**:

- **Purpose**: Make HAL conditional based on specific STM32F40x variant (F405 lacks ethernet, F401 has different peripherals)
- **Why Incomplete**: Register generation includes all peripherals; runtime detection or conditional compilation needed
- **Complexity**: Medium - requires build system integration to conditionally include peripherals based on chip model
- **Related Items**: Affects register generation and peripheral availability

**Recommendation**: Use chip-specific conditionals in build system to include/exclude peripheral modules, or implement runtime peripheral detection and feature gating

---

### TODO #206: Extract getRegField utility (STM32F407)

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:122`  
**Author**: Matt Knight (2023-09-20)  
**Commit**: c80a53e9 - "hal,rp2xxx: cleanup timer impl"

**Original Comment**:
```zig
const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
```

**Code Context**:
```zig
     112:         const pin = num_to_pin(num);
     113:         return Pin{ .source_pin = .{
     114:             .port = port,
     115:             .pin = pin,
     116:         } };
     117:     }
     118: 
     119:     pub fn read(self: Pin) u1 {
     120:         const idr_reg = self.source_pin.port.IDR;
     121:         const pin = self.source_pin.pin;
>>> 122:         const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
     123:         return @intCast(reg_value);
     124:     }
     125: 
     126:     pub fn put(self: Pin, value: u1) void {
     127:         const pin = self.source_pin.pin;
     128: 
     129:         self.source_pin.port.BSRR.write_raw(
     130:             @as(u32, 1) << if (value == 1)
     131:                 @intFromEnum(pin.num)
     132:             else
```

**Analysis**:

- **Purpose**: Same as TODO #204 - extract register field access into utility function
- **Why Incomplete**: Duplicate issue across different STM32 HAL files
- **Complexity**: Low
- **Related Items**: Duplicate of #204

**Recommendation**: Same as #204 - create shared utility function for register field access

---

### TODO #207: Handle unsupported word size with parity

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:265`  
**Author**: Matt Knight (2024-07-15)  
**Commit**: a1ee2bb5 - "stm32f407: implement uart"

**Original Comment**:
```zig
// TODO: should we consider this an unsupported word size or unsupported parity?
```

**Code Context**:
```zig
     255:                 .@"8" => {
     256:                     periph.CR1.modify(.{
     257:                         .M = 0,
     258:                         .PCE = 1,
     259:                         .PS = @intFromEnum(config.parity),
     260:                     });
     261:                 },
     262:                 .@"9" => {
     263:                     if (config.parity != .none) {
     264:                         std.log.err("9-bit word size with parity enabled results in 10-bit frames which are not supported", .{});
>>> 265:                         // TODO: should we consider this an unsupported word size or unsupported parity?
     266:                         return error.UnsupportedConfiguration;
     267:                     }
     268:                     // TODO: should we consider this an unsupported word size or unsupported parity?
     269:                     periph.CR1.modify(.{
     270:                         .M = 1,
     271:                         .PCE = 0,
     272:                     });
     273:                 },
     274:             }
     275:         }
```

**Analysis**:

- **Purpose**: Clarify error handling semantics when user requests invalid combination (9-bit + parity = 10-bit frame)
- **Why Incomplete**: Error path works but unclear whether to categorize as word size or parity error
- **Complexity**: Low - documentation/error message clarification
- **Related Items**: Also TODO #208 (same issue repeated)

**Recommendation**: Return more specific error like `error.UnsupportedWordSizeParityCombination` or keep current error but improve log message to make it clear both settings contribute to the problem

---

### TODO #208: Handle unsupported word size with parity (duplicate)

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:268`  
**Author**: Matt Knight (2024-07-15)  
**Commit**: a1ee2bb5 - "stm32f407: implement uart"

**Original Comment**:
```zig
// TODO: should we consider this an unsupported word size or unsupported parity?
```

**Code Context**:
```zig
     258:                         .M = 0,
     259:                         .PCE = 1,
     260:                         .PS = @intFromEnum(config.parity),
     261:                     });
     262:                 },
     263:                 .@"9" => {
     264:                     if (config.parity != .none) {
     265:                         std.log.err("9-bit word size with parity enabled results in 10-bit frames which are not supported", .{});
     266:                         // TODO: should we consider this an unsupported word size or unsupported parity?
     267:                         return error.UnsupportedConfiguration;
     268:                     }
>>> 268:                     // TODO: should we consider this an unsupported word size or unsupported parity?
     269:                     periph.CR1.modify(.{
     270:                         .M = 1,
     271:                         .PCE = 0,
     272:                     });
     273:                 },
     274:             }
     275:         }
     276: 
     277:         // Enable USART
     278:         periph.CR1.modify(.{ .UE = 1 });
```

**Analysis**:

- **Purpose**: Same as TODO #207
- **Why Incomplete**: Duplicate comment
- **Complexity**: Low
- **Related Items**: Duplicate of #207

**Recommendation**: Same as #207 - clarify error semantics, possibly remove duplicate comment

---

## Summary

**Batch 06 Complete**: 25 TODOs analyzed from STM32 and ESP32 port files

**Complexity Breakdown**:
- Low: 8 TODOs (error handling, validation, utility functions)
- Medium: 13 TODOs (HAL extensions, peripheral modes, clock calculations)
- High: 4 TODOs (F105/107 support, advanced features, architecture changes)

**Common Themes**:
1. **STM32 HAL Maturity**: Many TODOs relate to extending basic implementations with advanced features
2. **Clock/Timing**: Multiple TODOs around proper clock source detection and validation
3. **Error Handling**: Several TODOs about adding proper validation and error returns
4. **Code Quality**: Utility function extraction and DRY principles

**Priority Recommendations**:
1. **High**: Fix TODO #191 (panic in pin read) - impacts basic functionality
2. **High**: TODO #200-202 (UART clock/baud rate) - affects reliability
3. **Medium**: TODO #189 (10-bit I2C addresses) - blocking for some devices
4. **Medium**: TODO #184 (HAL detection) - affects build system robustness
