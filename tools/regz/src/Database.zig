const std = @import("std");
const build_options = @import("build_options");
const svd = @import("svd.zig");
const xml = @import("xml.zig");
const atdf = @import("atdf.zig");
const Peripheral = @import("Peripheral.zig");
const Register = @import("Register.zig");
const Field = @import("Field.zig");
const Enumeration = @import("Enumeration.zig");

const assert = std.debug.assert;
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;

const Self = @This();

const Range = struct {
    begin: u32,
    end: u32,
};

const PeripheralUsesInterrupt = struct {
    peripheral_idx: u32,
    interrupt_value: u32,
};

const FieldsInRegister = struct {
    register_idx: u32,
    field_range: Range,
};

const ClusterInPeripheral = struct {
    peripheral_idx: u32,
    cluster_idx: u32,
};

const ClusterInCluster = struct {
    parent_idx: u32,
    child_idx: u32,
};

const Nesting = enum {
    namespaced,
    contained,
};

allocator: Allocator,
arena: ArenaAllocator,
device: ?svd.Device,
cpu: ?svd.Cpu,
interrupts: std.ArrayList(svd.Interrupt),
peripherals: std.ArrayList(Peripheral),
clusters: std.ArrayList(svd.Cluster),
registers: std.ArrayList(Register),
fields: std.ArrayList(Field),
enumerations: std.ArrayList(Enumeration),
peripherals_use_interrupts: std.ArrayList(PeripheralUsesInterrupt),
clusters_in_peripherals: std.ArrayList(ClusterInPeripheral),
clusters_in_clusters: std.ArrayList(ClusterInCluster),
registers_in_peripherals: std.AutoHashMap(u32, Range),
registers_in_clusters: std.AutoHashMap(u32, Range),
fields_in_registers: std.AutoHashMap(u32, Range),
enumerations_in_fields: std.AutoHashMap(u32, Range),
dimensions: Dimensions,

/// takes ownership of arena allocator
fn init(allocator: Allocator) Self {
    return Self{
        .allocator = allocator,
        .arena = ArenaAllocator.init(allocator),
        .device = null,
        .cpu = null,
        .interrupts = std.ArrayList(svd.Interrupt).init(allocator),
        .peripherals = std.ArrayList(Peripheral).init(allocator),
        .clusters = std.ArrayList(svd.Cluster).init(allocator),
        .registers = std.ArrayList(Register).init(allocator),
        .fields = std.ArrayList(Field).init(allocator),
        .enumerations = std.ArrayList(Enumeration).init(allocator),
        .peripherals_use_interrupts = std.ArrayList(PeripheralUsesInterrupt).init(allocator),
        .clusters_in_peripherals = std.ArrayList(ClusterInPeripheral).init(allocator),
        .clusters_in_clusters = std.ArrayList(ClusterInCluster).init(allocator),
        .registers_in_peripherals = std.AutoHashMap(u32, Range).init(allocator),
        .registers_in_clusters = std.AutoHashMap(u32, Range).init(allocator),
        .fields_in_registers = std.AutoHashMap(u32, Range).init(allocator),
        .enumerations_in_fields = std.AutoHashMap(u32, Range).init(allocator),
        .dimensions = Dimensions.init(allocator),
    };
}

pub fn deinit(self: *Self) void {
    self.interrupts.deinit();
    self.peripherals.deinit();
    self.clusters.deinit();
    self.registers.deinit();
    self.fields.deinit();
    self.enumerations.deinit();
    self.peripherals_use_interrupts.deinit();
    self.registers_in_peripherals.deinit();
    self.fields_in_registers.deinit();
    self.clusters_in_peripherals.deinit();
    self.clusters_in_clusters.deinit();
    self.registers_in_clusters.deinit();
    self.enumerations_in_fields.deinit();
    self.dimensions.deinit();
    self.arena.deinit();
}

pub fn initFromSvd(allocator: Allocator, doc: *xml.Doc) !Self {
    const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
    const device_node = xml.findNode(root_element, "device") orelse return error.NoDevice;
    const device_nodes: *xml.Node = device_node.children orelse return error.NoDeviceNodes;

    var db = Self.init(allocator);
    errdefer db.deinit();

    db.device = try svd.Device.parse(&db.arena, device_nodes);
    db.cpu = if (xml.findNode(device_nodes, "cpu")) |cpu_node|
        try svd.Cpu.parse(&db.arena, @ptrCast(*xml.Node, cpu_node.children orelse return error.NoCpu))
    else
        null;

    var named_derivations = Derivations([]const u8).init(allocator);
    defer named_derivations.deinit();

    if (xml.findNode(device_nodes, "peripherals")) |peripherals_node| {
        var peripheral_it: ?*xml.Node = xml.findNode(peripherals_node.children, "peripheral"); //peripherals_node.children;
        while (peripheral_it != null) : (peripheral_it = xml.findNode(peripheral_it.?.next, "peripheral")) {
            const peripheral_nodes: *xml.Node = peripheral_it.?.children orelse continue;
            const peripheral = try svd.parsePeripheral(&db.arena, peripheral_nodes);
            try db.peripherals.append(peripheral);

            const peripheral_idx = @intCast(u32, db.peripherals.items.len - 1);
            if (xml.getAttribute(peripheral_it, "derivedFrom")) |derived_from|
                try named_derivations.peripherals.put(peripheral_idx, try db.arena.allocator().dupe(u8, derived_from));

            if (try svd.Dimension.parse(&db.arena, peripheral_nodes)) |dimension|
                try db.dimensions.peripherals.put(peripheral_idx, dimension);

            var interrupt_it: ?*xml.Node = xml.findNode(peripheral_nodes, "interrupt");
            while (interrupt_it != null) : (interrupt_it = xml.findNode(interrupt_it.?.next, "interrupt")) {
                const interrupt_nodes: *xml.Node = interrupt_it.?.children orelse continue;
                const interrupt = try svd.Interrupt.parse(&db.arena, interrupt_nodes);

                try db.peripherals_use_interrupts.append(.{
                    .peripheral_idx = peripheral_idx,
                    .interrupt_value = @intCast(u32, interrupt.value),
                });

                // if the interrupt doesn't exist then do a sorted insert
                if (std.sort.binarySearch(svd.Interrupt, interrupt, db.interrupts.items, {}, svd.Interrupt.compare) == null) {
                    try db.interrupts.append(interrupt);
                    std.sort.sort(svd.Interrupt, db.interrupts.items, {}, svd.Interrupt.lessThan);
                }
            }

            if (xml.findNode(peripheral_nodes, "registers")) |registers_node| {
                const reg_begin_idx = db.registers.items.len;
                try db.loadRegisters(registers_node.children, &named_derivations);
                try db.registers_in_peripherals.put(peripheral_idx, .{
                    .begin = @intCast(u32, reg_begin_idx),
                    .end = @intCast(u32, db.registers.items.len),
                });

                // process clusters, this might need to be recursive
                var cluster_it: ?*xml.Node = xml.findNode(registers_node.children, "cluster");
                while (cluster_it != null) : (cluster_it = xml.findNode(cluster_it.?.next, "cluster")) {
                    const cluster_nodes: *xml.Node = cluster_it.?.children orelse continue;
                    const cluster = try svd.Cluster.parse(&db.arena, cluster_nodes);
                    try db.clusters.append(cluster);

                    const cluster_idx = @intCast(u32, db.clusters.items.len - 1);
                    if (xml.getAttribute(cluster_it, "derivedFrom")) |derived_from|
                        try named_derivations.clusters.put(cluster_idx, try db.arena.allocator().dupe(u8, derived_from));

                    if (try svd.Dimension.parse(&db.arena, cluster_nodes)) |dimension|
                        try db.dimensions.clusters.put(cluster_idx, dimension);

                    try db.clusters_in_peripherals.append(.{
                        .cluster_idx = cluster_idx,
                        .peripheral_idx = peripheral_idx,
                    });

                    const first_reg_idx = db.registers.items.len;
                    try db.loadRegisters(cluster_nodes, &named_derivations);
                    try db.registers_in_clusters.put(cluster_idx, .{
                        .begin = @intCast(u32, first_reg_idx),
                        .end = @intCast(u32, db.registers.items.len),
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
    var derivations = Derivations(u32).init(allocator);
    defer derivations.deinit();
    {
        var it = named_derivations.peripherals.iterator();
        while (it.next()) |entry| {
            const base_name = entry.value_ptr.*;
            const idx = @intCast(u32, for (db.peripherals.items) |peripheral, i| {
                if (std.mem.eql(u8, base_name, peripheral.name))
                    break i;
            } else return error.DerivationNotFound);
            try derivations.peripherals.put(entry.key_ptr.*, idx);
        }

        it = named_derivations.registers.iterator();
        while (it.next()) |entry| {
            const base_name = entry.value_ptr.*;
            const idx = @intCast(u32, for (db.registers.items) |register, i| {
                if (std.mem.eql(u8, base_name, register.name))
                    break i;
            } else return error.DerivationNotFound);
            try derivations.registers.put(entry.key_ptr.*, idx);
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
                try db.registers_in_peripherals.put(child_idx, parent_range)
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
                try db.fields_in_registers.put(child_idx, field_range)
            else
                std.log.warn("register '{s}' derived from '{s}', but the latter does not have fields", .{
                    db.registers.items[child_idx].name, db.registers.items[parent_idx].name,
                });
        }
    }

    return db;
}

fn loadRegisters(
    db: *Self,
    nodes: ?*xml.Node,
    named_derivations: *Derivations([]const u8),
) !void {
    var register_it: ?*xml.Node = xml.findNode(nodes, "register");
    while (register_it != null) : (register_it = xml.findNode(register_it.?.next, "register")) {
        const register_nodes: *xml.Node = register_it.?.children orelse continue;
        const register = try svd.parseRegister(&db.arena, register_nodes, db.device.?.register_properties.size orelse db.device.?.width);
        const register_idx = @intCast(u32, db.registers.items.len);
        try db.registers.append(register);

        if (xml.getAttribute(register_it, "derivedFrom")) |derived_from|
            try named_derivations.registers.put(register_idx, try db.arena.allocator().dupe(u8, derived_from));

        if (try svd.Dimension.parse(&db.arena, register_nodes)) |dimension|
            try db.dimensions.registers.put(register_idx, dimension);

        const field_begin_idx = @intCast(u32, db.fields.items.len);
        if (xml.findNode(register_nodes, "fields")) |fields_node| {
            var field_it: ?*xml.Node = xml.findNode(fields_node.children, "field");
            while (field_it != null) : (field_it = xml.findNode(field_it.?.next, "field")) {
                const field_nodes: *xml.Node = field_it.?.children orelse continue;
                const field_name = xml.findValueForKey(field_nodes, "name") orelse continue;
                if (useless_field_names.has(field_name))
                    continue;

                const field = try svd.parseField(&db.arena, field_nodes);
                try db.fields.append(field);

                const field_idx = @intCast(u32, db.fields.items.len - 1);
                if (xml.getAttribute(field_it, "derivedFrom")) |derived_from|
                    try named_derivations.fields.put(field_idx, try db.arena.allocator().dupe(u8, derived_from));

                if (try svd.Dimension.parse(&db.arena, field_nodes)) |dimension|
                    try db.dimensions.fields.put(field_idx, dimension);

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

        // TODO: can we use unions for overlapping fields?
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
            try db.fields_in_registers.put(register_idx, .{
                .begin = field_begin_idx,
                .end = @intCast(u32, db.fields.items.len),
            });
    }
}

// TODO: record order somehow (clusters vs. register)
fn loadNestedClusters(
    db: *Self,
    nodes: ?*xml.Node,
    named_derivations: *Derivations([]const u8),
) anyerror!void {
    const parent_idx = @intCast(u32, db.clusters.items.len - 1);

    var cluster_it: ?*xml.Node = xml.findNode(nodes, "cluster");
    while (cluster_it != null) : (cluster_it = xml.findNode(cluster_it.?.next, "cluster")) {
        const cluster_nodes: *xml.Node = cluster_it.?.children orelse continue;
        const cluster = try svd.Cluster.parse(&db.arena, cluster_nodes);
        try db.clusters.append(cluster);

        const cluster_idx = @intCast(u32, db.clusters.items.len - 1);
        if (xml.getAttribute(cluster_it, "derivedFrom")) |derived_from|
            try named_derivations.clusters.put(cluster_idx, try db.arena.allocator().dupe(u8, derived_from));

        if (try svd.Dimension.parse(&db.arena, cluster_nodes)) |dimension|
            try db.dimensions.clusters.put(cluster_idx, dimension);

        try db.clusters_in_clusters.append(.{
            .parent_idx = parent_idx,
            .child_idx = cluster_idx,
        });

        const first_reg_idx = db.registers.items.len;
        try db.loadRegisters(cluster_nodes, named_derivations);
        try db.registers_in_clusters.put(cluster_idx, .{
            .begin = @intCast(u32, first_reg_idx),
            .end = @intCast(u32, db.registers.items.len),
        });

        try db.loadNestedClusters(cluster_nodes, named_derivations);
    }
}

pub fn initFromAtdf(allocator: Allocator, doc: *xml.Doc) !Self {
    const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
    const tools_node = xml.findNode(root_element, "avr-tools-device-file") orelse return error.NoToolsNode;
    var regs_start_addr: usize = 0;

    var peripheral_instances = std.StringHashMap(void).init(allocator);
    defer peripheral_instances.deinit();

    var db = Self.init(allocator);
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
            };

            const device_nodes: *xml.Node = device_it.?.children orelse continue;
            regs_start_addr = if (xml.findNode(device_nodes, "address-spaces")) |address_spaces_node| blk: {
                var ret: ?usize = null;
                var address_space_it: ?*xml.Node = xml.findNode(address_spaces_node.children.?, "address-space");
                while (address_space_it != null) : (address_space_it = xml.findNode(address_space_it.?.next, "address-space")) {
                    const address_space_nodes: *xml.Node = address_space_it.?.children orelse continue;
                    var memory_segment_it: ?*xml.Node = xml.findNode(address_space_nodes, "memory-segment");
                    while (memory_segment_it != null) : (memory_segment_it = xml.findNode(memory_segment_it.?.next, "memory-segment")) {
                        const memory_type = xml.getAttribute(memory_segment_it, "type") orelse continue;
                        if (std.mem.eql(u8, "regs", memory_type)) {
                            if (ret != null) {
                                std.log.err("multiple register memory segments found, no idea what to do, please cut a ticket: https://github.com/ZigEmbeddedGroup/regz", .{});
                                return error.Explained;
                            } else if (xml.getAttribute(memory_segment_it, "start")) |addr_str| {
                                ret = try std.fmt.parseInt(usize, addr_str, 0);
                            }
                        }
                    }
                }

                if (ret) |start_address| {
                    break :blk start_address;
                } else {
                    std.log.err("failed to determine the start address for registers", .{});
                    return error.Explained;
                }
            } else unreachable;

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
                        try db.interrupts.append(interrupt);
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

            var value_groups = std.StringHashMap(Range).init(allocator);
            defer value_groups.deinit();

            var value_group_it: ?*xml.Node = xml.findNode(module_nodes, "value-group");
            while (value_group_it != null) : (value_group_it = xml.findNode(value_group_it.?.next, "value-group")) {
                const value_group_nodes: *xml.Node = value_group_it.?.children orelse continue;
                const value_group_name = if (xml.getAttribute(value_group_it, "name")) |name|
                    try db.arena.allocator().dupe(u8, name)
                else
                    continue;

                const first_enum_idx = @intCast(u32, db.enumerations.items.len);
                var value_it: ?*xml.Node = xml.findNode(value_group_nodes, "value");
                while (value_it != null) : (value_it = xml.findNode(value_it.?.next, "value")) {
                    try db.enumerations.append(.{
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
                    .end = @intCast(u32, db.enumerations.items.len),
                });
            }

            var register_group_it: ?*xml.Node = xml.findNode(module_nodes, "register-group");
            while (register_group_it != null) : (register_group_it = xml.findNode(register_group_it.?.next, "register-group")) {
                const register_group_nodes: *xml.Node = register_group_it.?.children orelse continue;
                const group_name = xml.getAttribute(register_group_it, "name") orelse continue;
                if (!peripheral_instances.contains(group_name))
                    continue;

                const peripheral_idx = @intCast(u32, db.peripherals.items.len);
                try db.peripherals.append(try atdf.parsePeripheral(&db.arena, register_group_it.?));

                const reg_begin_idx = @intCast(u32, db.registers.items.len);
                var register_it: ?*xml.Node = xml.findNode(register_group_nodes, "register");
                while (register_it != null) : (register_it = xml.findNode(register_it.?.next, "register")) {
                    const register_idx = @intCast(u32, db.registers.items.len);
                    try db.registers.append(try atdf.parseRegister(&db.arena, register_it.?, regs_start_addr, register_it.?.children != null));

                    const register_nodes: *xml.Node = register_it.?.children orelse continue;
                    const field_begin_idx = @intCast(u32, db.fields.items.len);
                    var bitfield_it: ?*xml.Node = xml.findNode(register_nodes, "bitfield");
                    while (bitfield_it != null) : (bitfield_it = xml.findNode(bitfield_it.?.next, "bitfield")) {
                        try db.fields.append(atdf.parseField(&db.arena, bitfield_it.?) catch |err| switch (err) {
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
                                    break field_begin_idx + @intCast(u32, offset);
                            } else continue;

                            if (value_groups.get(value_group_name)) |enum_range|
                                try db.enumerations_in_fields.put(field_idx, enum_range);
                        }
                    }

                    try db.fields_in_registers.put(register_idx, .{
                        .begin = field_begin_idx,
                        .end = @intCast(u32, db.fields.items.len),
                    });
                }

                try db.registers_in_peripherals.put(peripheral_idx, .{
                    .begin = reg_begin_idx,
                    .end = @intCast(u32, db.registers.items.len),
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

pub fn toZig(self: *Self, out_writer: anytype) !void {
    if (self.device == null) {
        std.log.err("failed to find device info", .{});
        return error.Explained;
    }

    var fifo = std.fifo.LinearFifo(u8, .Dynamic).init(self.allocator);
    defer fifo.deinit();

    const writer = fifo.writer();

    try writer.print(
        \\// this file was generated by regz: https://github.com/ZigEmbeddedGroup/regz
        \\// commit: {s}
    , .{build_options.commit});
    try writer.writeAll("//\n");
    if (self.device.?.vendor) |vendor_name|
        try writer.print("// vendor: {s}\n", .{vendor_name});

    if (self.device.?.name) |device_name|
        try writer.print("// device: {s}\n", .{device_name});

    if (self.cpu) |cpu| if (cpu.name) |cpu_name|
        try writer.print("// cpu: {s}\n", .{cpu_name});

    if (self.interrupts.items.len > 0 and self.cpu != null) {
        if (svd.CpuName.parse(self.cpu.?.name.?)) |cpu_type| {
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
            for (self.interrupts.items) |interrupt| {
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
                    try writeDescription(self.arena.child_allocator, writer, description);

                try writer.print("    {s}: InterruptVector = unhandled,\n", .{std.zig.fmtId(interrupt.name)});
                expected += 1;
            }

            try writer.writeAll("};\n");
        }
    }

    if (self.registers.items.len > 0) {
        try writer.writeAll("\npub const registers = struct {\n");
        for (self.peripherals.items) |peripheral, i| {
            const peripheral_idx = @intCast(u32, i);
            const has_registers = self.registers_in_peripherals.contains(peripheral_idx);
            const has_clusters = for (self.clusters_in_peripherals.items) |cip| {
                if (cip.peripheral_idx == peripheral_idx)
                    break true;
            } else false;

            if (!has_registers and !has_clusters)
                continue;

            if (self.dimensions.peripherals.get(peripheral_idx)) |_| {
                std.log.warn("dimensioned peripherals not supported yet: {s}", .{peripheral.name});
                continue;
            }

            const reg_range = self.registers_in_peripherals.get(peripheral_idx).?;
            const registers = self.registers.items[reg_range.begin..reg_range.end];
            if (registers.len != 0 or has_clusters) {
                if (peripheral.description) |description| if (!useless_descriptions.has(description)) {
                    try writer.writeByte('\n');
                    try writeDescription(self.arena.child_allocator, writer, description);
                };

                try writer.print("    pub const {s} = struct {{\n", .{std.zig.fmtId(peripheral.name)});
                if (peripheral.base_addr) |base_addr|
                    try writer.print("        pub const base_address = 0x{x};\n", .{base_addr});

                if (peripheral.version) |version|
                    try writer.print("        pub const version = \"{s}\";\n", .{version});

                for (registers) |_, range_offset| {
                    const reg_idx = @intCast(u32, reg_range.begin + range_offset);
                    try self.genZigRegister(writer, peripheral.base_addr, reg_idx, .namespaced);
                }

                if (has_clusters) {
                    for (self.clusters_in_peripherals.items) |cip| {
                        if (cip.peripheral_idx == peripheral_idx) {
                            try self.genZigCluster(writer, peripheral.base_addr, cip.cluster_idx, .namespaced);
                        }
                    }

                    for (self.clusters_in_clusters.items) |cic| {
                        const nested = self.clusters.items[cic.child_idx];
                        std.log.warn("nested clusters not supported yet: {s}", .{nested.name});
                    }
                }

                try writer.writeAll("    };\n");
            }
        }

        try writer.writeAll("};\n");
    }

    try writer.writeAll("\n" ++ @embedFile("mmio.zig"));

    // write zero to fifo so that it's null terminated
    try writer.writeByte(0);
    const text = fifo.readableSlice(0);
    var ast = try std.zig.parse(self.allocator, @bitCast([:0]const u8, text[0 .. text.len - 1]));
    defer ast.deinit(self.allocator);

    const formatted_text = try ast.render(self.allocator);
    defer self.allocator.free(formatted_text);

    try out_writer.writeAll(formatted_text);
}

fn genZigCluster(
    db: *Self,
    writer: anytype,
    base_addr: ?usize,
    cluster_idx: u32,
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

                // TODO: check address offset of register wrt the cluster
                var bits: usize = 0;
                for (registers) |register, offset| {
                    const reg_idx = @intCast(u32, range.begin + offset);
                    try db.genZigRegister(writer, base_addr, reg_idx, .contained);
                    bits += register.size;
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
                    const reg_idx = @intCast(u32, range.begin + offset);
                    try db.genZigRegister(writer, base_addr, reg_idx, .namespaced);
                }

                try writer.writeAll("};\n");
            }
        },
        .contained => {},
    }
}

fn genZigSingleRegister(
    self: *Self,
    writer: anytype,
    name: []const u8,
    width: usize,
    has_base_addr: bool,
    addr_offset: usize,
    field_range_opt: ?Range,
    array_prefix: []const u8,
    nesting: Nesting,
) !void {
    if (field_range_opt) |field_range| {
        const fields = self.fields.items[field_range.begin..field_range.end];
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

            try self.genZigFields(
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
    }
}

fn genZigFields(
    self: *Self,
    writer: anytype,
    reg_width: usize,
    fields: []Field,
    first_field_idx: u32,
) !void {
    var expected_bit: usize = 0;
    var reserved_num: usize = 0;
    for (fields) |field, offset| {
        const field_idx = @intCast(u32, first_field_idx + offset);
        const dimension_opt = self.dimensions.fields.get(field_idx);

        if (dimension_opt) |dimension| {
            assert(std.mem.indexOf(u8, field.name, "[%s]") == null);

            if (dimension.index) |dim_index| switch (dim_index) {
                .list => |list| for (list.items) |entry| {
                    const name = try std.mem.replaceOwned(u8, self.arena.allocator(), field.name, "%s", entry);
                    try writer.print("{s}: u{},\n", .{ std.zig.fmtId(name), field.width });
                    expected_bit += field.width;
                },
                .num => {
                    std.log.warn("dimensioned register fields not supported yet: {s}", .{field.name});
                    assert(false);
                },
            } else {
                var i: usize = 0;
                while (i < dimension.dim) : (i += 1) {
                    const num_str = try std.fmt.allocPrint(self.arena.allocator(), "{}", .{i});
                    const name = try std.mem.replaceOwned(u8, self.arena.allocator(), field.name, "%s", num_str);
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

        const enumerations_opt = if (self.enumerations_in_fields.get(field_idx)) |enum_range|
            self.enumerations.items[enum_range.begin..enum_range.end]
        else
            null;

        // TODO: default values?
        if (field.description) |description|
            if (!useless_descriptions.has(description)) {
                try writeDescription(self.arena.child_allocator, writer, description);
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
    self: *Self,
    writer: anytype,
    base_addr: ?usize,
    reg_idx: u32,
    nesting: Nesting,
) !void {
    const register = self.registers.items[reg_idx];
    const field_range = if (self.fields_in_registers.get(reg_idx)) |range| range else null;

    const dimension_opt = self.dimensions.registers.get(reg_idx);
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
            std.log.info("dimension: {s}", .{dimension_opt});
            return error.InvalidRegisterName;
        }

        const dimension = dimension_opt.?;
        for (dimension.index.?.list.items) |elem, i| {
            const name = try std.mem.replaceOwned(u8, self.arena.allocator(), register.name, "%s", elem);
            const addr_offset = register.addr_offset + (i * dimension.increment);

            try writer.writeByte('\n');
            if (nesting == .namespaced) {
                const addr = if (base_addr) |base| base + addr_offset else addr_offset;
                try writer.print("/// address: 0x{x}\n", .{addr});
            }

            if (register.description) |description|
                try writeDescription(self.arena.child_allocator, writer, description);

            try self.genZigSingleRegister(
                writer,
                name,
                register.size,
                base_addr != null,
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
            const num_str = try std.fmt.allocPrint(self.arena.allocator(), "{}", .{i});
            const name = try std.mem.replaceOwned(u8, self.arena.allocator(), register.name, "%s", num_str);
            const addr_offset = register.addr_offset + (i * dimension.increment);

            try writer.writeByte('\n');
            if (nesting == .namespaced) {
                const addr = if (base_addr) |base| base + addr_offset else addr_offset;
                try writer.print("/// address: 0x{x}\n", .{addr});
            }

            if (register.description) |description|
                try writeDescription(self.arena.child_allocator, writer, description);

            try self.genZigSingleRegister(
                writer,
                name,
                register.size,
                base_addr != null,
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
            if (dimension.increment != register.size / 8) {
                std.log.err("register: {s}", .{register.name});
                std.log.err("size: {}", .{register.size});
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

            break :blk try std.fmt.allocPrint(self.arena.allocator(), "[{}]", .{dimension.dim});
        } else "";

        const name = try std.mem.replaceOwned(u8, self.arena.allocator(), register.name, "[%s]", "");
        try writer.writeByte('\n');
        if (nesting == .namespaced) {
            const addr = if (base_addr) |base| base + register.addr_offset else register.addr_offset;
            try writer.print("/// address: 0x{x}\n", .{addr});
        }

        if (register.description) |description|
            try writeDescription(self.arena.child_allocator, writer, description);

        try self.genZigSingleRegister(
            writer,
            name,
            register.size,
            base_addr != null,
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

fn Derivations(comptime T: type) type {
    return struct {
        enumerations: std.AutoHashMap(u32, T),
        fields: std.AutoHashMap(u32, T),
        registers: std.AutoHashMap(u32, T),
        clusters: std.AutoHashMap(u32, T),
        peripherals: std.AutoHashMap(u32, T),

        fn init(allocator: Allocator) @This() {
            return @This(){
                .enumerations = std.AutoHashMap(u32, T).init(allocator),
                .fields = std.AutoHashMap(u32, T).init(allocator),
                .registers = std.AutoHashMap(u32, T).init(allocator),
                .clusters = std.AutoHashMap(u32, T).init(allocator),
                .peripherals = std.AutoHashMap(u32, T).init(allocator),
            };
        }

        fn deinit(self: *@This()) void {
            self.enumerations.deinit();
            self.fields.deinit();
            self.registers.deinit();
            self.clusters.deinit();
            self.peripherals.deinit();
        }
    };
}

const Dimensions = struct {
    fields: std.AutoHashMap(u32, svd.Dimension),
    registers: std.AutoHashMap(u32, svd.Dimension),
    clusters: std.AutoHashMap(u32, svd.Dimension),
    peripherals: std.AutoHashMap(u32, svd.Dimension),

    fn init(allocator: Allocator) @This() {
        return @This(){
            .fields = std.AutoHashMap(u32, svd.Dimension).init(allocator),
            .registers = std.AutoHashMap(u32, svd.Dimension).init(allocator),
            .clusters = std.AutoHashMap(u32, svd.Dimension).init(allocator),
            .peripherals = std.AutoHashMap(u32, svd.Dimension).init(allocator),
        };
    }

    fn deinit(self: *@This()) void {
        self.fields.deinit();
        self.registers.deinit();
        self.clusters.deinit();
        self.peripherals.deinit();
    }
};

const useless_descriptions = std.ComptimeStringMap(void, .{
    .{"Unspecified"},
});

const useless_field_names = std.ComptimeStringMap(void, .{
    .{"RESERVED"},
});
