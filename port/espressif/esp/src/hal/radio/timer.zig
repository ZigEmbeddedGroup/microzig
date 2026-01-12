const std = @import("std");
const log = std.log.scoped(.radio_timer);
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
const time = microzig.drivers.time;
const rtos = @import("../rtos.zig");
const get_time_since_boot = @import("../time.zig").get_time_since_boot;

const c = @import("esp-wifi-driver");

pub const CallbackFn = *const fn (?*anyopaque) callconv(.c) void;

pub const Timer = struct {
    ets_timer: *c.ets_timer,
    callback: CallbackFn,
    arg: ?*anyopaque,
    deadline: time.Deadline,
    periodic: ?time.Duration,
    node: std.SinglyLinkedList.Node = .{},
};

var reload_semaphore: rtos.Semaphore = .init(0, 1);
var mutex: rtos.Mutex = .{};
var timer_list: std.SinglyLinkedList = .{};

pub fn init(gpa: Allocator) Allocator.Error!void {
    _ = try rtos.spawn(gpa, task_fn, .{}, .{
        .priority = .highest, // TODO: what should the priority be?
        .stack_size = 8192,
    });
}

pub fn deinit() void {
    // TODO: exit mechanism
}

pub fn setfn(
    gpa: std.mem.Allocator,
    ets_timer: *c.ets_timer,
    callback: CallbackFn,
    arg: ?*anyopaque,
) !void {
    {
        mutex.lock();
        defer mutex.unlock();

        if (find(ets_timer)) |tim| {
            tim.callback = callback;
            tim.arg = arg;
            tim.deadline = .no_deadline;
        } else {
            const timer = try gpa.create(Timer);
            timer.* = .{
                .ets_timer = ets_timer,
                .callback = callback,
                .arg = arg,
                .deadline = .no_deadline,
                .periodic = null,
            };
            timer_list.prepend(&timer.node);
        }
    }

    reload_semaphore.give();
}

pub fn arm(
    ets_timer: *c.ets_timer,
    duration: time.Duration,
    repeat: bool,
) void {
    {
        mutex.lock();
        defer mutex.unlock();

        if (find(ets_timer)) |tim| {
            tim.deadline = .init_relative(get_time_since_boot(), duration);
            tim.periodic = if (repeat) duration else null;
        } else {
            std.log.warn("timer not found based on ets_timer", .{});
        }
    }

    reload_semaphore.give();
}

pub fn disarm(ets_timer: *c.ets_timer) void {
    mutex.lock();
    defer mutex.unlock();

    if (find(ets_timer)) |tim| {
        tim.deadline = .no_deadline;
    } else {
        std.log.warn("timer not found based on ets_timer", .{});
    }
}

pub fn done(gpa: std.mem.Allocator, ets_timer: *c.ets_timer) void {
    mutex.lock();
    defer mutex.unlock();

    if (find(ets_timer)) |tim| {
        timer_list.remove(&tim.node);
        gpa.destroy(tim);
    } else {
        std.log.warn("timer not found based on ets_timer", .{});
    }
}

fn task_fn() void {
    while (true) {
        const now = get_time_since_boot();
        while (true) {
            const callback, const arg = blk: {
                mutex.lock();
                defer mutex.unlock();

                const tim = find_expired(now) orelse break;
                if (tim.periodic) |period| {
                    tim.deadline = .init_relative(now, period);
                } else {
                    tim.deadline = .no_deadline;
                }
                break :blk .{ tim.callback, tim.arg };
            };

            callback(arg);
        }

        const sleep_duration = blk: {
            mutex.lock();
            defer mutex.unlock();
            break :blk if (find_next_wake_absolute()) |next_wake_absolute|
                next_wake_absolute.diff(now)
            else
                null;
        };

        reload_semaphore.take_with_timeout(sleep_duration) catch {};
    }
}

fn find(ets_timer: *c.ets_timer) ?*Timer {
    var it = timer_list.first;
    while (it) |node| : (it = node.next) {
        const timer: *Timer = @alignCast(@fieldParentPtr("node", node));
        if (timer.ets_timer == ets_timer) {
            return timer;
        }
    }
    return null;
}

fn find_expired(now: time.Absolute) ?*Timer {
    var it = timer_list.first;
    while (it) |node| : (it = node.next) {
        const timer: *Timer = @alignCast(@fieldParentPtr("node", node));
        if (timer.deadline.is_reached_by(now)) {
            return timer;
        }
    }
    return null;
}

fn find_next_wake_absolute() ?time.Absolute {
    var it = timer_list.first;
    var min_deadline: time.Deadline = .no_deadline;
    while (it) |node| : (it = node.next) {
        const timer: *Timer = @alignCast(@fieldParentPtr("node", node));
        if (@intFromEnum(timer.deadline.timeout) < @intFromEnum(min_deadline.timeout)) {
            min_deadline = timer.deadline;
        }
    }
    return if (min_deadline.can_be_reached()) min_deadline.timeout else null;
}
