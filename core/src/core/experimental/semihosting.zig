const std = @import("std");

pub const Debug = struct {
    pub const PanicCodes = enum(usize) {
        //Hardware vector reason codes: 0x0..0x7
        BranchThroughZero,
        UndefinedInstr,
        SoftwareInterrupt,
        PrefetchAbort,
        DataAbort,
        AddressException,
        IRQ,
        FIQ,

        //Software reason codes (0x20 - 0x29)
        BreakPoint = 0x20,
        WatchPoint,
        StepComplete,
        RunTimeErrorUnknown,
        InternalError,
        UserInterruption,
        ApplicationExit,
        StackOverflow,
        DivisionByZero,
        OSSpecific,
    };

    pub const PanicData = extern struct {
        reason: usize,
        subcode: usize,
    };

    pub const MemInfo = extern struct {
        heap_base: *anyopaque,
        heap_limit: *anyopaque,
        stack_base: *anyopaque,
        stack_limit: *anyopaque,
    };

    //WriteC and Write0 write direct to the Debug terminal, no context need
    pub const Writer = struct {
        interface: std.Io.Writer,
    };

    pub fn writer(buffer: []u8) Writer {
        return .{
            .interface = .{
                .vtable = &.{
                    .drain = drain,
                },
                .buffer = buffer,
            },
        };
    }

    pub const Argv = extern struct {
        buffer: [*]u8,
        len: usize,
    };

    fn drain(io_w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
        const buf = io_w.buffered();

        var ret: usize = 0;
        if (buf.len > 0) {
            ret += try writerfn({}, buf);
            _ = io_w.consumeAll();
        }
        for (data[0 .. data.len - 1]) |d| {
            ret += try writerfn({}, d);
        }
        for (0..splat) |_| {
            const to_splat = data[data.len - 1];
            ret += try writerfn({}, to_splat);
        }

        return ret;
    }

    //this is ssssssslow but WriteC is even more slow and Write0 requires '\0' sentinel
    fn writerfn(_: void, data: []const u8) std.Io.Writer.Error!usize {
        const len = data.len;
        if (len == 0) return 0;

        if (len != 1) {
            const tmp_c = data[len - 1]; //check if last char is a sentinel
            if (tmp_c != 0) {
                // Temporarily change last char to null byte
                var tmp_data: []u8 = @constCast(data);
                tmp_data[len - 1] = 0;
                write0(@ptrCast(tmp_data.ptr));
                tmp_data[len - 1] = tmp_c;
                // Write the last character separately
                write_byte(tmp_c);
                return len;
            }
            write0(@ptrCast(data.ptr));
            return len;
        }
        write_byte(data[0]);
        return 1;
    }

    ///writes to the Debug terminal.
    ///NOTE: if available, always use `stdout`
    pub fn print(comptime fmt: []const u8, args: anytype) void {
        var buf: [256]u8 = undefined;
        var dbg_w = writer(&buf);
        dbg_w.interface.print(fmt, args) catch return;
        dbg_w.interface.flush() catch return;
    }

    ///get C errno value
    pub fn get_errno() usize {
        resume @as(usize, @bitCast(sys_errno()));
    }

    ///get data from the command line.
    /// NOTE: The semihosting implementation might impose limits on the maximum length of the string that can be transferred.
    /// However, the implementation must be able to support a command-line length of at least 80 bytes.
    pub fn get_cmd_args(buffer: []u8) anyerror![]const u8 {
        var cmd = Argv{
            .buffer = buffer.ptr,
            .len = buffer.len,
        };
        const ret = sys_cmd_line(&cmd);
        return if (ret == 0) cmd.buffer[0..cmd.len] else error.Fail;
    }

    //currently the semihost specification defines only 2 extensions, where both belong to the same extension byte.
    pub fn check_extensions(feature_byte: usize, feature_bit: u3) bool {
        const MAGIC: [4]u8 = .{ 0x53, 0x48, 0x46, 0x42 };
        var magic_buffer: [4]u8 = undefined;

        // Try opening the extension file
        const ext_file = fs.open(":semihosting-features", .R) catch return false;

        // Check the size
        const byte_size = ext_file.size() catch return false;
        if (byte_size < (MAGIC.len + feature_byte + 1)) return false;

        var read_buf: [256]u8 = undefined;
        var file_reader = ext_file.reader(&read_buf);
        _ = file_reader.interface.readSliceShort(&magic_buffer) catch return false;

        // Check the magic number
        for (magic_buffer, MAGIC) |number, magic| {
            if (number != magic) return false;
        }

        //get feature byte and check feature bit
        ext_file.seek(feature_byte + 4) catch return false;

        var ext_byte_buf: [1]u8 = undefined;
        _ = file_reader.interface.readSliceShort(&ext_byte_buf) catch return false;
        const ext_byte = ext_byte_buf[0];

        return (ext_byte & @as(u8, 1) << feature_bit) != 0;
    }

    ///get the stdout stream.
    ///NOTE: this feature is an extension of semihosting and if not implemented by the host it always results in an error
    pub fn stdout() fs.FileError!fs.File {
        if (!check_extensions(0, 1)) return error.InvalidFile;
        return try fs.open(":tt", .@"W+");
    }

    ///get the stderr stream.
    ///NOTE: this feature is an extension of semihosting and if not implemented by the host it always results in an error
    pub fn stderr() fs.FileError!fs.File {
        if (!check_extensions(0, 1)) return error.InvalidFile;
        return try fs.open(":tt", .@"A+");
    }

    pub fn system_memory() MemInfo {
        var mem: MemInfo = undefined;
        sys_heapinfo(&mem);
        return mem;
    }

    ///Signals an exception to the debugger
    /// NOTE: Not all semihosting client implementations will necessarily trap every corresponding event.
    /// NOTE: It is possible for the debugger to request that the application continues by performing an RDI_Execute request or equivalent.
    pub fn panic(reason: PanicCodes, subcode: usize) void {
        const data = PanicData{
            .reason = @intFromEnum(reason) + 0x20000,
            .subcode = subcode,
        };

        //check for EXIT_EXT
        //when the exit extension is not implemented on 32bit targets
        //sys_exit does not receive "exit code"
        if (check_extensions(0, 0)) {
            _ = sys_exit_ext(&data);
        } else {
            //ARM-A/M 32bit only
            //on 32bit targets sys_exit receives data by value and not by reference
            _ = sys_exit(@ptrFromInt(data.reason));
        }
    }

    pub fn exit(code: usize) void {
        panic(.ApplicationExit, code);
    }
};

pub const Time = struct {
    pub const TimeError = error{
        ReadTicksFail,
        UnknownTickFreq,
    };
    pub const Elapsed = extern struct {
        low: u32,
        high: u32,
    };

    ///return the host time in epoch
    pub fn system_time() usize {
        return @as(usize, @bitCast(sys_time()));
    }
    ///return the corrent tick counter value in centiseconds
    pub fn absolute() TimeError!usize {
        const ret = sys_clock();
        return if (ret == -1) TimeError.ReadTicksFail else @as(usize, @bitCast(ret));
    }

    ///return the corrent tick counter value in "tick_freg"
    /// This function is optional and if not implemented it always returns an error.
    pub fn elapsed() TimeError!u64 {
        var ticks = Elapsed{ .low = 0, .high = 0 };
        const ret = sys_elapsed(&ticks);
        return if (ret == -1) TimeError.ReadTicksFail else @as(u64, @bitCast(ticks));
    }

    /// This function is optional and if not implemented it always returns an error.
    pub fn get_tick_freq() TimeError!usize {
        const ret = sys_tickfreq();
        return if (ret == -1) TimeError.UnknownTickFreq else @as(usize, @bitCast(ret));
    }
};

pub const fs = struct {
    pub const FileError = error{
        OpenFail,
        RenameFail,
        RemoveFail,
        InvalidFile,
    };

    pub const FType = enum {
        FIle,
        Device,
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

    pub const RWFile = extern struct {
        file: File,
        buf: [*]u8,
        buf_len: usize,
    };

    pub const Path = extern struct {
        path: [*:0]const u8,
        len: usize,
    };

    pub const Seek = extern struct {
        file: File,
        seek: usize,
    };

    pub const File = enum(usize) {
        _,

        pub const Writer = struct {
            file: File,
            interface: std.Io.Writer,
        };

        pub const Reader = struct {
            file: File,
            interface: std.Io.Reader,
        };

        fn writefn(ctx: File, data: []const u8) std.Io.Writer.Error!usize {
            const w_file = RWFile{
                .file = ctx,
                .buf = @constCast(data.ptr),
                .buf_len = data.len,
            };

            const ret: usize = @bitCast(sys_write(&w_file));
            return data.len - ret;
        }

        fn readfn(ctx: File, out: []u8) std.Io.Reader.Error!usize {
            var r_file = RWFile{
                .file = ctx,
                .buf = out.ptr,
                .buf_len = out.len,
            };

            const ret = sys_read(&r_file);
            if (ret == -1) return error.ReadFailed;
            return out.len - @as(usize, @bitCast(ret));
        }

        pub fn writer(file: File, buffer: []u8) Writer {
            return .{
                .file = file,
                .interface = .{
                    .vtable = &.{
                        .drain = drain,
                    },
                    .buffer = buffer,
                },
            };
        }

        pub fn reader(file: File, buffer: []u8) Reader {
            return .{
                .file = file,
                .interface = .{
                    .vtable = &.{
                        .stream = stream,
                    },
                    .buffer = buffer,
                    .seek = 0,
                    .end = 0,
                },
            };
        }

        fn drain(io_w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
            const w: *Writer = @fieldParentPtr("interface", io_w);
            _ = splat;
            // TODO: implement splat
            var ret: usize = 0;
            for (data) |d| {
                const n = try writefn(w.file, d);
                ret += n;
                if (n != d.len)
                    return ret;
            }

            return ret;
        }

        fn stream(io_r: *std.Io.Reader, w: *std.Io.Writer, limit: std.Io.Limit) std.Io.Reader.StreamError!usize {
            const r: *Reader = @fieldParentPtr("interface", io_r);
            // TODO: limit
            _ = limit;

            var buf: [256]u8 = undefined;
            const n = try r.file.readfn(&buf);
            try w.writeAll(buf[0..n]);
            return n;
        }

        //Write Functions

        pub fn print(file: File, comptime fmt: []const u8, args: anytype) void {
            var buf: [256]u8 = undefined;
            var wrt = file.writer(&buf);
            wrt.interface.print(fmt, args) catch return;
            wrt.interface.flush() catch return;
        }

        //Read Functions

        //util Functions

        pub fn get_type(file: File) FileError!FType {
            return switch (sys_istty(&file)) {
                0 => FType.FIle,
                1 => FType.Device,
                else => FileError.InvalidFile,
            };
        }

        pub fn seek(file: File, offset: usize) FileError!void {
            return if (sys_seek(&Seek{ .file = file, .seek = offset }) != 0) FileError.InvalidFile else {};
        }

        pub fn size(file: File) FileError!usize {
            const ret = sys_flen(&file);
            return if (ret < 0) FileError.InvalidFile else @as(usize, @bitCast(ret));
        }

        pub fn close(file: File) FileError!void {
            return if (sys_close(&file) < 0) FileError.InvalidFile else {};
        }
    };

    pub fn open(path: [:0]const u8, mode: OpenMode) FileError!File {
        const file = OpenFile{
            .path = path,
            .mode = mode,
            .path_len = path.len,
        };
        const ret = sys_open(&file);
        return if (ret < 0) FileError.OpenFail else @enumFromInt(@as(usize, @bitCast(ret)));
    }

    pub fn remove(path: [:0]const u8) FileError!void {
        const rm = Path{
            .path = path.ptr,
            .len = path.len,
        };

        return if (sys_remove(&rm) < 0) FileError.RemoveFail else {};
    }

    pub fn rename(old: [:0]const u8, new: [:0]const u8) FileError!void {
        const re: [2]Path = .{
            Path{ .path = old.ptr, .len = old.len },
            Path{ .path = new.ptr, .len = new.len },
        };

        return if (sys_rename(&re) < 0) FileError.RenameFail else {};
    }
};

//======BASE SYSCALLS===========

pub const Syscalls = enum(usize) {
    SYS_OPEN = 0x01,
    SYS_CLOSE = 0x02,
    WRITEC = 0x03,
    WRITE0 = 0x04,
    SYS_WRITE = 0x05,
    SYS_READ = 0x06,
    SYS_ISERROR = 0x08,
    SYS_ISTTY = 0x09,
    SYS_SEEK = 0x0A,
    SYS_FLEN = 0x0C,
    SYS_REMOVE = 0x0E,
    SYS_RENAME = 0x0F,
    SYS_CLOCK = 0x10,
    SYS_TIME = 0x11,
    SYS_ERRNO = 0x13,
    SYS_GET_CMD_LINE = 0x15,
    SYS_HEAPINFO = 0x16,
    SYS_EXIT = 0x18,
    SYS_EXIT_EXTENDED = 0x20,
    SYS_ELAPSED = 0x30,
    SYS_TICKFREQ = 0x31,
};

///ARM-M SEMIHOST CALL
fn call(number: Syscalls, param: *const anyopaque) isize {
    return asm volatile (
        \\mov r0, %[num]
        \\mov r1, %[p]
        \\bkpt #0xAB
        \\mov %[ret], r0
        : [ret] "=r" (-> isize),
        : [num] "r" (number),
          [p] "r" (param),
        : .{ .memory = true, .r0 = true, .r1 = true });
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

pub inline fn sys_write(file: *const fs.RWFile) isize {
    return call(.SYS_WRITE, file);
}

pub inline fn sys_read(file: *fs.RWFile) isize {
    return call(.SYS_READ, file);
}

pub inline fn sys_seek(file: *const fs.Seek) isize {
    return call(.SYS_SEEK, file);
}

pub inline fn sys_flen(file: *const fs.File) isize {
    return call(.SYS_FLEN, file);
}

pub inline fn sys_remove(file: *const fs.Path) isize {
    return call(.SYS_REMOVE, file);
}

pub inline fn sys_rename(file: [*]const fs.Path) isize {
    return call(.SYS_RENAME, file);
}

//only useful when using syscalls directly
pub inline fn sys_iserror(ret_code: *const isize) bool {
    return call(.SYS_ISERROR, ret_code) != 0;
}

pub inline fn sys_istty(file: *const fs.File) isize {
    return call(.SYS_ISTTY, file);
}

pub inline fn sys_clock() isize {
    return call(.SYS_CLOCK, &0);
}

pub inline fn sys_time() isize {
    return call(.SYS_TIME, &0);
}

pub inline fn sys_errno() isize {
    return call(.SYS_ERRNO, &0);
}

pub inline fn sys_cmd_line(args: *Debug.Argv) isize {
    return call(.SYS_GET_CMD_LINE, args);
}

pub inline fn sys_heapinfo(args: *Debug.MemInfo) void {
    _ = call(.SYS_HEAPINFO, args);
}

pub inline fn sys_exit(args: *const Debug.PanicData) isize {
    return call(.SYS_EXIT, args);
}

pub inline fn sys_exit_ext(args: *const Debug.PanicData) isize {
    return call(.SYS_EXIT_EXTENDED, args);
}

pub inline fn sys_elapsed(time: *Time.Elapsed) isize {
    return call(.SYS_ELAPSED, time);
}

pub inline fn sys_tickfreq() isize {
    return call(.SYS_TICKFREQ, &0);
}
