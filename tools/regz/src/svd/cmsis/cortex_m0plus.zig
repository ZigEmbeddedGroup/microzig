const std = @import("std");
const Database = @import("../../Database.zig");
const EntityId = Database.EntityId;
const cortex_m0 = @import("cortex_m0.zig");

pub const add_nvic_fields = cortex_m0.add_nvic_fields;

pub fn add_core_registers(db: *Database, device_id: EntityId, scs: EntityId) !void {
    const scb = try db.create_register_group(scs, .{
        .name = "SCB",
        .description = "System Control Block",
    });
    _ = try db.create_peripheral_instance(device_id, scs, .{
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

    if (db.instances.devices.get(device_id)) |cpu| if (cpu.properties.get("cpu.vtor") != null) {
        const vtor = try db.create_register(scb, .{
            .name = "VTOR",
            .description = "Vector Table Offset Register",
            .offset = 0x08,
            .size = 32,
        });

        _ = try db.create_field(vtor, .{
            .name = "TBLOFF",
            .offset = 8,
            .size = 24,
        });
    };

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

    try cortex_m0.add_nvic_cluster(db, device_id, scs);

    if (db.instances.devices.get(device_id)) |cpu| if (cpu.properties.get("cpu.mpu") != null)
        try add_mpu_registers(db, device_id, scs);
}

fn add_mpu_registers(db: *Database, device_id: EntityId, scs: EntityId) !void {
    const mpu = try db.create_register_group(scs, .{
        .name = "MPU",
        .description = "Memory Protection Unit",
    });
    _ = try db.create_peripheral_instance(device_id, scs, .{
        .name = "MPU",
        .offset = 0xd90,
    });

    const type_reg = try db.create_register(mpu, .{
        .name = "TYPE",
        .description = "MPU Type Register",
        .offset = 0x00,
        .access = .read_only,
        .size = 32,
    });
    const ctrl = try db.create_register(mpu, .{
        .name = "CTRL",
        .description = "MPU Control Register",
        .offset = 0x04,
        .size = 32,
    });
    const rnr = try db.create_register(mpu, .{
        .name = "RNR",
        .description = "MPU Region RNRber Register",
        .offset = 0x08,
        .size = 32,
    });
    const rbar = try db.create_register(mpu, .{
        .name = "RBAR",
        .description = "MPU Region Base Address Register",
        .offset = 0x0c,
        .size = 32,
    });
    const rasr = try db.create_register(mpu, .{
        .name = "RASR",
        .description = "MPU Region Attribute and Size Register",
        .offset = 0x10,
        .size = 32,
    });

    _ = try db.create_field(type_reg, .{ .name = "SEPARATE", .offset = 0, .size = 1 });
    _ = try db.create_field(type_reg, .{ .name = "DREGION", .offset = 8, .size = 8 });
    _ = try db.create_field(type_reg, .{ .name = "IREGION", .offset = 16, .size = 8 });

    _ = try db.create_field(ctrl, .{ .name = "ENABLE", .offset = 0, .size = 1 });
    _ = try db.create_field(ctrl, .{ .name = "HFNMIENA", .offset = 1, .size = 1 });
    _ = try db.create_field(ctrl, .{ .name = "PRIVDEFENA", .offset = 2, .size = 1 });

    _ = try db.create_field(rnr, .{ .name = "REGION", .offset = 0, .size = 8 });

    _ = try db.create_field(rbar, .{ .name = "REGION", .offset = 0, .size = 4 });
    _ = try db.create_field(rbar, .{ .name = "VALID", .offset = 4, .size = 1 });
    _ = try db.create_field(rbar, .{ .name = "ADDR", .offset = 8, .size = 24 });

    _ = try db.create_field(rasr, .{ .name = "ENABLE", .offset = 0, .size = 1 });
    _ = try db.create_field(rasr, .{ .name = "SIZE", .offset = 1, .size = 5 });
    _ = try db.create_field(rasr, .{ .name = "SRD", .offset = 8, .size = 8 });
    _ = try db.create_field(rasr, .{ .name = "B", .offset = 16, .size = 1 });
    _ = try db.create_field(rasr, .{ .name = "C", .offset = 17, .size = 1 });
    _ = try db.create_field(rasr, .{ .name = "S", .offset = 18, .size = 1 });
    _ = try db.create_field(rasr, .{ .name = "TEX", .offset = 19, .size = 3 });
    _ = try db.create_field(rasr, .{ .name = "AP", .offset = 24, .size = 3 });
    _ = try db.create_field(rasr, .{ .name = "XN", .offset = 28, .size = 1 });
}
