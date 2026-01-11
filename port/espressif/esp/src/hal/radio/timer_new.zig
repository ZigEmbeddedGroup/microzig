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

pub const Command = union(enum) {
    exit,
    setfn: struct {
        ets_timer: *c.ets_timer,
        func: CallbackFn,
        arg: ?*anyopaque,
    },
    arm: struct {
        ets_timer: *c.ets_timer,
        duration: time.Duration,
        repeat: bool,
    },
    disarm: *c.ets_timer,
    done: *c.ets_timer,
};

var buf: [1]Command = undefined;
pub var command_queue: rtos.Queue(Command) = undefined;

var timer_list: std.SinglyLinkedList = .{};

pub fn init(gpa: Allocator) Allocator.Error!void {
    command_queue = .init(&buf);

    _ = try rtos.spawn(gpa, task_fn, .{gpa}, .{
        .priority = .lowest,
        .stack_size = 8192,
    });
}

pub fn deinit() void {
    command_queue.put_one(.exit, null);

    // TODO: wait for task to exit
}

fn task_fn(gpa: std.mem.Allocator) void {
    while (true) {
        const now = get_time_since_boot();
        while (find_expired(now)) |tim| {
            if (tim.periodic) |period| {
                tim.deadline = .init_relative(now, period);
            } else {
                tim.deadline = .no_deadline;
            }
            tim.callback(tim.arg);
        }

        const sleep_duration = if (find_next_wake_absolute()) |next_wake_absolute|
            next_wake_absolute.diff(now)
        else
            null;

        const command = command_queue.get_one(sleep_duration) catch continue;
        switch (command) {
            .exit => break,
            .setfn => |setfn| {
                if (find(setfn.ets_timer)) |tim| {
                    tim.callback = setfn.func;
                    tim.arg = setfn.arg;
                    tim.deadline = .no_deadline;

                    // setfn.ets_timer.expire = 0;
                } else {
                    // setfn.ets_timer.next = null;
                    // setfn.ets_timer.period = 0;
                    // setfn.ets_timer.func = null;
                    // setfn.ets_timer.priv = null;

                    add(gpa, setfn.ets_timer, setfn.func, setfn.arg) catch {
                        std.log.warn("failed to allocate timer", .{});
                    };
                }
            },
            .arm => |arm| {
                if (find(arm.ets_timer)) |tim| {
                    tim.deadline = .init_relative(get_time_since_boot(), arm.duration);
                    tim.periodic = if (arm.repeat) arm.duration else null;
                } else {
                    std.log.warn("timer not found based on ets_timer", .{});
                }
            },
            .disarm => |ets_timer| {
                if (find(ets_timer)) |tim| {
                    tim.deadline = .no_deadline;
                } else {
                    std.log.warn("timer not found based on ets_timer", .{});
                }
            },
            .done => |ets_timer| {
                if (find(ets_timer)) |tim| {
                    // ets_timer.priv = null;
                    // ets_timer.expire = 0;
                    remove(gpa, tim);
                } else {
                    std.log.warn("timer not found based on ets_timer", .{});
                }
            },
        }
    }
}

fn add(allocator: Allocator, ets_timer: *c.ets_timer, callback: CallbackFn, arg: ?*anyopaque) !void {
    const timer = try allocator.create(Timer);
    timer.* = .{
        .ets_timer = ets_timer,
        .callback = callback,
        .arg = arg,
        .deadline = .no_deadline,
        .periodic = null,
    };
    timer_list.prepend(&timer.node);
}

fn remove(allocator: Allocator, timer: *Timer) void {
    timer_list.remove(&timer.node);
    allocator.destroy(timer);
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
