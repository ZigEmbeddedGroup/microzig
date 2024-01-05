//! implementation of `errno.h`

const std = @import("std");

threadlocal var errno: c_int = 0;

export fn __get_errno() *c_int {
    return &errno;
}
