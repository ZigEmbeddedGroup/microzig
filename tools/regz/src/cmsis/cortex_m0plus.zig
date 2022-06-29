const std = @import("std");
const Database = @import("../Database.zig");
const Register = @import("../Register.zig");
const Field = @import("../Field.zig");
const cortex_m0 = @import("cortex_m0.zig");

pub fn addCoreRegisters(db: *Database, scs: Database.PeripheralIndex) !void {
    try cortex_m0.addNvicCluster(db, scs);

    const scb = try db.addClusterToPeripheral(scs, .{
        .name = "SCB",
        .description = "System Control Block",
        .addr_offset = 0xd00,
    });

    var scb_regs = std.ArrayList(Register).init(db.gpa);
    defer scb_regs.deinit();

    try scb_regs.appendSlice(&.{
        .{
            .name = "CPUID",
            .addr_offset = 0x000,
            .access = .read_only,
        },
        .{
            .name = "ICSR",
            .description = "Interrupt Control and State Register",
            .addr_offset = 0x004,
        },
        .{
            .name = "AIRCR",
            .description = "Application Interrupt and Reset Control Register",
            .addr_offset = 0x00c,
        },
        .{
            .name = "SCR",
            .description = "System Control Register",
            .addr_offset = 0x010,
        },
        .{
            .name = "CCR",
            .description = "Configuration Control Register",
            .addr_offset = 0x014,
        },
        .{
            .name = "SHP",
            .description = "System Handlers Priority Registers. [0] is RESERVED",
            .addr_offset = 0x01c,
            //.dimension = .{
            //    .dim = 2,
            //},
        },
        .{
            .name = "SHCSR",
            .description = "System Handler Control and State Register",
            .addr_offset = 0x024,
        },
    });

    if (db.cpu) |cpu| if (cpu.vtor_present) {
        try scb_regs.append(.{
            .name = "VTOR",
            .description = "Vector Table Offset Register",
            .addr_offset = 0x08,
        });
    };

    var regs = try db.addRegistersToCluster(scb, scb_regs.items);

    const cpuid = regs.begin;
    try db.addFieldsToRegister(cpuid, &.{
        .{ .name = "REVISION", .offset = 0, .width = 4 },
        .{ .name = "PARTNO", .offset = 4, .width = 12 },
        .{ .name = "ARCHITECTURE", .offset = 16, .width = 4 },
        .{ .name = "VARIANT", .offset = 20, .width = 4 },
        .{ .name = "IMPLEMENTER", .offset = 24, .width = 8 },
    });

    const icsr = regs.begin + 1;
    try db.addFieldsToRegister(icsr, &.{
        .{ .name = "VECTACTIVE", .offset = 0, .width = 9 },
        .{ .name = "VECTPENDING", .offset = 12, .width = 9 },
        .{ .name = "ISRPENDING", .offset = 22, .width = 1 },
        .{ .name = "ISRPREEMPT", .offset = 23, .width = 1 },
        .{ .name = "PENDSTCLR", .offset = 25, .width = 1 },
        .{ .name = "PENDSTSET", .offset = 26, .width = 1 },
        .{ .name = "PENDSVCLR", .offset = 27, .width = 1 },
        .{ .name = "PENDSVSET", .offset = 28, .width = 1 },
        .{ .name = "NMIPENDSET", .offset = 31, .width = 1 },
    });

    const aircr = regs.begin + 2;
    try db.addFieldsToRegister(aircr, &.{
        .{ .name = "VECTCLRACTIVE", .offset = 1, .width = 1 },
        .{ .name = "SYSRESETREQ", .offset = 2, .width = 1 },
        .{ .name = "ENDIANESS", .offset = 15, .width = 1 },
        .{ .name = "VECTKEY", .offset = 16, .width = 16 },
    });

    const scr = regs.begin + 3;
    try db.addFieldsToRegister(scr, &.{
        .{ .name = "SLEEPONEXIT", .offset = 1, .width = 1 },
        .{ .name = "SLEEPDEEP", .offset = 2, .width = 1 },
        .{ .name = "SEVONPEND", .offset = 4, .width = 1 },
    });

    const ccr = regs.begin + 4;
    try db.addFieldsToRegister(ccr, &.{
        .{ .name = "UNALIGN_TRP", .offset = 3, .width = 1 },
        .{ .name = "STKALIGN", .offset = 9, .width = 1 },
    });

    const shcsr = regs.begin + 6;
    try db.addFieldsToRegister(shcsr, &.{
        .{ .name = "SVCALLPENDED", .offset = 15, .width = 1 },
    });

    if (db.cpu) |cpu| if (cpu.vtor_present) {
        const vtor = regs.begin + 7;
        try db.addFieldsToRegister(vtor, &.{.{
            .name = "TBLOFF",
            .offset = 8,
            .width = 24,
        }});
    };

    if (db.cpu) |cpu| if (cpu.mpu_present)
        try addMpuRegisters(db, scs);

    try db.addSystemRegisterAddresses(scs, scb, regs);
}

fn addMpuRegisters(db: *Database, scs: Database.PeripheralIndex) !void {
    const mpu = try db.addClusterToPeripheral(scs, .{
        .name = "MPU",
        .description = "Memory Protection Unit",
        .addr_offset = 0xd90,
    });

    const regs = try db.addRegistersToCluster(mpu, &.{
        .{
            .name = "TYPE",
            .description = "MPU Type Register",
            .addr_offset = 0x00,
            .access = .read_only,
        },
        .{
            .name = "CTRL",
            .description = "MPU Control Register",
            .addr_offset = 0x04,
        },
        .{
            .name = "RNR",
            .description = "MPU Region RNRber Register",
            .addr_offset = 0x08,
        },
        .{
            .name = "RBAR",
            .description = "MPU Region Base Address Register",
            .addr_offset = 0x0c,
        },
        .{
            .name = "RASR",
            .description = "MPU Region Attribute and Size Register",
            .addr_offset = 0x10,
        },
    });

    const type_reg = regs.begin;
    try db.addFieldsToRegister(type_reg, &.{
        .{ .name = "SEPARATE", .offset = 0, .width = 1 },
        .{ .name = "DREGION", .offset = 8, .width = 8 },
        .{ .name = "IREGION", .offset = 16, .width = 8 },
    });

    const ctrl = regs.begin + 1;
    try db.addFieldsToRegister(ctrl, &.{
        .{ .name = "ENABLE", .offset = 0, .width = 1 },
        .{ .name = "HFNMIENA", .offset = 1, .width = 1 },
        .{ .name = "PRIVDEFENA", .offset = 2, .width = 1 },
    });

    const rnr = regs.begin + 2;
    try db.addFieldsToRegister(rnr, &.{
        .{ .name = "REGION", .offset = 0, .width = 8 },
    });

    const rbar = regs.begin + 3;
    try db.addFieldsToRegister(rbar, &.{
        .{ .name = "REGION", .offset = 0, .width = 4 },
        .{ .name = "VALID", .offset = 4, .width = 1 },
        .{ .name = "ADDR", .offset = 8, .width = 24 },
    });

    const rasr = regs.begin + 4;
    try db.addFieldsToRegister(rasr, &.{
        .{ .name = "ENABLE", .offset = 0, .width = 1 },
        .{ .name = "SIZE", .offset = 1, .width = 5 },
        .{ .name = "SRD", .offset = 8, .width = 8 },
        .{ .name = "B", .offset = 16, .width = 1 },
        .{ .name = "C", .offset = 17, .width = 1 },
        .{ .name = "S", .offset = 18, .width = 1 },
        .{ .name = "TEX", .offset = 19, .width = 3 },
        .{ .name = "AP", .offset = 24, .width = 3 },
        .{ .name = "XN", .offset = 28, .width = 1 },
    });

    try db.addSystemRegisterAddresses(scs, mpu, regs);
}
