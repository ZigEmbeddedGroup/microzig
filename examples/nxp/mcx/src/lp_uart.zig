const microzig = @import("microzig");
const hal = microzig.hal;

const Pin = hal.Pin;
const FlexComm = hal.FlexComm;
const LP_UART = FlexComm.LP_UART;

// Init the two pins required for uart on the flexcomm 4 interface:
// - pin 8 of port 1 corresponds to FC4_P0, which is RXD for uart
// - pin 9 of port 1 corresponds to FC4_P0, which is TXD for uart
//
// see section 66.2.3 of the reference manual and the chip's pinout for more details
fn init_pins() void {
    // FC4_P0
    Pin.num(1, 8).configure()
        .alt(2) // select the flexcomm 4 interface for the pin
        .enable_input_buffer()
        .done();
    // FC4_P1
    Pin.num(1, 9).configure()
        .alt(2) // select the flexcomm 4 interface for the pin
        .enable_input_buffer()
        .done();
}

pub fn main() !void {
    hal.Port.num(1).init(); // we init port 1 to edit the pin's config
    init_pins();

    // Provide the interface with the 12MHz clock divided by 1
    FlexComm.num(4).set_clock(.FRO_12MHz, 1);
    const uart: LP_UART = try .init(4, .Default);

    uart.transmit("This is a message using the low level interface\n");
    uart.transmit("Send a message: ");

    // We can also use zig's Io interface to read
    var buffer: [16]u8 = undefined;
    var reader = uart.reader(&buffer);
    // the delimiter can depend on the config of the sender
    const message = try reader.interface.takeDelimiterExclusive('\n');
    reader.interface.toss(1); // toss the delimiter

    // And to write
    var writer = uart.writer(&.{});
    try writer.interface.print("Successfully received \"{s}\"\n", .{ message });
}
