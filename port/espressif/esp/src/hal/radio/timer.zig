const std = @import("std");
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
const time = microzig.drivers.time;
const hal = microzig.hal;

const multitasking = @import("multitasking.zig");

const c = @import("esp-wifi-driver");

pub const CallbackFn = *const fn (?*anyopaque) callconv(.c) void;

pub const Timer = struct {
    ets_timer: *c.ets_timer,
    callback: CallbackFn,
    arg: ?*anyopaque,
    deadline: time.Deadline,
    periodic: ?time.Duration,
};

const TimerList = std.SinglyLinkedList(Timer);
const TimerListNode = TimerList.Node;

var timer_list: TimerList = .{};

// pub fn init(allocator: Allocator) !void {
//     const task = try multitasking.Task.create(allocator, timer_task, null, 8192);
//     multitasking.schedule_task(task);
// }

pub fn add(allocator: Allocator, ets_timer: *c.ets_timer, callback: CallbackFn, arg: ?*anyopaque) !void {
    const timer: Timer = .{
        .ets_timer = ets_timer,
        .callback = callback,
        .arg = arg,
        .deadline = .init_absolute(null),
        .periodic = null,
    };

    const node = try allocator.create(TimerListNode);
    node.* = .{
        .data = timer,
    };

    timer_list.prepend(node);
}

pub fn remove(allocator: Allocator, timer: *Timer) void {
    const node: *TimerListNode = @fieldParentPtr("data", timer);
    timer_list.remove(node);
    allocator.destroy(node);
}

pub fn find(ets_timer: *c.ets_timer) ?*Timer {
    var current_node = timer_list.first;
    while (current_node) |node| : (current_node = node.next) {
        const timer = &node.data;
        if (timer.ets_timer == ets_timer) {
            return timer;
        }
    }
    return null;
}

pub fn tick() void {
    while (true) {
        const now = hal.time.get_time_since_boot();

        const maybe_call, const arg = blk: {
            const cs = microzig.interrupt.enter_critical_section();
            defer cs.leave();

            if (find_next_due(now)) |tim| {
                if (tim.periodic) |period| {
                    tim.deadline = .init_relative(now, period);
                } else {
                    tim.deadline = .init_absolute(null);
                }

                break :blk .{ tim.callback, tim.arg };
            } else {
                break :blk .{ null, null };
            }
        };

        if (maybe_call) |callback| {
            callback(arg);
        } else {
            break;
        }
    }
}

fn find_next_due(now: time.Absolute) ?*Timer {
    var current_node = timer_list.first;
    while (current_node) |node| : (current_node = node.next) {
        const timer = &node.data;
        if (timer.deadline.is_reached_by(now)) {
            return timer;
        }
    }
    return null;
}

// fn timer_task(_: ?*anyopaque) callconv(.c) noreturn {
// }
