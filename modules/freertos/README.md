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
- ✅ **ISR variants** — supported operations provide `*_from_isr` helpers
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
    freertos.task.start_scheduler();
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

**Allocation and deletion:** The default build uses `heap_1`, which supports allocation but cannot free memory.

### Tasks (`freertos.task`)

Task creation, deletion, scheduling, and runtime queries.

| Function | Description |
|---|---|
| `create(function, name, stack_depth, params, priority)` | Create a task → `Error!TaskHandle` |
| `destroy(handle)` | Delete a task (`null` = self; requires a freeing heap) |
| `delay(ticks)` | Block for `ticks` ticks |
| `delay_until(prev_wake_time, increment)` | Periodic delay → `bool` |
| `suspend(handle)` | Suspend a task (`null` = self) |
| `resume(handle)` | Resume a suspended task |
| `resume_from_isr(handle)` | Resume from ISR → `bool` (context switch needed) |
| `abort_delay(handle)` | Force-unblock a task → `bool` |
| `set_priority(handle, priority)` | Change a task's priority |
| `get_priority(handle)` | Get current priority |
| `get_current_handle()` | Handle of the running task |
| `get_handle(name)` | Look up task by name → `?TaskHandle` |
| `get_name(handle)` | Task name string |
| `get_state(handle)` | → `.running`, `.ready`, `.blocked`, `.suspended`, `.deleted` |
| `get_stack_high_water_mark(handle)` | Minimum free stack (words) since creation |
| `get_tick_count()` | Current system tick |
| `get_count()` | Total number of tasks |
| `start_scheduler()` | Start FreeRTOS — **never returns** |
| `end_scheduler()` | Stop FreeRTOS |
| `get_scheduler_state()` | → `.not_started`, `.running`, `.suspended` |
| `suspend_all()` / `resume_all()` | Disable/enable task switching |

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
| `q.send_to_front(item, timeout)` | Send to front |
| `q.overwrite(item)` | Overwrite single-item queue (never blocks) |
| `q.receive(timeout)` | Receive and remove → `Error!T` (`QueueEmpty` on timeout) |
| `q.peek(timeout)` | Read front item without removing |
| `q.send_from_isr(item)` | ISR send → `ISR_Result` |
| `q.receive_from_isr()` | ISR receive → `?IsrReceiveResult(T)` |
| `q.messages_waiting()` | Number of items in queue |
| `q.spaces_available()` | Free slots remaining |
| `q.reset()` | Flush the queue |
| `q.destroy()` | Delete the queue (requires a freeing heap) |

### Semaphores (`freertos.semaphore`)

Binary and counting semaphores for synchronization and signaling between tasks/ISRs.

| Function | Description |
|---|---|
| `create_binary()` | Create binary semaphore (starts empty) → `Error!Semaphore` |
| `create_counting(max, initial)` | Create counting semaphore → `Error!Semaphore` |
| `s.take(timeout)` | Acquire → `Error!void` (`Timeout`) |
| `s.give()` | Release → `Error!void` (`Failure` if not taken) |
| `s.give_from_isr()` | Release from ISR → `ISR_Result` |
| `s.take_from_isr()` | Acquire from ISR → `ISR_Result` |
| `s.get_count()` | Current count (or 1/0 for binary) |
| `s.destroy()` | Delete the semaphore (requires a freeing heap) |

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
| `create_recursive()` | Create a recursive mutex → `Error!Recursive` |
| `m.acquire(timeout)` | Lock → `Error!void` (`Timeout`) |
| `m.release()` | Unlock → `Error!void` (`Failure` if not held) |
| `m.get_holder()` | Task holding the mutex → `?TaskHandle` |
| `m.destroy()` | Delete the mutex (requires a freeing heap) |

Recursive mutexes can be acquired multiple times by the same task — each `acquire` must be paired with a `release`.

### Event Groups (`freertos.event_group`)

Multi-bit synchronization primitives. Tasks can wait on any combination of event bits, enabling rendezvous-style coordination.

```zig
var events = try freertos.event_group.create();
defer events.destroy();

// Task A sets bit 0
_ = events.set_bits(0x01);

// Task B waits for bits 0 AND 1
const bits = try events.wait_bits(0x03, .{ .wait_for_all = true, .timeout = 1000 });
```

| Function | Description |
|---|---|
| `create()` | Create an event group → `Error!EventGroup` |
| `e.set_bits(bits)` | Set bits → returns new value |
| `e.clear_bits(bits)` | Clear bits → returns previous value |
| `e.get_bits()` | Read current bits |
| `e.wait_bits(bits, opts)` | Wait for bit pattern → `Error!EventBits` (`Timeout`) |
| `e.sync(set, wait, timeout)` | Barrier: set bits then wait for others → `Error!EventBits` |
| `e.set_bits_from_isr(bits)` | Set bits from ISR → `ISR_Result` |
| `e.destroy()` | Delete the event group (requires a freeing heap) |

`WaitOptions` fields: `clear_on_exit` (default `true`), `wait_for_all` (default `false`), `timeout` (default `max_delay`).

### Software Timers (`freertos.timer`)

Periodic or one-shot timers that execute a callback in the timer daemon task context.

```zig
var tmr = try freertos.timer.create("heartbeat", 1000, true, null, my_callback);
try tmr.start(0);
defer tmr.destroy_blocking();
```

| Function | Description |
|---|---|
| `create(name, period, auto_reload, id, callback)` | Create a timer → `Error!Timer` |
| `t.start(cmd_timeout)` | Start/restart the timer |
| `t.stop(cmd_timeout)` | Stop the timer |
| `t.reset(cmd_timeout)` | Reset countdown from now |
| `t.change_period(new_period, cmd_timeout)` | Change period and restart |
| `t.destroy(cmd_timeout)` | Enqueue timer deletion (requires a freeing heap; can fail if command queue full) |
| `t.destroy_blocking()` | Wait indefinitely to enqueue timer deletion (requires a freeing heap) |
| `t.is_active()` | Check if running → `bool` |
| `t.get_name()` / `t.get_period()` / `t.get_expiry_time()` | Timer properties |
| `t.get_id()` / `t.set_id(ptr)` | User-defined ID pointer |
| `t.get_auto_reload()` / `t.set_auto_reload(bool)` | Auto-reload mode |
| `t.start_from_isr()` / `t.stop_from_isr()` / `t.reset_from_isr()` | ISR variants → `ISR_Result` |
| `pend_function_call(fn, p1, p2, timeout)` | Defer a function call to the timer daemon |

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
| `notify_indexed(handle, index, value, action)` | Send at specific index |
| `notify_and_query(handle, value, action)` | Send and get previous value → `Error!u32` |
| `give(handle)` | Increment notification (lightweight semaphore give) |
| `notify_from_isr(handle, value, action)` | Send from ISR → `ISR_Result` |
| `give_from_isr(handle)` | Increment from ISR → `ISR_Result` |
| `wait(clear_entry, clear_exit, timeout)` | Wait for notification → `Error!u32` |
| `wait_indexed(index, clear_entry, clear_exit, timeout)` | Wait at specific index |
| `take(clear_on_exit, timeout)` | Binary/counting semaphore pattern → `Error!u32` |
| `clear_state(handle)` | Clear pending state → `bool` |
| `clear_bits(handle, bits)` | Clear bits in notification value → previous value |

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
try freertos.config.check_base_type(rc);

// Convert nullable C handle → Zig error (null → error.OutOfMemory)
const handle = try freertos.config.check_handle(c.TaskHandle_t, raw_handle);
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

FreeRTOS configuration is generated from a single `config/FreeRTOSConfig.h.cmake` template at build time. Per-platform `FreeRTOSConfig.h` files have been removed; all tunable settings are now controlled through `build.zig` options.

### Build options

| Option | Type | Default | Description |
|---|---|---|---|
| `-Dport_name` | enum | `RP2040` | FreeRTOS port to target (`RP2040`, `RP2350_ARM`) |
| `-Didle_hook` | bool | `false` | Enable `configUSE_IDLE_HOOK` — calls `vApplicationIdleHook()` from the idle task |
| `-Dtick_hook` | bool | `false` | Enable `configUSE_TICK_HOOK` — calls `vApplicationTickHook()` on every tick interrupt |

When either hook is enabled you must define the corresponding callback in your application:

```zig
// Idle hook — called continuously by the idle task
export fn vApplicationIdleHook() callconv(.c) void {
    // e.g. enter low-power sleep
}

// Tick hook — called from the tick ISR every tick
export fn vApplicationTickHook() callconv(.c) void {
    // lightweight bookkeeping only — runs in ISR context
}
```

### Key settings (defaults)

| Setting | Value | Notes |
|---|---|---|
| `configTICK_RATE_HZ` | 1000 | 1 ms tick resolution |
| `configMAX_PRIORITIES` | 32 | Priority levels 0–31 |
| `configMINIMAL_STACK_SIZE` | 256 | Words (1 KB on 32-bit) |
| `configTOTAL_HEAP_SIZE` | 128 KB | FreeRTOS heap (`heap_1`, allocation only) |
| `configCHECK_FOR_STACK_OVERFLOW` | 2 | Full stack painting check — traps via `@trap()` |
| `configSUPPORT_DYNAMIC_ALLOCATION` | 1 | Dynamic only (static not yet supported) |
| `configNUMBER_OF_CORES` | 1 | Single-core only |

To enable object deletion and reclaim memory, replace `portable/MemMang/heap_1.c` with a heap implementation that supports freeing, such as `portable/MemMang/heap_4.c`, in [build.zig](build.zig).

### Pico SDK interop (disabled)

`configSUPPORT_PICO_SYNC_INTEROP` and `configSUPPORT_PICO_TIME_INTEROP` are **disabled**. The FreeRTOS RP2xxx port relies on `.init_array` constructors to initialize spin-locks and event groups before `main()`. MicroZig does not process `.init_array`, so enabling these causes a NULL dereference and Usage Fault on scheduler start. Re-enable only after MicroZig adds `.init_array` support.

## Known Limitations

- **Object deletion** — the default `heap_1` allocator cannot free memory; task deletion and object `destroy()`/`destroy_blocking()` calls require a freeing heap
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
