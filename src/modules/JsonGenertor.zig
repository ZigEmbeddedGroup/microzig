const std = @import("std");
const chip = @import("chip");

pub fn main() !void {
    @setEvalBranchQuota(100000);
    var json = std.json.writeStream(std.io.getStdOut().writer(), 20);

    try json.beginObject();
    try json.objectField("version");
    try json.emitString("0.1.0");

    try json.objectField("types");
    try json.beginObject();

    try json.objectField("peripherals");
    try json.beginObject();
    inline for (comptime std.meta.declarations(chip.types)) |peripheral| {
    const peripheral_type = @field(chip.types, peripheral.name);
        try json.objectField(peripheral.name);
        try json.beginObject();

        try json.objectField("description");
        try json.emitString("TODO");

        try json.objectField("children");
        try json.beginObject();

        try json.objectField("registers");
        try json.beginObject();

        inline for (std.meta.fields(peripheral_type)) |register| {
            if (comptime std.mem.startsWith(u8, register.name, "reserved")) continue;
            if (@typeInfo(register.type) == .Array) continue; // TODO

            try json.objectField(register.name);
            try json.beginObject();

            try json.objectField("description");
            try json.emitString("TODO");

            try json.objectField("offset");
            try json.emitNumber(@offsetOf(peripheral_type, register.name));

            try json.objectField("size");
            try json.emitNumber(@bitSizeOf(register.type));

            try json.objectField("reset_value");
            try json.emitNumber(0); // TODO

            try json.objectField("reset_mask");
            try json.emitNumber(0); // TODO

            if (@typeInfo(register.type) == .Struct) {
                try json.objectField("children");
                try json.beginObject();

                try json.objectField("fields");
                try json.beginObject();
                inline for (std.meta.fields(register.type.underlying_type)) |field| {
                    try json.objectField(field.name);
                    try json.beginObject();

                    try json.objectField("description");
                    try json.emitString("TODO");

                    try json.objectField("offset");
                    try json.emitNumber(@bitOffsetOf(register.type.underlying_type, field.name));

                    try json.objectField("size");
                    try json.emitNumber(@bitSizeOf(field.type));

                    try json.endObject(); // field.name
                }
                try json.endObject(); // fields
                try json.endObject(); // children
            }

            try json.endObject(); // register.name
        }
        try json.endObject(); // registers

        try json.endObject(); // children
        try json.endObject(); // peripheral.name
    }
    try json.endObject(); // peripherals
    try json.endObject(); // types

    try json.objectField("devices");
    try json.beginObject();
    inline for (comptime std.meta.declarations(chip.devices)) |device| {
        const device_type = @field(chip.devices, device.name);
        try json.objectField(device.name);
        try json.beginObject();

        try json.objectField("arch");
        try json.emitString("cortex_m3"); // TODO

        try json.objectField("description");
        try json.emitString(device.name);

        try json.objectField("properties");
        try json.beginObject();

        inline for (comptime std.meta.declarations(device_type.properties)) |prop| {
            try json.objectField(prop.name);
            try json.emitString(@field(device_type.properties, prop.name));
        }

        try json.endObject();

        try json.objectField("children");
        try json.beginObject();

        try json.objectField("interrupts");
        try json.beginObject();
        // TODO
        try json.endObject(); // interrupts

        try json.objectField("peripheral_instances");
        try json.beginObject();
        inline for (comptime std.meta.declarations(device_type.peripherals)) |peripheral| {
            const peripheral_type = @field(device_type.peripherals, peripheral.name);
            try json.objectField(peripheral.name);
            try json.beginObject();

            try json.objectField("description");
            try json.emitString("TODO");

            try json.objectField("offset");
            try json.emitNumber(@ptrToInt(peripheral_type));

            try json.objectField("type");
            try json.emitString(@typeName(@TypeOf(peripheral_type))); // TODO

            try json.endObject();
        }
        try json.endObject(); // peripheral_instances

        try json.endObject(); // children

        try json.endObject(); // device.name
    }
    try json.endObject(); // devices

    try json.endObject(); // root
}
