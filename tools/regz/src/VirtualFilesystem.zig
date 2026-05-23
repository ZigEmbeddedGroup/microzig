//! Filesystem to store generated files
gpa: Allocator,
directories: Map(ID, Dir) = .empty,
files: Map(ID, File) = .empty,
// child -> parent
hierarchy: Map(ID, ID) = .empty,
next_id: u16 = 1,

const VirtualFilesystem = @This();

const std = @import("std");
const Allocator = std.mem.Allocator;
const Map = std.AutoArrayHashMapUnmanaged;
const assert = std.debug.assert;

const log = std.log.scoped(.vfs);

pub const Kind = enum {
    file,
    directory,
};

pub const Dir = struct {
    name: []const u8,

    pub fn deinit(d: *Dir, gpa: Allocator) void {
        gpa.free(d.name);
    }

    fn create_file(userdata: ?*anyopaque, dir: std.Io.Dir, sub_path: []const u8, _: std.Io.Dir.CreateFileOptions) std.Io.File.OpenError!std.Io.File {
        const vfs: *VirtualFilesystem = @ptrCast(@alignCast(userdata.?));
        const dir_id: ID = @enumFromInt(dir.handle);

        if (std.mem.findScalar(u8, sub_path, '/') != null) {
            log.err("path includes '/': '{s}'", .{sub_path});
            return error.BadPathName;
        }

        const id = vfs.create_file(dir_id, sub_path) catch |err| switch (err) {
            error.OutOfMemory => return error.NoSpaceLeft,
        };
        return .{
            .handle = @intFromEnum(id),
            .flags = .{
                .nonblocking = false,
            },
        };
    }

    fn create_dir_path_open(
        userdata: ?*anyopaque,
        parent_dir: std.Io.Dir,
        sub_path: []const u8,
        _: std.Io.Dir.Permissions,
        _: std.Io.Dir.OpenOptions,
    ) std.Io.Dir.CreateDirPathOpenError!std.Io.Dir {
        const vfs: *VirtualFilesystem = @ptrCast(@alignCast(userdata.?));
        const parent: ID = @enumFromInt(parent_dir.handle);
        const id = vfs.create_dir(parent, sub_path) catch return error.NoSpaceLeft;

        return .{
            .handle = @intFromEnum(id),
        };
    }

    fn close(_: ?*anyopaque, _: []const std.Io.Dir) void {}
};

pub const File = struct {
    name: []const u8,
    content: std.Io.Writer.Allocating,

    pub fn deinit(f: *File, gpa: Allocator) void {
        gpa.free(f.name);
        f.content.deinit();
    }

    pub fn close(_: ?*anyopaque, _: []const std.Io.File) void {}
};

fn operate(userdata: ?*anyopaque, op: std.Io.Operation) std.Io.Cancelable!std.Io.Operation.Result {
    const vfs: *VirtualFilesystem = @ptrCast(@alignCast(userdata.?));
    return switch (op) {
        .file_write_streaming => |write_op| blk: {
            const file = vfs.files.getPtr(@enumFromInt(write_op.file.handle)).?;
            const header = write_op.header;
            const data = write_op.data;
            const splat = write_op.splat;
            break :blk .{
                .file_write_streaming = file.content.writer.writeSplatHeader(header, data, splat) catch error.NoSpaceLeft,
            };
        },
        .file_read_streaming => unreachable,
        .device_io_control => unreachable,
        .net_receive => unreachable,
    };
}

pub const ID = enum(u16) {
    root = 0,
    _,
};

pub fn init(gpa: Allocator) VirtualFilesystem {
    return VirtualFilesystem{
        .gpa = gpa,
    };
}

pub fn deinit(fs: *VirtualFilesystem) void {
    for (fs.directories.values()) |*directory| directory.deinit(fs.gpa);
    for (fs.files.values()) |*file| file.deinit(fs.gpa);

    fs.directories.deinit(fs.gpa);
    fs.files.deinit(fs.gpa);
    fs.hierarchy.deinit(fs.gpa);
}

pub fn root_dir(fs: *VirtualFilesystem) std.Io.Dir {
    _ = fs;
    return .{ .handle = @intFromEnum(ID.root) };
}

pub fn get_file(fs: *VirtualFilesystem, path: []const u8) !?ID {
    var components: std.ArrayList([]const u8) = .empty;
    defer components.deinit(fs.gpa);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try components.append(fs.gpa, component);

    return fs.recursive_get_file(0, .root, components.items);
}

fn recursive_get_file(fs: *VirtualFilesystem, depth: usize, dir_id: ID, components: []const []const u8) !?ID {
    return switch (components.len) {
        0 => null,
        1 => blk: {
            const children = try fs.get_children(fs.gpa, dir_id);
            defer fs.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .file)
                    continue;

                const name = fs.get_name(child.id);
                if (std.mem.eql(u8, name, components[0]))
                    break child.id;
            } else null;
        },
        else => blk: {
            const children = try fs.get_children(fs.gpa, dir_id);
            defer fs.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .directory)
                    continue;

                break try fs.recursive_get_file(depth + 1, child.id, components[1..]) orelse continue;
            } else null;
        },
    };
}

pub const Entry = struct {
    id: ID,
    kind: Kind,
};

pub fn get_children(fs: *VirtualFilesystem, allocator: Allocator, id: ID) ![]const Entry {
    var ret: std.ArrayList(Entry) = .empty;
    for (fs.hierarchy.keys(), fs.hierarchy.values()) |child_id, parent_id| {
        if (parent_id == id)
            try ret.append(allocator, .{
                .id = child_id,
                .kind = fs.get_kind(child_id),
            });
    }
    return ret.toOwnedSlice(allocator);
}

fn new_id(fs: *VirtualFilesystem) ID {
    defer fs.next_id += 1;
    return @enumFromInt(fs.next_id);
}

fn create_dir(fs: *VirtualFilesystem, parent: ID, name: []const u8) !ID {
    const id = fs.new_id();

    const name_copy = try fs.gpa.dupe(u8, name);
    try fs.directories.put(fs.gpa, id, .{
        .name = name_copy,
    });

    try fs.hierarchy.put(fs.gpa, id, parent);

    return id;
}

fn create_file(fs: *VirtualFilesystem, parent: ID, name: []const u8) !ID {
    const id = fs.new_id();

    const name_copy = try fs.gpa.dupe(u8, name);
    try fs.files.put(fs.gpa, id, .{
        .name = name_copy,
        .content = .init(fs.gpa),
    });

    try fs.hierarchy.put(fs.gpa, id, parent);

    return id;
}

pub fn get_kind(fs: *VirtualFilesystem, id: ID) Kind {
    return if (fs.files.contains(id))
        .file
    else if (fs.directories.contains(id))
        .directory
    else
        unreachable;
}

pub fn get_name(fs: *VirtualFilesystem, id: ID) []const u8 {
    return if (fs.files.get(id)) |f|
        f.name
    else if (fs.directories.get(id)) |d|
        d.name
    else
        unreachable;
}

pub fn get_content(fs: *VirtualFilesystem, id: ID) []const u8 {
    assert(fs.get_kind(id) == .file);
    return fs.files.get(id).?.content.writer.buffered();
}

fn get_child(fs: *VirtualFilesystem, parent: ID, component: []const u8) ?ID {
    return for (fs.hierarchy.keys(), fs.hierarchy.values()) |child_id, entry_parent_id| {
        if (entry_parent_id == parent and std.mem.eql(u8, component, fs.get_name(child_id)))
            break child_id;
    } else null;
}

pub fn io(vfs: *VirtualFilesystem) std.Io {
    return .{
        .userdata = vfs,
        .vtable = &.{
            .dirCreateFile = Dir.create_file,
            .operate = operate,

            // Default/failing/unimplemented handlers
            .crashHandler = std.Io.noCrashHandler,
            .async = std.Io.noAsync,
            .concurrent = std.Io.failingConcurrent,
            .await = std.Io.unreachableAwait,
            .cancel = std.Io.unreachableCancel,
            .groupAsync = std.Io.noGroupAsync,
            .groupConcurrent = std.Io.failingGroupConcurrent,
            .groupAwait = std.Io.unreachableGroupAwait,
            .groupCancel = std.Io.unreachableGroupCancel,

            .recancel = std.Io.unreachableRecancel,
            .swapCancelProtection = std.Io.unreachableSwapCancelProtection,
            .checkCancel = std.Io.unreachableCheckCancel,

            .futexWait = std.Io.noFutexWait,
            .futexWaitUncancelable = std.Io.noFutexWaitUncancelable,
            .futexWake = std.Io.noFutexWake,

            .batchAwaitAsync = std.Io.unreachableBatchAwaitAsync,
            .batchAwaitConcurrent = std.Io.unreachableBatchAwaitConcurrent,
            .batchCancel = std.Io.unreachableBatchCancel,

            .dirCreateDir = std.Io.failingDirCreateDir,
            .dirCreateDirPath = std.Io.failingDirCreateDirPath,
            .dirCreateDirPathOpen = Dir.create_dir_path_open,
            .dirOpenDir = std.Io.failingDirOpenDir,
            .dirStat = std.Io.failingDirStat,
            .dirStatFile = std.Io.failingDirStatFile,
            .dirAccess = std.Io.failingDirAccess,
            .dirCreateFileAtomic = std.Io.failingDirCreateFileAtomic,
            .dirOpenFile = std.Io.failingDirOpenFile,
            .dirClose = Dir.close,
            .dirRead = std.Io.noDirRead,
            .dirRealPath = std.Io.failingDirRealPath,
            .dirRealPathFile = std.Io.failingDirRealPathFile,
            .dirDeleteFile = std.Io.failingDirDeleteFile,
            .dirDeleteDir = std.Io.failingDirDeleteDir,
            .dirRename = std.Io.failingDirRename,
            .dirRenamePreserve = std.Io.failingDirRenamePreserve,
            .dirSymLink = std.Io.failingDirSymLink,
            .dirReadLink = std.Io.failingDirReadLink,
            .dirSetOwner = std.Io.failingDirSetOwner,
            .dirSetFileOwner = std.Io.failingDirSetFileOwner,
            .dirSetPermissions = std.Io.failingDirSetPermissions,
            .dirSetFilePermissions = std.Io.failingDirSetFilePermissions,
            .dirSetTimestamps = std.Io.noDirSetTimestamps,
            .dirHardLink = std.Io.failingDirHardLink,

            .fileStat = std.Io.failingFileStat,
            .fileLength = std.Io.failingFileLength,
            .fileClose = File.close,
            .fileWritePositional = std.Io.failingFileWritePositional,
            .fileWriteFileStreaming = std.Io.noFileWriteFileStreaming,
            .fileWriteFilePositional = std.Io.noFileWriteFilePositional,
            .fileReadPositional = std.Io.failingFileReadPositional,
            .fileSeekBy = std.Io.failingFileSeekBy,
            .fileSeekTo = std.Io.failingFileSeekTo,
            .fileSync = std.Io.failingFileSync,
            .fileIsTty = std.Io.unreachableFileIsTty,
            .fileEnableAnsiEscapeCodes = std.Io.unreachableFileEnableAnsiEscapeCodes,
            .fileSupportsAnsiEscapeCodes = std.Io.unreachableFileSupportsAnsiEscapeCodes,
            .fileSetLength = std.Io.failingFileSetLength,
            .fileSetOwner = std.Io.failingFileSetOwner,
            .fileSetPermissions = std.Io.failingFileSetPermissions,
            .fileSetTimestamps = std.Io.noFileSetTimestamps,
            .fileLock = std.Io.failingFileLock,
            .fileTryLock = std.Io.failingFileTryLock,
            .fileUnlock = std.Io.unreachableFileUnlock,
            .fileDowngradeLock = std.Io.failingFileDowngradeLock,
            .fileRealPath = std.Io.failingFileRealPath,
            .fileHardLink = std.Io.failingFileHardLink,

            .fileMemoryMapCreate = std.Io.failingFileMemoryMapCreate,
            .fileMemoryMapDestroy = std.Io.unreachableFileMemoryMapDestroy,
            .fileMemoryMapSetLength = std.Io.unreachableFileMemoryMapSetLength,
            .fileMemoryMapRead = std.Io.unreachableFileMemoryMapRead,
            .fileMemoryMapWrite = std.Io.unreachableFileMemoryMapWrite,

            .processExecutableOpen = std.Io.failingProcessExecutableOpen,
            .processExecutablePath = std.Io.failingProcessExecutablePath,
            .lockStderr = std.Io.unreachableLockStderr,
            .tryLockStderr = std.Io.noTryLockStderr,
            .unlockStderr = std.Io.unreachableUnlockStderr,
            .processCurrentPath = std.Io.failingProcessCurrentPath,
            .processSetCurrentDir = std.Io.failingProcessSetCurrentDir,
            .processSetCurrentPath = std.Io.failingProcessSetCurrentPath,
            .processReplace = std.Io.failingProcessReplace,
            .processReplacePath = std.Io.failingProcessReplacePath,
            .processSpawn = std.Io.failingProcessSpawn,
            .processSpawnPath = std.Io.failingProcessSpawnPath,
            .childWait = std.Io.unreachableChildWait,
            .childKill = std.Io.unreachableChildKill,

            .progressParentFile = std.Io.failingProgressParentFile,

            .now = std.Io.noNow,
            .clockResolution = std.Io.failingClockResolution,
            .sleep = std.Io.noSleep,

            .random = std.Io.noRandom,
            .randomSecure = std.Io.failingRandomSecure,

            .netListenIp = std.Io.failingNetListenIp,
            .netAccept = std.Io.failingNetAccept,
            .netBindIp = std.Io.failingNetBindIp,
            .netConnectIp = std.Io.failingNetConnectIp,
            .netListenUnix = std.Io.failingNetListenUnix,
            .netConnectUnix = std.Io.failingNetConnectUnix,
            .netSocketCreatePair = std.Io.failingNetSocketCreatePair,
            .netSend = std.Io.failingNetSend,

            .netRead = std.Io.failingNetRead,
            .netWrite = std.Io.failingNetWrite,
            .netWriteFile = std.Io.failingNetWriteFile,
            .netClose = std.Io.unreachableNetClose,
            .netShutdown = std.Io.failingNetShutdown,
            .netInterfaceNameResolve = std.Io.failingNetInterfaceNameResolve,
            .netInterfaceName = std.Io.unreachableNetInterfaceName,
            .netLookup = std.Io.failingNetLookup,
        },
    };
}
