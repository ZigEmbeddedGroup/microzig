pub const heap = @import("core/heap.zig");
/// USB data types and helper functions
pub const usb = @import("core/usb.zig");
pub const arm_semihosting = @import("core/arm_semihosting.zig");

test "core tests" {
    _ = usb;
    _ = heap;
}
