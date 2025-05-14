const microzig = @import("microzig");
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

        busy_delay(1000);
    }
}

inline fn busy_delay(comptime ms: u32) void {
    const cpu_frequency = board.cpu_frequency;
    const cycles_per_ms = cpu_frequency / 1_000;
    const loop_cycles = 3;
    const limit = cycles_per_ms * ms / loop_cycles;

    var i: u32 = 0;
    while (i < limit) : (i += 1) {
        asm volatile ("" ::: "memory");
    }
}
