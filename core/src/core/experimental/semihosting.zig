const std = @import("std");

pub const fs = struct {
    pub const FileError = error{
        OpenFail,
        CloseFail,
    };
    pub const OpenMode = enum(usize) {
        R,
        RB,
        @"R+",
        @"R+B",
        W,
        WB,
        @"W+",
        @"W+B",
        A,
        AB,
        @"A+",
        @"A+B",
    };
    pub const OpenFile = extern struct {
        path: [*:0]const u8,
        mode: OpenMode,
        path_len: usize,
    };

    pub const WriteFile = extern struct {
        file: File,
        buf: [*]const u8,
        buf_len: usize,
    };

    pub const File = enum(usize) {
        _,
        const Writer = std.io.Writer(File, anyerror, writefn);
        fn writefn(ctx: File, data: []const u8) anyerror!usize {
            const w_file = WriteFile{
                .file = ctx,
                .buf = data.ptr,
                .buf_len = data.len,
            };

            const ret: usize = @bitCast(sys_write(&w_file));
            return data.len - ret;
        }

        pub fn print(file: File, comptime fmt: []const u8, args: anytype) void {
            const wrt = Writer{ .context = file };
            wrt.print(fmt, args) catch return;
        }

        pub fn close(file: File) FileError!void {
            return if (sys_close(&file) < 0) FileError.CloseFail else {};
        }
    };

    pub fn open_file(path: [:0]const u8, mode: OpenMode) FileError!File {
        const file = OpenFile{
            .path = path,
            .mode = mode,
            .path_len = path.len,
        };
        const ret = sys_open(&file);
        return if (ret < 0) FileError.OpenFail else @enumFromInt(@as(usize, @bitCast(ret)));
    }
};

//======BASE SYSCALLS===========

pub const Syscalls = enum(usize) {
    SYS_OPEN = 0x01,
    SYS_CLOSE = 0x02,
    WRITEC = 0x03,
    WRITE0 = 0x04,
    SYS_WRITE = 0x05,
};

fn call(number: Syscalls, param: *const anyopaque) isize {
    return asm volatile (
        \\mov r0, %[num]
        \\mov r1, %[p]
        \\BKPT #0xAB
        \\mov %[ret], r0
        : [ret] "=r" (-> isize),
        : [num] "r" (number),
          [p] "r" (param),
        : "memory", "r0", "r1"
    );
}

//WriteC does not have return
pub inline fn write_byte(c: u8) void {
    _ = call(.WRITEC, &c);
}

//Write0 does not have return
pub inline fn write0(str: [*:0]const u8) void {
    _ = call(.WRITE0, str);
}

pub inline fn sys_open(file: *const fs.OpenFile) isize {
    return call(.SYS_OPEN, file);
}

pub inline fn sys_close(file: *const fs.File) isize {
    return call(.SYS_CLOSE, file);
}

pub inline fn sys_write(file: *const fs.WriteFile) isize {
    return call(.SYS_WRITE, file);
}

//======END BASE SYSCALLS=========

//this WriteC and Write0 write direct to the Debug terminal, no context need
const DebugWriter = std.io.Writer(void, anyerror, debug_writer);

//this is ssssssslow but WriteC is even more slow and Write0 requires '\0' sentinel
fn debug_writer(_: void, data: []const u8) anyerror!usize {
    var len = data.len;

    if (len != 1) {
        const tmp_c = data[len - 1]; //check if last char is a sentinel
        if (tmp_c != 0) {
            len -= 1; //last char is gonna be change to '\0'
            var tmp_data: []u8 = @constCast(data);
            tmp_data[len] = 0;
            write0(@ptrCast(tmp_data.ptr));
            tmp_data[len] = tmp_c;
            return len;
        }
        write0(@ptrCast(data.ptr));
        return len;
    }
    write_byte(data[0]);
    return 1;
}

pub fn debug_print(comptime fmt: []const u8, args: anytype) void {
    const dbg_w = DebugWriter{ .context = {} };
    dbg_w.print(fmt, args) catch return;
}
