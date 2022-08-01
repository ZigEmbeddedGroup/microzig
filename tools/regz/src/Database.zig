const std = @import("std");
const build_options = @import("build_options");
const svd = @import("svd.zig");
const xml = @import("xml.zig");
const atdf = @import("atdf.zig");
const Peripheral = @import("Peripheral.zig");
const Register = @import("Register.zig");
const Field = @import("Field.zig");
const Enumeration = @import("Enumeration.zig");
const cmsis = @import("cmsis.zig");

const assert = std.debug.assert;
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;

const Database = @This();

pub const Access = svd.Access;
pub const PeripheralIndex = u32;
pub const ClusterIndex = u32;
pub const RegisterIndex = u32;
pub const FieldIndex = u32;
pub const EnumIndex = u32;

fn IndexRange(comptime Index: type) type {
    return struct {
        begin: Index,
        end: Index,

        fn contains(index_range: @This(), index: Index) bool {
            return index >= index_range.begin and index < index_range.end;
        }
    };
}

const PeripheralUsesInterrupt = struct {
    peripheral_idx: PeripheralIndex,
    interrupt_value: u32,
};

const FieldsInRegister = struct {
    register_idx: RegisterIndex,
    field_range: IndexRange(FieldIndex),
};

const ClusterInPeripheral = struct {
    peripheral_idx: PeripheralIndex,
    cluster_idx: ClusterIndex,
};

const ClusterInCluster = struct {
    parent_idx: ClusterIndex,
    child_idx: ClusterIndex,
};

const Nesting = enum {
    namespaced,
    contained,
};

fn RegisterProperties(comptime IndexType: type) type {
    return struct {
        /// register size in bits
        size: std.AutoHashMapUnmanaged(IndexType, u16) = .{},
        access: std.AutoHashMapUnmanaged(IndexType, Access) = .{},
        reset_value: std.AutoHashMapUnmanaged(IndexType, u64) = .{},
        reset_mask: std.AutoHashMapUnmanaged(IndexType, u64) = .{},

        fn deinit(register_properties: *@This(), allocator: Allocator) void {
            register_properties.size.deinit(allocator);
            register_properties.access.deinit(allocator);
            register_properties.reset_value.deinit(allocator);
            register_properties.reset_mask.deinit(allocator);
        }
    };
}

const RegisterPropertyTables = struct {
    register: RegisterProperties(RegisterIndex) = .{},
    cluster: RegisterProperties(ClusterIndex) = .{},
    peripheral: RegisterProperties(PeripheralIndex) = .{},

    fn deinit(self: *RegisterPropertyTables, allocator: Allocator) void {
        self.register.deinit(allocator);
        self.cluster.deinit(allocator);
        self.peripheral.deinit(allocator);
    }
};

gpa: Allocator,
arena: ArenaAllocator,
device: ?svd.Device,
cpu: ?svd.Cpu,
interrupts: std.ArrayListUnmanaged(svd.Interrupt) = .{},
peripherals: std.ArrayListUnmanaged(Peripheral) = .{},
clusters: std.ArrayListUnmanaged(svd.Cluster) = .{},
registers: std.ArrayListUnmanaged(Register) = .{},
fields: std.ArrayListUnmanaged(Field) = .{},
enumerations: std.ArrayListUnmanaged(Enumeration) = .{},
peripherals_use_interrupts: std.ArrayListUnmanaged(PeripheralUsesInterrupt) = .{},
clusters_in_peripherals: std.ArrayListUnmanaged(ClusterInPeripheral) = .{},
clusters_in_clusters: std.ArrayListUnmanaged(ClusterInCluster) = .{},
registers_in_peripherals: std.AutoArrayHashMapUnmanaged(PeripheralIndex, IndexRange(RegisterIndex)) = .{},
registers_in_clusters: std.AutoArrayHashMapUnmanaged(ClusterIndex, IndexRange(RegisterIndex)) = .{},
fields_in_registers: std.AutoArrayHashMapUnmanaged(RegisterIndex, IndexRange(FieldIndex)) = .{},
enumerations_in_fields: std.AutoArrayHashMapUnmanaged(FieldIndex, IndexRange(EnumIndex)) = .{},
dimensions: Dimensions = .{},
register_properties: RegisterPropertyTables = .{},
field_access: std.AutoArrayHashMapUnmanaged(FieldIndex, Access) = .{},

/// Register addresses of registers we know will exist on an MCU, it's used for
/// deduplication when a vendor includes xml entries for those registers
system_reg_addrs: std.AutoArrayHashMapUnmanaged(u64, void) = .{},

pub fn deinit(db: *Database) void {
    db.interrupts.deinit(db.gpa);
    db.peripherals.deinit(db.gpa);
    db.clusters.deinit(db.gpa);
    db.registers.deinit(db.gpa);
    db.fields.deinit(db.gpa);
    db.enumerations.deinit(db.gpa);
    db.peripherals_use_interrupts.deinit(db.gpa);
    db.registers_in_peripherals.deinit(db.gpa);
    db.fields_in_registers.deinit(db.gpa);
    db.clusters_in_peripherals.deinit(db.gpa);
    db.clusters_in_clusters.deinit(db.gpa);
    db.registers_in_clusters.deinit(db.gpa);
    db.enumerations_in_fields.deinit(db.gpa);
    db.dimensions.deinit(db.gpa);
    db.register_properties.deinit(db.gpa);
    db.field_access.deinit(db.gpa);
    db.system_reg_addrs.deinit(db.gpa);
    db.arena.deinit();
}

pub fn initFromSvd(allocator: Allocator, doc: *xml.Doc) !Database {
    const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
    const device_node = xml.findNode(root_element, "device") orelse return error.NoDevice;
    const device_nodes: *xml.Node = device_node.children orelse return error.NoDeviceNodes;

    var db = Database{
        .gpa = allocator,
        .arena = ArenaAllocator.init(allocator),
        .cpu = null,
        .device = null,
    };
    errdefer db.deinit();

    db.device = try svd.Device.parse(&db.arena, device_nodes);
    db.cpu = if (xml.findNode(device_nodes, "cpu")) |cpu_node|
        try svd.Cpu.parse(&db.arena, @ptrCast(*xml.Node, cpu_node.children orelse return error.NoCpu))
    else
        null;

    if (xml.findNode(device_nodes, "peripherals")) |peripherals_node| {
        var peripheral_it: ?*xml.Node = xml.findNode(peripherals_node.children, "peripheral"); //peripherals_node.children;
        while (peripheral_it != null) : (peripheral_it = xml.findNode(peripheral_it.?.next, "peripheral")) {
            const peripheral_nodes: *xml.Node = peripheral_it.?.children orelse continue;

            var interrupt_it: ?*xml.Node = xml.findNode(peripheral_nodes, "interrupt");
            while (interrupt_it != null) : (interrupt_it = xml.findNode(interrupt_it.?.next, "interrupt")) {
                const interrupt_nodes: *xml.Node = interrupt_it.?.children orelse continue;
                const interrupt = try svd.Interrupt.parse(&db.arena, interrupt_nodes);

                // if the interrupt doesn't exist then do a sorted insert
                if (std.sort.binarySearch(svd.Interrupt, interrupt, db.interrupts.items, {}, svd.Interrupt.compare) == null) {
                    try db.interrupts.append(db.gpa, interrupt);
                    std.sort.sort(svd.Interrupt, db.interrupts.items, {}, svd.Interrupt.lessThan);
                }
            }
        }
    }

    if (db.cpu) |cpu| if (cpu.name) |cpu_name|
        if (svd.CpuName.parse(cpu_name)) |cpu_type|
            try cmsis.addCoreRegisters(&db, cpu_type);

    var named_derivations = Derivations([]const u8){};
    defer named_derivations.deinit(allocator);

    if (xml.findNode(device_nodes, "peripherals")) |peripherals_node| {
        var peripheral_it: ?*xml.Node = xml.findNode(peripherals_node.children, "peripheral");
        while (peripheral_it != null) : (peripheral_it = xml.findNode(peripheral_it.?.next, "peripheral")) {
            const peripheral_nodes: *xml.Node = peripheral_it.?.children orelse continue;
            const peripheral = try svd.parsePeripheral(&db.arena, peripheral_nodes);
            try db.peripherals.append(db.gpa, peripheral);

            const peripheral_idx = @intCast(PeripheralIndex, db.peripherals.items.len - 1);
            if (xml.getAttribute(peripheral_it, "derivedFrom")) |derived_from|
                try named_derivations.peripherals.put(db.gpa, peripheral_idx, try db.arena.allocator().dupe(u8, derived_from));

            if (try svd.Dimension.parse(&db.arena, peripheral_nodes)) |dimension|
                try db.dimensions.peripherals.put(db.gpa, peripheral_idx, dimension);

            const register_properties = try svd.RegisterProperties.parse(&db.arena, peripheral_nodes);
            if (register_properties.size) |size|
                try db.register_properties.peripheral.size.put(db.gpa, peripheral_idx, size);

            if (register_properties.access) |access|
                try db.register_properties.peripheral.access.put(db.gpa, peripheral_idx, access);

            if (register_properties.reset_value) |reset_value|
                try db.register_properties.peripheral.reset_value.put(db.gpa, peripheral_idx, reset_value);

            if (register_properties.reset_mask) |reset_mask|
                try db.register_properties.peripheral.reset_mask.put(db.gpa, peripheral_idx, reset_mask);

            var interrupt_it: ?*xml.Node = xml.findNode(peripheral_nodes, "interrupt");
            while (interrupt_it != null) : (interrupt_it = xml.findNode(interrupt_it.?.next, "interrupt")) {
                const interrupt_nodes: *xml.Node = interrupt_it.?.children orelse continue;
                const interrupt = try svd.Interrupt.parse(&db.arena, interrupt_nodes);

                try db.peripherals_use_interrupts.append(db.gpa, .{
                    .peripheral_idx = peripheral_idx,
                    .interrupt_value = @intCast(u32, interrupt.value),
                });
            }

            if (xml.findNode(peripheral_nodes, "registers")) |registers_node| {
                const reg_begin_idx = db.registers.items.len;
                {
                    const base_addr = if (peripheral.base_addr) |periph_base_addr| periph_base_addr else 0;
                    try db.loadRegisters(registers_node.children, base_addr, &named_derivations);
                    try db.registers_in_peripherals.put(db.gpa, peripheral_idx, .{
                        .begin = @intCast(RegisterIndex, reg_begin_idx),
                        .end = @intCast(RegisterIndex, db.registers.items.len),
                    });
                }

                // process clusters, this might need to be recursive
                var cluster_it: ?*xml.Node = xml.findNode(registers_node.children, "cluster");
                while (cluster_it != null) : (cluster_it = xml.findNode(cluster_it.?.next, "cluster")) {
                    const cluster_nodes: *xml.Node = cluster_it.?.children orelse continue;
                    const cluster = try svd.Cluster.parse(&db.arena, cluster_nodes);
                    try db.clusters.append(db.gpa, cluster);

                    const cluster_idx = @intCast(ClusterIndex, db.clusters.items.len - 1);
                    if (xml.getAttribute(cluster_it, "derivedFrom")) |derived_from|
                        try named_derivations.clusters.put(db.gpa, cluster_idx, try db.arena.allocator().dupe(u8, derived_from));

                    if (try svd.Dimension.parse(&db.arena, cluster_nodes)) |dimension|
                        try db.dimensions.clusters.put(db.gpa, cluster_idx, dimension);

                    // TODO: rest of the fields
                    const cluster_register_props = try svd.RegisterProperties.parse(&db.arena, cluster_nodes);
                    if (cluster_register_props.size) |size|
                        try db.register_properties.cluster.size.put(db.gpa, cluster_idx, size);

                    if (cluster_register_props.access) |access|
                        try db.register_properties.cluster.access.put(db.gpa, cluster_idx, access);

                    if (cluster_register_props.reset_value) |reset_value|
                        try db.register_properties.cluster.reset_value.put(db.gpa, cluster_idx, reset_value);

                    if (cluster_register_props.reset_mask) |reset_mask|
                        try db.register_properties.cluster.reset_mask.put(db.gpa, cluster_idx, reset_mask);

                    try db.clusters_in_peripherals.append(db.gpa, .{
                        .cluster_idx = cluster_idx,
                        .peripheral_idx = peripheral_idx,
                    });

                    const base_addr = if (peripheral.base_addr) |periph_base|
                        periph_base + cluster.addr_offset
                    else
                        cluster.addr_offset;

                    const first_reg_idx = db.registers.items.len;
                    try db.loadRegisters(cluster_nodes, base_addr, &named_derivations);
                    try db.registers_in_clusters.put(db.gpa, cluster_idx, .{
                        .begin = @intCast(RegisterIndex, first_reg_idx),
                        .end = @intCast(RegisterIndex, db.registers.items.len),
                    });

                    try db.loadNestedClusters(cluster_nodes, &named_derivations);
                }
            }
        }
    }

    if (named_derivations.enumerations.count() != 0)
        return error.Todo;

    if (named_derivations.fields.count() != 0)
        return error.Todo;

    if (named_derivations.clusters.count() != 0)
        return error.Todo;

    // transform derivatives from strings to indexes, makes searching at bit
    // cleaner, and much easier to detect circular dependencies
    var derivations = Derivations(u32){};
    defer derivations.deinit(allocator);
    {
        var it = named_derivations.peripherals.iterator();
        while (it.next()) |entry| {
            const base_name = entry.value_ptr.*;
            const idx = @intCast(PeripheralIndex, for (db.peripherals.items) |peripheral, i| {
                if (std.mem.eql(u8, base_name, peripheral.name))
                    break i;
            } else return error.DerivationNotFound);
            try derivations.peripherals.put(allocator, entry.key_ptr.*, idx);
        }

        it = named_derivations.registers.iterator();
        while (it.next()) |entry| {
            const base_name = entry.value_ptr.*;
            const idx = @intCast(RegisterIndex, for (db.registers.items) |register, i| {
                if (std.mem.eql(u8, base_name, register.name))
                    break i;
            } else return error.DerivationNotFound);
            try derivations.registers.put(allocator, entry.key_ptr.*, idx);
        }
    }

    // TODO: circular dependency checks

    // expand derivations
    {
        // TODO: look into needing more than pointing at registers
        var it = derivations.peripherals.iterator();
        while (it.next()) |entry| {
            const parent_idx = entry.value_ptr.*;
            const child_idx = entry.key_ptr.*;

            if (db.registers_in_peripherals.contains(child_idx))
                return error.Todo;

            if (db.registers_in_peripherals.get(parent_idx)) |parent_range|
                try db.registers_in_peripherals.put(allocator, child_idx, parent_range)
            else
                return error.FailedToDerive;
        }
    }

    {
        // TODO: look into needing more than pointing at registers
        var it = derivations.registers.iterator();
        while (it.next()) |entry| {
            const parent_idx = entry.value_ptr.*;
            const child_idx = entry.key_ptr.*;

            // TODO: determine how deriving from a register while having fields
            // works, does it just merge the fields in?
            if (db.fields_in_registers.contains(child_idx))
                return error.Todo;

            if (db.fields_in_registers.get(parent_idx)) |field_range|
                try db.fields_in_registers.put(allocator, child_idx, field_range)
            else
                std.log.warn("register '{s}' derived from '{s}', but the latter does not have fields", .{
                    db.registers.items[child_idx].name, db.registers.items[parent_idx].name,
                });
        }
    }

    return db;
}

fn loadRegisters(
    db: *Database,
    nodes: ?*xml.Node,
    base_addr: ?u64,
    named_derivations: *Derivations([]const u8),
) !void {
    var register_it: ?*xml.Node = xml.findNode(nodes, "register");
    while (register_it != null) : (register_it = xml.findNode(register_it.?.next, "register")) {
        const register_nodes: *xml.Node = register_it.?.children orelse continue;
        const register = try svd.parseRegister(&db.arena, register_nodes);
        if (base_addr) |ba|
            if (db.system_reg_addrs.contains(ba + register.addr_offset)) {
                std.log.debug("skipping register {s}, it is a system register", .{register.name});
                continue;
            };

        const register_idx = @intCast(RegisterIndex, db.registers.items.len);
        try db.registers.append(db.gpa, register);

        if (xml.getAttribute(register_it, "derivedFrom")) |derived_from|
            try named_derivations.registers.put(db.gpa, register_idx, try db.arena.allocator().dupe(u8, derived_from));

        if (try svd.Dimension.parse(&db.arena, register_nodes)) |dimension|
            try db.dimensions.registers.put(db.gpa, register_idx, dimension);

        const register_properties = try svd.RegisterProperties.parse(&db.arena, register_nodes);
        if (register_properties.size) |size|
            try db.register_properties.register.size.put(db.gpa, register_idx, size);

        if (register_properties.access) |access|
            try db.register_properties.register.access.put(db.gpa, register_idx, access);

        if (register_properties.reset_value) |reset_value|
            try db.register_properties.register.reset_value.put(db.gpa, register_idx, reset_value);

        if (register_properties.reset_mask) |reset_mask|
            try db.register_properties.register.reset_mask.put(db.gpa, register_idx, reset_mask);

        const field_begin_idx = @intCast(FieldIndex, db.fields.items.len);
        if (xml.findNode(register_nodes, "fields")) |fields_node| {
            var field_it: ?*xml.Node = xml.findNode(fields_node.children, "field");
            while (field_it != null) : (field_it = xml.findNode(field_it.?.next, "field")) {
                const field_nodes: *xml.Node = field_it.?.children orelse continue;
                const field_name = xml.findValueForKey(field_nodes, "name") orelse continue;
                if (useless_field_names.has(field_name))
                    continue;

                const field = try svd.parseField(&db.arena, field_nodes);
                try db.fields.append(db.gpa, field);

                const field_idx = @intCast(FieldIndex, db.fields.items.len - 1);
                if (xml.getAttribute(field_it, "derivedFrom")) |derived_from|
                    try named_derivations.fields.put(db.gpa, field_idx, try db.arena.allocator().dupe(u8, derived_from));

                if (try svd.Dimension.parse(&db.arena, field_nodes)) |dimension|
                    try db.dimensions.fields.put(db.gpa, field_idx, dimension);

                if (field.access) |access|
                    try db.field_access.put(db.gpa, field_idx, access);

                // TODO: enumerations at some point when there's a solid plan
                //if (xml.findNode(field_nodes, "enumeratedValues")) |enum_values_node| {
                //    // TODO: usage
                //    // TODO: named_derivations
                //    const name = xml.findValueForKey(enum_values_node, "name");
                //    _ = name;
                //    var enum_values_it: ?*xml.Node = xml.findNode(enum_values_node.children, "enumeratedValue");
                //    while (enum_values_it != null) : (enum_values_it = xml.findNode(enum_values_it.?.next, "enumeratedValue")) {
                //        const enum_nodes: *xml.Node = enum_values_it.?.children orelse continue;
                //        const enum_value = try svd.EnumeratedValue.parse(&arena, enum_nodes);
                //        _ = enum_value;
                //    }
                //}
            }
        }

        // sort fields by offset
        std.sort.sort(Field, db.fields.items[field_begin_idx..], {}, Field.lessThan);

        // remove overlapping fields
        var i = field_begin_idx;
        var current_bit: usize = 0;
        while (i < db.fields.items.len) {
            if (current_bit > db.fields.items[i].offset) {
                const ignored = db.fields.orderedRemove(i);
                std.log.warn("ignoring field '{s}' ({}-{}) because it overlaps with '{s}' ({}-{}) in register '{s}'", .{
                    ignored.name,
                    ignored.offset,
                    ignored.offset + ignored.width,
                    db.fields.items[i - 1].name,
                    db.fields.items[i - 1].offset,
                    db.fields.items[i - 1].offset + db.fields.items[i - 1].width,
                    register.name,
                });
            } else if (db.fields.items[i].offset + db.fields.items[i].width > db.device.?.width) {
                const ignored = db.fields.orderedRemove(i);
                std.log.warn("ignoring field '{s}' ({}-{}) in register '{s}' because it's outside it's size: {}", .{
                    ignored.name,
                    ignored.offset,
                    ignored.offset + ignored.width,
                    register.name,
                    db.device.?.width,
                });
            } else {
                current_bit = db.fields.items[i].offset + db.fields.items[i].width;
                i += 1;
            }
        }

        if (field_begin_idx != db.fields.items.len)
            try db.fields_in_registers.put(db.gpa, register_idx, .{
                .begin = field_begin_idx,
                .end = @intCast(FieldIndex, db.fields.items.len),
            });
    }
}

// TODO: record order somehow (clusters vs. register)
fn loadNestedClusters(
    db: *Database,
    nodes: ?*xml.Node,
    named_derivations: *Derivations([]const u8),
) anyerror!void {
    const parent_idx = @intCast(ClusterIndex, db.clusters.items.len - 1);

    var cluster_it: ?*xml.Node = xml.findNode(nodes, "cluster");
    while (cluster_it != null) : (cluster_it = xml.findNode(cluster_it.?.next, "cluster")) {
        const cluster_nodes: *xml.Node = cluster_it.?.children orelse continue;
        const cluster = try svd.Cluster.parse(&db.arena, cluster_nodes);
        try db.clusters.append(db.gpa, cluster);

        const cluster_idx = @intCast(ClusterIndex, db.clusters.items.len - 1);
        if (xml.getAttribute(cluster_it, "derivedFrom")) |derived_from|
            try named_derivations.clusters.put(db.gpa, cluster_idx, try db.arena.allocator().dupe(u8, derived_from));

        if (try svd.Dimension.parse(&db.arena, cluster_nodes)) |dimension|
            try db.dimensions.clusters.put(db.gpa, cluster_idx, dimension);

        const register_properties = try svd.RegisterProperties.parse(&db.arena, cluster_nodes);
        if (register_properties.size) |size|
            try db.register_properties.cluster.size.put(db.gpa, cluster_idx, size);

        if (register_properties.access) |access|
            try db.register_properties.cluster.access.put(db.gpa, cluster_idx, access);

        if (register_properties.reset_value) |reset_value|
            try db.register_properties.cluster.reset_value.put(db.gpa, cluster_idx, reset_value);

        if (register_properties.reset_mask) |reset_mask|
            try db.register_properties.cluster.reset_mask.put(db.gpa, cluster_idx, reset_mask);

        try db.clusters_in_clusters.append(db.gpa, .{
            .parent_idx = parent_idx,
            .child_idx = cluster_idx,
        });

        const first_reg_idx = db.registers.items.len;
        try db.loadRegisters(cluster_nodes, null, named_derivations);
        try db.registers_in_clusters.put(db.gpa, cluster_idx, .{
            .begin = @intCast(RegisterIndex, first_reg_idx),
            .end = @intCast(RegisterIndex, db.registers.items.len),
        });

        try db.loadNestedClusters(cluster_nodes, named_derivations);
    }
}

pub fn initFromAtdf(allocator: Allocator, doc: *xml.Doc) !Database {
    const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
    const tools_node = xml.findNode(root_element, "avr-tools-device-file") orelse return error.NoToolsNode;

    var peripheral_instances = std.StringHashMap(void).init(allocator);
    defer peripheral_instances.deinit();

    var db = Database{
        .gpa = allocator,
        .arena = ArenaAllocator.init(allocator),
        .cpu = null,
        .device = null,
    };
    errdefer db.deinit();

    if (xml.findNode(tools_node.children orelse return error.NoChildren, "devices")) |devices_node| {
        var device_it: ?*xml.Node = xml.findNode(devices_node.children, "device");
        while (device_it != null) : (device_it = xml.findNode(device_it.?.next, "device")) {
            if (db.device != null) {
                std.log.err("multiple devices defined in this file. TODO: give user list of devices to choose from", .{});
                return error.Explained;
            }

            // this name lowercased should line up with a zig target
            const name: ?[]const u8 = if (xml.getAttribute(device_it, "name")) |n|
                try db.arena.allocator().dupe(u8, n)
            else
                null;
            const arch: ?[]const u8 = if (xml.getAttribute(device_it, "architecture")) |a|
                try db.arena.allocator().dupe(u8, a)
            else
                null;
            const family: ?[]const u8 = if (xml.getAttribute(device_it, "family")) |f|
                try db.arena.allocator().dupe(u8, f)
            else
                null;

            db.device = .{
                .vendor = "Atmel",
                .series = family,
                .name = name,
                .address_unit_bits = 16,
                .width = 8,
                .register_properties = .{},
            };

            db.cpu = svd.Cpu{
                .name = arch,
                .revision = "0.0.1",
                .endian = .little,
                .nvic_prio_bits = 0,
                .vendor_systick_config = false,
                .device_num_interrupts = null,
                .vtor_present = false,
                .mpu_present = false,
            };

            const device_nodes: *xml.Node = device_it.?.children orelse continue;
            if (xml.findNode(device_nodes, "peripherals")) |peripherals_node| {
                var module_it: ?*xml.Node = xml.findNode(peripherals_node.children.?, "module");
                while (module_it != null) : (module_it = xml.findNode(module_it.?.next, "module")) {
                    const module_nodes = module_it.?.children orelse continue;
                    var instance_it: ?*xml.Node = xml.findNode(module_nodes, "instance");
                    while (instance_it != null) : (instance_it = xml.findNode(instance_it.?.next, "instance")) {
                        const instance_nodes = instance_it.?.children orelse continue;
                        const instance_name = xml.getAttribute(instance_it, "name") orelse return error.NoInstanceName;
                        if (xml.findNode(instance_nodes, "register-group")) |register_group| {
                            const group_name = xml.getAttribute(register_group, "name") orelse return error.NoRegisterGroupName;
                            const name_in_module = xml.getAttribute(register_group, "name-in-module") orelse return error.NoNameInModule;

                            if (!std.mem.eql(u8, instance_name, group_name) or !std.mem.eql(u8, group_name, name_in_module)) {
                                std.log.warn("mismatching names for name-in-module: {s}, ignoring, if you see this please cut a ticket: https://github.com/ZigEmbeddedGroup/regz", .{
                                    name_in_module,
                                });
                                continue;
                            }

                            try peripheral_instances.put(try db.arena.allocator().dupe(u8, name_in_module), {});
                        }
                    }
                }
            }

            if (xml.findNode(device_nodes, "interrupts")) |interrupts_node| {
                var interrupt_it: ?*xml.Node = xml.findNode(interrupts_node.children.?, "interrupt");
                while (interrupt_it != null) : (interrupt_it = xml.findNode(interrupt_it.?.next, "interrupt")) {
                    const interrupt = svd.Interrupt{
                        .name = if (xml.getAttribute(interrupt_it, "name")) |interrupt_name|
                            try db.arena.allocator().dupe(u8, interrupt_name)
                        else
                            return error.NoName,
                        .description = if (xml.getAttribute(interrupt_it, "caption")) |caption|
                            try db.arena.allocator().dupe(u8, caption)
                        else
                            return error.NoCaption,
                        .value = if (xml.getAttribute(interrupt_it, "index")) |index_str|
                            try std.fmt.parseInt(usize, index_str, 0)
                        else
                            return error.NoIndex,
                    };

                    // if the interrupt doesn't exist then do a sorted insert
                    if (std.sort.binarySearch(svd.Interrupt, interrupt, db.interrupts.items, {}, svd.Interrupt.compare) == null) {
                        try db.interrupts.append(db.gpa, interrupt);
                        std.sort.sort(svd.Interrupt, db.interrupts.items, {}, svd.Interrupt.lessThan);
                    }
                }
            }
        }
    }

    if (xml.findNode(tools_node.children orelse return error.NoChildren, "modules")) |modules_node| {
        var module_it: ?*xml.Node = xml.findNode(modules_node.children.?, "module");
        while (module_it != null) : (module_it = xml.findNode(module_it.?.next, "module")) {
            const module_nodes: *xml.Node = module_it.?.children orelse continue;

            var value_groups = std.StringHashMap(IndexRange(u32)).init(allocator);
            defer value_groups.deinit();

            var value_group_it: ?*xml.Node = xml.findNode(module_nodes, "value-group");
            while (value_group_it != null) : (value_group_it = xml.findNode(value_group_it.?.next, "value-group")) {
                const value_group_nodes: *xml.Node = value_group_it.?.children orelse continue;
                const value_group_name = if (xml.getAttribute(value_group_it, "name")) |name|
                    try db.arena.allocator().dupe(u8, name)
                else
                    continue;

                const first_enum_idx = @intCast(EnumIndex, db.enumerations.items.len);
                var value_it: ?*xml.Node = xml.findNode(value_group_nodes, "value");
                while (value_it != null) : (value_it = xml.findNode(value_it.?.next, "value")) {
                    try db.enumerations.append(db.gpa, .{
                        .value = if (xml.getAttribute(value_it, "value")) |value_str|
                            try std.fmt.parseInt(usize, value_str, 0)
                        else
                            continue,
                        .description = if (xml.getAttribute(value_it, "caption")) |caption|
                            try db.arena.allocator().dupe(u8, caption)
                        else
                            null,
                    });
                }

                std.sort.sort(Enumeration, db.enumerations.items[first_enum_idx..], {}, Enumeration.lessThan);
                try value_groups.put(value_group_name, .{
                    .begin = first_enum_idx,
                    .end = @intCast(EnumIndex, db.enumerations.items.len),
                });
            }

            var register_group_it: ?*xml.Node = xml.findNode(module_nodes, "register-group");
            while (register_group_it != null) : (register_group_it = xml.findNode(register_group_it.?.next, "register-group")) {
                const register_group_nodes: *xml.Node = register_group_it.?.children orelse continue;
                const group_name = xml.getAttribute(register_group_it, "name") orelse continue;
                if (!peripheral_instances.contains(group_name))
                    continue;

                const register_group_offset = try xml.parseIntForKey(usize, db.gpa, register_group_nodes, "offset");

                const peripheral_idx = @intCast(PeripheralIndex, db.peripherals.items.len);
                try db.peripherals.append(db.gpa, try atdf.parsePeripheral(&db.arena, register_group_it.?));

                const reg_begin_idx = @intCast(RegisterIndex, db.registers.items.len);
                var register_it: ?*xml.Node = xml.findNode(register_group_nodes, "register");
                while (register_it != null) : (register_it = xml.findNode(register_it.?.next, "register")) {
                    const register = try atdf.parseRegister(&db.arena, register_it.?, register_group_offset, register_it.?.children != null);

                    const register_idx = @intCast(RegisterIndex, db.registers.items.len);
                    try db.registers.append(db.gpa, register);

                    if (register.size) |size|
                        try db.register_properties.register.size.put(db.gpa, register_idx, size);

                    const register_nodes: *xml.Node = register_it.?.children orelse continue;
                    const field_begin_idx = @intCast(FieldIndex, db.fields.items.len);
                    var bitfield_it: ?*xml.Node = xml.findNode(register_nodes, "bitfield");
                    while (bitfield_it != null) : (bitfield_it = xml.findNode(bitfield_it.?.next, "bitfield")) {
                        try db.fields.append(db.gpa, atdf.parseField(&db.arena, bitfield_it.?) catch |err| switch (err) {
                            error.InvalidMask => continue,
                            else => return err,
                        });
                    }

                    // we expect fields to be sorted by offset
                    std.sort.sort(Field, db.fields.items[field_begin_idx..], {}, Field.lessThan);

                    // go back through bitfields and get the enumerations
                    bitfield_it = xml.findNode(register_nodes, "bitfield");
                    while (bitfield_it != null) : (bitfield_it = xml.findNode(bitfield_it.?.next, "bitfield")) {
                        if (xml.getAttribute(bitfield_it, "values")) |value_group_name| {
                            const field_name = xml.getAttribute(bitfield_it, "name") orelse continue;
                            const field_idx = for (db.fields.items[field_begin_idx..]) |field, offset| {
                                if (std.mem.eql(u8, field_name, field.name))
                                    break field_begin_idx + @intCast(FieldIndex, offset);
                            } else continue;

                            if (value_groups.get(value_group_name)) |enum_range|
                                try db.enumerations_in_fields.put(db.gpa, field_idx, enum_range);
                        }
                    }

                    try db.fields_in_registers.put(db.gpa, register_idx, .{
                        .begin = field_begin_idx,
                        .end = @intCast(FieldIndex, db.fields.items.len),
                    });
                }

                try db.registers_in_peripherals.put(db.gpa, peripheral_idx, .{
                    .begin = reg_begin_idx,
                    .end = @intCast(RegisterIndex, db.registers.items.len),
                });
            }
        }
    }

    // there is also pinouts, however that's linked to IC package information,
    // not exactly sure if we're going to do anything with that

    return db;
}

fn writeDescription(
    allocator: Allocator,
    writer: anytype,
    description: []const u8,
) !void {
    const max_line_width = 80;

    // keep explicit lines from svd
    var line_it = std.mem.tokenize(u8, description, "\n\r");
    while (line_it.next()) |input_line| {
        var it = std.mem.tokenize(u8, input_line, " \t");
        var line = std.ArrayList(u8).init(allocator);
        defer line.deinit();

        while (it.next()) |token| {
            if (line.items.len + token.len > max_line_width) {
                if (line.items.len > 0) {
                    try writer.print("///{s}\n", .{line.items});
                    line.clearRetainingCapacity();
                    try line.append(' ');
                    try line.appendSlice(token);
                } else {
                    try writer.print("/// {s}\n", .{token});
                }
            } else {
                try line.append(' ');
                try line.appendSlice(token);
            }
        }

        if (line.items.len > 0) {
            try writer.print("///{s}\n", .{line.items});
        }
    }
}

pub fn toZig(db: *Database, out_writer: anytype) !void {
    if (db.device == null) {
        std.log.err("failed to find device info", .{});
        return error.Explained;
    }

    var fifo = std.fifo.LinearFifo(u8, .Dynamic).init(db.gpa);
    defer fifo.deinit();

    const writer = fifo.writer();

    try writer.print(
        \\// this file was generated by regz: https://github.com/ZigEmbeddedGroup/regz
        \\// commit: {s}
    , .{build_options.commit});
    try writer.writeAll("//\n");
    if (db.device.?.vendor) |vendor_name|
        try writer.print("// vendor: {s}\n", .{vendor_name});

    if (db.device.?.name) |device_name|
        try writer.print("// device: {s}\n", .{device_name});

    if (db.cpu) |cpu| if (cpu.name) |cpu_name|
        try writer.print("// cpu: {s}\n", .{cpu_name});

    if (db.interrupts.items.len > 0 and db.cpu != null) {
        if (svd.CpuName.parse(db.cpu.?.name.?)) |cpu_type| {
            try writer.writeAll("\npub const VectorTable = extern struct {\n");

            // TODO: isCortexM()
            if (cpu_type != .avr) {
                // this is an arm machine
                try writer.writeAll(
                    \\    initial_stack_pointer: u32,
                    \\    Reset: InterruptVector = unhandled,
                    \\    NMI: InterruptVector = unhandled,
                    \\    HardFault: InterruptVector = unhandled,
                    \\
                );

                switch (cpu_type) {
                    // Cortex M23 has a security extension and when implemented
                    // there are two vector tables (same layout though)
                    .cortex_m0, .cortex_m0plus, .cortex_m23 => try writer.writeAll(
                        \\    reserved0: [7]u32 = undefined,
                        \\
                    ),
                    .sc300, .cortex_m3, .cortex_m4, .cortex_m7, .cortex_m33 => try writer.writeAll(
                        \\    MemManage: InterruptVector = unhandled,
                        \\    BusFault: InterruptVector = unhandled,
                        \\    UsageFault: InterruptVector = unhandled,
                        \\    reserved0: [4]u32 = undefined,
                        \\
                    ),
                    else => {
                        std.log.err("unhandled cpu type: {}", .{cpu_type});
                        return error.Todo;
                    },
                }

                try writer.writeAll(
                    \\    SVCall: InterruptVector = unhandled,
                    \\    reserved1: [2]u32 = undefined,
                    \\    PendSV: InterruptVector = unhandled,
                    \\    SysTick: InterruptVector = unhandled,
                    \\
                );
            }

            var reserved_count: usize = 2;
            var expected: usize = 0;
            for (db.interrupts.items) |interrupt| {
                if (expected > interrupt.value) {
                    assert(false);
                    return error.InterruptOrder;
                }

                while (expected < interrupt.value) : ({
                    expected += 1;
                    reserved_count += 1;
                }) {
                    try writer.print("    reserved{}: u32 = undefined,\n", .{reserved_count});
                }

                if (interrupt.description) |description| if (!useless_descriptions.has(description))
                    try writeDescription(db.arena.child_allocator, writer, description);

                try writer.print("    {s}: InterruptVector = unhandled,\n", .{std.zig.fmtId(interrupt.name)});
                expected += 1;
            }

            try writer.writeAll("};\n");
        }
    }

    if (db.registers.items.len > 0) {
        try writer.writeAll("\npub const registers = struct {\n");
        for (db.peripherals.items) |peripheral, i| {
            const peripheral_idx = @intCast(u32, i);
            const has_registers = db.registers_in_peripherals.contains(peripheral_idx);
            const has_clusters = for (db.clusters_in_peripherals.items) |cip| {
                if (cip.peripheral_idx == peripheral_idx)
                    break true;
            } else false;

            if (!has_registers and !has_clusters)
                continue;

            if (db.dimensions.peripherals.get(peripheral_idx)) |_| {
                std.log.warn("dimensioned peripherals not supported yet: {s}", .{peripheral.name});
                continue;
            }

            if (peripheral.description) |description| if (!useless_descriptions.has(description)) {
                try writer.writeByte('\n');
                try writeDescription(db.arena.child_allocator, writer, description);
            };

            try writer.print("    pub const {s} = struct {{\n", .{std.zig.fmtId(peripheral.name)});
            if (peripheral.base_addr) |base_addr|
                try writer.print("        pub const base_address = 0x{x};\n", .{base_addr});

            if (peripheral.version) |version|
                try writer.print("        pub const version = \"{s}\";\n", .{version});

            if (db.registers_in_peripherals.get(peripheral_idx)) |reg_range| {
                const registers = db.registers.items[reg_range.begin..reg_range.end];

                for (registers) |_, range_offset| {
                    const reg_idx = @intCast(RegisterIndex, reg_range.begin + range_offset);
                    const register = try db.getRegister(reg_idx);
                    try db.genZigRegister(writer, peripheral.base_addr, null, reg_idx, register, .namespaced);
                }
            }

            if (has_clusters) {
                for (db.clusters_in_peripherals.items) |cip| {
                    if (cip.peripheral_idx == peripheral_idx) {
                        try db.genZigCluster(writer, peripheral.base_addr, cip.cluster_idx, .namespaced);
                    }
                }

                for (db.clusters_in_clusters.items) |cic| {
                    const nested = db.clusters.items[cic.child_idx];
                    std.log.warn("nested clusters not supported yet: {s}", .{nested.name});
                }
            }

            try writer.writeAll("    };\n");
        }

        try writer.writeAll("};\n");
    }

    try writer.writeAll("\n" ++ @embedFile("mmio.zig"));

    // write zero to fifo so that it's null terminated
    try writer.writeByte(0);
    const text = fifo.readableSlice(0);
    var ast = try std.zig.parse(db.gpa, @bitCast([:0]const u8, text[0 .. text.len - 1]));
    defer ast.deinit(db.gpa);

    const formatted_text = try ast.render(db.gpa);
    defer db.gpa.free(formatted_text);

    try out_writer.writeAll(formatted_text);
}

fn genZigCluster(
    db: *Database,
    writer: anytype,
    base_addr: ?u64,
    cluster_idx: ClusterIndex,
    nesting: Nesting,
) !void {
    const cluster = db.clusters.items[cluster_idx];
    const dimension_opt = db.dimensions.clusters.get(cluster_idx);
    if (dimension_opt == null and std.mem.indexOf(u8, cluster.name, "%s") != null)
        return error.MissingDimension;

    if (dimension_opt) |dimension| if (dimension.index != null) {
        std.log.warn("clusters with dimIndex set are not implemented yet: {s}", .{cluster.name});
        return;
    };

    switch (nesting) {
        .namespaced => if (db.registers_in_clusters.get(cluster_idx)) |range| {
            const registers = db.registers.items[range.begin..range.end];
            try writer.writeByte('\n');
            if (cluster.description) |description|
                if (!useless_descriptions.has(description))
                    try writeDescription(db.arena.child_allocator, writer, description);

            if (dimension_opt) |dimension| {
                const name = try std.mem.replaceOwned(u8, db.arena.allocator(), cluster.name, "[%s]", "");

                try writer.print("pub const {s} = @ptrCast(*volatile [{}]packed struct {{", .{ name, dimension.dim });

                var bits: usize = 0;
                for (registers) |_, offset| {
                    const reg_idx = @intCast(RegisterIndex, range.begin + offset);
                    const register = try db.getRegister(reg_idx);
                    try db.genZigRegister(writer, base_addr, cluster.addr_offset, reg_idx, register, .contained);
                    bits += register.size.?;
                }

                if (bits % 8 != 0 or db.device.?.width % 8 != 0)
                    return error.InvalidWordSize;

                const bytes = bits / 8;
                const bytes_per_word = db.device.?.width / 8;
                if (bytes > dimension.increment)
                    return error.InvalidClusterSize;

                const num_padding_words = (dimension.increment - bytes) / bytes_per_word;
                var i: usize = 0;
                while (i < num_padding_words) : (i += 1) {
                    try writer.print("padding{}: u{},\n", .{ i, db.device.?.width });
                }

                try writer.print("}}, base_address + 0x{x});\n", .{cluster.addr_offset});
            } else {
                try writer.print("pub const {s} = struct {{\n", .{std.zig.fmtId(cluster.name)});
                for (registers) |_, offset| {
                    const reg_idx = @intCast(RegisterIndex, range.begin + offset);
                    const register = try db.getRegister(reg_idx);
                    try db.genZigRegister(writer, base_addr, cluster.addr_offset, reg_idx, register, .namespaced);
                }

                try writer.writeAll("};\n");
            }
        },
        .contained => {},
    }
}

fn genZigSingleRegister(
    db: *Database,
    writer: anytype,
    name: []const u8,
    width: u32,
    has_base_addr: bool,
    addr_offset: u64,
    field_range_opt: ?IndexRange(FieldIndex),
    array_prefix: []const u8,
    nesting: Nesting,
) !void {
    if (field_range_opt) |field_range| {
        const fields = db.fields.items[field_range.begin..field_range.end];
        assert(fields.len != 0);

        if (fields.len == 1 and std.mem.eql(u8, fields[0].name, name)) {
            if (fields[0].width > width)
                return error.BadWidth;

            if (fields[0].width == width)
                // TODO: oof please refactor this
                switch (nesting) {
                    .namespaced => if (has_base_addr)
                        try writer.print("pub const {s} = @intToPtr(*volatile {s}u{}, base_address + 0x{x});\n", .{
                            std.zig.fmtId(name),
                            array_prefix,
                            width,
                            addr_offset,
                        })
                    else
                        try writer.print("pub const {s} = @intToPtr(*volatile {s}u{}, 0x{x});\n", .{
                            std.zig.fmtId(name),
                            array_prefix,
                            width,
                            addr_offset,
                        }),
                    .contained => try writer.print("{s}: {s}u{},\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        width,
                    }),
                }
            else switch (nesting) {
                .namespaced => if (has_base_addr)
                    try writer.print("pub const {s} = @intToPtr(*volatile {s}MmioInt({}, u{}), base_address + 0x{x});\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        width,
                        fields[0].width,
                        addr_offset,
                    })
                else
                    try writer.print("pub const {s} = @intToPtr(*volatile {s}MmioInt({}, u{}), 0x{x});\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        width,
                        fields[0].width,
                        addr_offset,
                    }),
                .contained => try writer.print("{s}: {s}MmioInt({}, u{}),\n", .{
                    std.zig.fmtId(name),
                    array_prefix,
                    width,
                    fields[0].width,
                }),
            }
        } else {
            switch (nesting) {
                .namespaced => try writer.print("pub const {s} = @intToPtr(*volatile {s}Mmio({}, packed struct {{\n", .{
                    std.zig.fmtId(name),
                    array_prefix,
                    width,
                }),
                .contained => try writer.print("{s}: {s}Mmio({}, packed struct {{\n", .{
                    std.zig.fmtId(name),
                    array_prefix,
                    width,
                }),
            }

            try db.genZigFields(
                writer,
                width,
                fields,
                field_range.begin,
            );

            switch (nesting) {
                .namespaced => if (has_base_addr)
                    try writer.print("}}), base_address + 0x{x});\n", .{addr_offset})
                else
                    try writer.print("}}), 0x{x});\n", .{addr_offset}),
                .contained => try writer.writeAll("}),\n"),
            }
        }
    } else {
        switch (nesting) {
            .namespaced => if (has_base_addr)
                if (width >= 8 and std.math.isPowerOfTwo(width))
                    try writer.print("pub const {s} = @intToPtr(*volatile {s}u{}, base_address + 0x{x});\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        width,
                        addr_offset,
                    })
                else {
                    const reg_width = reg_width: {
                        var reg_width: usize = 8;
                        while (reg_width < width) : (reg_width *= 2) {
                            if (reg_width > 128)
                                return error.TooBig; // artificial limit, probably something weird going on
                        }

                        break :reg_width reg_width;
                    };

                    try writer.print("pub const {s} = @intToPtr(*volatile {s}MmioInt({}, u{}), base_address + 0x{x});\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        reg_width,
                        width,
                        addr_offset,
                    });
                }
            else {
                if (width >= 8 and std.math.isPowerOfTwo(width))
                    try writer.print("pub const {s} = @intToPtr(*volatile {s}u{}, 0x{x});\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        width,
                        addr_offset,
                    })
                else {
                    const reg_width = reg_width: {
                        var reg_width: usize = 8;
                        while (reg_width < width) : (reg_width *= 2) {
                            if (reg_width > 128)
                                return error.TooBig; // artificial limit, probably something weird going on
                        }

                        break :reg_width reg_width;
                    };

                    try writer.print("pub const {s} = @intToPtr(*volatile {s}MmioInt({}, u{}), 0x{x});\n", .{
                        std.zig.fmtId(name),
                        array_prefix,
                        reg_width,
                        width,
                        addr_offset,
                    });
                }
            },
            .contained => try writer.print("{s}: {s}u{},\n", .{
                std.zig.fmtId(name),
                array_prefix,
                width,
            }),
        }
    }
}

fn genZigFields(
    db: *Database,
    writer: anytype,
    reg_width: usize,
    fields: []Field,
    first_field_idx: FieldIndex,
) !void {
    var expected_bit: usize = 0;
    var reserved_num: usize = 0;
    for (fields) |field, offset| {
        const field_idx = @intCast(FieldIndex, first_field_idx + offset);
        const dimension_opt = db.dimensions.fields.get(field_idx);

        if (dimension_opt) |dimension| {
            assert(std.mem.indexOf(u8, field.name, "[%s]") == null);

            if (dimension.index) |dim_index| switch (dim_index) {
                .list => |list| for (list.items) |entry| {
                    const name = try std.mem.replaceOwned(u8, db.arena.allocator(), field.name, "%s", entry);
                    try writer.print("{s}: u{},\n", .{ std.zig.fmtId(name), field.width });
                    expected_bit += field.width;
                },
                .num => |num| {
                    var i: usize = 0;
                    while (i < num) : (i += 1) {
                        const idx = try std.fmt.allocPrint(db.arena.allocator(), "{}", .{i});
                        const name = try std.mem.replaceOwned(u8, db.arena.allocator(), field.name, "%s", idx);
                        try writer.print("{s}: u{},\n", .{ std.zig.fmtId(name), field.width });
                        expected_bit += field.width;
                    }
                },
            } else {
                var i: usize = 0;
                while (i < dimension.dim) : (i += 1) {
                    const num_str = try std.fmt.allocPrint(db.arena.allocator(), "{}", .{i});
                    const name = try std.mem.replaceOwned(u8, db.arena.allocator(), field.name, "%s", num_str);
                    try writer.print("{s}: u{},\n", .{ std.zig.fmtId(name), field.width });
                    expected_bit += field.width;
                }
            }

            continue;
        }

        if (std.mem.indexOf(u8, field.name, "%s") != null)
            return error.MissingDimension;

        if (expected_bit > field.offset) {
            std.log.err("found overlapping fields in register:", .{});
            for (fields) |f| {
                std.log.err("  {s}: {}+{}", .{ f.name, f.offset, f.width });
            }
            return error.Explained;
        }

        while (expected_bit < field.offset) : ({
            expected_bit += 1;
            reserved_num += 1;
        }) {
            try writer.print("reserved{}: u1,\n", .{reserved_num});
        }

        if (expected_bit + field.width > reg_width) {
            for (fields[offset..]) |ignored| {
                std.log.warn("field '{s}' ({}-{}) in register is outside word size: {}", .{
                    ignored.name,
                    ignored.offset,
                    ignored.offset + ignored.width,
                    reg_width,
                });
            }
            break;
        }

        const enumerations_opt = if (db.enumerations_in_fields.get(field_idx)) |enum_range|
            db.enumerations.items[enum_range.begin..enum_range.end]
        else
            null;

        // TODO: default values?
        if (field.description) |description|
            if (!useless_descriptions.has(description)) {
                try writeDescription(db.arena.child_allocator, writer, description);
                if (enumerations_opt != null) {
                    try writer.writeAll("///\n");
                }
            };

        if (enumerations_opt) |enumerations| for (enumerations) |enumeration| {
            try writer.print("/// 0x{x}: ", .{enumeration.value});
            if (enumeration.description) |description|
                try writer.print("{s}\n", .{description})
            else
                try writer.writeAll("undocumented\n");
        };

        try writer.print("{s}: u{},\n", .{ std.zig.fmtId(field.name), field.width });

        expected_bit += field.width;
    }

    var padding_num: usize = 0;

    while (expected_bit < reg_width) : ({
        expected_bit += 1;
        padding_num += 1;
    }) {
        try writer.print("padding{}: u1,\n", .{padding_num});
    }
}

fn genZigRegister(
    db: *Database,
    writer: anytype,
    base_addr: ?u64,
    cluster_offset: ?u64,
    reg_idx: RegisterIndex,
    register: Register,
    nesting: Nesting,
) !void {
    const field_range = if (db.fields_in_registers.get(reg_idx)) |range| range else null;

    const dimension_opt = db.dimensions.registers.get(reg_idx);
    if (dimension_opt == null and std.mem.indexOf(u8, register.name, "%s") != null)
        return error.MissingDimension;

    const wants_list = dimension_opt != null and std.mem.indexOf(u8, register.name, "%s") != null and std.mem.indexOf(u8, register.name, "[%s]") == null;
    const is_list = if (dimension_opt) |dimension| if (dimension.index) |dim_index|
        dim_index == .list and std.mem.indexOf(u8, register.name, "[%s]") == null
    else
        false else false;

    if (is_list) {
        if (std.mem.indexOf(u8, register.name, "[%s]") != null) {
            std.log.info("register name: {s}", .{register.name});
            std.log.info("dimension: {?}", .{dimension_opt});
            return error.InvalidRegisterName;
        }

        const dimension = dimension_opt.?;
        for (dimension.index.?.list.items) |elem, i| {
            const name = try std.mem.replaceOwned(u8, db.arena.allocator(), register.name, "%s", elem);
            const addr_offset = register.addr_offset + (i * dimension.increment);

            try writer.writeByte('\n');
            if (nesting == .namespaced) {
                var addr: u64 = addr_offset;
                if (cluster_offset) |offset|
                    addr += offset;
                if (base_addr) |base|
                    addr += base;

                try writer.print("/// address: 0x{x}\n", .{addr});
            }

            if (register.description) |description|
                try writeDescription(db.arena.child_allocator, writer, description);

            try db.genZigSingleRegister(
                writer,
                name,
                register.size.?,
                base_addr != null,
                if (nesting == .namespaced)
                    if (cluster_offset) |offset|
                        offset + addr_offset
                    else
                        addr_offset
                else
                    addr_offset,
                field_range,
                "",
                nesting,
            );
        }

        return;
    } else if (wants_list) {
        if (std.mem.indexOf(u8, register.name, "[%s]") != null) {
            return error.InvalidRegisterName;
        }

        const dimension = dimension_opt.?;
        var i: usize = 0;
        while (i < dimension.dim) : (i += 1) {
            const num_str = try std.fmt.allocPrint(db.arena.allocator(), "{}", .{i});
            const name = try std.mem.replaceOwned(u8, db.arena.allocator(), register.name, "%s", num_str);
            const addr_offset = register.addr_offset + (i * dimension.increment);

            try writer.writeByte('\n');
            if (nesting == .namespaced) {
                var addr: u64 = addr_offset;
                if (cluster_offset) |offset|
                    addr += offset;
                if (base_addr) |base|
                    addr += base;

                try writer.print("/// address: 0x{x}\n", .{addr});
            }

            if (register.description) |description|
                try writeDescription(db.arena.child_allocator, writer, description);

            try db.genZigSingleRegister(
                writer,
                name,
                register.size.?,
                base_addr != null,
                if (nesting == .namespaced)
                    if (cluster_offset) |offset|
                        offset + addr_offset
                    else
                        addr_offset
                else
                    addr_offset,
                field_range,
                "",
                nesting,
            );
        }

        return;
    } else {
        if (std.mem.indexOf(u8, register.name, "[%s]") == null and std.mem.indexOf(u8, register.name, "%s") != null) {
            std.log.err("register: {s}", .{register.name});
            return error.InvalidRegisterName;
        }

        const array_prefix: []const u8 = if (dimension_opt) |dimension| blk: {
            if (dimension.increment != register.size.? / 8) {
                std.log.err("register: {s}", .{register.name});
                std.log.err("size: {?}", .{register.size});
                std.log.err("dimension: {}", .{dimension});
                return error.InvalidArrayIncrement;
            }

            // if index is set, then it must be a comma separated list of numbers 0 to dim - 1
            if (dimension.index) |dim_index| switch (dim_index) {
                .list => |list| {
                    var expected_num: usize = 0;
                    while (expected_num < dimension.dim) : (expected_num += 1) {
                        const num = try std.fmt.parseInt(usize, list.items[expected_num], 0);
                        if (num != expected_num)
                            return error.InvalidDimIndex;
                    }
                },
                .num => |num| if (num != dimension.dim) {
                    return error.InvalidDimIndex;
                },
            };

            break :blk try std.fmt.allocPrint(db.arena.allocator(), "[{}]", .{dimension.dim});
        } else "";

        const name = try std.mem.replaceOwned(u8, db.arena.allocator(), register.name, "[%s]", "");
        try writer.writeByte('\n');
        if (nesting == .namespaced) {
            var addr = register.addr_offset;
            if (cluster_offset) |offset|
                addr += offset;
            if (base_addr) |base|
                addr += base;

            try writer.print("/// address: 0x{x}\n", .{addr});
        }

        if (register.description) |description|
            try writeDescription(db.arena.child_allocator, writer, description);

        try db.genZigSingleRegister(
            writer,
            name,
            register.size.?,
            base_addr != null,
            if (nesting == .namespaced)
                if (cluster_offset) |offset|
                    offset + register.addr_offset
                else
                    register.addr_offset
            else
                register.addr_offset,
            field_range,
            array_prefix,
            nesting,
        );

        return;
    }

    std.log.info("register {}: {s}", .{ reg_idx, register.name });
    std.log.info("  nesting: {}", .{nesting});
    if (dimension_opt) |dimension| {
        std.log.info("  dim: {}", .{dimension.dim});
        std.log.info("  dim_index: {}", .{dimension.index});
    }

    assert(false); // haven't figured out this configuration yet
}

pub fn toJson(writer: anytype) !void {
    _ = writer;
    return error.Todo;
}

// TODO: might have to make the index type a param
fn findIndexOfContainer(db: Database, comptime map_field: []const u8, contained_idx: u32) ?u32 {
    var iterator = @field(db, map_field).iterator();
    return while (iterator.next()) |entry| {
        if (entry.value_ptr.contains(contained_idx))
            break entry.key_ptr.*;
    } else null;
}

fn findClusterContainingRegister(db: Database, reg_idx: RegisterIndex) ?ClusterIndex {
    return db.findIndexOfContainer("registers_in_clusters", reg_idx);
}

fn findClusterContainingCluster(db: Database, cluster_idx: ClusterIndex) ?ClusterIndex {
    return for (db.clusters_in_clusters.items) |cic| {
        if (cic.child_idx == cluster_idx)
            break cic.parent_idx;
    } else null;
}

fn findPeripheralContainingRegister(db: Database, reg_idx: RegisterIndex) ?PeripheralIndex {
    return db.findIndexOfContainer("registers_in_peripherals", reg_idx);
}

fn findPeripheralContainingCluster(db: Database, cluster_idx: ClusterIndex) ?PeripheralIndex {
    return for (db.clusters_in_peripherals.items) |cip| {
        if (cip.cluster_idx == cluster_idx)
            break cip.peripheral_idx;
    } else null;
}

fn registerPropertyUpwardsSearch(
    db: Database,
    comptime T: type,
    comptime field: []const u8,
    reg_idx: RegisterIndex,
    clusters: []const ClusterIndex,
    peripheral_idx: PeripheralIndex,
) ?T {
    return @field(db.register_properties.register, field).get(reg_idx) orelse
        for (clusters) |cluster_idx|
    {
        if (@field(db.register_properties.cluster, field).get(cluster_idx)) |value| {
            break value;
        }
    } else @field(db.register_properties.peripheral, field).get(peripheral_idx) orelse
        @field(db.device.?.register_properties, field);
}

pub fn getRegister(
    db: Database,
    reg_idx: RegisterIndex,
) !Register {
    if (reg_idx >= db.registers.items.len)
        return error.NotFound;

    const register = db.registers.items[reg_idx];
    var clusters = std.ArrayListUnmanaged(ClusterIndex){};
    defer clusters.deinit(db.gpa);

    while (true) {
        const cluster_idx = if (clusters.items.len == 0)
            db.findClusterContainingRegister(reg_idx) orelse break
        else
            db.findClusterContainingCluster(clusters.items[clusters.items.len - 1]) orelse break;

        try clusters.append(db.gpa, cluster_idx);
    }

    const peripheral_idx = if (clusters.items.len == 0)
        db.findPeripheralContainingRegister(reg_idx) orelse
            return error.PeripheralNotFound
    else
        db.findPeripheralContainingCluster(clusters.items[clusters.items.len - 1]) orelse
            return error.PeripheralNotFound;

    const size: u16 = db.registerPropertyUpwardsSearch(
        u16,
        "size",
        reg_idx,
        clusters.items,
        peripheral_idx,
    ) orelse if (db.device) |device| device.width else return error.SizeNotFound;

    const access: Access = db.registerPropertyUpwardsSearch(
        Access,
        "access",
        reg_idx,
        clusters.items,
        peripheral_idx,
    ) orelse .read_write;

    const reset_value: u64 = db.registerPropertyUpwardsSearch(
        u64,
        "reset_value",
        reg_idx,
        clusters.items,
        peripheral_idx,
    ) orelse 0;

    const reset_mask: u64 = db.registerPropertyUpwardsSearch(
        u64,
        "reset_mask",
        reg_idx,
        clusters.items,
        peripheral_idx,
    ) orelse std.math.maxInt(u64);

    return Register{
        .name = register.name,
        .description = register.description,
        .addr_offset = register.addr_offset,
        .size = size,
        .access = access,
        .reset_value = reset_value,
        .reset_mask = reset_mask,
    };
}

pub fn addClusterToPeripheral(
    db: *Database,
    peripheral: PeripheralIndex,
    cluster: svd.Cluster,
) !ClusterIndex {
    const cluster_idx = @intCast(ClusterIndex, db.clusters.items.len);
    try db.clusters.append(db.gpa, cluster);
    try db.clusters_in_peripherals.append(db.gpa, .{
        .peripheral_idx = peripheral,
        .cluster_idx = cluster_idx,
    });

    // TODO: register properties and dimensions
    return cluster_idx;
}

pub fn addFieldsToRegister(db: *Database, register: RegisterIndex, fields: []const Field) !void {
    const begin = @intCast(FieldIndex, db.fields.items.len);
    try db.fields.appendSlice(db.gpa, fields);
    try db.fields_in_registers.put(db.gpa, register, .{
        .begin = begin,
        .end = @intCast(FieldIndex, db.fields.items.len),
    });
}

pub fn addRegistersToCluster(db: *Database, cluster: ClusterIndex, registers: []const Register) !IndexRange(RegisterIndex) {
    const begin = @intCast(RegisterIndex, db.registers.items.len);
    try db.registers.appendSlice(db.gpa, registers);

    const range = IndexRange(RegisterIndex){
        .begin = begin,
        .end = @intCast(RegisterIndex, db.registers.items.len),
    };
    try db.registers_in_clusters.put(db.gpa, cluster, range);

    // TODO: register properties and dimensions
    return range;
}

pub fn addSystemRegisterAddresses(
    db: *Database,
    peripheral_idx: PeripheralIndex,
    cluster_idx: ?ClusterIndex,
    regs: IndexRange(RegisterIndex),
) !void {
    const peripheral = db.peripherals.items[peripheral_idx];
    const base_address = if (peripheral.base_addr) |periph_base_addr|
        if (cluster_idx) |ci|
            periph_base_addr + db.clusters.items[ci].addr_offset
        else
            periph_base_addr
    else
        0;

    for (db.registers.items[regs.begin..regs.end]) |register|
        try db.system_reg_addrs.put(db.gpa, base_address + register.addr_offset, {});
}

fn Derivations(comptime T: type) type {
    return struct {
        enumerations: std.AutoHashMapUnmanaged(EnumIndex, T) = .{},
        fields: std.AutoHashMapUnmanaged(FieldIndex, T) = .{},
        registers: std.AutoHashMapUnmanaged(RegisterIndex, T) = .{},
        clusters: std.AutoHashMapUnmanaged(ClusterIndex, T) = .{},
        peripherals: std.AutoHashMapUnmanaged(PeripheralIndex, T) = .{},

        fn deinit(derivations: *@This(), allocator: Allocator) void {
            derivations.enumerations.deinit(allocator);
            derivations.fields.deinit(allocator);
            derivations.registers.deinit(allocator);
            derivations.clusters.deinit(allocator);
            derivations.peripherals.deinit(allocator);
        }
    };
}

const Dimensions = struct {
    fields: std.AutoHashMapUnmanaged(FieldIndex, svd.Dimension) = .{},
    registers: std.AutoHashMapUnmanaged(RegisterIndex, svd.Dimension) = .{},
    clusters: std.AutoHashMapUnmanaged(ClusterIndex, svd.Dimension) = .{},
    peripherals: std.AutoHashMapUnmanaged(PeripheralIndex, svd.Dimension) = .{},

    fn deinit(dimensions: *@This(), allocator: Allocator) void {
        dimensions.fields.deinit(allocator);
        dimensions.registers.deinit(allocator);
        dimensions.clusters.deinit(allocator);
        dimensions.peripherals.deinit(allocator);
    }
};

const useless_descriptions = std.ComptimeStringMap(void, .{
    .{"Unspecified"},
});

const useless_field_names = std.ComptimeStringMap(void, .{
    .{"RESERVED"},
});

pub fn format(
    db: Database,
    comptime fmt: []const u8,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = db;
    _ = options;
    _ = fmt;
    try writer.writeAll("Regz Database:\n");
    if (db.interrupts.items.len > 0) {
        try writer.writeAll("  Interrupts:\n");
        for (db.interrupts.items) |interrupt|
            try writer.print("    {}\n", .{interrupt});
    }

    if (db.peripherals.items.len > 0) {
        try writer.writeAll("  Peripherals:\n");
        for (db.peripherals.items) |peripheral, i|
            try writer.print("    {}: {}\n", .{ i, peripheral });
    }

    if (db.registers.items.len > 0) {
        try writer.writeAll("  Registers:\n");
        for (db.registers.items) |register, i|
            try writer.print("    {}: {}\n", .{ i, register });
    }

    if (db.fields.items.len > 0) {
        try writer.writeAll("  Fields:\n");
        for (db.fields.items) |field, i|
            try writer.print("    {}: {}\n", .{ i, field });
    }
}
