const builtin = @import("builtin");
const std = @import("std");
const log = std.log.scoped(.esp_radio_osi);

const microzig = @import("microzig");
const enter_critical_section = microzig.interrupt.enter_critical_section;
const time = microzig.drivers.time;
const peripherals = microzig.chip.peripherals;
const APB_CTRL = peripherals.APB_CTRL;
const hal = microzig.hal;

const Scheduler = @import("../Scheduler.zig");
const systimer = @import("../systimer.zig");
const get_time_since_boot = @import("../time.zig").get_time_since_boot;
const timer = @import("timer.zig");
const wifi = @import("wifi.zig");

const c = @import("esp-wifi-driver");

// TODO: config
const coex_enabled: bool = false;

pub var allocator: std.mem.Allocator = undefined;
pub var scheduler: *Scheduler = undefined;

pub var wifi_interrupt_handler: struct {
    f: *const fn (?*anyopaque) callconv(.c) void,
    arg: ?*anyopaque,
} = undefined;

extern fn vsnprintf(buffer: [*c]u8, len: usize, fmt: [*c]const u8, va_list: std.builtin.VaList) callconv(.c) void;

const log_esp_wifi_driver_internal = std.log.scoped(.esp_wifi_driver_internal);

fn syslog(fmt: ?[*:0]const u8, va_list: std.builtin.VaList) callconv(.c) void {
    var buf: [512:0]u8 = undefined;
    vsnprintf(&buf, 512, fmt, va_list);
    log_esp_wifi_driver_internal.debug("{s}", .{std.mem.span((&buf).ptr)});
}

// ----- exports -----

pub fn strlen(str: ?[*:0]const u8) callconv(.c) usize {
    const s = str orelse return 0;

    return std.mem.len(s);
}

pub fn strnlen(str: ?[*:0]const u8, _: usize) callconv(.c) usize {
    // const s = str orelse return 0;
    // return if (std.mem.indexOfScalar(u8, s[0..n], 0)) |index| index + 1 else n;
    const s = str orelse return 0;

    return std.mem.len(s);
}

pub fn strrchr(str: ?[*:0]const u8, chr: u32) callconv(.c) ?[*:0]const u8 {
    const s = str orelse return null;

    // Should return even the index of the zero byte if requested. This
    // implementation only works with single byte characters.

    if (std.mem.lastIndexOfScalar(u8, s[0 .. std.mem.len(s) + 1], @intCast(chr))) |index| {
        return @ptrFromInt(@intFromPtr(s) + index);
    } else {
        return null;
    }
}

pub fn __assert_func(
    file: ?[*:0]const u8,
    line: u32,
    func: ?[*:0]const u8,
    failed_expr: ?[*:0]const u8,
) callconv(.c) void {
    switch (builtin.mode) {
        .Debug, .ReleaseSafe => {
            log.err("assertion failed: `{s}` in file {s}, line {}, function {s}", .{
                failed_expr orelse "",
                file orelse "",
                line,
                func orelse "",
            });
            @panic("assertion failed");
        },
        .ReleaseSmall => @panic("assertion failed"),
        .ReleaseFast => unreachable,
    }
}

pub fn malloc(len: usize) callconv(.c) ?*anyopaque {
    log.debug("malloc {}", .{len});

    const buf = allocator.rawAlloc(8 + len, .@"8", @returnAddress()) orelse {
        log.warn("failed to allocate memory: {}", .{len});
        return null;
    };

    const alloc_len: *usize = @ptrCast(@alignCast(buf));
    alloc_len.* = len;
    return @ptrFromInt(@intFromPtr(buf) + 8);
}

pub fn calloc(number: usize, size: usize) callconv(.c) ?*anyopaque {
    const total_size: usize = number * size;
    if (malloc(total_size)) |ptr| {
        @memset(@as([*]u8, @ptrCast(ptr))[0..total_size], 0);
        return ptr;
    }
    return null;
}

pub fn free(ptr: ?*anyopaque) callconv(.c) void {
    // Avoid multiple frees at the same time as it causes a panic
    microzig.cpu.interrupt.disable_interrupts();
    defer microzig.cpu.interrupt.enable_interrupts();

    log.debug("free {?}", .{ptr});

    if (ptr == null) {
        log.warn("ignoring free(null) called by 0x{x}", .{@returnAddress()});
        return;
    }

    const buf_ptr: [*]u8 = @ptrFromInt(@intFromPtr(ptr) - 8);
    const buf_len: *usize = @ptrCast(@alignCast(buf_ptr));
    allocator.rawFree(buf_ptr[0 .. @sizeOf(usize) + buf_len.*], .@"8", @returnAddress());
}

pub fn puts(ptr: ?*anyopaque) callconv(.c) void {
    const s: []const u8 = std.mem.span(@as([*:0]const u8, @ptrCast(ptr)));
    log_esp_wifi_driver_internal.debug("{s}", .{s});
}

pub fn gettimeofday(tv: ?*c.timeval, _: ?*anyopaque) callconv(.c) i32 {
    if (tv) |time_val| {
        const usec = get_time_since_boot().to_us();
        time_val.tv_sec = usec / 1_000_000;
        time_val.tv_usec = @intCast(usec % 1_000_000);
    }

    return 0;
}

pub fn sleep(time_sec: c_uint) callconv(.c) c_int {
    scheduler.sleep(.from_us(time_sec * 1_000_000));
    return 0;
}

pub fn usleep(time_us: u32) callconv(.c) c_int {
    scheduler.sleep(.from_us(time_us));
    return 0;
}

comptime {
    // provide some weak links so they can be overriten

    @export(&strlen, .{ .name = "strlen", .linkage = .weak });
    @export(&strnlen, .{ .name = "strnlen", .linkage = .weak });
    @export(&strrchr, .{ .name = "strrchr", .linkage = .weak });

    @export(&__assert_func, .{ .name = "__assert_func", .linkage = .weak });

    @export(&malloc, .{ .name = "malloc", .linkage = .weak });
    @export(&calloc, .{ .name = "calloc", .linkage = .weak });
    @export(&free, .{ .name = "free", .linkage = .weak });
    @export(&puts, .{ .name = "puts", .linkage = .weak });

    @export(&gettimeofday, .{ .name = "gettimeofday", .linkage = .weak });
    @export(&sleep, .{ .name = "sleep", .linkage = .weak });
    @export(&usleep, .{ .name = "usleep", .linkage = .weak });
}

pub export var WIFI_EVENT: c.esp_event_base_t = "WIFI_EVENT";

pub export fn rtc_printf(fmt: ?[*:0]const u8, ...) callconv(.c) void {
    syslog(fmt, @cVaStart());
}

pub export fn phy_printf(fmt: ?[*:0]const u8, ...) callconv(.c) void {
    syslog(fmt, @cVaStart());
}

pub export fn coexist_printf(fmt: ?[*:0]const u8, ...) callconv(.c) void {
    syslog(fmt, @cVaStart());
}

pub export fn net80211_printf(fmt: ?[*:0]const u8, ...) callconv(.c) void {
    syslog(fmt, @cVaStart());
}

pub export fn pp_printf(fmt: ?[*:0]const u8, ...) callconv(.c) void {
    syslog(fmt, @cVaStart());
}

pub export fn esp_fill_random(buf: [*c]u8, len: usize) callconv(.c) void {
    log.debug("esp_fill_random {any} {}", .{ buf, len });

    hal.rng.read(buf[0..len]);
}

// ----- end of exports -----

pub fn env_is_chip() callconv(.c) bool {
    return true;
}

pub fn set_intr(cpu_no: i32, intr_source: u32, intr_num: u32, intr_prio: i32) callconv(.c) void {
    log.debug("set_intr {} {} {} {}", .{ cpu_no, intr_source, intr_num, intr_prio });

    // esp32c3
    // these are already set up
    // possible calls:
    // INFO - set_intr 0 2 1 1 (WIFI_PWR)
    // INFO - set_intr 0 0 1 1 (WIFI_MAC)
    //
    // we don't need to do anything as these interrupts are already setup in
    // `radio.init`
}

pub fn clear_intr(intr_source: u32, intr_num: u32) callconv(.c) void {
    log.debug("clear_intr {} {}", .{ intr_source, intr_num });
}

pub fn set_isr(
    n: i32,
    f: ?*anyopaque,
    arg: ?*anyopaque,
) callconv(.c) void {
    log.debug("set_isr {} {?} {?}", .{ n, f, arg });

    // esp32c3 specific

    switch (n) {
        0, 1 => {
            wifi_interrupt_handler = .{
                .f = @ptrCast(@alignCast(f)),
                .arg = arg,
            };
        },
        else => @panic("invalid interrupt number"),
    }
}

// TODO
pub fn ints_on(mask: u32) callconv(.c) void {
    log.debug("ints_on {}", .{mask});

    if (mask == 2) {
        microzig.cpu.interrupt.enable(.interrupt29);
    }
}

// TODO
pub fn ints_off(mask: u32) callconv(.c) void {
    log.debug("ints_off {}", .{mask});

    if (mask == 2) {
        microzig.cpu.interrupt.disable(.interrupt29);
    }
}

pub fn is_from_isr() callconv(.c) bool {
    return true;
}

pub fn spin_lock_create() callconv(.c) ?*anyopaque {
    log.debug("spin_lock_create", .{});
    return semphr_create(1, 1);
}

pub fn spin_lock_delete(ptr: ?*anyopaque) callconv(.c) void {
    log.debug("spin_lock_delete {?}", .{ptr});
    return semphr_delete(ptr);
}

pub fn wifi_int_disable(mux_ptr: ?*anyopaque) callconv(.c) u32 {
    log.debug("wifi_int_disable {?}", .{mux_ptr});

    const ints_enabled = microzig.cpu.interrupt.globally_enabled();
    if (ints_enabled) {
        microzig.cpu.interrupt.disable_interrupts();
    }
    return @intFromBool(ints_enabled);
}

pub fn wifi_int_restore(mux_ptr: ?*anyopaque, state: u32) callconv(.c) void {
    log.debug("wifi_int_restore {?} {}", .{ mux_ptr, state });

    // check if interrupts were enabled before.
    if (state != 0) {
        microzig.cpu.interrupt.enable_interrupts();
    }
}

pub fn task_yield_from_isr() callconv(.c) void {
    log.debug("task_yield_from_isr", .{});

    Scheduler.yield_from_isr();
}

pub fn semphr_create(max_value: u32, init_value: u32) callconv(.c) ?*anyopaque {
    log.debug("semphr_create {} {}", .{ max_value, init_value });

    const sem = allocator.create(Scheduler.Semaphore) catch {
        log.warn("failed to allocate semaphore", .{});
        return null;
    };
    sem.* = .init(init_value);

    log.debug(">>>> semaphore create: {*}", .{sem});

    return sem;
}

pub fn semphr_delete(ptr: ?*anyopaque) callconv(.c) void {
    log.debug("semphr_delete {?}", .{ptr});

    allocator.destroy(@as(*Scheduler.Semaphore, @ptrCast(@alignCast(ptr))));
}

pub fn semphr_take(ptr: ?*anyopaque, tick: u32) callconv(.c) i32 {
    log.debug("semphr_take {?} {}", .{ ptr, tick });

    const sem: *Scheduler.Semaphore = @ptrCast(@alignCast(ptr));
    const maybe_timeout: ?time.Duration = if (tick == c.OSI_FUNCS_TIME_BLOCKING)
        .from_us(tick)
    else
        null;
    sem.take_with_timeout(scheduler, maybe_timeout) catch {
        log.debug(">>>> return from semaphore take with timeout: {*}", .{sem});
        return 1;
    };

    return 0;
}

pub fn semphr_give(ptr: ?*anyopaque) callconv(.c) i32 {
    log.debug("semphr_give {?}", .{ptr});

    const sem: *Scheduler.Semaphore = @ptrCast(@alignCast(ptr));
    sem.give(scheduler);
    return 1;
}

pub fn wifi_thread_semphr_get() callconv(.c) ?*anyopaque {
    return &scheduler.current_task.semaphore;
}

// TODO: idk if we're gonna need to implement this
pub fn mutex_create() callconv(.c) ?*anyopaque {
    @panic("mutex_create: not implemented");
}

pub fn recursive_mutex_create() callconv(.c) ?*anyopaque {
    log.debug("recursive_mutex_create", .{});

    const mutex = allocator.create(Scheduler.RecursiveMutex) catch {
        log.warn("failed to allocate recursive mutex", .{});
        return null;
    };
    mutex.* = .{};

    log.debug(">>>> mutex create: {*}", .{mutex});

    return mutex;
}

pub fn mutex_delete(ptr: ?*anyopaque) callconv(.c) void {
    log.debug("mutex_delete {?}", .{ptr});

    const mutex: *Scheduler.RecursiveMutex = @ptrCast(@alignCast(ptr));
    allocator.destroy(mutex);
}

pub fn mutex_lock(ptr: ?*anyopaque) callconv(.c) i32 {
    log.debug("mutex lock {?}", .{ptr});

    const mutex: *Scheduler.RecursiveMutex = @ptrCast(@alignCast(ptr));
    mutex.lock(scheduler);

    return 1;
}

pub fn mutex_unlock(ptr: ?*anyopaque) callconv(.c) i32 {
    log.debug("mutex unlock {?}", .{ptr});

    const mutex: *Scheduler.RecursiveMutex = @ptrCast(@alignCast(ptr));
    return @intFromBool(mutex.unlock(scheduler));
}

pub const QueueWrapper = struct {
    item_len: u32,
    inner: Scheduler.TypeErasedQueue,
};

pub fn queue_create(capacity: u32, item_len: u32) callconv(.c) ?*anyopaque {
    log.debug("queue_create {} {}", .{ capacity, item_len });

    const new_cap, const new_item_len = if (capacity != 3 and item_len != 4)
        .{ capacity, item_len }
    else blk: {
        log.warn("fixing queue item len", .{});
        break :blk .{ 3, 8 };
    };

    const buf: []u8 = allocator.alloc(u8, new_cap) catch {
        log.warn("failed to allocate queue buffer", .{});
        return null;
    };

    const queue = allocator.create(QueueWrapper) catch {
        log.warn("failed to allocate queue", .{});
        allocator.free(buf);
        return null;
    };

    queue.* = .{
        .item_len = new_item_len,
        .inner = .init(buf),
    };

    log.debug(">>>> queue create: {*}", .{queue});

    return queue;
}

pub fn queue_delete(ptr: ?*anyopaque) callconv(.c) void {
    log.debug("queue_delete {?}", .{ptr});

    const queue: *QueueWrapper = @ptrCast(@alignCast(ptr));
    allocator.free(queue.inner.buffer);
    allocator.destroy(queue);
}

pub fn queue_send(ptr: ?*anyopaque, item_ptr: ?*anyopaque, block_time_tick: u32) callconv(.c) i32 {
    log.debug("queue_send {?} {?} {}", .{ ptr, item_ptr, block_time_tick });

    const queue: *QueueWrapper = @ptrCast(@alignCast(ptr));
    const item: [*]const u8 = @ptrCast(@alignCast(item_ptr));

    const maybe_timeout: ?time.Duration = if (block_time_tick == c.OSI_FUNCS_TIME_BLOCKING)
        .from_us(block_time_tick)
    else
        null;

    return @intCast(@divExact(queue.inner.put_with_timeout(
        scheduler,
        item[0..queue.item_len],
        queue.item_len,
        maybe_timeout,
    ) catch |err| switch (err) {
        error.Closed => unreachable,
        error.Timeout => return -1,
    }, queue.item_len));
}

pub fn queue_send_from_isr(ptr: ?*anyopaque, item_ptr: ?*anyopaque, _hptw: ?*anyopaque) callconv(.c) i32 {
    log.debug("queue_send_from_isr {?} {?} {?}", .{ ptr, item_ptr, _hptw });

    const queue: *QueueWrapper = @ptrCast(@alignCast(ptr));
    const item: [*]const u8 = @ptrCast(@alignCast(item_ptr));
    const n = @divExact(queue.inner.put_from_isr(
        scheduler,
        item[0..queue.item_len],
    ) catch unreachable, queue.item_len);

    @as(*u32, @ptrCast(@alignCast(_hptw))).* = @intFromBool(scheduler.is_a_higher_priority_task_ready());

    return @intCast(n);
}

pub fn queue_send_to_back() callconv(.c) void {
    @panic("queue_send_to_back: not implemented");
}

pub fn queue_send_to_front() callconv(.c) void {
    @panic("queue_send_to_front: not implemented");
}

pub fn queue_recv(ptr: ?*anyopaque, item_ptr: ?*anyopaque, block_time_tick: u32) callconv(.c) i32 {
    log.debug("queue_recv {?} {?} {}", .{ ptr, item_ptr, block_time_tick });

    const queue: *QueueWrapper = @ptrCast(@alignCast(ptr));
    const item: [*]u8 = @ptrCast(@alignCast(item_ptr));

    const maybe_timeout: ?time.Duration = if (block_time_tick == c.OSI_FUNCS_TIME_BLOCKING)
        .from_us(block_time_tick)
    else
        null;

    return @intCast(@divExact(queue.inner.get_with_timeout(
        scheduler,
        item[0..queue.item_len],
        queue.item_len,
        maybe_timeout,
    ) catch |err| switch (err) {
        error.Closed => unreachable,
        error.Timeout => return -1,
    }, queue.item_len));
}

pub fn queue_msg_waiting(ptr: ?*anyopaque) callconv(.c) u32 {
    log.debug("queue_msg_waiting {?}", .{ptr});

    const queue: *QueueWrapper = @ptrCast(@alignCast(ptr));
    return @divExact(queue.inner.len, queue.item_len);
}

pub fn event_group_create() callconv(.c) void {
    @panic("event_group_create: not implemented");
}

pub fn event_group_delete() callconv(.c) void {
    @panic("event_group_delete: not implemented");
}

pub fn event_group_set_bits() callconv(.c) void {
    @panic("event_group_set_bits: not implemented");
}

pub fn event_group_clear_bits() callconv(.c) void {
    @panic("event_group_clear_bits: not implemented");
}

pub fn event_group_wait_bits() callconv(.c) void {
    @panic("event_group_wait_bits: not implemented");
}

fn task_create_common(
    task_func: ?*anyopaque,
    name: [*c]const u8,
    stack_depth: u32,
    param: ?*anyopaque,
    prio: u32,
    task_handle: ?*anyopaque,
    core_id: u32,
) i32 {
    _ = name; // autofix
    _ = core_id; // autofix

    const task: *Scheduler.Task = scheduler.raw_alloc_spawn_with_options(
        @ptrCast(@alignCast(task_func)),
        param,
        .{
            .priority = @enumFromInt(prio),
            .stack_size = stack_depth,
        },
    ) catch {
        log.warn("failed to create task", .{});
        return 0;
    };

    @as(*usize, @ptrCast(@alignCast(task_handle))).* = @intFromPtr(task);

    return 1;
}

pub fn task_create_pinned_to_core(
    task_func: ?*anyopaque,
    name: [*c]const u8,
    stack_depth: u32,
    param: ?*anyopaque,
    prio: u32,
    task_handle: ?*anyopaque,
    core_id: u32,
) callconv(.c) i32 {
    log.debug("task_create_pinned_to_core {?} {s} {} {?} {} {?} {}", .{
        task_func,
        name,
        stack_depth,
        param,
        prio,
        task_handle,
        core_id,
    });

    return task_create_common(task_func, name, stack_depth, param, prio, task_handle, core_id);
}

pub fn task_create(
    task_func: ?*anyopaque,
    name: [*c]const u8,
    stack_depth: u32,
    param: ?*anyopaque,
    prio: u32,
    task_handle: ?*anyopaque,
) callconv(.c) i32 {
    log.debug("task_create {?} {s} {} {?} {} {?}", .{
        task_func,
        name,
        stack_depth,
        param,
        prio,
        task_handle,
    });

    return task_create_common(task_func, name, stack_depth, param, prio, task_handle, 0);
}

pub fn task_delete() callconv(.c) void {
    @panic("task_delete: not implemented");
}

pub fn task_delay(tick: u32) callconv(.c) void {
    log.debug("task_delay {}", .{tick});

    scheduler.sleep(.from_us(tick));
}

pub fn task_ms_to_tick(ms: u32) callconv(.c) i32 {
    return @intCast(ms * 1_000);
}

pub fn task_get_current_task() callconv(.c) ?*anyopaque {
    return scheduler.current_task;
}

pub fn task_get_max_priority() callconv(.c) i32 {
    return @intFromEnum(Scheduler.Priority.highest);
}

pub fn get_free_heap_size() callconv(.c) void {
    @panic("get_free_heap_size: not implemented");
}

pub fn rand() callconv(.c) u32 {
    return hal.rng.random_u32();
}

pub fn dport_access_stall_other_cpu_start_wrap() callconv(.c) void {
    log.debug("dport_access_stall_other_cpu_start_wrap", .{});
}

pub fn dport_access_stall_other_cpu_end_wrap() callconv(.c) void {
    log.debug("dport_access_stall_other_cpu_end_wrap", .{});
}

pub fn wifi_apb80m_request() callconv(.c) void {
    log.debug("wifi_apb80m_request", .{});
}

pub fn wifi_apb80m_release() callconv(.c) void {
    log.debug("wifi_apb80m_release", .{});
}

const CONFIG_ESP32_PHY_MAX_TX_POWER: u8 = 20;

fn limit(val: u8, low: u8, high: u8) u8 {
    return if (val < low) low else if (val > high) high else val;
}

const phy_init_data_default: c.esp_phy_init_data_t = .{
    .params = .{
        0x00,
        0x00,
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x50),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x50),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x50),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x4c),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x4c),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x48),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x4c),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x48),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x48),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x44),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x4a),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x46),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x46),
        limit(CONFIG_ESP32_PHY_MAX_TX_POWER * 4, 0, 0x42),
        0x00,
        0x00,
        0x00,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0x74,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    },
};

fn clocks_phy_set_enabled(enable: bool) void {
    const system_wifi_clk_wifi_bt_common_m: u32 = 0x78078F;

    var wifi_clk_en = APB_CTRL.WIFI_CLK_EN.read().WIFI_CLK_EN;
    if (enable) {
        wifi_clk_en |= system_wifi_clk_wifi_bt_common_m;
    } else {
        wifi_clk_en &= ~system_wifi_clk_wifi_bt_common_m;
    }
    APB_CTRL.WIFI_CLK_EN.write(.{ .WIFI_CLK_EN = wifi_clk_en });
}

pub fn phy_disable() callconv(.c) void {
    log.debug("phy_disable", .{});
    clocks_phy_set_enabled(false);
}

pub fn phy_enable() callconv(.c) void {
    log.debug("phy_enable", .{});

    const cs = enter_critical_section();
    defer cs.leave();

    clocks_phy_set_enabled(true);

    // TODO: fully implement phy enable
    var cal_data: c.esp_phy_calibration_data_t = std.mem.zeroes(c.esp_phy_calibration_data_t);

    const phy_version = c.get_phy_version_str();
    log.debug("phy_version {s}", .{phy_version});

    _ = c.register_chipv7_phy(&phy_init_data_default, &cal_data, c.PHY_RF_CAL_PARTIAL);
}

pub fn phy_update_country_info(country: [*c]const u8) callconv(.c) c_int {
    log.debug("phy_update_country_info {s}", .{country});
    return -1;
}

pub fn read_mac(mac: [*c]u8, typ: c_uint) callconv(.c) c_int {
    log.debug("read_mac {*} {}", .{ mac, typ });

    const mac_tmp: [6]u8 = hal.radio.read_mac(switch (typ) {
        0 => .sta,
        1 => .ap,
        2 => .bt,
        else => @panic("unknown mac typ"),
    });
    @memcpy(mac[0..6], &mac_tmp);

    return 0;
}

pub fn timer_arm(ets_timer_ptr: ?*anyopaque, ms: u32, repeat: bool) callconv(.c) void {
    timer_arm_us(ets_timer_ptr, ms * 1_000, repeat);
}

pub fn timer_disarm(ets_timer_ptr: ?*anyopaque) callconv(.c) void {
    log.debug("timer_disarm {?}", .{ets_timer_ptr});

    const ets_timer: *c.ets_timer = @ptrCast(@alignCast(ets_timer_ptr));

    const cs = enter_critical_section();
    defer cs.leave();

    if (timer.find(ets_timer)) |tim| {
        tim.deadline = .init_absolute(null);
    } else {
        log.warn("timer not found based on ets_timer", .{});
    }
}

pub fn timer_done(ets_timer_ptr: ?*anyopaque) callconv(.c) void {
    log.debug("timer_done {?}", .{ets_timer_ptr});

    const ets_timer: *c.ets_timer = @ptrCast(@alignCast(ets_timer_ptr));

    const cs = enter_critical_section();
    defer cs.leave();

    if (timer.find(ets_timer)) |tim| {
        ets_timer.priv = null;
        ets_timer.expire = 0;
        timer.remove(allocator, tim);
    } else {
        log.warn("timer not found based on ets_timer", .{});
    }
}

pub fn timer_setfn(ets_timer_ptr: ?*anyopaque, callback_ptr: ?*anyopaque, arg: ?*anyopaque) callconv(.c) void {
    log.debug("timer_setfn {?} {?} {?}", .{ ets_timer_ptr, callback_ptr, arg });

    const ets_timer: *c.ets_timer = @ptrCast(@alignCast(ets_timer_ptr));
    const callback: timer.CallbackFn = @ptrCast(@alignCast(callback_ptr));

    const cs = enter_critical_section();
    defer cs.leave();

    if (timer.find(ets_timer)) |tim| {
        tim.callback = callback;
        tim.arg = arg;
        tim.deadline = .init_absolute(null);

        ets_timer.expire = 0;
    } else {
        ets_timer.next = null;
        ets_timer.period = 0;
        ets_timer.func = null;
        ets_timer.priv = null;

        timer.add(allocator, ets_timer, callback, arg) catch {
            log.warn("failed to allocate timer", .{});
        };
    }
}

pub fn timer_arm_us(ets_timer_ptr: ?*anyopaque, us: u32, repeat: bool) callconv(.c) void {
    log.debug("timer_arm_us {?} {} {}", .{ ets_timer_ptr, us, repeat });

    const ets_timer: *c.ets_timer = @ptrCast(@alignCast(ets_timer_ptr));

    // TODO: locking
    const cs = enter_critical_section();
    defer cs.leave();

    if (timer.find(ets_timer)) |tim| {
        const period: time.Duration = .from_us(us);
        tim.deadline = .init_relative(get_time_since_boot(), period);
        tim.periodic = if (repeat) period else null;
    } else {
        log.warn("timer not found based on ets_timer", .{});
    }
}

pub fn wifi_reset_mac() callconv(.c) void {
    log.debug("wifi_reset_mac", .{});

    APB_CTRL.WIFI_RST_EN.write(.{ .WIFI_RST = APB_CTRL.WIFI_RST_EN.read().WIFI_RST | (1 << 2) });
    APB_CTRL.WIFI_RST_EN.write(.{ .WIFI_RST = APB_CTRL.WIFI_RST_EN.read().WIFI_RST & ~@as(u32, 1 << 2) });
}

pub fn wifi_clock_enable() callconv(.c) void {
    log.debug("wifi_clock_enable", .{});

    // no op on esp32c3
}

pub fn wifi_clock_disable() callconv(.c) void {
    log.debug("wifi_clock_disable", .{});

    // no op on esp32c3
}

pub fn wifi_rtc_enable_iso() callconv(.c) void {
    @panic("wifi_rtc_enable_iso: not implemented");
}

pub fn wifi_rtc_disable_iso() callconv(.c) void {
    @panic("wifi_rtc_disable_iso: not implemented");
}

pub fn esp_timer_get_time() callconv(.c) i64 {
    log.debug("esp_timer_get_time", .{});

    return @intCast(get_time_since_boot().to_us());
}

pub fn nvs_set_i8() callconv(.c) void {
    @panic("nvs_set_i8: not implemented");
}

pub fn nvs_get_i8() callconv(.c) void {
    @panic("nvs_get_i8: not implemented");
}

pub fn nvs_set_u8() callconv(.c) void {
    @panic("nvs_set_u8: not implemented");
}

pub fn nvs_get_u8() callconv(.c) void {
    @panic("nvs_get_u8: not implemented");
}

pub fn nvs_set_u16() callconv(.c) void {
    @panic("nvs_set_u16: not implemented");
}

pub fn nvs_get_u16() callconv(.c) void {
    @panic("nvs_get_u16: not implemented");
}

pub fn nvs_open() callconv(.c) void {
    @panic("nvs_open: not implemented");
}

pub fn nvs_close() callconv(.c) void {
    @panic("nvs_close: not implemented");
}

pub fn nvs_commit() callconv(.c) void {
    @panic("nvs_commit: not implemented");
}

pub fn nvs_set_blob() callconv(.c) void {
    @panic("nvs_set_blob: not implemented");
}

pub fn nvs_get_blob() callconv(.c) void {
    @panic("nvs_get_blob: not implemented");
}

pub fn nvs_erase_key() callconv(.c) void {
    @panic("nvs_erase_key: not implemented");
}

pub fn get_random(buf: [*c]u8, len: usize) callconv(.c) c_int {
    hal.rng.read(buf[0..len]);
    return 0;
}

pub fn get_time() callconv(.c) void {
    @panic("get_time: not implemented");
}

pub fn random() callconv(.c) c_ulong {
    return hal.rng.random_u32();
}

pub fn slowclk_cal_get() callconv(.c) u32 {
    // NOTE: esp32c3 specific
    return 28639;
}

pub fn log_write(_: c_uint, _: [*c]const u8, fmt: [*c]const u8, ...) callconv(.c) void {
    syslog(fmt, @cVaStart());
}

pub fn log_writev(_: c_uint, _: [*c]const u8, fmt: [*c]const u8, va_list: c.va_list) callconv(.c) void {
    syslog(fmt, @ptrCast(va_list));
}

pub fn log_timestamp() callconv(.c) u32 {
    return @truncate(get_time_since_boot().to_us() * 1_000);
}

pub const malloc_internal = malloc;

pub fn realloc_internal() callconv(.c) void {
    @panic("realloc_internal: not implemented");
}

pub const calloc_internal = calloc;

pub fn zalloc_internal(len: usize) callconv(.c) ?*anyopaque {
    if (malloc(len)) |ptr| {
        @memset(@as([*]u8, @ptrCast(ptr))[0..len], 0);
        return ptr;
    }

    return null;
}

pub const wifi_malloc = malloc;

pub fn wifi_realloc() callconv(.c) void {
    @panic("wifi_realloc: not implemented");
}

pub const wifi_calloc = calloc;
pub const wifi_zalloc = zalloc_internal;

var wifi_queue_handle: ?*QueueWrapper = null;
var wifi_queue: QueueWrapper = undefined;

pub fn wifi_create_queue(capacity: c_int, item_len: c_int) callconv(.c) ?*anyopaque {
    log.debug("wifi_create_queue {} {}", .{ capacity, item_len });

    std.debug.assert(wifi_queue_handle == null);

    const buf: []u8 = allocator.alloc(u8, @intCast(capacity)) catch {
        log.warn("failed to allocate queue buffer", .{});
        return null;
    };

    wifi_queue = .{
        .inner = .init(buf),
        .item_len = @intCast(item_len),
    };
    wifi_queue_handle = &wifi_queue;

    log.debug(">>>> wifi queue create: {*}", .{&wifi_queue_handle});

    return @ptrCast(&wifi_queue_handle);
}

pub fn wifi_delete_queue(ptr: ?*anyopaque) callconv(.c) void {
    log.debug("wifi_delete_queue {?}", .{ptr});

    std.debug.assert(ptr == @as(?*anyopaque, @ptrCast(&wifi_queue_handle)));

    const queue: *QueueWrapper = @ptrCast(@alignCast(ptr));
    allocator.free(queue.inner.buffer);

    wifi_queue_handle = null;
    wifi_queue = undefined;
}

pub fn coex_init() callconv(.c) c_int {
    log.debug("coex_init", .{});

    return if (coex_enabled) c.coex_init() else 0;
}

pub fn coex_deinit() callconv(.c) void {
    log.debug("coex_deinit", .{});

    if (coex_enabled) c.coex_deinit();
}

pub fn coex_enable() callconv(.c) c_int {
    log.debug("coex_enable", .{});

    return if (coex_enabled) c.coex_enable() else 0;
}

pub fn coex_disable() callconv(.c) void {
    log.debug("coex_disable", .{});

    if (coex_enabled) c.coex_disable();
}

pub fn coex_status_get() callconv(.c) u32 {
    log.debug("coex_status_get", .{});

    return if (coex_enabled) c.coex_status_get() else 0;
}

pub fn coex_condition_set() callconv(.c) void {
    @panic("coex_condition_set");
}

pub fn coex_wifi_request(
    event: u32,
    latency: u32,
    duration: u32,
) callconv(.c) c_int {
    log.debug("coex_wifi_request", .{});

    return if (coex_enabled) c.coex_wifi_request(event, latency, duration) else 0;
}

pub fn coex_wifi_release(event: u32) callconv(.c) c_int {
    log.debug("coex_wifi_release", .{});

    return if (coex_enabled) c.coex_wifi_release(event) else 0;
}

pub fn coex_wifi_channel_set(
    primary: u8,
    secondary: u8,
) callconv(.c) c_int {
    log.debug("coex_wifi_channel_set", .{});

    return if (coex_enabled) c.coex_wifi_channel_set(primary, secondary) else 0;
}

pub fn coex_event_duration_get(event: u32, duration: [*c]u32) callconv(.c) c_int {
    log.debug("coex_event_duration_get", .{});

    return if (coex_enabled) c.coex_event_duration_get(event, duration) else 0;
}

pub fn coex_pti_get(event: u32, pti: [*c]u8) callconv(.c) c_int {
    log.debug("coex_pti_get", .{});

    return if (coex_enabled) c.coex_pti_get(event, pti) else 0;
}

pub fn coex_schm_status_bit_clear(@"type": u32, status: u32) callconv(.c) void {
    log.debug("coex_schm_status_bit_clear", .{});

    if (coex_enabled) c.coex_schm_status_bit_clear(@"type", status);
}

pub fn coex_schm_status_bit_set(@"type": u32, status: u32) callconv(.c) void {
    log.debug("coex_schm_status_bit_set", .{});

    if (coex_enabled) c.coex_schm_status_bit_set(@"type", status);
}

pub fn coex_schm_interval_set(interval: u32) callconv(.c) c_int {
    log.debug("coex_schm_interval_set", .{});

    return if (coex_enabled) c.coex_schm_interval_set(interval) else 0;
}

pub fn coex_schm_interval_get() callconv(.c) u32 {
    log.debug("coex_schm_interval_get", .{});

    return if (coex_enabled) c.coex_schm_interval_get() else 0;
}

pub fn coex_schm_curr_period_get() callconv(.c) u8 {
    log.debug("coex_schm_curr_period_get", .{});

    return if (coex_enabled) c.coex_schm_curr_period_get() else 0;
}

pub fn coex_schm_curr_phase_get() callconv(.c) ?*anyopaque {
    log.debug("coex_schm_curr_phase_get", .{});

    return if (coex_enabled) c.coex_schm_curr_phase_get() else null;
}

pub fn coex_schm_process_restart() callconv(.c) c_int {
    log.debug("coex_schm_process_restart", .{});

    return if (coex_enabled) c.coex_schm_process_restart() else 0;
}

pub fn coex_schm_register_cb(
    @"type": c_int,
    callback: ?*const fn (c_int) callconv(.c) c_int,
) callconv(.c) c_int {
    log.debug("coex_schm_register_cb", .{});

    return if (coex_enabled) c.coex_schm_register_callback(@"type", callback) else 0;
}

pub fn coex_register_start_cb(cb: ?*const fn () callconv(.c) c_int) callconv(.c) c_int {
    log.debug("coex_register_start_cb", .{});

    return if (coex_enabled) c.coex_register_start_cb(cb) else 0;
}

extern fn ext_coex_schm_flexible_period_set(period: u8) i32;
pub fn coex_schm_flexible_period_set(period: u8) callconv(.c) c_int {
    log.debug("coex_schm_flexible_period_set {}", .{period});

    return if (coex_enabled) ext_coex_schm_flexible_period_set(period) else 0;
}

extern fn ext_coex_schm_flexible_period_get() u8;
pub fn coex_schm_flexible_period_get() callconv(.c) u8 {
    log.debug("coex_schm_flexible_period_get", .{});

    return if (coex_enabled) ext_coex_schm_flexible_period_get() else 0;
}
