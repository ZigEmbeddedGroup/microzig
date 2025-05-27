fn calc_descriptor_size(comptime string: []const u8) comptime_int {
    return (string.len * 2) + 2;
}

pub fn string_to_descriptor(comptime string: []const u8) [calc_descriptor_size(string)]u8 {
    var buf: [calc_descriptor_size(string)]u8 = undefined;
    buf[0] = buf.len;
    buf[1] = 0x03;
    for (0..string.len) |index| {
        buf[(((index) * 2)) + 2] = string[index];
        buf[(((index) * 2) + 1) + 2] = 0;
    }
    return buf;
}
