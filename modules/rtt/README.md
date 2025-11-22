# Zig RTT

An implementation of [Segger's RTT protocol](https://wiki.segger.com/RTT) in pure Zig.

## Installation

This package is included as a part of MicroZig. Currently only Cortex-M CPU targets have RTT
support. To access the rtt module, import it like so:

```zig
const microzig = @import("microzig");
const rtt = microzig.cpu.rtt;
```

## Configuration

RTT is configured by creating the RTT "type" at `comptime` like so:
```zig
// rtt.RTT takes an rtt.Config
const rtt_instance = rtt.RTT(.{
    // A slice of rtt.channel.Config for target -> probe communication
    .up_channels = &.{
        .{ .name = "Terminal", .mode = .NoBlockSkip, .buffer_size = 128 },
        .{ .name = "Up2", .mode = .NoBlockSkip, .buffer_size = 256 },
    },
    // A slice of rtt.channel.Config for probe -> target communication
    .down_channels = &.{
        .{ .name = "Terminal", .mode = .BlockIfFull, .buffer_size = 512 },
        .{ .name = "Down2", .mode = .BlockIfFull, .buffer_size = 1024 },
    },
    // Optional override of lock/unlock functionality for thread safe RTT
    .exclusive_access = your_lock_struct,
    // Optional placement in specific linker section for a fixed address control block
    .linker_section = ".rtt_cb",
});
```

This mirrors the functionality presented in the original `SEGGER_RTT_Conf.h` file, except you
can specify a compile time configuration for _every_ up and down channel as opposed to just
up/down channel 0!

Every field in `rtt.Config` is optional, and an empty `Config` gives the default behavior of the
original RTT default config which is:
- Single up channel with a buffer size of 1024 bytes
- Single down channel with a buffer size of 16 bytes
- Architecture specific thread safety via disabling/re-enabling interrupts during RTT write/read operations
- No specific linker section placement

### Custom Thread Safety

This package exposes a `GenericLock` function that creates a type given lock/unlock functions and a
type for "context" to pass to each function. This type has a method `any()`, that returns a type
erased `AnyLock` that can be passed to a `rtt.Config`. Users can utilize this API to specify their
own custom lock/unlock behavior for RTT to use if the default behavior isn't desired. Assigning
`null` to `.exclusive_access` disables thread safety entirely.

## Usage

Once an rtt instance is configured, the API is quite simple:
- `init()` properly initializes the control block memory, and _must_ be called before any other RTT
  operations take place
- `fn write(comptime channel_number: usize, bytes: []const u8) usize` writes bytes to a specific up
  channel (device -> probe), where `channel_number` is validated at compile time to exist, and
  returns number of bytes written (writing less than requested bytes is not an error)
- `fn writer(comptime channel_number: usize, buf: []u8) Writer` returns a struct that implements the
  `std.Io.Writer` interface for a specific up channel. Allows integration with the standard library
  functions that use this type. A special note is that the `Writer` discards write data when the RTT
  up channel write buffer is full. While this can lead to data loss if the up buffer isn't big
  enough and getting written too fast/frequently, it prevents the undesirable behavior of constantly
  returning a `WriteError` if a debug probe isn't connected. See the implementation code for more
  details.
- `fn read(comptime channel_number: usize, bytes: []u8) usize` reads bytes from a specific down
  channel (probe -> device), where `channel_number` is validated at compile time to exist, and
  returns number of bytes read (reading less than requested bytes is not an error)
- `fn reader(comptime channel_number: usize, buf: []u8) Reader` returns a struct that implements the
  `std.Io.Reader` interface for a specific down channel. See implementation and doc comments for
  more information on choosing a buffer.

See the [example](../../examples/raspberrypi/rp2xxx/src/rtt_log.zig) for more information on using
this package.

## TODO:
- Support for CPUs with caches (cache alignment + cache access considerations) to mirror the
  `SEGGER_RTT_CPU_CACHE_LINE_SIZE` and `SEGGER_RTT_UNCACHED_OFF` macros in original Segger source
- Support for virtual terminals supported by RTT viewer
- Support for ANSI terminal color escape codes supported by RTT viewer
- Compile time option for returning a `WriteError` from `Writer` when attempting to write a full RTT
  buffer
