//! NVIC Registers
//!
//! ╔════════╦══════════╦═══╦═══╦═══════╦══════╦════════╦══════════════════════════════════╦═╦════╦═════╦════╦═════╦════╦════╦═════╦═════╦══════╦═════╦══════════╦══════════╦═══════╦════════╗
//! ║ Offset ║ Register ║ R ║ W ║ Field ║ With ║ Offset ║ Description                      ║ ║ M0 ║ M0+ ║ M1 ║ M3  ║ M4 ║ M7 ║ M23 ║ M33 ║ M35P ║ M55 ║ ARMV8MBL ║ ARMV8MML ║ SC000 ║ SC3000 ║
//! ╠════════╬══════════╬═══╬═══╬═══════╬══════╬════════╬══════════════════════════════════╬═╬════╩═════╩════╩═════╩════╩════╩═════╩═════╩══════╩═════╩══════════╩══════════╩═══════╩════════╣
//! ║ 0x0000 ║ ISER     ║ X ║ X ║       ║      ║        ║ Interrupt Set Enable Register    ║ ║ X    X     X    X     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║ 0x0080 ║ ICER     ║ X ║ X ║       ║      ║        ║ Interrupt Clear Enable Register  ║ ║ X    X     X    X     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║ 0x0100 ║ ISPR     ║ X ║ X ║       ║      ║        ║ Interrupt Set Pending Register   ║ ║ X    X     X    X     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║ 0x0180 ║ ICPR     ║ X ║ X ║       ║      ║        ║ Interrupt Clear Pending Register ║ ║ X    X     X    X     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║ 0x0200 ║ IABR     ║   ║   ║       ║      ║        ║ Interrupt Priority Register      ║ ║                 8     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║ 0x0300 ║ IP       ║ X ║ X ║       ║      ║        ║                                  ║ ║ 8    8     8    240   ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║ 0x0E00 ║ STIR     ║   ║   ║       ║      ║        ║                                  ║ ║                 X     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ║        ║          ║   ║   ║ INTID ║ 9    ║ 0      ║                                  ║ ║                 X     ?    ?    ?     ?     ?      ?     ?          ?          ?       ?      ║
//! ╚════════╩══════════╩═══╩═══╩═══════╩══════╩════════╩══════════════════════════════════╩═╩═══════════════════════════════════════════════════════════════════════════════════════════════╝

const std = @import("std");
const Database = @import("../../Database.zig");
const EntityId = Database.EntityId;

pub const address = 0xe000e100;

// deletes an existing NVIC peripheral if it has one. This is because the
// registers we'll generate are better :)
//
// assumes if the device has interrupts, they've been loaded
pub fn load(db: *Database, device_id: EntityId) !void {
    const device = db.instances.devices.get(device_id).?;
    if (!device.arch.is_arm())
        return;

    switch (device.arch) {
        .cortex_m0, .cortex_m0plus, .cortex_m1 => {},
        else => {
            std.log.warn("TODO: implement NVIC register generation for '{}'", .{device.arch});
            return;
        },
    }

    const nvic = try db.create_peripheral(.{
        .name = "NVIC",
        .description = "Nested Vectored Interrupt Controller",
    });

    _ = try db.create_peripheral_instance(device_id, nvic, .{
        .name = "NVIC",
        .offset = address,
    });

    // TODO: behavior is different for cortex-m3/4/7, probably the others too
    const interrupt_registers = [_]EntityId{
        try db.create_register(nvic, .{ .name = "ISER", .offset = 0x000, .size = 32, .description = "Interrupt Set Enable Register" }),
        try db.create_register(nvic, .{ .name = "ICER", .offset = 0x080, .size = 32, .description = "Interrupt Clear Enable Register" }),
        try db.create_register(nvic, .{ .name = "ISPR", .offset = 0x100, .size = 32, .description = "Interrupt Set Pending Register" }),
        try db.create_register(nvic, .{ .name = "ICPR", .offset = 0x180, .size = 32, .description = "Interrupt Clear Pending Register" }),
    };

    // TODO: generate IP if any of the above fail, like nvicPrioBits is missing

    // interrupt priority registers
    if (device.properties.get("cpu.nvicPrioBits")) |bits| if (try std.fmt.parseInt(u32, bits, 10) > 0) {
        const ip_addr_offset = 0x300;

        var i: u32 = 0;
        while (i < 8) : (i += 1) {
            const addr_offset = ip_addr_offset + (i * 4);
            const reg_name = try std.fmt.allocPrint(db.arena.allocator(), "IP{}", .{i});

            _ = try db.create_register(nvic, .{
                .name = reg_name,
                .description = "Interrupt Priority Register",
                .offset = addr_offset,
                .size = 32,
            });
        }
    };

    // fields for basic registers
    const interrupts = db.instances.interrupts;
    for (interrupts.keys(), interrupts.values()) |interrupt_id, interrupt_index| {
        if (interrupt_index < 0)
            continue;

        const interrupt_name = db.attrs.name.get(interrupt_id).?;
        for (interrupt_registers) |register| {
            _ = try db.create_field(register, .{
                .name = interrupt_name,
                .offset = @bitCast(u32, interrupt_index),
                .size = 1,
            });
        }

        const nvic_prio_bits = try std.fmt.parseInt(
            u32,
            device.properties.get("cpu.nvicPrioBits") orelse return error.MissingNvicPrioBits,
            10,
        );
        if (nvic_prio_bits == 0) continue;

        const reg_name = try std.fmt.allocPrint(db.arena.allocator(), "IP{}", .{interrupt_index >> 2});
        const reg_id = try db.get_entity_id_by_name("type.register", reg_name);
        _ = try db.create_field(reg_id, .{
            .name = interrupt_name,
            .offset = (8 * (@intCast(u8, interrupt_index) % 4)) + (8 - nvic_prio_bits),
            .size = nvic_prio_bits,
        });
    }

    // TODO: cpu module specific NVIC registers

    // destroy registers that line up with NVIC registers
    var unique_peripherals = std.ArrayList(EntityId).init(db.gpa);
    defer unique_peripherals.deinit();

    for (db.types.peripherals.keys()) |peripheral_id| outer: {
        var unique_instance_id: ?EntityId = null;
        const instances = db.instances.peripherals;
        for (instances.keys(), instances.values()) |instance_id, type_id| {
            if (type_id == peripheral_id) {
                if (type_id == nvic)
                    break :outer;

                if (unique_instance_id == null) {
                    unique_instance_id = instance_id;
                } else break :outer;
            }
        }

        // every peripheral type should have an instance
        try unique_peripherals.append(unique_instance_id.?);
    }

    // Put together a hit list of register addresses
    var hit_list = std.AutoArrayHashMap(u64, void).init(db.gpa);
    defer hit_list.deinit();

    for (db.children.registers.get(nvic).?.keys()) |child_id| {
        if (db.attrs.offset.get(child_id)) |register_offset| {
            std.log.debug("hit_list entry: 0x{x}", .{address + register_offset});
            try hit_list.put(address + register_offset, {});
        }
    }

    var destroy_list = std.AutoArrayHashMap(EntityId, void).init(db.gpa);
    defer destroy_list.deinit();

    for (unique_peripherals.items) |instance_id| {
        const peripheral_id = db.instances.peripherals.get(instance_id).?;
        const instance_offset = db.attrs.offset.get(instance_id).?;
        const children = db.children.registers.get(peripheral_id) orelse continue;
        for (children.keys()) |register_id| {
            const register_offset = db.attrs.offset.get(register_id) orelse continue;
            if (hit_list.contains(instance_offset + register_offset))
                try destroy_list.put(register_id, {});
        }
    }

    for (destroy_list.keys()) |register_id|
        db.destroy_entity(register_id);
}
