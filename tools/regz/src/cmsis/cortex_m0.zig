const std = @import("std");
const Database = @import("../Database.zig");
const Register = @import("../Register.zig");
const Field = @import("../Field.zig");

pub fn addCoreRegisters(db: *Database, scs: Database.PeripheralIndex) !void {
    try addNvicCluster(db, scs);
    try addScbCluster(db, scs);
}

pub fn addNvicCluster(db: *Database, scs: Database.PeripheralIndex) !void {
    const nvic = try db.addClusterToPeripheral(scs, .{
        .name = "NVIC",
        .description = "Nested Vectored Interrupt Controller",
        .addr_offset = 0x100,
    });

    const regs = try db.addRegistersToCluster(nvic, &.{
        .{
            .name = "ISER",
            .description = "Interrupt Set Enable Register",
            .addr_offset = 0x000,
        },
        .{
            .name = "ICER",
            .description = "Interrupt Clear Enable Register",
            .addr_offset = 0x80,
        },
        .{
            .name = "ISPR",
            .description = "Interrupt Set Pending Register",
            .addr_offset = 0x100,
        },
        .{
            .name = "ICPR",
            .description = "Interrupt Clear Pending Register",
            .addr_offset = 0x180,
        },
    });

    var fields = std.ArrayList(Field).init(db.gpa);
    defer fields.deinit();

    for (db.interrupts.items) |interrupt|
        try fields.append(.{
            .name = interrupt.name,
            .offset = @intCast(u8, interrupt.value),
            .width = 1,
        });

    const iser = regs.begin;
    try db.addFieldsToRegister(iser, fields.items);

    const icer = regs.begin + 1;
    try db.addFieldsToRegister(icer, fields.items);

    const ispr = regs.begin + 2;
    try db.addFieldsToRegister(ispr, fields.items);

    const icpr = regs.begin + 3;
    try db.addFieldsToRegister(icpr, fields.items);

    if (db.cpu) |cpu| if (cpu.nvic_prio_bits > 0)
        try addInterruptPriorityRegisters(db, scs, nvic);

    try db.addSystemRegisterAddresses(scs, nvic, regs);
}

fn addInterruptPriorityRegisters(
    db: *Database,
    scs: Database.PeripheralIndex,
    nvic: Database.ClusterIndex,
) !void {
    const ip_addr_offset = 0x300;
    const nvic_prio_bits = db.cpu.?.nvic_prio_bits;
    const peripheral = db.peripherals.items[scs];
    const cluster = db.clusters.items[nvic];
    const base_addr = if (peripheral.base_addr) |periph_base_addr|
        periph_base_addr + cluster.addr_offset
    else
        cluster.addr_offset;

    var register_fields = std.ArrayList([]Field).init(db.gpa);
    defer register_fields.deinit();

    var registers = std.ArrayList(Register).init(db.gpa);
    defer registers.deinit();

    {
        var i: u32 = 0;
        while (i < 8) : (i += 1) {
            // TODO: assert no duplicates in the interrupt table
            var fields = std.ArrayListUnmanaged(Field){};
            errdefer fields.deinit(db.arena.allocator());

            for (db.interrupts.items) |interrupt| {
                if (i == interrupt.value / 4) {
                    try fields.append(db.arena.allocator(), .{
                        .name = interrupt.name,
                        .offset = (8 * (@intCast(u8, interrupt.value) % 4)) + (8 - nvic_prio_bits),
                        .width = nvic_prio_bits,
                    });
                }
            }

            const addr_offset = ip_addr_offset + (i * 4);
            if (fields.items.len > 0) {
                const reg_name = try std.fmt.allocPrint(db.arena.allocator(), "IP{}", .{
                    i,
                });

                try registers.append(.{
                    .name = reg_name,
                    .description = "Interrupt Priority Register",
                    .addr_offset = addr_offset,
                });

                try register_fields.append(fields.toOwnedSlice(db.arena.allocator()));
            }

            try db.system_reg_addrs.put(db.gpa, base_addr + addr_offset, {});
        }
    }

    const regs = try db.addRegistersToCluster(nvic, registers.items);
    for (register_fields.items) |fields, i|
        try db.addFieldsToRegister(regs.begin + @intCast(u32, i), fields);
}

pub fn addScbCluster(db: *Database, scs: Database.PeripheralIndex) !void {
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

    try db.addSystemRegisterAddresses(scs, scb, regs);
}
