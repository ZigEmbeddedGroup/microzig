//! {
//!   "stdout": "hello",
//!   "stderr": "world"
//! }
const testsuite = @import("testsuite");

export fn _start() callconv(.c) noreturn {
    testsuite.write(.stdout, "hello");
    testsuite.write(.stderr, "world");
    testsuite.exit(0);
}
