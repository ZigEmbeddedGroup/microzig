const std = @import("std");
const root = @import("root");
const config = @import("microzig-config");

pub fn sei() void {
    asm volatile ("cpsie i");
}

pub fn cli() void {
    asm volatile ("cpsid i");
}

pub fn enable_fault_irq() void {
    asm volatile ("cpsie f");
}
pub fn disable_fault_irq() void {
    asm volatile ("cpsid f");
}

pub fn nop() void {
    asm volatile ("nop");
}
pub fn wfi() void {
    asm volatile ("wfi");
}
pub fn wfe() void {
    asm volatile ("wfe");
}
pub fn sev() void {
    asm volatile ("sev");
}
pub fn isb() void {
    asm volatile ("isb");
}
pub fn dsb() void {
    asm volatile ("dsb");
}
pub fn dmb() void {
    asm volatile ("dmb");
}
pub fn clrex() void {
    asm volatile ("clrex");
}

pub const startup_logic = struct {
    const InterruptVector = extern union {
        C: fn () callconv(.C) void,
        Naked: fn () callconv(.Naked) void,
        // Interrupt is not supported on arm
    };

    const VectorTable = extern struct {
        initial_stack_pointer: u32 = config.end_of_stack,
        reset: InterruptVector = InterruptVector{ .C = _start },
        nmi: InterruptVector = makeUnhandledHandler("nmi"),
        hard_fault: InterruptVector = makeUnhandledHandler("hard_fault"),
        mpu_fault: InterruptVector = makeUnhandledHandler("mpu_fault"),
        bus_fault: InterruptVector = makeUnhandledHandler("bus_fault"),
        usage_fault: InterruptVector = makeUnhandledHandler("usage_fault"),
        secure_fault: InterruptVector = makeUnhandledHandler("secure_fault"),

        reserved: [3]u32 = .{ 0, 0, 0 },
        svc: InterruptVector = makeUnhandledHandler("svc"),
        debugmon: InterruptVector = makeUnhandledHandler("debugmon"),
        reserved1: u32 = 0,

        pendsv: InterruptVector = makeUnhandledHandler("pendsv"),
        systick: InterruptVector = makeUnhandledHandler("systick"),
    };

    fn isValidField(field_name: []const u8) bool {
        return !std.mem.startsWith(u8, field_name, "reserved") and
            !std.mem.eql(u8, field_name, "initial_stack_pointer") and
            !std.mem.eql(u8, field_name, "reset");
    }

    export const vectors: VectorTable linksection("microzig_flash_start") = blk: {
        var temp: VectorTable = .{};
        if (@hasDecl(root, "vector_table")) {
            const vector_table = root.vector_table;
            if (@typeInfo(vector_table) != .Struct)
                @compileLog("root.vector_table must be a struct");

            inline for (@typeInfo(vector_table).Struct.decls) |decl| {
                const calling_convention = @typeInfo(@TypeOf(@field(vector_table, decl.name))).Fn.calling_convention;
                const handler = @field(vector_table, decl.name);

                if (!@hasField(VectorTable, decl.name)) {
                    var msg: []const u8 = "There is no such interrupt as '" ++ decl.name ++ "' declarations in 'root.vector_table' must be one of:\n";
                    inline for (std.meta.fields(VectorTable)) |field| {
                        if (isValidField(field.name)) {
                            msg = msg ++ "    " ++ field.name ++ "\n";
                        }
                    }

                    @compileError(msg);
                }

                if (!isValidField(decl.name))
                    @compileError("You are not allowed to specify '" ++ decl.name ++ "' in the vector table, for your sins you must now pay a $5 fine to the ZSF: https://github.com/sponsors/ziglang");

                @field(temp, decl.name) = switch (calling_convention) {
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
        break :blk temp;
    };

    fn makeUnhandledHandler(comptime str: []const u8) InterruptVector {
        return InterruptVector{
            .C = struct {
                fn unhandledInterrupt() callconv(.C) noreturn {
                    @panic("unhandled interrupt: " ++ str);
                }
            }.unhandledInterrupt,
        };
    }

    extern fn microzig_main() noreturn;

    extern var microzig_data_start: anyopaque;
    extern var microzig_data_end: anyopaque;
    extern var microzig_bss_start: anyopaque;
    extern var microzig_bss_end: anyopaque;
    extern const microzig_data_load_start: anyopaque;

    fn _start() callconv(.C) noreturn {

        // fill .bss with zeroes
        {
            const bss_start = @ptrCast([*]u8, &microzig_bss_start);
            const bss_end = @ptrCast([*]u8, &microzig_bss_end);
            const bss_len = @ptrToInt(bss_end) - @ptrToInt(bss_start);

            std.mem.set(u8, bss_start[0..bss_len], 0);
        }

        // load .data from flash
        {
            const data_start = @ptrCast([*]u8, &microzig_data_start);
            const data_end = @ptrCast([*]u8, &microzig_data_end);
            const data_len = @ptrToInt(data_end) - @ptrToInt(data_start);
            const data_src = @ptrCast([*]const u8, &microzig_data_load_start);

            std.mem.copy(u8, data_start[0..data_len], data_src[0..data_len]);
        }

        microzig_main();
    }
};
