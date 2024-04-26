pub fn disable_interrupts() void {}
pub const startup_logic = struct {
    extern fn microzig_main() noreturn;
    pub fn _start() callconv(.C) noreturn {
        microzig_main();
    }
};

pub fn export_startup_logic() void {}
