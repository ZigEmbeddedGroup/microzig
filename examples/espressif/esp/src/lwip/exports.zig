/// Platform dependent exports required by lwip
///
const std = @import("std");

const microzig = @import("microzig");
const esp = microzig.hal;
const rtos = esp.rtos;

const c = @import("include.zig").c;

const log = std.log.scoped(.lwip);

// TODO: mutex and mailbox can be implemented without allocations if we define
// the correct types in sys_arch.h

pub var gpa: std.mem.Allocator = undefined;
pub var core_mutex: rtos.Mutex = .{};

export fn lwip_lock_core_mutex() void {
    core_mutex.lock();
}

export fn lwip_unlock_core_mutex() void {
    core_mutex.unlock();
}

export fn lwip_rand() u32 {
    return esp.rng.random_u32();
}

export fn lwip_assert(msg: [*c]const u8, file: [*c]const u8, line: c_int) void {
    log.err("assert: {s} in file: {s}, line: {}", .{ msg, file, line });
    @panic("lwip assert");
}

export fn lwip_diag(msg: [*c]const u8, file: [*c]const u8, line: c_int) void {
    log.debug("{s} in file: {s}, line: {}", .{ msg, file, line });
}

export fn sys_now() u32 {
    const ts = esp.time.get_time_since_boot();
    return @truncate(ts.to_us() / 1000);
}

export fn sys_init() void {}

export fn sys_mutex_new(ptr: *c.sys_mutex_t) c.err_t {
    const mutex = gpa.create(rtos.Mutex) catch {
        log.warn("failed to allocate mutex", .{});
        return c.ERR_MEM;
    };
    mutex.* = .{};
    ptr.* = mutex;
    return c.ERR_OK;
}

export fn sys_mutex_free(ptr: *c.sys_mutex_t) void {
    const mutex: *rtos.Mutex = @ptrCast(@alignCast(ptr.*));
    gpa.destroy(mutex);
}

export fn sys_mutex_lock(ptr: *c.sys_mutex_t) void {
    const mutex: *rtos.Mutex = @ptrCast(@alignCast(ptr.*));
    mutex.lock();
}

export fn sys_mutex_unlock(ptr: *c.sys_mutex_t) void {
    const mutex: *rtos.Mutex = @ptrCast(@alignCast(ptr.*));
    mutex.unlock();
}

const MailboxElement = ?*anyopaque;
const Mailbox = rtos.Queue(MailboxElement);

export fn sys_mbox_new(ptr: *c.sys_mbox_t, size: i32) c.err_t {
    const buffer = gpa.alloc(MailboxElement, @intCast(size)) catch {
        log.warn("failed to allocate mailbox buffer", .{});
        return c.ERR_MEM;
    };

    const mailbox = gpa.create(Mailbox) catch {
        log.warn("failed to allocate mailbox", .{});
        gpa.free(buffer);
        return c.ERR_MEM;
    };
    mailbox.* = .init(buffer);

    ptr.* = mailbox;
    return c.ERR_OK;
}

export fn sys_mbox_free(ptr: *c.sys_mbox_t) void {
    const mailbox: *Mailbox = @ptrCast(@alignCast(ptr.*));
    gpa.free(@as([]MailboxElement, @ptrCast(@alignCast(mailbox.type_erased.buffer))));
    gpa.destroy(mailbox);
    ptr.* = null;
}

export fn sys_mbox_valid(ptr: *c.sys_mbox_t) c_int {
    return @intFromBool(ptr.* != null);
}

export fn sys_mbox_set_invalid(ptr: *c.sys_mbox_t) void {
    ptr.* = null;
}

export fn sys_mbox_post(ptr: *c.sys_mbox_t, element: MailboxElement) void {
    const mailbox: *Mailbox = @ptrCast(@alignCast(ptr.*));
    mailbox.put_one(element, null) catch unreachable;
}

export fn sys_mbox_trypost(ptr: *c.sys_mbox_t, element: MailboxElement) c.err_t {
    const mailbox: *Mailbox = @ptrCast(@alignCast(ptr.*));
    if (mailbox.put_one_non_blocking(element)) {
        return c.ERR_OK;
    } else {
        return c.ERR_MEM;
    }
}

comptime {
    @export(&sys_mbox_trypost, .{ .name = "sys_mbox_trypost_fromisr" });
}

export fn sys_arch_mbox_fetch(ptr: *c.sys_mbox_t, element_ptr: *MailboxElement, timeout: u32) u32 {
    const mailbox: *Mailbox = @ptrCast(@alignCast(ptr.*));
    const now = esp.time.get_time_since_boot();
    element_ptr.* = mailbox.get_one(if (timeout != 0) .from_ms(timeout) else null) catch {
        return c.SYS_ARCH_TIMEOUT;
    };
    // returns waiting time in ms
    return @intCast(esp.time.get_time_since_boot().diff(now).to_us() / 1_000);
}

export fn sys_arch_mbox_tryfetch(ptr: *c.sys_mbox_t, element_ptr: *MailboxElement) u32 {
    const mailbox: *Mailbox = @ptrCast(@alignCast(ptr.*));
    if (mailbox.get_one_non_blocking()) |element| {
        element_ptr.* = element;
        return 0;
    } else {
        return c.SYS_MBOX_EMPTY;
    }
}

export fn sys_sem_new(ptr: *c.sys_sem_t, count: u8) c.err_t {
    const sem = gpa.create(rtos.Semaphore) catch {
        log.warn("failed to allocate semaphore", .{});
        return c.ERR_MEM;
    };
    sem.* = .init(count, 1);
    ptr.* = sem;
    return c.ERR_OK;
}

export fn sys_sem_free(ptr: *c.sys_sem_t) void {
    const sem: *rtos.Semaphore = @ptrCast(@alignCast(ptr.*));
    gpa.destroy(sem);
}

export fn sys_sem_signal(ptr: *c.sys_sem_t) void {
    const sem: *rtos.Semaphore = @ptrCast(@alignCast(ptr.*));
    sem.give();
}

export fn sys_arch_sem_wait(ptr: *c.sys_sem_t, timeout: u32) u32 {
    const sem: *rtos.Semaphore = @ptrCast(@alignCast(ptr.*));
    const now = esp.time.get_time_since_boot();
    sem.take_with_timeout(if (timeout != 0) .from_ms(timeout) else null) catch {
        return c.SYS_ARCH_TIMEOUT;
    };
    // returns waiting time in ms
    return @intCast(esp.time.get_time_since_boot().diff(now).to_us() / 1_000);
}

export fn sys_sem_valid(ptr: *c.sys_sem_t) c_int {
    return @intFromBool(ptr.* != null);
}

export fn sys_sem_set_invalid(ptr: *c.sys_sem_t) void {
    ptr.* = null;
}

fn task_wrapper(
    task_entry: c.lwip_thread_fn,
    param: ?*anyopaque,
) void {
    task_entry.?(param);
}

export fn sys_thread_new(name: [*:0]u8, thread: c.lwip_thread_fn, arg: ?*anyopaque, stacksize: c_int, prio: c_int) c.sys_thread_t {
    _ = stacksize;
    _ = prio;

    return rtos.spawn(gpa, task_wrapper, .{ thread, arg }, .{
        .name = std.mem.span(name),
        .stack_size = 4096,
        .priority = @enumFromInt(2),
    }) catch @panic("failed to allocate lwip task");
}
