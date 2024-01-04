# microzig Design Meeting

## Package structure

`microzig` package exports all functions and types available in the HAL as well as `microzig.mcu` which will provide access to the MCU. All functions in `microzig` which are not generic will be inline-forwarded to the `board` or `mcu` package.

```
root
 |- std
 |- microzig
 |   |- mcu (should be specified if "board" does not exit)
 |   |- build_options (defines if "mcu" and/or "board" exists)
 |   \- board (must export ".mcu")
 |       \- mcu
 \- mcu (user decision)
```

## Minimal Root file

Declaring `panic` in the root file will cause `builtin` to reference the proper package which will then instantiate microzig which will reference `mcu` package which will instantiate `reset` (or similar) which will invoke `microzig.main()` which will invoke `root.main()`. Oh boy :laughing:

```zig
const micro = @import("micro");

pub const panic = micro.panic; // this will instantiate microzig

comptime { _ = micro };  // this should not be necessary

pub fn main() void {

}
```

## `microzig.mcu`

`microzig` exports a symbol `mcu` which will provide access to the MCU, CPU and board features

```zig
// mcu.zig in microzig.zig
const config = @import("build_options");

usingnamespace if(config.has_board)
	@import("board").mcu
else
	@import("mcu");

pub const has_board = config.has_board;
pub const board = @import("board");
```

## Interrupt API

All interrupt handlers are static and will be collected from `root.interrupt_handlers`. Each symbol will be verified if it's a valid interrupt vector. 
A symbol can be a function `fn() void`, or a anonymous enum literal `.hang` or `.reset`.

`microzig.interrupts.enable` and `microzig.interrupts.disable` will allow masking/unmasking those interrupts, `.cli()` and `.sei()` will globally disable/enable interrupts

`microzig.interrupts` also provides some handling of critical sections

```zig
pub fn main() void {
  micro.interrupts.enable(.WDT);  // enables the WDT interrupt
  micro.interrupts.disable(.WDT); // enables the WDT interrupt
  micro.interrupts.enable(.WTF); // yields compile error "WTF is not a valid interrupt"
  micro.interrupts.enable(.PCINT0); // yields compile error "PCINT0 has no defined interrupt handler"
  micro.interrupts.enable(.NMI); // yields compile error "NMI cannot be masked"
  micro.interrupts.enableAll();
  micro.interrupts.batchEnable(.{ .NMI, .WDT  });
  
  micro.interrupts.cli(); // set interrupt enabled (global enable)
  
  { // critical section
    var crit = micro.interrupts.enterCriticalSection();
    defer crit.leave();
  }
}

var TIMER2_OVF_RUNTIME: fn()void = foo;

pub const interrupt_handlers = struct {
	
  // AVR 
	pub fn TIMER2_OVF() void { TIMER2_OVF_RUNTIME(); }
  pub fn WDT() void { }
  
  pub const PCINT1 = .reset;
  pub const PCINT2 = .hang;
  
  // cortex-mX exceptions
  pub fn NMI() void { }
  pub fn HardFault() void {}

  // LPC 1768 interrupt/irq
  pub fn SSP1() void { }
};
```

## Timer API

microzig should allow having a general purpose timer mechanism

```zig
pub var cpu_frequency = 16.0 * micro.clock.mega_hertz;

pub const sleep_mode = .timer; // timer, busyloop, whatever

pub fn main() !void {
  led.init();

  while(true) {
    led.toggle();
    micro.sleep(100_000); // sleep 100ms
  }
}
```

## GPIO API

`microzig.Pin` parses a pin definition and returns a type that encodes all relevant info and functions to route that pin.
`microzig.Gpio` is a GPIO port/pin configuration that allows modifying pin levels.

```zig

// micro.Pin returns a type containing all relevant pin information
const status_led_pin = micro.Pin("PA3");

// generate a runtime possible pin that cannot be used in all APIs
var generic_pic: micro.RuntimePin.init(status_led_pin);

// 4 Bit IEEE-488 bit banging register
const serial_out = micro.GpioOutputRegister(.{
  micro.Pin("PA0"),
  micro.Pin("PA1"),
  micro.Pin("PA3"), // whoopsies, i miswired, let the software fix that
  micro.Pin("PA2"),
});

pub fn bitBang(nibble: u4) void {
  serial_out.write(nibble);
}

pub fn main() !void {

  // Route all gpio pins from the bit bang register
	inline for(serial_out.pins) |pin| {
  	pin.route(".gpio");
  }
  serial_out.init();

	// route that pin to UART.RXD
  status_led_pin.route(.uart0_rxd); 
  
  //var uart_read_dma_channel = micro.Dma.init(.{.channel = 1});
  
  const status_led = micro.Gpio(status_led_pin, .{
    .mode          = .output,       // { input, output, input_output, open_drain, generic }
    .initial_state = .unspecificed, // { unspecified, low, high, floating, driven }
  });
  status_led.init();
  
  switch(status_led.mode) {
  	// only reading API is available
  	.input => {
    	_ = status_led.read();
    },
    
    // reading and writing is available
    .output => {
    	_ = status_led.read();
      status_led.write(.high);
      
      // "subvariant" of the write 
      status_led.toggle();
      status_led.setToHigh();
      status_led.setToLow();
    },
    
    // reading, writing and changing direction is available
    .input_output => {
      status_led.setDirection(.input, undefined);
    	_ = status_led.read();
      status_led.setDirection(.output, .high); // reqires a defined state after setting the direction
      status_led.write(.high);
    },
    
    // reading and setDive is available
    .open_drain => {
      status_led.setDrive(.disabled);
    	_ = status_led.read();
      status_led.setDrive(.enabled);
    },
    
    // will have all available APIs enabled
    .generic => {},
  }
  
 	// AVR:   PORTA[3]   => "PA3"
  // NXP:   PORT[1][3] => "P1.3"
  // PICO:  PORT[1]    => "P3"
  // STM:   PORT[A][3] => "A3"
  // ESP32: PORT[1]    => "P3"
```


## UART example

```zig
const std = @import("std");
const micro = @import("µzig");

// if const it can be comptime-optimized
pub var cpu_frequency = 100.0 * micro.clock.mega_hertz;

// if this is enabled, a event loop will run
// in microzig.main() that allows using `async`/`await` "just like that" *grin*
pub const io_mode = .evented;

pub fn main() !void {
  var debug_port = micro.Uart.init(0, .{
    .baud_rate = 9600,
    .stop_bits = .@"2",
    .parity = .none, // { none, even, odd, mark, space }
    .data_bits = .@"8", // 5, 6, 7, 8, or 9 data bits
    //.in_dma_channel = 0,
    //.out_dma_channel = 0,
  });
 
  debug_port.configureDMA(???);
  
  try debug_port.writer().writeAll("Hello, World!");
  
  var line_buffer: [64]u8 = undefined;
  const len = try debug_port.reader().readUntilDelimiter(&line_buffer, '\n');
}
```




## Initialization

somewhere inside micro.zig
```zig
extern fn reset() noreturn {
  if(@hasDecl(mcu, "mcu_reset")) {
  	mcu.mcu_reset();
    @unreachable();
  }
	// zeroing bss, copying .data, setting stack address
  
  if(@hasDecl(root, "early_main")) // idk about the name
    root.early_main();
  else {
  	mcu.init();
  
  	if(@hasDecl(root, "main"))
  		root.main();
		else
  		@compileError("main or entry_main missing")
	}
}
```
