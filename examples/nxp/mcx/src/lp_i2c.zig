const microzig = @import("microzig");
const hal = microzig.hal;

const Pin = hal.Pin;
const FlexComm = hal.FlexComm;
const LP_I2C = FlexComm.LP_I2C;

// Init the two pins required for uart on the flexcomm 4 interface:
// - pin 0 of port 1 corresponds to FC3_P0, which is SDA for I2C
// - pin 1 of port 1 corresponds to FC3_P0, which is SCL for I2C
//
// see section 66.2.3 of the reference manual and the chip's pinout for more details
fn init_lpi2c_pins() void {
    // FC3_P0
    Pin.num(1, 0).configure()
        .alt(2)
        .set_pull(.up)
        .enable_input_buffer()
        .done();
    // FC3_P1
    Pin.num(1, 1).configure()
        .alt(2)
        .set_pull(.up)
        .enable_input_buffer()
        .done();
}

pub fn main() !void {
    hal.Port.num(1).init(); // we init port 1 to edit the pin's config
    init_lpi2c_pins();

    // Provide the interface with the 12MHz clock divided by 1
    FlexComm.num(3).set_clock(.FRO_12MHz, 1);
    const i2c: LP_I2C = try .init(3, .Default);

    const data = &.{ 0xde, 0xad, 0xbe, 0xef };

    // Low level write
    try i2c.send_blocking(0x10, data);

    // Recommended:
    // Using microzig's I2C_Device interface to write
    const i2c_device = i2c.i2c_device();
    try i2c_device.write(@enumFromInt(0x10), data);

    // and read
    var buffer: [4]u8 = undefined;
    _ = try i2c_device.read(@enumFromInt(0x10), &buffer);

    // or do both
    try i2c_device.write_then_read(@enumFromInt(0x10), data, &buffer);
}
