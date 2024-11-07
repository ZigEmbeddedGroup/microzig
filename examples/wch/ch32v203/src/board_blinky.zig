const microzig = @import("microzig");
// const hal = microzig.hal;
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
    const pins = board.pin_config.apply();

    while (true) {
        // var val = pins.led.read();
        // switch (val) {
        //     0 => pins.led.put(1),
        //     1 => pins.led.put(0),
        // }
        pins.led.toggle();

        busyloop();
    }
}

// cpu_frequency

inline fn busyloop() void {
    const limit = board.cpu_frequency / 4;

    var i: u32 = 0;
    while (i < limit) : (i += 1) {
        asm volatile ("" ::: "memory");
    }
}
