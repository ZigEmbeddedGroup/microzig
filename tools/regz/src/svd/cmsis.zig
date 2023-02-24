const std = @import("std");
const svd = @import("../svd.zig");
const Database = @import("../Database.zig");
const EntityId = Database.EntityId;

const cores = struct {
    const cortex_m0 = @import("cmsis/cortex_m0.zig");
    const cortex_m0plus = @import("cmsis/cortex_m0plus.zig");
    const cortex_m1 = @import("cmsis/cortex_m1.zig");
};

fn add_systick_registers(db: *Database, device_id: EntityId, scs_id: EntityId) !void {
    const systick_type = try db.create_register_group(scs_id, .{
        .name = "SysTick",
        .description = "System Tick Timer",
    });
    _ = try db.create_peripheral_instance(device_id, systick_type, .{
        .name = "SysTick",
        .offset = 0xe000e010,
    });

    const ctrl_id = try db.create_register(systick_type, .{
        .name = "CTRL",
        .description = "SysTick Control and Status Register",
        .offset = 0x0,
        .size = 32,
    });
    const load_id = try db.create_register(systick_type, .{
        .name = "LOAD",
        .description = "SysTick Reload Value Register",
        .offset = 0x4,
        .size = 32,
    });
    const val_id = try db.create_register(systick_type, .{
        .name = "VAL",
        .description = "SysTick Current Value Register",
        .offset = 0x8,
        .size = 32,
    });
    const calib_id = try db.create_register(systick_type, .{
        .name = "CALIB",
        .description = "SysTick Calibration Register",
        .offset = 0xc,
        .size = 32,
        .access = .read_only,
    });

    // CTRL fields
    _ = try db.create_field(ctrl_id, .{ .name = "ENABLE", .offset = 0, .size = 1 });
    _ = try db.create_field(ctrl_id, .{ .name = "TICKINT", .offset = 1, .size = 1 });
    _ = try db.create_field(ctrl_id, .{ .name = "CLKSOURCE", .offset = 2, .size = 1 });
    _ = try db.create_field(ctrl_id, .{ .name = "COUNTFLAG", .offset = 16, .size = 1 });

    // LOAD fields
    _ = try db.create_field(load_id, .{ .name = "RELOAD", .offset = 0, .size = 24 });

    // VAL fields
    _ = try db.create_field(val_id, .{ .name = "CURRENT", .offset = 0, .size = 24 });

    // CALIB fields
    _ = try db.create_field(calib_id, .{ .name = "TENMS", .offset = 0, .size = 24 });
    _ = try db.create_field(calib_id, .{ .name = "SKEW", .offset = 30, .size = 1 });
    _ = try db.create_field(calib_id, .{ .name = "NOREF", .offset = 31, .size = 1 });
}

pub fn add_core_registers(db: *Database, cpu_name: Database.Arch, device_id: EntityId) !void {
    const type_id = try db.create_peripheral(.{
        .name = "SCS",
        .description = "System Control Space",
    });

    if (db.instances.devices.get(device_id)) |cpu| {
        if (!(try has_vendor_systick_config(cpu)))
            try add_systick_registers(db, device_id, type_id);

        inline for (@typeInfo(cores).Struct.decls) |decl|
            if (cpu_name == @field(Database.Arch, decl.name))
                try @field(cores, decl.name).add_core_registers(db, device_id, type_id);
    }
}

pub fn add_nvic_fields(db: *Database, cpu_name: Database.Arch, device_id: EntityId) !void {
    inline for (@typeInfo(cores).Struct.decls) |decl|
        if (cpu_name == @field(Database.Arch, decl.name))
            try @field(cores, decl.name).add_nvic_fields(db, device_id);
}

fn has_vendor_systick_config(cpu: anytype) !bool {
    if (cpu.properties.get("cpu.vendor_systick_config")) |systick| {
        if (std.mem.eql(u8, systick, "false") or std.mem.eql(u8, systick, "0")) {
            return false;
        } else if (std.mem.eql(u8, systick, "true") or std.mem.eql(u8, systick, "1")) {
            return true;
        } else {
            return error.BadVendorSystickConfigRepresentation;
        }
    }
    return error.MissingVendorSystickConfig;
}
