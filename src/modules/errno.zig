//! implementation of `errno.h`

const std = @import("std");
const builtin = @import("builtin");

const storage = if (builtin.single_threaded)
    struct {
        var errno: c_int = 0; // regular variable on single-threaded systems
    }
else
    struct {
        threadlocal var errno: c_int = 0; // thread-local variable on multi-threaded systems
    };

export fn __get_errno() *c_int {
    return &storage.errno;
}
