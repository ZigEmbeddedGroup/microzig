const std = @import("std");
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
const TrapFrame = microzig.cpu.TrapFrame;
const SYSTEM = microzig.chip.peripherals.SYSTEM;

pub const Task = struct {
    trap_frame: TrapFrame,
    stack: []u8,
    semaphore: u32 = 0,
    next: *Task,

    pub fn create(
        allocator: std.mem.Allocator,
        entry: *const fn (param: ?*anyopaque) callconv(.c) noreturn,
        param: ?*anyopaque,
        stack_size: usize,
    ) Allocator.Error!*Task {
        const stack: []u8 = try allocator.alloc(u8, stack_size);
        errdefer allocator.free(stack);

        const task: *Task = try allocator.create(Task);
        errdefer allocator.destroy(task);

        const trap_frame: TrapFrame = blk: {
            const stack_top_addr: usize = @intFromPtr(stack.ptr) + stack.len;

            var frame: TrapFrame = undefined;
            @memset(std.mem.asBytes(&frame), 0);

            frame.pc = @intFromPtr(entry);
            frame.a0 = @intFromPtr(param);
            frame.sp = stack_top_addr - stack_top_addr % 16;

            break :blk frame;
        };

        task.* = .{
            .trap_frame = trap_frame,
            .stack = stack,
            .next = task, // loop back to this task
        };

        return task;
    }

    pub fn destroy(task: *Task, allocator: Allocator) void {
        allocator.free(task.stack);
        allocator.destroy(task);
    }
};

var main_task: *Task = undefined;
/// SAFETY: we don't need optionals because there will always be the main task
/// running. It can't be deleted.
pub var current_task: *Task = undefined;

/// Must be called before the preemption timer interrupt is enabled.
pub fn init(allocator: Allocator) !void {
    const task: *Task = try allocator.create(Task);
    task.* = .{
        .trap_frame = undefined,
        .stack = &.{},
        .next = task, // loop back to this task
    };
    current_task = task;
    main_task = task;
}

pub fn schedule_task(task: *Task) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    task.next = current_task.next;
    current_task.next = task;
}

pub fn switch_task(trap_frame: *TrapFrame) void {
    copy_context(&current_task.trap_frame, trap_frame);

    // check if we need to delete any task

    current_task = current_task.next;

    copy_context(trap_frame, &current_task.trap_frame);
}

fn copy_context(dst: *TrapFrame, src: *const TrapFrame) void {
    const size = @offsetOf(TrapFrame, "mstatus");
    @memcpy(std.mem.asBytes(dst)[0..size], std.mem.asBytes(src)[0..size]);
}

pub fn yield_task() void {
    if (!microzig.cpu.interrupt.globally_enabled()) {
        @panic("can't yield when interrupts are disabled");
    }

    // TODO: config
    SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
        .CPU_INTR_FROM_CPU_0 = 1,
    });

    microzig.cpu.wfi();
}
