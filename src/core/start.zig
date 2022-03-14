const std = @import("std");
const app = @import("app");
const builtin = @import("builtin");
const microzig = @import("microzig");

pub usingnamespace app;

fn isValidField(field_name: []const u8) bool {
    return !std.mem.startsWith(u8, field_name, "reserved") and
        !std.mem.eql(u8, field_name, "initial_stack_pointer") and
        !std.mem.eql(u8, field_name, "reset");
}

comptime {
    if (builtin.cpu.arch == .arm or builtin.cpu.arch == .thumb) {
        @export(vector_table, .{
            .name = "vector_table",
            .section = "microzig_flash_start",
            .linkage = .Strong,
        });
    }
}

const VectorTable = microzig.chip.VectorTable;
const vector_table: VectorTable = blk: {
    var tmp: microzig.chip.VectorTable = .{
        .initial_stack_pointer = microzig.config.end_of_stack,
        .Reset = .{ .C = microzig.cpu.startup_logic._start },
    };

    if (@hasDecl(app, "interrupts")) {
        if (@typeInfo(app.interrupts) != .Struct)
            @compileLog("root.interrupts must be a struct");

        inline for (@typeInfo(app.interrupts).Struct.decls) |decl| {
            const calling_convention = @typeInfo(@TypeOf(@field(app.interrupts, decl.name))).Fn.calling_convention;
            const handler = @field(app.interrupts, decl.name);

            if (!@hasField(VectorTable, decl.name)) {
                var msg: []const u8 = "There is no such interrupt as '" ++ decl.name ++ "'. Declarations in 'interrupts' must be one of:\n";
                inline for (std.meta.fields(VectorTable)) |field| {
                    if (isValidField(field.name)) {
                        msg = msg ++ "    " ++ field.name ++ "\n";
                    }
                }

                @compileError(msg);
            }

            if (!isValidField(decl.name))
                @compileError("You are not allowed to specify '" ++ decl.name ++ "' in the vector table, for your sins you must now pay a $5 fine to the ZSF: https://github.com/sponsors/ziglang");

            @field(tmp, decl.name) = switch (calling_convention) {
                .C => .{ .C = handler },
                .Naked => .{ .Naked = handler },
                // for unspecified calling convention we are going to generate small wrapper
                .Unspecified => .{
                    .C = struct {
                        fn wrapper() callconv(.C) void {
                            if (calling_convention == .Unspecified) // TODO: workaround for some weird stage1 bug
                                @call(.{ .modifier = .always_inline }, handler, .{});
                        }
                    }.wrapper,
                },

                else => @compileError("unsupported calling convention for function " ++ decl.name),
            };
        }
    }
    break :blk tmp;
};

/// This is the logical entry point for microzig.
/// It will invoke the main function from the root source file
/// and provides error return handling as well as a event loop if requested.
///
/// Why is this function exported?
/// This is due to the modular design of microzig to allow the "chip" dependency of microzig
/// to call into our main function here. If we would use a normal function call, we'd have a
/// circular dependency between the `microzig` and `chip` package. This function is also likely
/// to be invoked from assembly, so it's also convenient in that regard.
export fn microzig_main() noreturn {
    if (!@hasDecl(app, "main"))
        @compileError("The root source file must provide a public function main!");

    const main = @field(app, "main");
    const info: std.builtin.TypeInfo = @typeInfo(@TypeOf(main));

    const invalid_main_msg = "main must be either 'pub fn main() void' or 'pub fn main() !void'.";
    if (info != .Fn or info.Fn.args.len > 0)
        @compileError(invalid_main_msg);

    const return_type = info.Fn.return_type orelse @compileError(invalid_main_msg);

    if (info.Fn.calling_convention == .Async)
        @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

    if (@typeInfo(return_type) == .ErrorUnion) {
        main() catch |err| {
            // TODO:
            // - Compute maximum size on the type of "err"
            // - Do not emit error names when std.builtin.strip is set.
            var msg: [64]u8 = undefined;
            @panic(std.fmt.bufPrint(&msg, "main() returned error {s}", .{@errorName(err)}) catch @panic("main() returned error."));
        };
    } else {
        main();
    }

    // main returned, just hang around here a bit
    microzig.hang();
}
