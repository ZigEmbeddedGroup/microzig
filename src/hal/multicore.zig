const std = @import("std");
const microzig = @import("microzig");
const regs = microzig.chip.registers;
const assert = std.debug.assert;

pub const fifo = struct {
    /// Check if the FIFO has valid data for reading.
    pub fn isReadReady() bool {
        return regs.SIO.FIFO_ST.read().VLD == 1;
    }

    /// Read from the FIFO
    /// Will return null if it is empty.
    pub fn read() ?u32 {
        if (!isReadReady())
            return null;

        return regs.SIO.FIFO_RD.*;
    }

    /// Read from the FIFO, waiting for data if there is none.
    pub fn readBloacking() u32 {
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
    pub fn isWriteReady() bool {
        return regs.SIO.FIFO_ST.read().RDY == 1;
    }

    /// Write to the FIFO
    /// You must check if there is space by calling is_write_ready
    pub fn write(value: u32) void {
        regs.SIO.FIFO_WR.* = value;
        microzig.cpu.sev();
    }

    /// Write to the FIFO, waiting for room if it is full.
    pub fn writeBlocking(value: u32) void {
        while (!isWriteReady())
            std.mem.doNotOptimizeAway(value);

        write(value);
    }
};

var core1_stack: [128]u32 = undefined;

/// Runs `entrypoint` on the second core.
pub fn launchCore1(entrypoint: *const fn () void) void {
    launchCore1WithStack(entrypoint, &core1_stack);
}

pub fn launchCore1WithStack(entrypoint: *const fn () void, stack: []u32) void {
    // TODO: disable SIO interrupts

    const wrapper = &struct {
        fn wrapper(_: u32, _: u32, _: u32, _: u32, entry: u32, stack_base: [*]u32) callconv(.C) void {
            // TODO: protect stack using MPU
            _ = stack_base;
            @intToPtr(*const fn () void, entry)();
        }
    }.wrapper;

    // reset the second core
    regs.PSM.FRCE_OFF.modify(.{ .proc1 = 1 });
    while (regs.PSM.FRCE_OFF.read().proc1 != 1) microzig.cpu.nop();
    regs.PSM.FRCE_OFF.modify(.{ .proc1 = 0 });

    stack[stack.len - 2] = @ptrToInt(entrypoint);
    stack[stack.len - 1] = @ptrToInt(stack.ptr);

    // calculate top of the stack
    const stack_ptr: u32 =
        @ptrToInt(stack.ptr) +
        (stack.len - 2) * @sizeOf(u32); // pop the two elements we "pushed" above

    // after reseting core1 is waiting for this specific sequence
    const cmds: [6]u32 = .{
        0,
        0,
        1,
        regs.SCS.SCB.VTOR.raw,
        stack_ptr,
        @ptrToInt(wrapper),
    };

    var seq: usize = 0;
    while (seq < cmds.len) {
        const cmd = cmds[seq];
        if (cmd == 0) {
            // always drain the fifo before sending zero
            fifo.drain();
            microzig.cpu.sev();
        }

        fifo.writeBlocking(cmd);
        // the second core should respond with the same value, if it doesnt't lets start over
        seq = if (cmd == fifo.readBloacking()) seq + 1 else 0;
    }
}
