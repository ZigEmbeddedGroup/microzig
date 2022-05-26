const std = @import("std");
const svd = @import("svd.zig");
const Database = @import("Database.zig");

const cores = struct {
    const cortex_m0plus = @import("cmsis/cortex_m0plus.zig");
};

fn addSysTickRegisters(db: *Database, scs: Database.PeripheralIndex) !void {
    const systick = try db.addClusterToPeripheral(scs, .{
        .name = "SysTick",
        .description = "System Tick Timer",
        .addr_offset = 0x10,
    });

    const regs = try db.addRegistersToCluster(systick, &.{
        .{
            .name = "CTRL",
            .description = "SysTick Control and Status Register",
            .addr_offset = 0x0,
        },
        .{
            .name = "LOAD",
            .description = "SysTick Reload Value Register",
            .addr_offset = 0x4,
        },
        .{
            .name = "VAL",
            .description = "SysTick Current Value Register",
            .addr_offset = 0x8,
        },
        .{
            .name = "CALIB",
            .description = "SysTick Calibration Register",
            .access = .read_only,
            .addr_offset = 0xc,
        },
    });

    const ctrl = regs.begin;
    try db.addFieldsToRegister(ctrl, &.{
        .{ .name = "ENABLE", .offset = 0, .width = 1 },
        .{ .name = "TICKINT", .offset = 1, .width = 1 },
        .{ .name = "CLKSOURCE", .offset = 2, .width = 1 },
        .{ .name = "COUNTFLAG", .offset = 16, .width = 1 },
    });

    const load = regs.begin + 1;
    try db.addFieldsToRegister(load, &.{
        .{ .name = "RELOAD", .offset = 0, .width = 24 },
    });

    const val = regs.begin + 2;
    try db.addFieldsToRegister(val, &.{
        .{ .name = "CURRENT", .offset = 0, .width = 24 },
    });

    const calib = regs.begin + 3;
    try db.addFieldsToRegister(calib, &.{
        .{ .name = "TENMS", .offset = 0, .width = 24 },
        .{ .name = "SKEW", .offset = 30, .width = 1 },
        .{ .name = "NOREF", .offset = 31, .width = 1 },
    });
}

pub fn addCoreRegisters(db: *Database, cpu_name: svd.CpuName) !void {
    const scs = @intCast(Database.PeripheralIndex, db.peripherals.items.len);
    try db.peripherals.append(db.gpa, .{
        .name = "SCS",
        .version = null,
        .description = "System Control Space",
        .base_addr = 0xe000e000,
    });
    try db.register_properties.peripheral.size.put(db.gpa, scs, 32);

    if (db.cpu) |cpu| if (!cpu.vendor_systick_config)
        try addSysTickRegisters(db, scs);

    inline for (@typeInfo(cores).Struct.decls) |decl|
        if (cpu_name == @field(svd.CpuName, decl.name))
            try @field(cores, decl.name).addCoreRegisters(db, scs);
}
