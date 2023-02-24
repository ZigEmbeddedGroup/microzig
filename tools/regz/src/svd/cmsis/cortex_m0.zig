const std = @import("std");
const Database = @import("../../Database.zig");
const EntityId = Database.EntityId;

const parseInt = std.fmt.parseInt;

pub fn add_core_registers(db: *Database, device_id: EntityId, scs_id: EntityId) !void {
    try add_nvic_cluster(db, device_id, scs_id);
    try add_scb_cluster(db, device_id, scs_id);
}

pub fn add_nvic_cluster(db: *Database, device_id: EntityId, scs_id: EntityId) !void {
    const nvic = try db.create_register_group(scs_id, .{
        .name = "NVIC",
        .description = "Nested Vectored Interrupt Controller",
    });
    _ = try db.create_peripheral_instance(device_id, scs_id, .{
        .name = "NVIC",
        .offset = 0xe000e100,
    });

    _ = try db.create_register(nvic, .{
        .name = "ISER",
        .description = "Interrupt Set Enable Register",
        .offset = 0x000,
        .size = 32,
    });
    _ = try db.create_register(nvic, .{
        .name = "ICER",
        .description = "Interrupt Clear Enable Register",
        .offset = 0x080,
        .size = 32,
    });
    _ = try db.create_register(nvic, .{
        .name = "ISPR",
        .description = "Interrupt Set Pending Register",
        .offset = 0x100,
        .size = 32,
    });
    _ = try db.create_register(nvic, .{
        .name = "ICPR",
        .description = "Interrupt Clear Pending Register",
        .offset = 0x180,
        .size = 32,
    });

    // interrupt priority registers
    if (db.instances.devices.get(device_id)) |cpu|
        if (cpu.properties.get("cpu.nvic_prio_bits")) |bits| if (try parseInt(u32, bits, 10) > 0) {
            const ip_addr_offset = 0x300;

            var i: u32 = 0;
            while (i < 8) : (i += 1) {
                const addr_offset = ip_addr_offset + (i * 4);
                const reg_name = try std.fmt.allocPrint(db.arena.allocator(), "IPR{}", .{i});

                _ = try db.create_register(nvic, .{
                    .name = reg_name,
                    .description = "Interrupt Priority Register",
                    .offset = addr_offset,
                    .size = 32,
                });
            }
        };
}

pub fn add_nvic_fields(db: *Database, device_id: EntityId) !void {
    const interrupt_registers: [4]EntityId = .{
        try db.get_entity_id_by_name("type.register", "ISER"),
        try db.get_entity_id_by_name("type.register", "ICER"),
        try db.get_entity_id_by_name("type.register", "ISPR"),
        try db.get_entity_id_by_name("type.register", "ICPR"),
    };

    var interrupt_iter = db.instances.interrupts.iterator();
    while (interrupt_iter.next()) |interrupt_kv| {
        if (interrupt_kv.value_ptr.* < 0) continue;

        const interrupt_name = db.attrs.name.get(interrupt_kv.key_ptr.*).?;
        const interrupt_index = @bitCast(u32, interrupt_kv.value_ptr.*);
        for (interrupt_registers) |register| {
            _ = try db.create_field(register, .{
                .name = interrupt_name,
                .offset = interrupt_index,
                .size = 1,
            });
        }

        const nvic_prio_bits = try parseInt(
            u32,
            db.instances.devices.get(device_id).?.properties.get("cpu.nvic_prio_bits") orelse return error.MissingNvicPrioBits,
            10,
        );
        if (nvic_prio_bits == 0) continue;

        const reg_name = try std.fmt.allocPrint(db.arena.allocator(), "IPR{}", .{interrupt_index >> 2});
        const reg_id = try db.get_entity_id_by_name("type.register", reg_name);

        _ = try db.create_field(reg_id, .{
            .name = interrupt_name,
            .offset = (8 * (@intCast(u8, interrupt_index) % 4)) + (8 - nvic_prio_bits),
            .size = nvic_prio_bits,
        });
    }
}

pub fn add_scb_cluster(db: *Database, device_id: EntityId, scs_id: EntityId) !void {
    const scb = try db.create_register_group(scs_id, .{
        .name = "SCB",
        .description = "System Control Block",
    });
    _ = try db.create_peripheral_instance(device_id, scs_id, .{
        .name = "SCB",
        .offset = 0xe000ed00,
    });

    const cpuid = try db.create_register(scb, .{
        .name = "CPUID",
        .offset = 0x000,
        .access = .read_only,
        .size = 32,
    });
    const icsr = try db.create_register(scb, .{
        .name = "ICSR",
        .description = "Interrupt Control and State Register",
        .offset = 0x004,
        .size = 32,
    });
    const aircr = try db.create_register(scb, .{
        .name = "AIRCR",
        .description = "Application Interrupt and Reset Control Register",
        .offset = 0x00c,
        .size = 32,
    });
    const scr = try db.create_register(scb, .{
        .name = "SCR",
        .description = "System Control Register",
        .offset = 0x010,
        .size = 32,
    });
    const ccr = try db.create_register(scb, .{
        .name = "CCR",
        .description = "Configuration Control Register",
        .offset = 0x014,
        .size = 32,
    });
    const shp = try db.create_register(scb, .{
        .name = "SHP",
        .description = "System Handlers Priority Registers. [0] is RESERVED",
        .offset = 0x01c,
        .size = 32,
        //.dimension = .{
        //    .dim = 2,
        //},
    });
    _ = shp;
    const shcsr = try db.create_register(scb, .{
        .name = "SHCSR",
        .description = "System Handler Control and State Register",
        .offset = 0x024,
        .size = 32,
    });

    // CPUID fields
    _ = try db.create_field(cpuid, .{ .name = "REVISION", .offset = 0, .size = 4 });
    _ = try db.create_field(cpuid, .{ .name = "PARTNO", .offset = 4, .size = 12 });
    _ = try db.create_field(cpuid, .{ .name = "ARCHITECTURE", .offset = 16, .size = 4 });
    _ = try db.create_field(cpuid, .{ .name = "VARIANT", .offset = 20, .size = 4 });
    _ = try db.create_field(cpuid, .{ .name = "IMPLEMENTER", .offset = 24, .size = 8 });

    // ICSR fields
    _ = try db.create_field(icsr, .{ .name = "VECTACTIVE", .offset = 0, .size = 9 });
    _ = try db.create_field(icsr, .{ .name = "VECTPENDING", .offset = 12, .size = 9 });
    _ = try db.create_field(icsr, .{ .name = "ISRPENDING", .offset = 22, .size = 1 });
    _ = try db.create_field(icsr, .{ .name = "ISRPREEMPT", .offset = 23, .size = 1 });
    _ = try db.create_field(icsr, .{ .name = "PENDSTCLR", .offset = 25, .size = 1 });
    _ = try db.create_field(icsr, .{ .name = "PENDSTSET", .offset = 26, .size = 1 });
    _ = try db.create_field(icsr, .{ .name = "PENDSVCLR", .offset = 27, .size = 1 });
    _ = try db.create_field(icsr, .{ .name = "PENDSVSET", .offset = 28, .size = 1 });
    _ = try db.create_field(icsr, .{ .name = "NMIPENDSET", .offset = 31, .size = 1 });

    // AIRCR fields
    _ = try db.create_field(aircr, .{ .name = "VECTCLRACTIVE", .offset = 1, .size = 1 });
    _ = try db.create_field(aircr, .{ .name = "SYSRESETREQ", .offset = 2, .size = 1 });
    _ = try db.create_field(aircr, .{ .name = "ENDIANESS", .offset = 15, .size = 1 });
    _ = try db.create_field(aircr, .{ .name = "VECTKEY", .offset = 16, .size = 16 });

    // SCR fields
    _ = try db.create_field(scr, .{ .name = "SLEEPONEXIT", .offset = 1, .size = 1 });
    _ = try db.create_field(scr, .{ .name = "SLEEPDEEP", .offset = 2, .size = 1 });
    _ = try db.create_field(scr, .{ .name = "SEVONPEND", .offset = 4, .size = 1 });

    // CCR fields
    _ = try db.create_field(ccr, .{ .name = "UNALIGN_TRP", .offset = 3, .size = 1 });
    _ = try db.create_field(ccr, .{ .name = "STKALIGN", .offset = 9, .size = 1 });

    // SHCSR fields
    _ = try db.create_field(shcsr, .{ .name = "SVCALLPENDED", .offset = 15, .size = 1 });
}
