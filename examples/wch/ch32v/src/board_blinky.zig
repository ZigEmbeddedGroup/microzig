const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

// Can define in the board file.
// const pin_config = hal.pins.GlobalConfiguration{
//     .GPIOA = .{
//         .PIN5 = .{
//             .name = "led",
//             .mode = .{ .output = .general_purpose_push_pull },
//         },
//     },
// };

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    const pins = board.pin_config.apply();

    while (true) {
        // var val = pins.led.read();
        // switch (val) {
        //     0 => pins.led.put(1),
        //     1 => pins.led.put(0),
        // }
        pins.led.toggle();

        hal.time.sleep_ms(1000);
    }
}
