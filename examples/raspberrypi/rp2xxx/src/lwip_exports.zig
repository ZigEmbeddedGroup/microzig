/// Exports required by lwip
///
/// This file is chip depndent, lwip.zig should not be dependent on specific
/// chips, so keeping this in separate file.
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const trng = rp2xxx.rand.trng;

const log = std.log.scoped(.lwip);
const assert = std.debug.assert;

export fn lwip_lock_interrupts(were_enabled: *bool) void {
    _ = were_enabled;
}

export fn lwip_unlock_interrupts(enable: bool) void {
    _ = enable;
}

export fn lwip_rand() u32 {
    return if (rp2xxx.compatibility.chip == .RP2350)
        trng.random_blocking()
    else
        4;
}

export fn lwip_assert(msg: [*c]const u8, file: [*c]const u8, line: c_int) void {
    log.err("assert: {s} in file: {s}, line: {}", .{ msg, file, line });
    @panic("lwip assert");
}

export fn lwip_diag(msg: [*c]const u8, file: [*c]const u8, line: c_int) void {
    log.debug("{s} in file: {s}, line: {}", .{ msg, file, line });
}

// required by fundation-libc/src/modules/errno.zig
// line 12 threadlocal
export fn __aeabi_read_tp() u32 {
    return 0;
}

export fn sys_now() u32 {
    const ts = time.get_time_since_boot();
    return @truncate(ts.to_us() / 1000);
}
