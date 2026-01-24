const std = @import("std");
const assert = std.debug.assert;
const Io = std.Io;
const Clock = Io.Clock;
const Timestamp = Io.Timestamp;
const SleepError = Io.SleepError;
const ConcurrentError = Io.ConcurrentError;
const Queue = Io.Queue;
const RandomSecureError = Io.RandomSecureError;
const LockedStderr = Io.LockedStderr;
const Terminal = Io.Terminal;
const Dir = Io.Dir;
const File = Io.File;
const CancelProtection = Io.CancelProtection;
const Timeout = Io.Timeout;
const Group = Io.Group;
const Cancelable = Io.Cancelable;
const AnyFuture = std.Io.AnyFuture;
const net = Io.net;

// Taken from https://codeberg.org/ziglang/zig/pulls/30691/ until it lands.

/// An implementation of `Io` which simulates a system supporting no `Io` operations.
///
/// This system has the following properties:
/// * Concurrency is unavailable.
/// * The stdio handles are pipes whose remote ends are already closed.
/// * The filesystem is entirely empty, including that the cwd is no longer present.
/// * The filesystem is full, so attempting to create entries always returns `error.NoSpaceLeft`.
/// * No entropy source is supported, so `randomSecure` always returns `error.EntropyUnavailable`, and `random` always returns (fills the buffer) with 0.
/// * No clocks are supported, so `now` and `sleep` always return `error.UnsupportedClock`.
/// * No network is connected, so network operations always return `error.NetworkDown`.
pub const io: std.Io = .{
    .userdata = null,
    .vtable = &.{
        .async = &noAsync,
        .concurrent = &failingConcurrent,
        .await = &unreachableAwait,
        .cancel = &unreachableCancel,

        .groupAsync = &noGroupAsync,
        .groupConcurrent = &failingGroupConcurrent,
        .groupAwait = &unreachableGroupAwait,
        .groupCancel = &unreachableGroupCancel,

        .recancel = &unreachableRecancel,
        .swapCancelProtection = &unreachableSwapCancelProtection,
        .checkCancel = &unreachableCheckCancel,

        .select = &unreachableSelect,
        .futexWait = &noFutexWait,
        .futexWaitUncancelable = &noFutexWaitUncancelable,
        .futexWake = &noFutexWake,

        .dirCreateDir = &failingDirCreateDir,
        .dirCreateDirPath = &failingDirCreateDirPath,
        .dirCreateDirPathOpen = &failingDirCreateDirPathOpen,
        .dirOpenDir = &failingDirOpenDir,
        .dirStat = &failingDirStat,
        .dirStatFile = &failingDirStatFile,
        .dirAccess = &failingDirAccess,
        .dirCreateFile = &failingDirCreateFile,
        .dirCreateFileAtomic = &failingDirCreateFileAtomic,
        .dirOpenFile = &failingDirOpenFile,
        .dirClose = &unreachableDirClose,
        .dirRead = &noDirRead,
        .dirRealPath = &failingDirRealPath,
        .dirRealPathFile = &failingDirRealPathFile,
        .dirDeleteFile = &failingDirDeleteFile,
        .dirDeleteDir = &failingDirDeleteDir,
        .dirRename = &failingDirRename,
        .dirRenamePreserve = &failingDirRenamePreserve,
        .dirSymLink = &failingDirSymLink,
        .dirReadLink = &failingDirReadLink,
        .dirSetOwner = &failingDirSetOwner,
        .dirSetFileOwner = &failingDirSetFileOwner,
        .dirSetPermissions = &failingDirSetPermissions,
        .dirSetFilePermissions = &failingDirSetFilePermissions,
        .dirSetTimestamps = &noDirSetTimestamps,
        .dirHardLink = &failingDirHardLink,

        .fileStat = &failingFileStat,
        .fileLength = &failingFileLength,
        .fileClose = &unreachableFileClose,
        .fileWriteStreaming = &failingFileWriteStreaming,
        .fileWritePositional = &failingFileWritePositional,
        .fileWriteFileStreaming = &noFileWriteFileStreaming,
        .fileWriteFilePositional = &noFileWriteFilePositional,
        .fileReadStreaming = &failingFileReadStreaming,
        .fileReadPositional = &failingFileReadPositional,
        .fileSeekBy = &failingFileSeekBy,
        .fileSeekTo = &failingFileSeekTo,
        .fileSync = &failingFileSync,
        .fileIsTty = &unreachableFileIsTty,
        .fileEnableAnsiEscapeCodes = &unreachableFileEnableAnsiEscapeCodes,
        .fileSupportsAnsiEscapeCodes = &unreachableFileSupportsAnsiEscapeCodes,
        .fileSetLength = &failingFileSetLength,
        .fileSetOwner = &failingFileSetOwner,
        .fileSetPermissions = &failingFileSetPermissions,
        .fileSetTimestamps = &noFileSetTimestamps,
        .fileLock = &failingFileLock,
        .fileTryLock = &failingFileTryLock,
        .fileUnlock = &unreachableFileUnlock,
        .fileDowngradeLock = &failingFileDowngradeLock,
        .fileRealPath = &failingFileRealPath,
        .fileHardLink = &failingFileHardLink,

        .fileMemoryMapCreate = &failingFileMemoryMapCreate,
        .fileMemoryMapDestroy = &unreachableFileMemoryMapDestroy,
        .fileMemoryMapSetLength = &unreachableFileMemoryMapSetLength,
        .fileMemoryMapRead = &unreachableFileMemoryMapRead,
        .fileMemoryMapWrite = &unreachableFileMemoryMapWrite,

        .processExecutableOpen = &failingProcessExecutableOpen,
        .processExecutablePath = &failingProcessExecutablePath,
        .lockStderr = &unreachableLockStderr,
        .tryLockStderr = &noTryLockStderr,
        .unlockStderr = &unreachableUnlockStderr,
        .processSetCurrentDir = &failingProcessSetCurrentDir,
        .processReplace = &failingProcessReplace,
        .processReplacePath = &failingProcessReplacePath,
        .processSpawn = &failingProcessSpawn,
        .processSpawnPath = &failingProcessSpawnPath,
        .childWait = &unreachableChildWait,
        .childKill = &unreachableChildKill,

        .progressParentFile = &failingProgressParentFile,

        .random = &noRandom,
        .randomSecure = &failingRandomSecure,

        .now = &failingNow,
        .sleep = &failingSleep,

        .netListenIp = &failingNetListenIp,
        .netAccept = &failingNetAccept,
        .netBindIp = &failingNetBindIp,
        .netConnectIp = &failingNetConnectIp,
        .netListenUnix = &failingNetListenUnix,
        .netConnectUnix = &failingNetConnectUnix,
        .netSend = &failingNetSend,
        .netReceive = &failingNetReceive,
        .netRead = &failingNetRead,
        .netWrite = &failingNetWrite,
        .netWriteFile = &failingNetWriteFile,
        .netClose = &unreachableNetClose,
        .netShutdown = &failingNetShutdown,
        .netInterfaceNameResolve = &failingNetInterfaceNameResolve,
        .netInterfaceName = &unreachableNetInterfaceName,
        .netLookup = &failingNetLookup,
    },
};

pub fn noAsync(userdata: ?*anyopaque, result: []u8, result_alignment: std.mem.Alignment, context: []const u8, context_alignment: std.mem.Alignment, start: *const fn (context: *const anyopaque, result: *anyopaque) void) ?*AnyFuture {
    _ = userdata;
    _ = result_alignment;
    _ = context_alignment;
    start(context.ptr, result.ptr);
    return null;
}

pub fn failingConcurrent(
    userdata: ?*anyopaque,
    result_len: usize,
    result_alignment: std.mem.Alignment,
    context: []const u8,
    context_alignment: std.mem.Alignment,
    start: *const fn (context: *const anyopaque, result: *anyopaque) void,
) ConcurrentError!*AnyFuture {
    _ = userdata;
    _ = result_len;
    _ = result_alignment;
    _ = context;
    _ = context_alignment;
    _ = start;
    return error.ConcurrencyUnavailable;
}

pub fn unreachableAwait(
    userdata: ?*anyopaque,
    any_future: *AnyFuture,
    result: []u8,
    result_alignment: std.mem.Alignment,
) void {
    _ = userdata;
    _ = any_future;
    _ = result;
    _ = result_alignment;
    unreachable;
}

pub fn unreachableCancel(
    userdata: ?*anyopaque,
    any_future: *AnyFuture,
    result: []u8,
    result_alignment: std.mem.Alignment,
) void {
    _ = userdata;
    _ = any_future;
    _ = result;
    _ = result_alignment;
    unreachable;
}

pub fn noGroupAsync(
    userdata: ?*anyopaque,
    group: *Group,
    context: []const u8,
    context_alignment: std.mem.Alignment,
    start: *const fn (context: *const anyopaque) Cancelable!void,
) void {
    _ = userdata;
    _ = group;
    _ = context_alignment;
    start(context.ptr) catch unreachable;
}

pub fn failingGroupConcurrent(
    userdata: ?*anyopaque,
    group: *Group,
    context: []const u8,
    context_alignment: std.mem.Alignment,
    start: *const fn (context: *const anyopaque) Cancelable!void,
) ConcurrentError!void {
    _ = userdata;
    _ = group;
    _ = context;
    _ = context_alignment;
    _ = start;
    return error.ConcurrencyUnavailable;
}

pub fn unreachableGroupAwait(userdata: ?*anyopaque, group: *Group, token: *anyopaque) Cancelable!void {
    _ = userdata;
    _ = group;
    _ = token;
    unreachable;
}

pub fn unreachableGroupCancel(userdata: ?*anyopaque, group: *Group, token: *anyopaque) void {
    _ = userdata;
    _ = group;
    _ = token;
    unreachable;
}

pub fn unreachableRecancel(userdata: ?*anyopaque) void {
    _ = userdata;
    unreachable;
}

pub fn unreachableSwapCancelProtection(userdata: ?*anyopaque, new: CancelProtection) CancelProtection {
    _ = userdata;
    _ = new;
    unreachable;
}

pub fn unreachableCheckCancel(userdata: ?*anyopaque) Cancelable!void {
    _ = userdata;
    unreachable;
}

pub fn unreachableSelect(userdata: ?*anyopaque, futures: []const *AnyFuture) Cancelable!usize {
    _ = userdata;
    _ = futures;
    unreachable;
}

pub fn noFutexWait(userdata: ?*anyopaque, ptr: *const u32, expected: u32, timeout: Timeout) Cancelable!void {
    _ = userdata;
    assert(ptr.* == expected or timeout != .none);
}

pub fn noFutexWaitUncancelable(userdata: ?*anyopaque, ptr: *const u32, expected: u32) void {
    _ = userdata;
    assert(ptr.* == expected);
}

pub fn noFutexWake(userdata: ?*anyopaque, ptr: *const u32, max_waiters: u32) void {
    _ = userdata;
    _ = ptr;
    _ = max_waiters;
    // no-op
}

pub fn failingDirCreateDir(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, permissions: Dir.Permissions) Dir.CreateDirError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = permissions;
    return error.NoSpaceLeft;
}

pub fn failingDirCreateDirPath(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, permissions: Dir.Permissions) Dir.CreateDirPathError!Dir.CreatePathStatus {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = permissions;
    return error.NoSpaceLeft;
}

pub fn failingDirCreateDirPathOpen(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, permissions: Dir.Permissions, options: Dir.OpenOptions) Dir.CreateDirPathOpenError!Dir {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = permissions;
    _ = options;
    return error.NoSpaceLeft;
}

pub fn failingDirOpenDir(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, options: Dir.OpenOptions) Dir.OpenError!Dir {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = options;
    return error.FileNotFound;
}

pub fn failingDirStat(userdata: ?*anyopaque, dir: Dir) Dir.StatError!Dir.Stat {
    _ = userdata;
    _ = dir;
    return error.Streaming;
}

pub fn failingDirStatFile(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, options: Dir.StatFileOptions) Dir.StatFileError!File.Stat {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = options;
    return error.FileNotFound;
}

pub fn failingDirAccess(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, options: Dir.AccessOptions) Dir.AccessError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = options;
    return error.FileNotFound;
}

pub fn failingDirCreateFile(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, options: File.CreateFlags) File.OpenError!File {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = options;
    return error.NoSpaceLeft;
}

pub fn failingDirCreateFileAtomic(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, options: Dir.CreateFileAtomicOptions) Dir.CreateFileAtomicError!File.Atomic {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = options;
    return error.NoSpaceLeft;
}

pub fn failingDirOpenFile(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, flags: File.OpenFlags) File.OpenError!File {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = flags;
    return error.FileNotFound;
}

pub fn unreachableDirClose(userdata: ?*anyopaque, dirs: []const Dir) void {
    _ = userdata;
    _ = dirs;
    unreachable;
}

pub fn noDirRead(userdata: ?*anyopaque, dir_reader: *Dir.Reader, buffer: []Dir.Entry) Dir.Reader.Error!usize {
    _ = userdata;
    _ = dir_reader;
    _ = buffer;
    return 0;
}

pub fn failingDirRealPath(userdata: ?*anyopaque, dir: Dir, out_buffer: []u8) Dir.RealPathError!usize {
    _ = userdata;
    _ = dir;
    _ = out_buffer;
    return error.FileNotFound;
}

pub fn failingDirRealPathFile(userdata: ?*anyopaque, dir: Dir, path_name: []const u8, out_buffer: []u8) Dir.RealPathFileError!usize {
    _ = userdata;
    _ = dir;
    _ = path_name;
    _ = out_buffer;
    return error.FileNotFound;
}

pub fn failingDirDeleteFile(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8) Dir.DeleteFileError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    return error.FileNotFound;
}

pub fn failingDirDeleteDir(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8) Dir.DeleteDirError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    return error.FileNotFound;
}

pub fn failingDirRename(userdata: ?*anyopaque, old_dir: Dir, old_sub_path: []const u8, new_dir: Dir, new_sub_path: []const u8) Dir.RenameError!void {
    _ = userdata;
    _ = old_dir;
    _ = old_sub_path;
    _ = new_dir;
    _ = new_sub_path;
    return error.FileNotFound;
}

pub fn failingDirRenamePreserve(userdata: ?*anyopaque, old_dir: Dir, old_sub_path: []const u8, new_dir: Dir, new_sub_path: []const u8) Dir.RenamePreserveError!void {
    _ = userdata;
    _ = old_dir;
    _ = old_sub_path;
    _ = new_dir;
    _ = new_sub_path;
    return error.FileNotFound;
}

pub fn failingDirSymLink(userdata: ?*anyopaque, dir: Dir, target_path: []const u8, sym_link_path: []const u8, flags: Dir.SymLinkFlags) Dir.SymLinkError!void {
    _ = userdata;
    _ = dir;
    _ = target_path;
    _ = sym_link_path;
    _ = flags;
    return error.FileNotFound;
}

pub fn failingDirReadLink(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, buffer: []u8) Dir.ReadLinkError!usize {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = buffer;
    return error.FileNotFound;
}

pub fn failingDirSetOwner(userdata: ?*anyopaque, dir: Dir, owner: ?File.Uid, group: ?File.Gid) Dir.SetOwnerError!void {
    _ = userdata;
    _ = dir;
    _ = owner;
    _ = group;
    return error.FileNotFound;
}

pub fn failingDirSetFileOwner(userdata: ?*anyopaque, dir: std.Io.Dir, sub_path: []const u8, owner: ?File.Uid, group: ?File.Gid, options: Dir.SetFileOwnerOptions) Dir.SetFileOwnerError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = owner;
    _ = group;
    _ = options;
    return error.FileNotFound;
}

pub fn failingDirSetPermissions(userdata: ?*anyopaque, dir: Dir, permissions: Dir.Permissions) Dir.SetPermissionsError!void {
    _ = userdata;
    _ = dir;
    _ = permissions;
    return error.FileNotFound;
}

pub fn failingDirSetFilePermissions(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, permissions: File.Permissions, options: Dir.SetFilePermissionsOptions) Dir.SetFilePermissionsError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = permissions;
    _ = options;
    return error.FileNotFound;
}

pub fn noDirSetTimestamps(userdata: ?*anyopaque, dir: Dir, sub_path: []const u8, options: Dir.SetTimestampsOptions) Dir.SetTimestampsError!void {
    _ = userdata;
    _ = dir;
    _ = sub_path;
    _ = options;
    // no-op
}

pub fn failingDirHardLink(userdata: ?*anyopaque, old_dir: Dir, old_sub_path: []const u8, new_dir: Dir, new_sub_path: []const u8, options: Dir.HardLinkOptions) Dir.HardLinkError!void {
    _ = userdata;
    _ = old_dir;
    _ = old_sub_path;
    _ = new_dir;
    _ = new_sub_path;
    _ = options;
    return error.FileNotFound;
}

pub fn failingFileStat(userdata: ?*anyopaque, file: File) File.StatError!File.Stat {
    _ = userdata;
    _ = file;
    return error.Streaming;
}

pub fn failingFileLength(userdata: ?*anyopaque, file: File) File.LengthError!u64 {
    _ = userdata;
    _ = file;
    return error.Streaming;
}

pub fn unreachableFileClose(userdata: ?*anyopaque, files: []const File) void {
    _ = userdata;
    _ = files;
    unreachable;
}

pub fn failingFileWriteStreaming(userdata: ?*anyopaque, file: File, header: []const u8, data: []const []const u8, splat: usize) File.Writer.Error!usize {
    _ = userdata;
    _ = file;
    _ = header;
    for (data[0 .. data.len - 1]) |item| {
        if (item.len > 0) {
            return error.BrokenPipe;
        }
    }
    if (data[data.len - 1].len != 0 and splat != 0) return error.BrokenPipe;
    return 0;
}

pub fn failingFileWritePositional(userdata: ?*anyopaque, file: File, header: []const u8, data: []const []const u8, splat: usize, offset: u64) File.WritePositionalError!usize {
    _ = userdata;
    _ = file;
    _ = header;
    _ = offset;
    for (data[0 .. data.len - 1]) |item| {
        if (item.len > 0) return error.BrokenPipe;
    }
    if (data[data.len - 1].len != 0 and splat != 0) return error.BrokenPipe;
    return 0;
}

pub fn noFileWriteFileStreaming(userdata: ?*anyopaque, file: File, header: []const u8, file_reader: *Io.File.Reader, limit: Io.Limit) File.Writer.WriteFileError!usize {
    _ = userdata;
    _ = file;
    _ = header;
    _ = file_reader;
    _ = limit;
    return error.Unimplemented;
}

pub fn noFileWriteFilePositional(userdata: ?*anyopaque, file: File, header: []const u8, file_reader: *Io.File.Reader, limit: Io.Limit, offset: u64) File.WriteFilePositionalError!usize {
    _ = userdata;
    _ = file;
    _ = header;
    _ = file_reader;
    _ = limit;
    _ = offset;
    return error.Unimplemented;
}

pub fn failingFileReadStreaming(userdata: ?*anyopaque, file: File, data: []const []u8) File.Reader.Error!usize {
    _ = userdata;
    _ = file;
    for (data) |item| {
        if (item.len > 0) return error.BrokenPipe;
    }
    return 0;
}

pub fn failingFileReadPositional(userdata: ?*anyopaque, file: File, data: []const []u8, offset: u64) File.ReadPositionalError!usize {
    _ = userdata;
    _ = file;
    _ = offset;
    for (data) |item| {
        if (item.len > 0) return error.BrokenPipe;
    }
    return 0;
}

pub fn failingFileSeekBy(userdata: ?*anyopaque, file: File, relative_offset: i64) File.SeekError!void {
    _ = userdata;
    _ = file;
    _ = relative_offset;
    return error.Unseekable;
}

pub fn failingFileSeekTo(userdata: ?*anyopaque, file: File, absolute_offset: u64) File.SeekError!void {
    _ = userdata;
    _ = file;
    _ = absolute_offset;
    return error.Unseekable;
}

pub fn failingFileSync(userdata: ?*anyopaque, file: File) File.SyncError!void {
    _ = userdata;
    _ = file;
    return error.NoSpaceLeft;
}

pub fn unreachableFileIsTty(userdata: ?*anyopaque, file: File) Cancelable!bool {
    _ = userdata;
    _ = file;
    unreachable;
}

pub fn unreachableFileEnableAnsiEscapeCodes(userdata: ?*anyopaque, file: File) File.EnableAnsiEscapeCodesError!void {
    _ = userdata;
    _ = file;
    unreachable;
}

pub fn unreachableFileSupportsAnsiEscapeCodes(userdata: ?*anyopaque, file: File) Cancelable!bool {
    _ = userdata;
    _ = file;
    unreachable;
}

pub fn failingFileSetLength(userdata: ?*anyopaque, file: File, length: u64) File.SetLengthError!void {
    _ = userdata;
    _ = file;
    _ = length;
    return error.NonResizable;
}

pub fn failingFileSetOwner(userdata: ?*anyopaque, file: File, owner: ?File.Uid, group: ?File.Gid) File.SetOwnerError!void {
    _ = userdata;
    _ = file;
    _ = owner;
    _ = group;
    return error.FileNotFound;
}

pub fn failingFileSetPermissions(userdata: ?*anyopaque, file: File, permissions: File.Permissions) File.SetPermissionsError!void {
    _ = userdata;
    _ = file;
    _ = permissions;
    return error.FileNotFound;
}

pub fn noFileSetTimestamps(userdata: ?*anyopaque, file: File, options: File.SetTimestampsOptions) File.SetTimestampsError!void {
    _ = userdata;
    _ = file;
    _ = options;
    // no-op
}

pub fn failingFileLock(userdata: ?*anyopaque, file: File, lock: File.Lock) File.LockError!void {
    _ = userdata;
    _ = file;
    _ = lock;
    return error.FileLocksUnsupported;
}

pub fn failingFileTryLock(userdata: ?*anyopaque, file: File, lock: File.Lock) File.LockError!bool {
    _ = userdata;
    _ = file;
    _ = lock;
    return error.FileLocksUnsupported;
}

pub fn unreachableFileUnlock(userdata: ?*anyopaque, file: File) void {
    _ = userdata;
    _ = file;
    unreachable;
}

pub fn failingFileDowngradeLock(userdata: ?*anyopaque, file: File) File.DowngradeLockError!void {
    _ = userdata;
    _ = file;
    // no-op
}

pub fn failingFileRealPath(userdata: ?*anyopaque, file: File, out_buffer: []u8) File.RealPathError!usize {
    _ = userdata;
    _ = file;
    _ = out_buffer;
    return error.FileNotFound;
}

pub fn failingFileHardLink(userdata: ?*anyopaque, file: File, new_dir: Dir, new_sub_path: []const u8, options: File.HardLinkOptions) File.HardLinkError!void {
    _ = userdata;
    _ = file;
    _ = new_dir;
    _ = new_sub_path;
    _ = options;
    return error.FileNotFound;
}

pub fn failingFileMemoryMapCreate(userdata: ?*anyopaque, file: File, options: File.MemoryMap.CreateOptions) File.MemoryMap.CreateError!File.MemoryMap {
    _ = userdata;
    _ = file;
    _ = options;
    return error.AccessDenied;
}

pub fn unreachableFileMemoryMapDestroy(userdata: ?*anyopaque, mm: *File.MemoryMap) void {
    _ = userdata;
    _ = mm;
    unreachable;
}

pub fn unreachableFileMemoryMapSetLength(userdata: ?*anyopaque, mm: *File.MemoryMap, options: File.MemoryMap.CreateOptions) File.MemoryMap.SetLengthError!void {
    _ = userdata;
    _ = mm;
    _ = options;
    unreachable;
}

pub fn unreachableFileMemoryMapRead(userdata: ?*anyopaque, mm: *File.MemoryMap) File.ReadPositionalError!void {
    _ = userdata;
    _ = mm;
    unreachable;
}

pub fn unreachableFileMemoryMapWrite(userdata: ?*anyopaque, mm: *File.MemoryMap) File.WritePositionalError!void {
    _ = userdata;
    _ = mm;
    unreachable;
}

pub fn failingProcessExecutableOpen(userdata: ?*anyopaque, flags: File.OpenFlags) std.process.OpenExecutableError!File {
    _ = userdata;
    _ = flags;
    return error.FileNotFound;
}

pub fn failingProcessExecutablePath(userdata: ?*anyopaque, buffer: []u8) std.process.ExecutablePathError!usize {
    _ = userdata;
    _ = buffer;
    return error.FileNotFound;
}

pub fn unreachableLockStderr(userdata: ?*anyopaque, terminal_mode: ?Terminal.Mode) Cancelable!LockedStderr {
    _ = userdata;
    _ = terminal_mode;
    unreachable;
}

pub fn noTryLockStderr(userdata: ?*anyopaque, terminal_mode: ?Terminal.Mode) Cancelable!?LockedStderr {
    _ = userdata;
    _ = terminal_mode;
    return null;
}

pub fn unreachableUnlockStderr(userdata: ?*anyopaque) void {
    _ = userdata;
    unreachable;
}

pub fn failingProcessSetCurrentDir(userdata: ?*anyopaque, dir: Dir) std.process.SetCurrentDirError!void {
    _ = userdata;
    _ = dir;
    return error.FileNotFound;
}

pub fn failingProcessReplace(userdata: ?*anyopaque, options: std.process.ReplaceOptions) std.process.ReplaceError {
    _ = userdata;
    _ = options;
    return error.OperationUnsupported;
}

pub fn failingProcessReplacePath(userdata: ?*anyopaque, dir: Dir, options: std.process.ReplaceOptions) std.process.ReplaceError {
    _ = userdata;
    _ = dir;
    _ = options;
    return error.OperationUnsupported;
}

pub fn failingProcessSpawn(userdata: ?*anyopaque, options: std.process.SpawnOptions) std.process.SpawnError!std.process.Child {
    _ = userdata;
    _ = options;
    return error.OperationUnsupported;
}

pub fn failingProcessSpawnPath(userdata: ?*anyopaque, dir: Dir, options: std.process.SpawnOptions) std.process.SpawnError!std.process.Child {
    _ = userdata;
    _ = dir;
    _ = options;
    return error.OperationUnsupported;
}

pub fn unreachableChildWait(userdata: ?*anyopaque, child: *std.process.Child) std.process.Child.WaitError!std.process.Child.Term {
    _ = userdata;
    _ = child;
    unreachable;
}

pub fn unreachableChildKill(userdata: ?*anyopaque, child: *std.process.Child) void {
    _ = userdata;
    _ = child;
    unreachable;
}

pub fn failingProgressParentFile(userdata: ?*anyopaque) std.Progress.ParentFileError!File {
    _ = userdata;
    return error.UnsupportedOperation;
}

pub fn noRandom(userdata: ?*anyopaque, buffer: []u8) void {
    _ = userdata;
    @memset(buffer, 0);
}

pub fn failingRandomSecure(userdata: ?*anyopaque, buffer: []u8) RandomSecureError!void {
    _ = userdata;
    _ = buffer;
    return error.EntropyUnavailable;
}

pub fn failingNow(userdata: ?*anyopaque, clock: Clock) Clock.Error!Timestamp {
    _ = userdata;
    _ = clock;
    return error.UnsupportedClock;
}

pub fn failingSleep(userdata: ?*anyopaque, clock: Timeout) SleepError!void {
    _ = userdata;
    _ = clock;
    return error.UnsupportedClock;
}

pub fn failingNetListenIp(userdata: ?*anyopaque, address: net.IpAddress, options: net.IpAddress.ListenOptions) net.IpAddress.ListenError!net.Server {
    _ = userdata;
    _ = address;
    _ = options;
    return error.NetworkDown;
}

pub fn failingNetAccept(userdata: ?*anyopaque, server: net.Socket.Handle) net.Server.AcceptError!net.Stream {
    _ = userdata;
    _ = server;
    return error.NetworkDown;
}

pub fn failingNetBindIp(userdata: ?*anyopaque, address: *const net.IpAddress, options: net.IpAddress.BindOptions) net.IpAddress.BindError!net.Socket {
    _ = userdata;
    _ = address;
    _ = options;
    return error.NetworkDown;
}

pub fn failingNetConnectIp(userdata: ?*anyopaque, address: *const net.IpAddress, options: net.IpAddress.ConnectOptions) net.IpAddress.ConnectError!net.Stream {
    _ = userdata;
    _ = address;
    _ = options;
    return error.NetworkDown;
}

pub fn failingNetListenUnix(userdata: ?*anyopaque, address: *const net.UnixAddress, options: net.UnixAddress.ListenOptions) net.UnixAddress.ListenError!net.Socket.Handle {
    _ = userdata;
    _ = address;
    _ = options;
    return error.NetworkDown;
}

pub fn failingNetConnectUnix(userdata: ?*anyopaque, address: *const net.UnixAddress) net.UnixAddress.ConnectError!net.Socket.Handle {
    _ = userdata;
    _ = address;
    return error.NetworkDown;
}

pub fn failingNetSend(userdata: ?*anyopaque, handle: net.Socket.Handle, messages: []net.OutgoingMessage, flags: net.SendFlags) struct { ?net.Socket.SendError, usize } {
    _ = userdata;
    _ = handle;
    _ = messages;
    _ = flags;
    return .{ error.NetworkDown, 0 };
}

pub fn failingNetReceive(userdata: ?*anyopaque, handle: net.Socket.Handle, message_buffer: []net.IncomingMessage, data_buffer: []u8, flags: net.ReceiveFlags, timeout: Timeout) struct { ?net.Socket.ReceiveTimeoutError, usize } {
    _ = userdata;
    _ = handle;
    _ = message_buffer;
    _ = data_buffer;
    _ = flags;
    _ = timeout;
    return .{ error.NetworkDown, 0 };
}

pub fn failingNetRead(userdata: ?*anyopaque, src: net.Socket.Handle, data: [][]u8) net.Stream.Reader.Error!usize {
    _ = userdata;
    _ = src;
    _ = data;
    return error.NetworkDown;
}

pub fn failingNetWrite(userdata: ?*anyopaque, dest: net.Socket.Handle, header: []const u8, data: []const []const u8, splat: usize) net.Stream.Writer.Error!usize {
    _ = userdata;
    _ = dest;
    _ = header;
    _ = data;
    _ = splat;
    return error.NetworkDown;
}

pub fn failingNetWriteFile(userdata: ?*anyopaque, handle: net.Socket.Handle, header: []const u8, file_reader: *Io.File.Reader, limit: Io.Limit) net.Stream.Writer.WriteFileError!usize {
    _ = userdata;
    _ = handle;
    _ = header;
    _ = file_reader;
    _ = limit;
    return error.NetworkDown;
}

pub fn unreachableNetClose(userdata: ?*anyopaque, handle: []const net.Socket.Handle) void {
    _ = userdata;
    _ = handle;
    unreachable;
}

pub fn failingNetShutdown(userdata: ?*anyopaque, handle: net.Socket.Handle, how: net.ShutdownHow) net.ShutdownError!void {
    _ = userdata;
    _ = handle;
    _ = how;
    return error.NetworkDown;
}

pub fn failingNetInterfaceNameResolve(userdata: ?*anyopaque, name: *const net.Interface.Name) net.Interface.Name.ResolveError!net.Interface {
    _ = userdata;
    _ = name;
    return error.InterfaceNotFound;
}

pub fn unreachableNetInterfaceName(userdata: ?*anyopaque, interface: net.Interface) net.Interface.NameError!net.Interface.Name {
    _ = userdata;
    _ = interface;
    unreachable;
}

pub fn failingNetLookup(userdata: ?*anyopaque, host_name: net.HostName, resolved: *Queue(net.HostName.LookupResult), options: net.HostName.LookupOptions) net.HostName.LookupError!void {
    _ = userdata;
    _ = host_name;
    _ = resolved;
    _ = options;
    return error.NetworkDown;
}
