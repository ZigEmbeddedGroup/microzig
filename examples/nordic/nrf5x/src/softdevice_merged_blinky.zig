// SoftDevice "merged" example: the build produces a combined Intel HEX that
// contains both the SoftDevice binary and the application. Flash the
// *_merged.hex to program everything in one shot. The app code is identical
// to the preflashed variant — only the build configuration differs.
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
