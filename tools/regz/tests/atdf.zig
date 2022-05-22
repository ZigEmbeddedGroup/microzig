const std = @import("std");
const xml = @import("xml");
const Database = @import("Database");

const allocator = std.testing.allocator;
const expectEqual = std.testing.expectEqual;

pub fn initDbFromAtdf(text: []const u8) !Database {
    const doc: *xml.Doc = try xml.readFromMemory(text);
    defer xml.freeDoc(doc);

    return try Database.initFromAtdf(allocator, doc);
}

test "correctly generate mmioInt: https://github.com/ZigEmbeddedGroup/regz/issues/6" {
    var db = try initDbFromAtdf(
        \\<avr-tools-device-file>
        \\  <devices>
        \\    <device name="ATmega328P" architecture="AVR8" family="megaAVR">
        \\      <peripherals>
        \\        <module name="USART">
        \\          <instance name="USART0" caption="USART">
        \\            <register-group name="USART0" name-in-module="USART0" offset="0x00" address-space="data" caption="USART"/>
        \\          </instance>
        \\        </module>
        \\      </peripherals>
        \\    </device>
        \\  </devices>
        \\  <modules>
        \\    <module caption="USART" name="USART">
        \\      <register-group caption="USART" name="USART0">
        \\        <register caption="USART Baud Rate Register Bytes" name="UBRR0" offset="0xC4" size="2" mask="0x0FFF"/>
        \\      </register-group>
        \\    </module>
        \\  </modules>
        \\</avr-tools-device-file>
        \\
    );
    defer db.deinit();

    const register_idx = 0;
    const register = try db.getRegister(register_idx);

    // should be 12 and not 16 due to the mask
    try expectEqual(@as(usize, 12), register.size.?);
}
