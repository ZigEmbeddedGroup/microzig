# FreeRTOS Module for MicroZig

Idiomatic Zig wrappers for the [FreeRTOS](https://www.freertos.org/) real-time operating system kernel, integrated into the [MicroZig](https://github.com/ZigEmbeddedGroup/microzig) embedded framework. Provides type-safe tasks, queues, semaphores, mutexes, timers, event groups, and task notifications — all with Zig error handling instead of raw C return codes.

Hardware-tested on **Seeed XIAO RP2350** (ARM Cortex-M33).

## Features

- ✅ **Tasks** — create, delete, suspend, resume, delay, priority management
- ✅ **Queues** — generic `Queue(T)` with compile-time type safety
- ✅ **Semaphores** — binary and counting
- ✅ **Mutexes** — standard (with priority inheritance) and recursive
- ✅ **Software Timers** — auto-reload and one-shot with callback support
- ✅ **Event Groups** — multi-bit synchronization and rendezvous/barrier patterns
- ✅ **Task Notifications** — lightweight direct-to-task signaling
- ✅ **ISR variants** — all primitives provide `*FromIsr` functions with wake flags
- ✅ **Raw C escape hatch** — `freertos.c.*` for anything not yet wrapped

## Quick Start

```zig
const std = @import("std");
const freertos = @import("freertos");

pub fn main() !void {
    // ... hardware init ...

    _ = try freertos.task.create(
        hello_task,
        "hello",
        freertos.config.minimal_stack_size * 8,
        null,
        freertos.config.max_priorities - 1,
    );

    // Start the scheduler — never returns
    freertos.task.startScheduler();
}

fn hello_task(_: ?*anyopaque) callconv(.c) void {
    var i: u32 = 0;
    while (true) : (i += 1) {
        std.log.info("Hello from FreeRTOS task {}", .{i});
        freertos.task.delay(500); // 500 ms at default 1 kHz tick rate
    }
}
```

## API Reference

### Tasks (`freertos.task`)

Task creation, deletion, scheduling, and runtime queries.

| Function | Description |
|---|---|
| `create(function, name, stack_depth, params, priority)` | Create a task → `Error!TaskHandle` |
| `destroy(handle)` | Delete a task (`null` = self) |
| `delay(ticks)` | Block for `ticks` ticks |
| `delayUntil(prev_wake_time, increment)` | Periodic delay → `bool` |
| `suspend(handle)` | Suspend a task (`null` = self) |
| `resume(handle)` | Resume a suspended task |
| `resumeFromIsr(handle)` | Resume from ISR → `bool` (context switch needed) |
| `abortDelay(handle)` | Force-unblock a task → `bool` |
| `setPriority(handle, priority)` | Change a task's priority |
| `getPriority(handle)` | Get current priority |
| `getCurrentHandle()` | Handle of the running task |
| `getHandle(name)` | Look up task by name → `?TaskHandle` |
| `getName(handle)` | Task name string |
| `getState(handle)` | → `.running`, `.ready`, `.blocked`, `.suspended`, `.deleted` |
| `getStackHighWaterMark(handle)` | Minimum free stack (words) since creation |
| `getTickCount()` | Current system tick |
| `getCount()` | Total number of tasks |
| `startScheduler()` | Start FreeRTOS — **never returns** |
| `endScheduler()` | Stop FreeRTOS |
| `getSchedulerState()` | → `.not_started`, `.running`, `.suspended` |
| `suspendAll()` / `resumeAll()` | Disable/enable task switching |

### Queues (`freertos.queue`)

Type-safe FIFO queues for inter-task communication. `Queue(T)` is a generic — the item type is checked at compile time and `receive()` returns `T` directly.

```zig
var q = try freertos.queue.create(u32, 10); // Queue(u32), capacity 10
defer q.destroy();

try q.send(&@as(u32, 42), freertos.config.max_delay);
const value = try q.receive(freertos.config.max_delay); // value: u32
```

| Function | Description |
|---|---|
| `create(T, length)` | Create a `Queue(T)` with given capacity → `Error!Queue(T)` |
| `q.send(item, timeout)` | Send to back → `Error!void` (`QueueFull` on timeout) |
| `q.sendToFront(item, timeout)` | Send to front |
| `q.overwrite(item)` | Overwrite single-item queue (never blocks) |
| `q.receive(timeout)` | Receive and remove → `Error!T` (`QueueEmpty` on timeout) |
| `q.peek(timeout)` | Read front item without removing |
| `q.sendFromIsr(item)` | ISR send → `IsrResult` |
| `q.receiveFromIsr()` | ISR receive → `?IsrReceiveResult(T)` |
| `q.messagesWaiting()` | Number of items in queue |
| `q.spacesAvailable()` | Free slots remaining |
| `q.reset()` | Flush the queue |

### Semaphores (`freertos.semaphore`)

Binary and counting semaphores for synchronization and signaling between tasks/ISRs.

| Function | Description |
|---|---|
| `createBinary()` | Create binary semaphore (starts empty) → `Error!Semaphore` |
| `createCounting(max, initial)` | Create counting semaphore → `Error!Semaphore` |
| `s.take(timeout)` | Acquire → `Error!void` (`Timeout`) |
| `s.give()` | Release → `Error!void` (`Failure` if not taken) |
| `s.giveFromIsr()` | Release from ISR → `IsrResult` |
| `s.takeFromIsr()` | Acquire from ISR → `IsrResult` |
| `s.getCount()` | Current count (or 1/0 for binary) |
| `s.destroy()` | Free the semaphore |

### Mutexes (`freertos.mutex`)

Standard and recursive mutexes with **priority inheritance** to prevent priority inversion. Use mutexes to protect shared resources; use semaphores for signaling.

```zig
var mtx = try freertos.mutex.create();
defer mtx.destroy();

try mtx.acquire(freertos.config.max_delay);
defer mtx.release() catch {};

// ... access shared resource ...
```

| Function | Description |
|---|---|
| `create()` | Create a standard mutex → `Error!Mutex` |
| `createRecursive()` | Create a recursive mutex → `Error!Recursive` |
| `m.acquire(timeout)` | Lock → `Error!void` (`Timeout`) |
| `m.release()` | Unlock → `Error!void` (`Failure` if not held) |
| `m.getHolder()` | Task holding the mutex → `?TaskHandle` |
| `m.destroy()` | Free the mutex |

Recursive mutexes can be acquired multiple times by the same task — each `acquire` must be paired with a `release`.

### Event Groups (`freertos.event_group`)

Multi-bit synchronization primitives. Tasks can wait on any combination of event bits, enabling rendezvous-style coordination.

```zig
var events = try freertos.event_group.create();
defer events.destroy();

// Task A sets bit 0
_ = events.setBits(0x01);

// Task B waits for bits 0 AND 1
const bits = try events.waitBits(0x03, .{ .wait_for_all = true, .timeout = 1000 });
```

| Function | Description |
|---|---|
| `create()` | Create an event group → `Error!EventGroup` |
| `e.setBits(bits)` | Set bits → returns new value |
| `e.clearBits(bits)` | Clear bits → returns previous value |
| `e.getBits()` | Read current bits |
| `e.waitBits(bits, opts)` | Wait for bit pattern → `Error!EventBits` (`Timeout`) |
| `e.sync(set, wait, timeout)` | Barrier: set bits then wait for others → `Error!EventBits` |
| `e.setBitsFromIsr(bits)` | Set bits from ISR → `IsrResult` |
| `e.destroy()` | Free the event group |

`WaitOptions` fields: `clear_on_exit` (default `true`), `wait_for_all` (default `false`), `timeout` (default `max_delay`).

### Software Timers (`freertos.timer`)

Periodic or one-shot timers that execute a callback in the timer daemon task context.

```zig
var tmr = try freertos.timer.create("heartbeat", 1000, true, null, my_callback);
try tmr.start(0);
defer tmr.destroyBlocking();
```

| Function | Description |
|---|---|
| `create(name, period, auto_reload, id, callback)` | Create a timer → `Error!Timer` |
| `t.start(cmd_timeout)` | Start/restart the timer |
| `t.stop(cmd_timeout)` | Stop the timer |
| `t.reset(cmd_timeout)` | Reset countdown from now |
| `t.changePeriod(new_period, cmd_timeout)` | Change period and restart |
| `t.destroy(cmd_timeout)` | Delete timer (can fail if queue full) |
| `t.destroyBlocking()` | Delete timer, wait forever (safe for `defer`) |
| `t.isActive()` | Check if running → `bool` |
| `t.getName()` / `t.getPeriod()` / `t.getExpiryTime()` | Timer properties |
| `t.getId()` / `t.setId(ptr)` | User-defined ID pointer |
| `t.getAutoReload()` / `t.setAutoReload(bool)` | Auto-reload mode |
| `t.startFromIsr()` / `t.stopFromIsr()` / `t.resetFromIsr()` | ISR variants → `IsrResult` |
| `pendFunctionCall(fn, p1, p2, timeout)` | Defer a function call to the timer daemon |

> ⚠️ **Implementation note:** The C macros `xTimerStart`, `xTimerStop`, etc. pass untyped `NULL` that Zig's `@cImport` can't coerce. The wrapper calls `xTimerGenericCommandFromTask` / `FromISR` directly, which is functionally identical.

### Task Notifications (`freertos.notification`)

Lightweight direct-to-task notifications — faster and smaller than semaphores or event groups. Each task has a 32-bit notification value per index.

```zig
// Lightweight binary semaphore pattern:
freertos.notification.give(task_handle) catch {};   // sender
_ = freertos.notification.take(true, freertos.config.max_delay) catch {}; // receiver
```

| Function | Description |
|---|---|
| `notify(handle, value, action)` | Send notification at index 0 |
| `notifyIndexed(handle, index, value, action)` | Send at specific index |
| `notifyAndQuery(handle, value, action)` | Send and get previous value → `Error!u32` |
| `give(handle)` | Increment notification (lightweight semaphore give) |
| `notifyFromIsr(handle, value, action)` | Send from ISR → `IsrResult` |
| `giveFromIsr(handle)` | Increment from ISR → `IsrResult` |
| `wait(clear_entry, clear_exit, timeout)` | Wait for notification → `Error!u32` |
| `waitIndexed(index, clear_entry, clear_exit, timeout)` | Wait at specific index |
| `take(clear_on_exit, timeout)` | Binary/counting semaphore pattern → `Error!u32` |
| `clearState(handle)` | Clear pending state → `bool` |
| `clearBits(handle, bits)` | Clear bits in notification value → previous value |

`Action` enum: `.none`, `.set_bits`, `.increment`, `.set_value_overwrite`, `.set_value_no_overwrite`

### Error Handling

All fallible operations return `freertos.config.Error`:

```zig
pub const Error = error{
    OutOfMemory,  // Heap exhausted (create functions)
    Timeout,      // Operation timed out
    QueueFull,    // Queue send failed
    QueueEmpty,   // Queue receive failed
    Failure,      // Generic pdFAIL
};
```

Two helper functions convert C return codes to Zig errors:

```zig
// Check pdPASS/pdFAIL return codes
try freertos.config.checkBaseType(rc);

// Convert nullable C handle → Zig error (null → error.OutOfMemory)
const handle = try freertos.config.checkHandle(c.TaskHandle_t, raw_handle);
```

### Raw C Access

For anything not wrapped, use `freertos.c` to access the full FreeRTOS C API directly:

```zig
const freertos = @import("freertos");

// Direct C call
freertos.c.vTaskDelay(100);

// Access C constants
const pass = freertos.c.pdPASS;
```

## Examples

| Example | Description |
|---|---|
| [`hello_task.zig`](../../examples/raspberrypi/rp2xxx/src/freertos/hello_task.zig) | Minimal — one task, UART logging, periodic delay |
| [`queue_demo.zig`](../../examples/raspberrypi/rp2xxx/src/freertos/queue_demo.zig) | Producer/consumer pattern with type-safe `Queue(u32)` |
| [`multitask_demo.zig`](../../examples/raspberrypi/rp2xxx/src/freertos/multitask_demo.zig) | 4 cooperating tasks using queues, mutexes, timers, event groups, notifications, and semaphores |

## Platform Support

| Platform | Chip | Status | Notes |
|---|---|---|---|
| RP2040 (Pico) | ARM Cortex-M0+ | ✅ Builds | Not yet hardware-tested |
| RP2350 ARM (Pico 2) | ARM Cortex-M33 | ✅ Tested on hardware | XIAO RP2350 |
| RP2350 RISC-V | Hazard3 | ❌ Blocked | Linker symbol issues with RISC-V port |
| ESP32 | Xtensa/RISC-V | 🔲 Planned | — |
| STM32 | ARM Cortex-M | 🔲 Planned | — |

## Configuration

Each platform has its own `FreeRTOSConfig.h` under `config/<platform>/`:

```
modules/freertos/config/
├── RP2040/FreeRTOSConfig.h
└── RP2350_ARM/FreeRTOSConfig.h
```

### Key settings (defaults)

| Setting | Value | Notes |
|---|---|---|
| `configTICK_RATE_HZ` | 1000 | 1 ms tick resolution |
| `configMAX_PRIORITIES` | 32 | Priority levels 0–31 |
| `configMINIMAL_STACK_SIZE` | 256 | Words (1 KB on 32-bit) |
| `configTOTAL_HEAP_SIZE` | 128 KB | FreeRTOS heap (heap_4) |
| `configCHECK_FOR_STACK_OVERFLOW` | 2 | Full stack painting check — traps via `@trap()` |
| `configSUPPORT_DYNAMIC_ALLOCATION` | 1 | Dynamic only (static not yet supported) |
| `configNUMBER_OF_CORES` | 1 | Single-core only |

### Pico SDK interop (disabled)

`configSUPPORT_PICO_SYNC_INTEROP` and `configSUPPORT_PICO_TIME_INTEROP` are **disabled**. The FreeRTOS RP2xxx port relies on `.init_array` constructors to initialize spin-locks and event groups before `main()`. MicroZig does not process `.init_array`, so enabling these causes a NULL dereference and Usage Fault on scheduler start. Re-enable only after MicroZig adds `.init_array` support.

## Known Limitations

- **Static allocation** — `configSUPPORT_STATIC_ALLOCATION` is off; `xTaskCreateStatic` etc. are not wrapped
- **Stream/message buffers** — not yet wrapped (use `freertos.c` as a workaround)
- **Multicore SMP** — `configNUMBER_OF_CORES` is 1; FreeRTOS SMP support is not yet integrated
- **`.init_array` constructors** — not processed by MicroZig startup, blocking Pico SDK interop
- **RISC-V** — RP2350 RISC-V port has unresolved linker symbols

## Contributing

FreeRTOS integration is tracked in [**issue #880**](https://github.com/ZigEmbeddedGroup/microzig/issues/880).

Areas that need work:

- Static allocation variants (`*CreateStatic`)
- Stream and message buffer wrappers
- Multicore SMP support
- `.init_array` processing in MicroZig startup
- Additional platform ports (ESP32, STM32)
- RISC-V port linker fixes
