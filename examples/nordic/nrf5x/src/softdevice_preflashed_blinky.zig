// SoftDevice "preflashed" example: assumes the SoftDevice is already on the
// chip. The build system adjusts the linker memory map so the application is
// placed after the SoftDevice region. Flash this .hex/.elf on its own.
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;
const time = nrf.time;

pub fn main() void {
    board.init();

    while (true) {
        board.led1.toggle();
        time.sleep_ms(250);
    }
}
