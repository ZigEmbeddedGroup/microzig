const std = @import("std");

pub const ExitType = enum {
    breakpoint,
    enter_sleep_mode,
    reset_watchdog,
    out_of_gas,
    system_exit,
};

pub const SystemCondition = struct {
    sreg: struct {
        c: ?bool = null,
        z: ?bool = null,
        n: ?bool = null,
        v: ?bool = null,
        s: ?bool = null,
        h: ?bool = null,
        t: ?bool = null,
        i: ?bool = null,
    } = .{},

    r0: ?u8 = null,
    r1: ?u8 = null,
    r2: ?u8 = null,
    r3: ?u8 = null,
    r4: ?u8 = null,
    r5: ?u8 = null,
    r6: ?u8 = null,
    r7: ?u8 = null,
    r8: ?u8 = null,
    r9: ?u8 = null,
    r10: ?u8 = null,
    r11: ?u8 = null,
    r12: ?u8 = null,
    r13: ?u8 = null,
    r14: ?u8 = null,
    r15: ?u8 = null,
    r16: ?u8 = null,
    r17: ?u8 = null,
    r18: ?u8 = null,
    r19: ?u8 = null,
    r20: ?u8 = null,
    r21: ?u8 = null,
    r22: ?u8 = null,
    r23: ?u8 = null,
    r24: ?u8 = null,
    r25: ?u8 = null,
    r26: ?u8 = null,
    r27: ?u8 = null,
    r28: ?u8 = null,
    r29: ?u8 = null,
    r30: ?u8 = null,
    r31: ?u8 = null,
};

pub const TestSuiteConfig = struct {
    exit: ExitType = .system_exit,
    exit_code: u8 = 0,

    stdout: []const u8 = "",
    stderr: []const u8 = "",
    stdin: []const u8 = "",
    precondition: SystemCondition = .{},
    postcondition: SystemCondition = .{},

    mileage: ?u32 = 0,

    cpu: ?[]const u8 = null,
    optimize: std.builtin.OptimizeMode = .ReleaseSmall,

    gcc_flags: []const []const u8 = &.{
        "-g",
        "-O2",
        "-nostdlib",
        "-nostdinc",
        "-ffreestanding",
    },

    pub fn toString(config: TestSuiteConfig, b: *std.Build) []const u8 {
        return std.json.stringifyAlloc(b.allocator, config, .{
            .whitespace = .indent_2,
            .emit_null_optional_fields = true,
            .emit_strings_as_arrays = false,
            .escape_unicode = true,
        }) catch @panic("oom");
    }

    pub fn load(allocator: std.mem.Allocator, file: std.fs.File) !TestSuiteConfig {
        var reader = std.json.reader(allocator, file.reader());
        defer reader.deinit();

        return try std.json.parseFromTokenSourceLeaky(TestSuiteConfig, allocator, &reader, .{
            .allocate = .alloc_always,
        });
    }
};
