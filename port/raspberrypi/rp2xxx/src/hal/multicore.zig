const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SIO = peripherals.SIO;
const PSM = peripherals.PSM;
const PPB = peripherals.PPB;

pub const fifo = struct {
    /// Check if the FIFO has valid data for reading.
    pub fn is_read_ready() bool {
        return SIO.FIFO_ST.read().VLD == 1;
    }

    /// Read from the FIFO
    /// Will return null if it is empty.
    pub fn read() ?u32 {
        if (!is_read_ready())
            return null;

        return SIO.FIFO_RD.read().FIFO_RD;
    }

    /// Read from the FIFO, waiting for data if there is none.
    pub fn read_blocking() u32 {
        while (true) {
            if (read()) |value| return value;
            microzig.cpu.wfe();
        }
    }

    /// Read from the FIFO, and throw everyting away.
    pub fn drain() void {
        while (read()) |_| {}
    }

    /// Check if the FIFO is ready to receive data.
    pub fn is_write_ready() bool {
        return SIO.FIFO_ST.read().RDY == 1;
    }

    /// Write to the FIFO
    /// You must check if there is space by calling is_write_ready
    pub fn write(value: u32) void {
        SIO.FIFO_WR.write(.{ .FIFO_WR = value });
        microzig.cpu.sev();
    }

    /// Write to the FIFO, waiting for room if it is full.
    pub fn write_blocking(value: u32) void {
        while (!is_write_ready())
            std.mem.doNotOptimizeAway(value);

        write(value);
    }
};

var core1_stack: [128]u32 = undefined;

/// Runs `entrypoint` on the second core.
pub fn launch_core1(entrypoint: *const fn () void) void {
    launch_core1_with_stack(entrypoint, &core1_stack);
}

pub fn launch_core1_with_stack(entrypoint: *const fn () void, stack: []u32) void {
    // TODO: disable SIO interrupts

    const wrapper = &struct {
        fn wrapper(_: u32, _: u32, _: u32, _: u32, entry: u32, stack_base: [*]u32) callconv(.c) void {
            // TODO: protect stack using MPU
            _ = stack_base;
            @as(*const fn () void, @ptrFromInt(entry))();
        }
    }.wrapper;

    // reset the second core
    PSM.FRCE_OFF.modify(.{ .PROC1 = 1 });
    while (PSM.FRCE_OFF.read().PROC1 != 1) microzig.cpu.nop();
    PSM.FRCE_OFF.modify(.{ .PROC1 = 0 });

    stack[stack.len - 2] = @intFromPtr(entrypoint);
    stack[stack.len - 1] = @intFromPtr(stack.ptr);

    // calculate top of the stack
    const stack_ptr: u32 =
        @intFromPtr(stack.ptr) +
        (stack.len - 2) * @sizeOf(u32); // pop the two elements we "pushed" above

    // after reseting core1 is waiting for this specific sequence
    const cmds: [6]u32 = .{
        0,
        0,
        1,
        PPB.VTOR.raw,
        stack_ptr,
        @intFromPtr(wrapper),
    };

    var seq: usize = 0;
    while (seq < cmds.len) {
        const cmd = cmds[seq];
        if (cmd == 0) {
            // always drain the fifo before sending zero
            fifo.drain();
            microzig.cpu.sev();
        }

        fifo.write_blocking(cmd);
        // the second core should respond with the same value, if it doesnt't lets start over
        seq = if (cmd == fifo.read_blocking()) seq + 1 else 0;
    }
}
