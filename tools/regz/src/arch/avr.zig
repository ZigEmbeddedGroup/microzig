//! codegen specific to AVR
const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const DeviceID = Database.DeviceID;

const gen = @import("../gen.zig");

const log = std.log.scoped(.@"gen.avr");

pub fn write_interrupt_vector(
    db: *Database,
    arena: Allocator,
    device: *const Database.Device,
    writer: anytype,
) !void {
    assert(device.arch.is_avr());

    const interrupts = try db.get_interrupts(arena, device.id);
    if (interrupts.len > 0) {
        try writer.writeAll(
            \\
            \\pub const VectorTable = extern struct {
            \\    const Handler = microzig.interrupt.Handler;
            \\    const unhandled = microzig.interrupt.unhandled;
            \\
            \\    RESET: Handler,
            \\
        );

        var index: i32 = 1;
        var i: u32 = 0;

        while (i < interrupts.len) : (i += 1) {
            const interrupt = interrupts[i];
            if (index < interrupt.idx) {
                try writer.print("reserved{}: [{}]u16 = undefined,\n", .{
                    index,
                    interrupt.idx - index,
                });
                index = interrupt.idx;
            } else if (index > interrupt.idx) {
                log.warn("skipping interrupt: {s}, index({}) > interrupt.idx({})", .{ interrupt.name, index, interrupt.idx });
                continue;
            }

            if (interrupt.description) |description|
                try gen.write_doc_comment(arena, description, writer);

            try writer.print("{}: Handler = unhandled,\n", .{
                std.zig.fmtId(interrupt.name),
            });

            index += 1;
        }
        try writer.writeAll("};\n\n");
    }
}
