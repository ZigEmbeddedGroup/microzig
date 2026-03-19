//! FreeRTOS task management — creation, deletion, control, and scheduler operations.
//!
//! Tasks are the fundamental execution unit in FreeRTOS. This module provides
//! idiomatic Zig wrappers for creating tasks, controlling execution (delay,
//! suspend, resume), querying state, and managing the scheduler lifecycle.
//!
//! ## Key Functions
//! - `create` / `destroy` — task lifecycle
//! - `delay` / `delay_until` — blocking delays
//! - `start_scheduler` — hand control to FreeRTOS (never returns)
//! - `get_tick_count` / `get_count` — runtime queries

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const TaskHandle = config.TaskHandle;
const TaskFunction = config.TaskFunction;
const Error = config.Error;

// ── Task State ──────────────────────────────────────────────────────────

/// Runtime state of a FreeRTOS task.
pub const State = enum {
    running,
    ready,
    blocked,
    suspended,
    deleted,
    invalid,

    /// Convert from the C `eTaskState` enum.
    fn from_c(state: c.eTaskState) State {
        return switch (state) {
            c.eRunning => .running,
            c.eReady => .ready,
            c.eBlocked => .blocked,
            c.eSuspended => .suspended,
            c.eDeleted => .deleted,
            else => .invalid,
        };
    }
};

// ── Task Creation & Deletion ────────────────────────────────────────────

/// Create a new dynamically-allocated FreeRTOS task.
///
/// Returns a handle to the created task, or `error.OutOfMemory` if the
/// kernel heap is exhausted.
///
/// ## Example
/// ```zig
/// const handle = try freertos.task.create(my_func, "worker", 512, null, 1);
/// ```
pub fn create(
    function: TaskFunction,
    name: [*:0]const u8,
    stack_depth: config.StackDepthType,
    parameters: ?*anyopaque,
    priority: config.U_BaseType,
) Error!TaskHandle {
    var handle: TaskHandle = null;
    const rc = c.xTaskCreate(
        function,
        name,
        stack_depth,
        parameters,
        priority,
        &handle,
    );
    try config.check_base_type(rc);
    return handle;
}

/// Delete a task. Pass `null` to delete the calling task.
pub fn destroy(task_handle: ?TaskHandle) void {
    c.vTaskDelete(task_handle);
}

// ── Task Control ────────────────────────────────────────────────────────

/// Block the calling task for the given number of ticks.
pub fn delay(ticks: TickType) void {
    c.vTaskDelay(ticks);
}

/// Block the calling task until an absolute tick count, for periodic execution.
/// Returns `true` if the task was actually delayed (not already past the target time).
pub fn delay_until(previous_wake_time: *TickType, time_increment: TickType) bool {
    return config.check_true(c.xTaskDelayUntil(previous_wake_time, time_increment));
}

/// Suspend a task. Pass `null` to suspend the calling task.
pub fn @"suspend"(task_handle: ?TaskHandle) void {
    c.vTaskSuspend(task_handle);
}

/// Resume a previously suspended task.
pub fn @"resume"(task_handle: TaskHandle) void {
    c.vTaskResume(task_handle);
}

/// Resume a task from an ISR context.
/// Returns `true` if a context switch should be requested.
pub fn resume_from_isr(task_handle: TaskHandle) bool {
    return config.check_true(c.xTaskResumeFromISR(task_handle));
}

/// Force a task out of the Blocked state.
/// Returns `true` if the task was actually unblocked.
pub fn abort_delay(task_handle: TaskHandle) bool {
    return config.check_true(c.xTaskAbortDelay(task_handle));
}

/// Set a task's priority.
pub fn set_priority(task_handle: ?TaskHandle, new_priority: config.U_BaseType) void {
    c.vTaskPrioritySet(task_handle, new_priority);
}

/// Get a task's current priority.
pub fn get_priority(task_handle: ?TaskHandle) config.U_BaseType {
    return c.uxTaskPriorityGet(task_handle);
}

// ── Task Utilities ──────────────────────────────────────────────────────

/// Get the handle of the currently running task.
pub fn get_current_handle() TaskHandle {
    return c.xTaskGetCurrentTaskHandle();
}

/// Look up a task handle by its name string.
/// Returns `null` if no task with that name exists.
pub fn get_handle(name: [*:0]const u8) ?TaskHandle {
    return c.xTaskGetHandle(name);
}

/// Get the idle task's handle.
pub fn get_idle_task_handle() TaskHandle {
    return c.xTaskGetIdleTaskHandle();
}

/// Get the human-readable name of a task.
pub fn get_name(task_handle: ?TaskHandle) [*:0]const u8 {
    return c.pcTaskGetName(task_handle);
}

/// Query the runtime state of a task.
pub fn get_state(task_handle: TaskHandle) State {
    return State.from_c(c.eTaskGetState(task_handle));
}

/// Get the minimum amount of free stack space (in words) that has existed
/// since the task was created — the "high water mark".
pub fn get_stack_high_water_mark(task_handle: ?TaskHandle) u32 {
    return @intCast(c.uxTaskGetStackHighWaterMark(task_handle));
}

/// Get the current system tick count.
pub fn get_tick_count() TickType {
    return c.xTaskGetTickCount();
}

/// Get the current system tick count (safe to call from ISR).
pub fn get_tick_count_from_isr() TickType {
    return c.xTaskGetTickCountFromISR();
}

/// Get the total number of tasks currently managed by the kernel.
pub fn get_count() u32 {
    return @intCast(c.uxTaskGetNumberOfTasks());
}

// ── Scheduler Control ───────────────────────────────────────────────────

/// Start the FreeRTOS scheduler. This call hands control to FreeRTOS and
/// **never returns** — all subsequent execution happens inside tasks or ISRs.
pub fn start_scheduler() noreturn {
    c.vTaskStartScheduler();
    unreachable;
}

/// Stop the FreeRTOS scheduler.
pub fn end_scheduler() void {
    c.vTaskEndScheduler();
}

/// Scheduler state.
pub const SchedulerState = enum {
    /// The scheduler has not been started yet (`start_scheduler` not called).
    not_started,
    /// The scheduler is running and dispatching tasks normally.
    running,
    /// The scheduler is suspended via `suspend_all`; no context switches occur.
    suspended,
};

/// Get the current scheduler state.
pub fn get_scheduler_state() SchedulerState {
    return switch (c.xTaskGetSchedulerState()) {
        c.taskSCHEDULER_NOT_STARTED => .not_started,
        c.taskSCHEDULER_RUNNING => .running,
        c.taskSCHEDULER_SUSPENDED => .suspended,
        else => .not_started,
    };
}

/// Suspend the scheduler. Tasks will not be switched, but interrupts
/// are still serviced. Call `resume_all()` to resume.
pub fn suspend_all() void {
    c.vTaskSuspendAll();
}

/// Resume the scheduler after a `suspend_all()` call.
/// Returns `true` if a context switch occurred as a result.
pub fn resume_all() bool {
    return config.check_true(c.xTaskResumeAll());
}

/// Advance the tick count (used in tickless idle implementations).
pub fn step_tick(ticks_to_jump: TickType) void {
    c.vTaskStepTick(ticks_to_jump);
}

// ── Thread Local Storage ────────────────────────────────────────────────

/// Set a thread-local storage pointer for a task.
pub fn set_thread_local_storage_pointer(task_handle: ?TaskHandle, index: config.BaseType, value: ?*anyopaque) void {
    c.vTaskSetThreadLocalStoragePointer(task_handle, index, value);
}

/// Get a thread-local storage pointer for a task.
pub fn get_thread_local_storage_pointer(task_handle: ?TaskHandle, index: config.BaseType) ?*anyopaque {
    return c.pvTaskGetThreadLocalStoragePointer(task_handle, index);
}
