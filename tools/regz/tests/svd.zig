const std = @import("std");
const xml = @import("xml");
const Database = @import("Database");

const allocator = std.testing.allocator;
const expectEqual = std.testing.expectEqual;
const Access = Database.Access;

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

// TODO: is getting the size from the width as a last resort correct?
test "register.size from device.size" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>42</width>
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

test "register.size from nested cluster" {
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
        \\          <addressOffset>0x0</addressOffset>
        \\          <cluster>
        \\            <name>bruh2</name>
        \\            <addressOffset>0x0</addressOffset>
        \\            <size>42</size>
        \\            <register>
        \\              <name>test</name>
        \\              <addressOffset>0x0</addressOffset>
        \\            </register>
        \\          </cluster>
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

test "register.access from device" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <access>read-write</access>
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

    try expectEqual(Access.read_write, register.access.?);
}

test "register.access from peripheral" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <access>read-write</access>
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

    try expectEqual(Access.read_write, register.access.?);
}

test "register.access from cluster" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <cluster>
        \\          <name>bruh</name>
        \\          <addressOffset>0x0</addressOffset>
        \\          <access>read-write</access>
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

    try expectEqual(Access.read_write, register.access.?);
}

test "register.access from nested cluster" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <cluster>
        \\          <name>bruh</name>
        \\          <addressOffset>0x0</addressOffset>
        \\          <cluster>
        \\            <name>bruh2</name>
        \\            <addressOffset>0x0</addressOffset>
        \\            <access>read-write</access>
        \\            <register>
        \\              <name>test</name>
        \\              <addressOffset>0x0</addressOffset>
        \\            </register>
        \\          </cluster>
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

    try expectEqual(Access.read_write, register.access.?);
}

test "register.access from register" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>test</name>
        \\          <addressOffset>0x0</addressOffset>
        \\          <size>42</size>
        \\          <access>read-write</access>
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

    try expectEqual(Access.read_write, register.access.?);
}

// TODO: determine if assuming read-write by default is okay
test "register.access missing" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
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

    try expectEqual(Access.read_write, register.access.?);
}

test "field.access" {
    var db = try initDbFromSvd(
        \\<device>
        \\  <name>ARMCM3xxx</name>
        \\  <addressUnitBits>8</addressUnitBits>
        \\  <width>32</width>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TIMER0</name>
        \\      <baseAddress>0x40010000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>test</name>
        \\          <addressOffset>0x0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>field</name>
        \\              <access>read-only</access>
        \\              <bitRange>[0:0]</bitRange>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
        \\
    );
    defer db.deinit();

    try expectEqual(Access.read_only, db.field_access.get(0).?);
}

//test "register.access" {}
// TODO: figure out if `protection` is interesting/important for us
//test "register.reset_value" {}
//test "register.reset_mask" {}
