const std = @import("std");
const log = std.log.scoped("esp_radio_osi");

const microzig = @import("microzig");
const enter_critical_section = microzig.interrupt.enter_critical_section;
const time = microzig.drivers.time;
const peripherals = microzig.chip.peripherals;
const APB_CTRL = peripherals.APB_CTRL;
const hal = microzig.hal;

const multitasking = @import("multitasking.zig");
const timer = @import("timer.zig");

const c = @import("esp-wifi-driver");

// TODO: config
const coex_enabled: bool = false;

pub var allocator: std.mem.Allocator = undefined;

pub var wifi_interrupt_handler: struct {
    f: *const fn (?*anyopaque) callconv(.c) void,
    arg: ?*anyopaque,
} = undefined;

extern fn vsnprintf(buffer: [*c]u8, len: usize, fmt: [*c]const u8, va_list: std.builtin.VaList) callconv(.c) void;

const log_wifi_internal = std.log.scoped(.esp_wifi_internal);

fn syslog(fmt: ?[*:0]const u8, va_list: std.builtin.VaList) callconv(.c) void {
    var buf: [512:0]u8 = undefined;
    vsnprintf(&buf, 512, fmt, va_list);
    log_wifi_internal.debug("{s}", .{std.mem.span((&buf).ptr)});
}

const c_other_exports = struct {
    pub export var WIFI_EVENT: c.esp_event_base_t = "WIFI_EVENT";
};

const c_functions = struct {
    // TODO: foundation libc for some of these.

    pub export fn strlen(str: ?[*:0]const u8) callconv(.c) usize {
        const s = str orelse return 0;

        return std.mem.len(s);
    }

    pub export fn strnlen(str: ?[*:0]const u8, _: usize) callconv(.c) usize {
        const s = str orelse return 0;

        // TODO Actually provide a complete implementation.
        return std.mem.len(s);
    }

    pub export fn strrchr(_: ?[*:0]const u8, _: u32) callconv(.c) usize {
        @panic("strrchr");
    }

    pub export fn __assert_func(
        file: ?[*:0]const u8,
        line: u32,
        func: ?[*:0]const u8,
        failed_expr: ?[*:0]const u8,
    ) void {
        log.err("assertion `{s}` failed: file `{s}`, line {}, function `{s}`", .{
            failed_expr orelse "",
            file orelse "",
            line,
            func orelse "",
        });
        @panic("assertion failed");
    }

    pub export fn malloc(len: usize) callconv(.c) ?*anyopaque {
        const maybe_alloc = blk: {
            const cs = enter_critical_section();
            defer cs.leave();

            break :blk allocator.rawAlloc(@sizeOf(usize) + len, .@"4", @returnAddress());
        };

        if (maybe_alloc) |alloc| {
            const alloc_len: *usize = @alignCast(@ptrCast(alloc));
            alloc_len.* = len;

            return @ptrFromInt(@intFromPtr(alloc) + @sizeOf(usize));
        } else {
            return null;
        }
    }

    pub export fn calloc(number: usize, size: usize) callconv(.c) ?*anyopaque {
        const total_size: usize = number * size;
        if (malloc(total_size)) |ptr| {
            @memset(@as([*]u8, @ptrCast(ptr))[0..total_size], 0);
            return ptr;
        }
        return null;
    }

    pub export fn free(ptr: ?*anyopaque) callconv(.c) void {
        std.debug.assert(ptr != null);

        const alloc: [*]u8 = @ptrFromInt(@intFromPtr(ptr) - 4);
        const alloc_len: *usize = @alignCast(@ptrCast(alloc));

        const cs = enter_critical_section();
        defer cs.leave();

        allocator.rawFree(alloc[0 .. 4 + alloc_len.*], .@"4", @returnAddress());
    }

    pub export fn _putchar(byte: u8) callconv(.c) void {
        // NOTE: not interrupt safe

        const static = struct {
            var buf: [256]u8 = undefined;
            var bytes_written: usize = 0;
        };

        static.buf[static.bytes_written] = byte;
        static.bytes_written += 1;

        if (static.bytes_written >= 256) {
            log_wifi_internal.debug("_putchar: {s}", .{&static.buf});
            static.bytes_written = 0;
        }
    }

    pub export fn puts(ptr: ?*anyopaque) callconv(.c) void {
        // NOTE: not interrupt safe

        const s: []const u8 = std.mem.span(@as([*:0]const u8, @ptrCast(ptr)));
        log_wifi_internal.debug("{s}", .{s});
    }

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

    pub export fn gettimeofday(tv: ?*c.timeval, _: ?*anyopaque) i32 {
        if (tv) |time_val| {
            const usec = hal.time.get_time_since_boot().to_us();
            time_val.tv_sec = usec / 1_000_000;
            time_val.tv_usec = @intCast(usec % 1_000_000);
        }

        return 0;
    }

    pub export fn sleep(time_sec: c_uint) callconv(.c) c_int {
        hal.time.sleep_ms(time_sec * 1_000);
        return 0;
    }

    pub export fn usleep(time_us: u32) callconv(.c) c_int {
        hal.time.sleep_us(time_us);
        return 0;
    }

    pub export fn esp_fill_random(buf: [*c]u8, len: usize) callconv(.c) void {
        hal.rng.read(buf[0..len]);
    }
};

comptime {
    std.testing.refAllDecls(c_functions);
    std.testing.refAllDecls(c_other_exports);
}

pub const osi = struct {
    pub fn env_is_chip() callconv(.c) bool {
        return true;
    }

    pub fn set_intr(cpu_no: i32, intr_source: u32, intr_num: u32, intr_prio: i32) callconv(.c) void {
        // TODO: maybe assert here argument values contain the values bellow

        log.debug("set_intr {} {} {} {}", .{ cpu_no, intr_source, intr_num, intr_prio });

        // esp32c3
        // these are already set up
        // possible calls:
        // INFO - set_intr 0 2 1 1 (WIFI_PWR)
        // INFO - set_intr 0 0 1 1 (WIFI_MAC)
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

        switch (n) {
            0, 1 => {
                const cs = enter_critical_section();
                defer cs.leave();

                wifi_interrupt_handler = .{
                    .f = @alignCast(@ptrCast(f)),
                    .arg = arg,
                };
            },
            else => @panic("invalid interrupt number"),
        }

        microzig.cpu.interrupt.enable(.interrupt1);
    }

    // NOTE: temp until I see what bits are set.
    pub fn ints_on(mask: u32) callconv(.c) void {
        std.debug.panic("ints_on {}", .{mask});
    }

    pub fn ints_off(mask: u32) callconv(.c) void {
        std.debug.panic("ints_off {}", .{mask});
    }

    pub fn is_from_isr() callconv(.c) bool {
        return true;
    }

    var FAKE_SPINLOCK: u8 = 1;
    pub fn spin_lock_create() callconv(.c) ?*anyopaque {
        log.debug("spin_lock_create", .{});
        return &FAKE_SPINLOCK;
    }

    pub fn spin_lock_delete(_: ?*anyopaque) callconv(.c) void {
        log.debug("spin_lock_delete", .{});
    }

    // NOTE: critical section for now. If we decide to run the code on multiple cpus (on other chips) we
    // should change this.
    pub fn wifi_int_disable(_: ?*anyopaque) callconv(.c) u32 {
        log.debug("wifi_int_disable", .{});

        const ints_enabled = microzig.cpu.interrupt.globally_enabled();
        if (ints_enabled) {
            microzig.cpu.interrupt.disable_interrupts();
        }
        return @intFromBool(ints_enabled);
    }

    pub fn wifi_int_restore(_: ?*anyopaque, state: u32) callconv(.c) void {
        log.debug("wifi_int_restore", .{});

        // NOTE: is this required?
        microzig.cpu.fence();

        // check if interrupts were enabled before.
        if (state != 0) {
            microzig.cpu.interrupt.enable_interrupts();
        }
    }

    pub fn task_yield_from_isr() callconv(.c) void {
        log.debug("task_yield_from_isr", .{});

        multitasking.yield_task();
    }

    pub fn semphr_create(max_value: u32, init_value: u32) callconv(.c) ?*anyopaque {
        log.debug("semphr_create {} {}", .{ max_value, init_value });

        const cs = enter_critical_section();
        defer cs.leave();

        const sem = allocator.create(u32) catch {
            log.warn("failed to allocate semaphore", .{});
            return null;
        };
        sem.* = init_value;

        return sem;
    }

    pub fn semphr_delete(ptr: ?*anyopaque) callconv(.c) void {
        log.debug("semphr_delete {?}", .{ptr});

        const cs = enter_critical_section();
        defer cs.leave();

        allocator.destroy(@as(*u32, @alignCast(@ptrCast(ptr))));
    }

    pub fn semphr_take(ptr: ?*anyopaque, tick: u32) callconv(.c) i32 {
        log.debug("semphr_take {?} {}", .{ ptr, tick });

        const forever = tick == c.OSI_FUNCS_TIME_BLOCKING;
        const timeout = tick;
        const start = hal.time.get_time_since_boot();

        const sem: *u32 = @alignCast(@ptrCast(ptr));

        while (true) {
            const res: bool = blk: {
                const cs = enter_critical_section();
                defer cs.leave();

                microzig.cpu.fence();

                const cnt = sem.*;
                if (cnt > 0) {
                    sem.* = cnt - 1;
                    break :blk true;
                } else {
                    break :blk false;
                }
            };

            if (res) {
                return 1;
            }

            if (!forever and hal.time.get_time_since_boot().diff(start).to_us() > timeout) {
                break;
            }

            multitasking.yield_task();
        }

        return 0;
    }

    pub fn semphr_give(ptr: ?*anyopaque) callconv(.c) i32 {
        log.debug("semphr_give {?}", .{ptr});

        const sem: *u32 = @alignCast(@ptrCast(ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        const cnt = sem.*;
        sem.* = cnt + 1;
        return 1;
    }

    pub fn wifi_thread_semphr_get() callconv(.c) ?*anyopaque {
        return @ptrCast(&multitasking.current_task.semaphore);
    }

    const Mutex = struct {
        locking_task: usize,
        count: u32,
        recursive: bool,
    };

    // TODO: idk if we're gonna need to implement this
    pub fn mutex_create() callconv(.c) ?*anyopaque {
        @panic("mutex_create: not implemented");
    }

    pub fn recursive_mutex_create() callconv(.c) ?*anyopaque {
        log.debug("recursive_mutex_create", .{});

        const cs = enter_critical_section();
        defer cs.leave();

        const mutex = allocator.create(Mutex) catch {
            log.warn("failed to allocate recursive mutex", .{});
            return null;
        };
        mutex.* = .{
            .locking_task = 0xffff_ffff,
            .count = 0,
            .recursive = true,
        };
        return mutex;
    }

    pub fn mutex_delete(ptr: ?*anyopaque) callconv(.c) void {
        log.debug("mutex_delete {?}", .{ptr});

        const mutex: *Mutex = @alignCast(@ptrCast(ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        allocator.destroy(mutex);
    }

    pub fn mutex_lock(ptr: ?*anyopaque) callconv(.c) i32 {
        log.debug("mutex lock {?}", .{ptr});

        const mutex: *Mutex = @alignCast(@ptrCast(ptr));
        const cur_task_id: usize = @intFromPtr(multitasking.current_task);

        while (true) {
            const mutex_locked = blk: {
                const cs = enter_critical_section();
                defer cs.leave();

                if (mutex.count == 0) {
                    mutex.locking_task = cur_task_id;
                    mutex.count += 1;
                    break :blk true;
                } else if (mutex.locking_task == cur_task_id) {
                    mutex.count += 1;
                    break :blk true;
                } else {
                    break :blk false;
                }
            };

            microzig.cpu.fence();

            if (mutex_locked) {
                return 1;
            }

            multitasking.yield_task();
        }
    }

    pub fn mutex_unlock(ptr: ?*anyopaque) callconv(.c) i32 {
        log.debug("mutex unlock {?}", .{ptr});

        const mutex: *Mutex = @alignCast(@ptrCast(ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        microzig.cpu.fence();

        if (mutex.count > 0) {
            mutex.count -= 1;
            return 1;
        } else {
            return 0;
        }
    }

    const Queue = struct {
        capacity: usize,
        item_len: usize,
        read_index: usize = 0,
        write_index: usize = 0,
        storage: []u8,

        pub fn create(capacity: usize, item_len: usize) error{OutOfMemory}!*Queue {
            const queue = try allocator.create(Queue);
            errdefer allocator.destroy(queue);

            queue.* = .{
                .capacity = capacity,
                .item_len = item_len,
                .read_index = 0,
                .write_index = 0,
                .storage = try allocator.alloc(u8, capacity * item_len),
            };

            return queue;
        }

        pub fn destroy(self: *Queue) void {
            allocator.free(self.storage);
            allocator.destroy(self);
        }

        pub fn len(self: Queue) usize {
            if (self.write_index >= self.read_index) {
                return self.write_index - self.read_index;
            } else {
                return self.capacity - self.read_index + self.write_index;
            }
        }

        pub fn get(self: Queue, index: usize) []u8 {
            const item_start = self.item_len * index;
            return self.storage[item_start..][0..self.item_len];
        }

        pub fn enqueue(self: *Queue, item: [*]const u8) error{QueueFull}!void {
            if (self.len() == self.capacity) {
                return error.QueueFull;
            }

            const slot = self.get(self.write_index);
            @memcpy(slot, item[0..self.item_len]);
            self.write_index = (self.write_index + 1) % self.capacity;
        }

        pub fn dequeue(self: *Queue, item: [*]u8) error{QueueEmpty}!void {
            if (self.len() == 0) {
                return error.QueueEmpty;
            }

            const slot = self.get(self.read_index);
            @memcpy(item[0..self.item_len], slot);
            self.read_index = (self.read_index + 1) % self.capacity;
        }
    };

    pub fn queue_create(capacity: u32, item_len: u32) callconv(.c) ?*anyopaque {
        log.debug("queue_create {} {}", .{ capacity, item_len });

        const cs = enter_critical_section();
        defer cs.leave();

        const queue = Queue.create(allocator, capacity, item_len) catch {
            log.warn("failed to allocate queue", .{});
            return null;
        };

        return queue;
    }

    pub fn queue_delete(ptr: ?*anyopaque) callconv(.c) void {
        log.debug("queue_delete {?}", .{ptr});

        const queue: *Queue = @alignCast(@ptrCast(ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        queue.destroy(allocator);
    }

    // NOTE: here we ignore the timeout. The rust version doesn't use it.
    fn queue_send_common(ptr: ?*anyopaque, item_ptr: ?*anyopaque) callconv(.c) i32 {
        const queue: *Queue = @alignCast(@ptrCast(ptr));
        const item: [*]const u8 = @alignCast(@ptrCast(item_ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        queue.enqueue(item) catch {
            log.warn("failed to add item to queue", .{});
            return 0;
        };

        return 1;
    }

    pub fn queue_send(ptr: ?*anyopaque, item_ptr: ?*anyopaque, block_time_tick: u32) callconv(.c) i32 {
        log.debug("queue_send {?} {?} {}", .{ ptr, item_ptr, block_time_tick });

        return queue_send_common(ptr, item_ptr);
    }

    pub fn queue_send_from_isr(ptr: ?*anyopaque, item_ptr: ?*anyopaque, _hptw: ?*anyopaque) callconv(.c) i32 {
        log.debug("queue_send_from_isr {?} {?} {?}", .{ ptr, item_ptr, _hptw });

        @as(*u32, @alignCast(@ptrCast(_hptw))).* = 1;
        return queue_send_common(ptr, item_ptr);
    }

    pub fn queue_send_to_back() callconv(.c) void {
        @panic("queue_send_to_back: not implemented");
    }

    pub fn queue_send_to_front() callconv(.c) void {
        @panic("queue_send_to_front: not implemented");
    }

    pub fn queue_recv(ptr: ?*anyopaque, item_ptr: ?*anyopaque, block_time_tick: u32) callconv(.c) i32 {
        log.debug("queue_recv {?} {?} {}", .{ ptr, item_ptr, block_time_tick });

        const forever = block_time_tick == c.OSI_FUNCS_TIME_BLOCKING;
        const timeout = block_time_tick;
        const start = hal.time.get_time_since_boot();

        const queue: *Queue = @alignCast(@ptrCast(ptr));
        const item: [*]u8 = @alignCast(@ptrCast(item_ptr));

        while (true) {
            const cs = enter_critical_section();
            defer cs.leave();

            if (queue.dequeue(item)) |_| {
                return 1;
            } else |_| {}

            if (!forever and hal.time.get_time_since_boot().diff(start).to_us() > timeout) {
                return -1;
            }

            multitasking.yield_task();
        }
    }

    pub fn queue_msg_waiting(ptr: ?*anyopaque) callconv(.c) u32 {
        log.debug("queue_msg_waiting {?}", .{ptr});

        const queue: *Queue = @alignCast(@ptrCast(ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        return queue.len();
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
        _ = prio; // autofix
        _ = core_id; // autofix

        const cs = enter_critical_section();
        cs.leave();

        const task: *multitasking.Task = multitasking.Task.create(
            allocator,
            @alignCast(@ptrCast(task_func)),
            param,
            stack_depth,
        ) catch {
            log.warn("failed to create task", .{});
            return 0;
        };
        multitasking.schedule_task(task);

        @as(*usize, @alignCast(@ptrCast(task_handle))).* = @intFromPtr(task);

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

        const start = hal.time.get_time_since_boot();
        const delay: time.Duration = .from_us(tick);

        while (hal.time.get_time_since_boot().diff(start).less_than(delay)) {
            multitasking.yield_task();
        }
    }

    // NOTE: we could probably use milliseconds directly.
    pub fn task_ms_to_tick(ms: u32) callconv(.c) i32 {
        // NOTE: idk about bitcast here. Seems weird that it returns i32.
        return @intCast(ms * 1_000);
    }

    pub fn task_get_current_task() callconv(.c) ?*anyopaque {
        return multitasking.current_task;
    }

    pub fn task_get_max_priority() callconv(.c) i32 {
        return -1;
    }

    pub const malloc = c_functions.malloc;
    pub const free = c_functions.free;

    pub fn event_post() callconv(.c) void {
        @panic("event_post: not implemented");
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

    fn phy_set_enabled(enable: bool) void {
        log.debug("phy_set_enabled", .{});

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
        phy_set_enabled(false);
    }

    pub fn phy_enable() callconv(.c) void {
        log.debug("phy_enable", .{});
        phy_set_enabled(true);
    }

    pub fn phy_update_country_info(country: [*c]const u8) callconv(.c) c_int {
        log.debug("phy_update_country_info {s}", .{country});
        return -1;
    }

    pub fn read_mac(mac: [*c]u8, typ: c_uint) callconv(.c) c_int {
        log.debug("read_mac {*} {}", .{ mac, typ });

        const EFUSE = microzig.chip.peripherals.EFUSE;

        const low_32_bits: u32 = EFUSE.RD_MAC_SPI_SYS_0.read().MAC_0;
        const high_16_bits: u16 = EFUSE.RD_MAC_SPI_SYS_1.read().MAC_1;
        @memcpy(mac[0..4], std.mem.asBytes(&low_32_bits));
        @memcpy(mac[4..6], std.mem.asBytes(&high_16_bits));

        // idk what this means
        switch (typ) {
            // esp_mac_wifi_softap
            1 => {
                const tmp = mac[0];
                var i: u6 = 0;
                while (i < 64) : (i += 1) {
                    mac[0] |= 0x02;
                    mac[0] ^= @intCast(i << 2);

                    if (mac[0] != tmp) {
                        break;
                    }
                }
            },
            // esp_mac_bt
            2 => {
                const tmp = mac[0];
                var i: u6 = 0;
                while (i < 64) : (i += 1) {
                    mac[0] |= 0x02;
                    mac[0] ^= @intCast(i << 2);

                    if (mac[0] != tmp) {
                        break;
                    }
                }
                mac[5] += 1;
            },
            else => {},
        }

        return 0;
    }

    pub fn timer_arm(ets_timer_ptr: ?*anyopaque, ms: u32, repeat: bool) callconv(.c) void {
        timer_arm_us(ets_timer_ptr, ms * 1_000, repeat);
    }

    pub fn timer_disarm(ets_timer_ptr: ?*anyopaque) callconv(.c) void {
        log.debug("timer_disarm {?}", .{ets_timer_ptr});

        const ets_timer: *c.ets_timer = @alignCast(@ptrCast(ets_timer_ptr));

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

        const ets_timer: *c.ets_timer = @alignCast(@ptrCast(ets_timer_ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        if (timer.find(ets_timer)) |tim| {
            timer.remove(allocator, tim);
        } else {
            log.warn("timer not found based on ets_timer", .{});
        }
    }

    pub fn timer_setfn(ets_timer_ptr: ?*anyopaque, callback_ptr: ?*anyopaque, arg: ?*anyopaque) callconv(.c) void {
        log.debug("timer_setfn {?} {?} {?}", .{ ets_timer_ptr, callback_ptr, arg });

        const ets_timer: *c.ets_timer = @alignCast(@ptrCast(ets_timer_ptr));
        ets_timer.func = @alignCast(@ptrCast(callback_ptr));
        ets_timer.priv = arg;

        const cs = enter_critical_section();
        defer cs.leave();

        if (timer.find(ets_timer)) |tim| {
            tim.deadline = .init_absolute(null);
        } else {
            timer.add(allocator, ets_timer) catch {
                log.warn("failed to allocate timer", .{});
            };
        }
    }

    pub fn timer_arm_us(ets_timer_ptr: ?*anyopaque, us: u32, repeat: bool) callconv(.c) void {
        log.debug("timer_arm_us {?} {} {}", .{ ets_timer_ptr, us, repeat });

        const ets_timer: *c.ets_timer = @alignCast(@ptrCast(ets_timer_ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        if (timer.find_timer(ets_timer)) |tim| {
            const period: time.Duration = .from_us(us);
            tim.deadline = .init_relative(hal.time.get_time_since_boot(), period);
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

        // TODO: or bit cast?
        return @intCast(hal.time.get_time_since_boot().to_us());
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
        return @truncate(hal.time.get_time_since_boot().to_us() * 1_000);
    }

    pub const malloc_internal = malloc;

    pub fn realloc_internal() callconv(.c) void {
        @panic("realloc_internal: not implemented");
    }

    pub const calloc_internal = c_functions.calloc;

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

    pub const wifi_calloc = c_functions.calloc;
    pub const wifi_zalloc = zalloc_internal;

    var wifi_queue_handle: *Queue = undefined;

    pub fn wifi_create_queue(capacity: c_int, item_len: c_int) callconv(.c) ?*anyopaque {
        log.debug("wifi_create_queue {} {}", .{ capacity, item_len });

        const cs = enter_critical_section();
        defer cs.leave();

        wifi_queue_handle = Queue.create(allocator, @intCast(capacity), @intCast(item_len)) catch {
            log.warn("failed to allocate wifi queue", .{});
            return null;
        };

        return @ptrCast(&wifi_queue_handle);
    }

    pub fn wifi_delete_queue(ptr: ?*anyopaque) callconv(.c) void {
        log.debug("wifi_delete_queue", .{});

        const queue: *Queue = @alignCast(@ptrCast(ptr));

        const cs = enter_critical_section();
        defer cs.leave();

        queue.destroy(allocator);
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
};
