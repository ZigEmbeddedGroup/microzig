const std = @import("std");
const xml = @import("xml");
const Database = @import("Database");

const allocator = std.testing.allocator;
const expectEqual = std.testing.expectEqual;

pub fn initDbFromSvd(text: []const u8) !Database {
    const doc: *xml.Doc = try xml.readFromMemory(text);
    defer xml.freeDoc(doc);

    return try Database.initFromSvd(allocator, doc);
}

test "cmsis example" {
    var db = try initDbFromSvd(@embedFile("svd/cmsis-example.svd"));
    defer db.deinit();

    // CPU is not populated in this svd file
    try expectEqual(@as(@TypeOf(db.cpu), null), db.cpu);
}

test "register.size from device" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>42</size>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>test</name>
        \\          <addressOffset>0x0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
        \\
    );
    defer db.deinit();

    const register_idx = 0;
    const register = try db.getRegister(register_idx);

    try expectEqual(@as(usize, 42), register.size.?);
}

test "register.size from peripheral" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <size>42</size>
        \\      <registers>
        \\        <register>
        \\          <name>test</name>
        \\          <addressOffset>0x0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
        \\
    );
    defer db.deinit();

    const register_idx = 0;
    const register = try db.getRegister(register_idx);

    try expectEqual(@as(usize, 42), register.size.?);
}

test "register.size from cluster" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <cluster>
        \\          <name>bruh</name>
        \\          <size>42</size>
        \\          <addressOffset>0x0</addressOffset>
        \\          <register>
        \\            <name>test</name>
        \\            <addressOffset>0x0</addressOffset>
        \\          </register>
        \\        </cluster>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
        \\
    );
    defer db.deinit();

    const register_idx = 0;
    const register = try db.getRegister(register_idx);

    try expectEqual(@as(usize, 42), register.size.?);
}

// TODO: nested cluster

test "register.size from register" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>test</name>
        \\          <addressOffset>0x0</addressOffset>
        \\          <size>42</size>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
        \\
    );
    defer db.deinit();

    const register_idx = 0;
    const register = try db.getRegister(register_idx);

    try expectEqual(@as(usize, 42), register.size.?);
}

// TODO: the way this is architected we'd see the error in the code generation side of things
//test "register.size missing" {
//    try std.testing.expectError(error.SizeNotFound, initDbFromSvd(
//        \\<device>
//        \\  <name>ARMCM3xxx</name>
//        \\  <addressUnitBits>8</addressUnitBits>
//        \\  <width>32</width>
//        \\  <peripherals>
//        \\    <peripheral>
//        \\      <name>TIMER0</name>
//        \\      <baseAddress>0x40010000</baseAddress>
//        \\      <registers>
//        \\        <register>
//        \\          <name>test</name>
//        \\          <addressOffset>0x0</addressOffset>
//        \\        </register>
//        \\      </registers>
//        \\    </peripheral>
//        \\  </peripherals>
//        \\</device>
//        \\
//    ));
//}

//test "register.access" {}
// TODO: figure out if `protection` is interesting/important for us
//test "register.reset_value" {}
//test "register.reset_mask" {}
