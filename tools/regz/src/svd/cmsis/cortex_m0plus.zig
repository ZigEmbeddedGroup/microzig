const std = @import("std");
const Database = @import("../../Database.zig");
const EntityId = Database.EntityId;
const cortex_m0 = @import("cortex_m0.zig");

pub const addNvicFields = cortex_m0.addNvicFields;

pub fn addCoreRegisters(db: *Database, device_id: EntityId, scs: EntityId) !void {
    const scb = try db.createRegisterGroup(scs, .{
        .name = "SCB",
        .description = "System Control Block",
    });
    _ = try db.createPeripheralInstance(device_id, scs, .{
        .name = "SCB",
        .offset = 0xe000ed00,
    });

    const cpuid = try db.createRegister(scb, .{
        .name = "CPUID",
        .offset = 0x000,
        .access = .read_only,
        .size = 32,
    });
    const icsr = try db.createRegister(scb, .{
        .name = "ICSR",
        .description = "Interrupt Control and State Register",
        .offset = 0x004,
        .size = 32,
    });
    const aircr = try db.createRegister(scb, .{
        .name = "AIRCR",
        .description = "Application Interrupt and Reset Control Register",
        .offset = 0x00c,
        .size = 32,
    });
    const scr = try db.createRegister(scb, .{
        .name = "SCR",
        .description = "System Control Register",
        .offset = 0x010,
        .size = 32,
    });
    const ccr = try db.createRegister(scb, .{
        .name = "CCR",
        .description = "Configuration Control Register",
        .offset = 0x014,
        .size = 32,
    });
    const shp = try db.createRegister(scb, .{
        .name = "SHP",
        .description = "System Handlers Priority Registers. [0] is RESERVED",
        .offset = 0x01c,
        .size = 32,
        //.dimension = .{
        //    .dim = 2,
        //},
    });
    _ = shp;
    const shcsr = try db.createRegister(scb, .{
        .name = "SHCSR",
        .description = "System Handler Control and State Register",
        .offset = 0x024,
        .size = 32,
    });

    if (db.instances.devices.get(device_id)) |cpu| if (cpu.properties.get("cpu.vtor") != null) {
        const vtor = try db.createRegister(scb, .{
            .name = "VTOR",
            .description = "Vector Table Offset Register",
            .offset = 0x08,
            .size = 32,
        });

        _ = try db.createField(vtor, .{
            .name = "TBLOFF",
            .offset = 8,
            .size = 24,
        });
    };

    // CPUID fields
    _ = try db.createField(cpuid, .{ .name = "REVISION", .offset = 0, .size = 4 });
    _ = try db.createField(cpuid, .{ .name = "PARTNO", .offset = 4, .size = 12 });
    _ = try db.createField(cpuid, .{ .name = "ARCHITECTURE", .offset = 16, .size = 4 });
    _ = try db.createField(cpuid, .{ .name = "VARIANT", .offset = 20, .size = 4 });
    _ = try db.createField(cpuid, .{ .name = "IMPLEMENTER", .offset = 24, .size = 8 });

    // ICSR fields
    _ = try db.createField(icsr, .{ .name = "VECTACTIVE", .offset = 0, .size = 9 });
    _ = try db.createField(icsr, .{ .name = "VECTPENDING", .offset = 12, .size = 9 });
    _ = try db.createField(icsr, .{ .name = "ISRPENDING", .offset = 22, .size = 1 });
    _ = try db.createField(icsr, .{ .name = "ISRPREEMPT", .offset = 23, .size = 1 });
    _ = try db.createField(icsr, .{ .name = "PENDSTCLR", .offset = 25, .size = 1 });
    _ = try db.createField(icsr, .{ .name = "PENDSTSET", .offset = 26, .size = 1 });
    _ = try db.createField(icsr, .{ .name = "PENDSVCLR", .offset = 27, .size = 1 });
    _ = try db.createField(icsr, .{ .name = "PENDSVSET", .offset = 28, .size = 1 });
    _ = try db.createField(icsr, .{ .name = "NMIPENDSET", .offset = 31, .size = 1 });

    // AIRCR fields
    _ = try db.createField(aircr, .{ .name = "VECTCLRACTIVE", .offset = 1, .size = 1 });
    _ = try db.createField(aircr, .{ .name = "SYSRESETREQ", .offset = 2, .size = 1 });
    _ = try db.createField(aircr, .{ .name = "ENDIANESS", .offset = 15, .size = 1 });
    _ = try db.createField(aircr, .{ .name = "VECTKEY", .offset = 16, .size = 16 });

    // SCR fields
    _ = try db.createField(scr, .{ .name = "SLEEPONEXIT", .offset = 1, .size = 1 });
    _ = try db.createField(scr, .{ .name = "SLEEPDEEP", .offset = 2, .size = 1 });
    _ = try db.createField(scr, .{ .name = "SEVONPEND", .offset = 4, .size = 1 });

    // CCR fields
    _ = try db.createField(ccr, .{ .name = "UNALIGN_TRP", .offset = 3, .size = 1 });
    _ = try db.createField(ccr, .{ .name = "STKALIGN", .offset = 9, .size = 1 });

    // SHCSR fields
    _ = try db.createField(shcsr, .{ .name = "SVCALLPENDED", .offset = 15, .size = 1 });

    try cortex_m0.addNvicCluster(db, device_id, scs);

    if (db.instances.devices.get(device_id)) |cpu| if (cpu.properties.get("cpu.mpu") != null)
        try addMpuRegisters(db, device_id, scs);
}

fn addMpuRegisters(db: *Database, device_id: EntityId, scs: EntityId) !void {
    const mpu = try db.createRegisterGroup(scs, .{
        .name = "MPU",
        .description = "Memory Protection Unit",
    });
    _ = try db.createPeripheralInstance(device_id, scs, .{
        .name = "MPU",
        .offset = 0xd90,
    });

    const type_reg = try db.createRegister(mpu, .{
        .name = "TYPE",
        .description = "MPU Type Register",
        .offset = 0x00,
        .access = .read_only,
        .size = 32,
    });
    const ctrl = try db.createRegister(mpu, .{
        .name = "CTRL",
        .description = "MPU Control Register",
        .offset = 0x04,
        .size = 32,
    });
    const rnr = try db.createRegister(mpu, .{
        .name = "RNR",
        .description = "MPU Region RNRber Register",
        .offset = 0x08,
        .size = 32,
    });
    const rbar = try db.createRegister(mpu, .{
        .name = "RBAR",
        .description = "MPU Region Base Address Register",
        .offset = 0x0c,
        .size = 32,
    });
    const rasr = try db.createRegister(mpu, .{
        .name = "RASR",
        .description = "MPU Region Attribute and Size Register",
        .offset = 0x10,
        .size = 32,
    });

    _ = try db.createField(type_reg, .{ .name = "SEPARATE", .offset = 0, .size = 1 });
    _ = try db.createField(type_reg, .{ .name = "DREGION", .offset = 8, .size = 8 });
    _ = try db.createField(type_reg, .{ .name = "IREGION", .offset = 16, .size = 8 });

    _ = try db.createField(ctrl, .{ .name = "ENABLE", .offset = 0, .size = 1 });
    _ = try db.createField(ctrl, .{ .name = "HFNMIENA", .offset = 1, .size = 1 });
    _ = try db.createField(ctrl, .{ .name = "PRIVDEFENA", .offset = 2, .size = 1 });

    _ = try db.createField(rnr, .{ .name = "REGION", .offset = 0, .size = 8 });

    _ = try db.createField(rbar, .{ .name = "REGION", .offset = 0, .size = 4 });
    _ = try db.createField(rbar, .{ .name = "VALID", .offset = 4, .size = 1 });
    _ = try db.createField(rbar, .{ .name = "ADDR", .offset = 8, .size = 24 });

    _ = try db.createField(rasr, .{ .name = "ENABLE", .offset = 0, .size = 1 });
    _ = try db.createField(rasr, .{ .name = "SIZE", .offset = 1, .size = 5 });
    _ = try db.createField(rasr, .{ .name = "SRD", .offset = 8, .size = 8 });
    _ = try db.createField(rasr, .{ .name = "B", .offset = 16, .size = 1 });
    _ = try db.createField(rasr, .{ .name = "C", .offset = 17, .size = 1 });
    _ = try db.createField(rasr, .{ .name = "S", .offset = 18, .size = 1 });
    _ = try db.createField(rasr, .{ .name = "TEX", .offset = 19, .size = 3 });
    _ = try db.createField(rasr, .{ .name = "AP", .offset = 24, .size = 3 });
    _ = try db.createField(rasr, .{ .name = "XN", .offset = 28, .size = 1 });
}
