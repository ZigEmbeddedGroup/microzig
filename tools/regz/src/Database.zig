const std = @import("std");
const svd = @import("svd.zig");
const xml = @import("xml.zig");

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

arena: std.heap.ArenaAllocator,
device: svd.Device,
cpu: ?svd.Cpu,
interrupts: std.ArrayList(svd.Interrupt),
peripherals: std.ArrayList(svd.Peripheral),
clusters: std.ArrayList(svd.Cluster),
registers: std.ArrayList(svd.Register),
fields: std.ArrayList(svd.Field),
peripherals_use_interrupts: std.ArrayList(PeripheralUsesInterrupt),
clusters_in_peripherals: std.ArrayList(ClusterInPeripheral),
clusters_in_clusters: std.ArrayList(ClusterInCluster),
registers_in_peripherals: std.AutoHashMap(u32, Range),
registers_in_clusters: std.AutoHashMap(u32, Range),
fields_in_registers: std.MultiArrayList(FieldsInRegister),
dimensions: Dimensions,

/// takes ownership of arena allocator
fn init(arena: std.heap.ArenaAllocator, device: svd.Device) Self {
    const allocator = arena.child_allocator;
    return Self{
        .arena = arena,
        .device = device,
        .cpu = null,
        .interrupts = std.ArrayList(svd.Interrupt).init(allocator),
        .peripherals = std.ArrayList(svd.Peripheral).init(allocator),
        .clusters = std.ArrayList(svd.Cluster).init(allocator),
        .registers = std.ArrayList(svd.Register).init(allocator),
        .fields = std.ArrayList(svd.Field).init(allocator),
        .peripherals_use_interrupts = std.ArrayList(PeripheralUsesInterrupt).init(allocator),
        .clusters_in_peripherals = std.ArrayList(ClusterInPeripheral).init(allocator),
        .clusters_in_clusters = std.ArrayList(ClusterInCluster).init(allocator),
        .registers_in_peripherals = std.AutoHashMap(u32, Range).init(allocator),
        .registers_in_clusters = std.AutoHashMap(u32, Range).init(allocator),
        .fields_in_registers = std.MultiArrayList(FieldsInRegister){},
        .dimensions = Dimensions.init(allocator),
    };
}

pub fn initFromSvd(allocator: std.mem.Allocator, doc: *xml.Doc) !Self {
    const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
    const device_node = xml.findNode(root_element, "device") orelse return error.NoDevice;
    const device_nodes: *xml.Node = device_node.children orelse return error.NoDeviceNodes;

    var arena = std.heap.ArenaAllocator.init(allocator);
    const device = blk: {
        errdefer arena.deinit();
        break :blk try svd.Device.parse(&arena, device_nodes);
    };

    var db = Self.init(arena, device);
    errdefer db.deinit();

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
            const peripheral = try svd.Peripheral.parse(&db.arena, peripheral_nodes);
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

            if (db.fields_in_registers.items(.field_range)[child_idx].begin !=
                db.fields_in_registers.items(.field_range)[child_idx].end)
                return error.Todo;

            db.fields_in_registers.items(.field_range)[child_idx] = db.fields_in_registers.items(.field_range)[parent_idx];
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
        const register = try svd.Register.parse(&db.arena, register_nodes, db.device.register_properties.size orelse db.device.width);
        try db.registers.append(register);

        const register_idx = @intCast(u32, db.registers.items.len - 1);
        if (xml.getAttribute(register_it, "derivedFrom")) |derived_from|
            try named_derivations.registers.put(register_idx, try db.arena.allocator().dupe(u8, derived_from));

        if (try svd.Dimension.parse(&db.arena, register_nodes)) |dimension|
            try db.dimensions.registers.put(register_idx, dimension);

        const field_begin_idx = db.fields.items.len;
        if (xml.findNode(register_nodes, "fields")) |fields_node| {
            var field_it: ?*xml.Node = xml.findNode(fields_node.children, "field");
            while (field_it != null) : (field_it = xml.findNode(field_it.?.next, "field")) {
                const field_nodes: *xml.Node = field_it.?.children orelse continue;
                const field = try svd.Field.parse(&db.arena, field_nodes);
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
        std.sort.sort(svd.Field, db.fields.items[field_begin_idx..], {}, svd.Field.lessThan);

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
            } else if (db.fields.items[i].offset + db.fields.items[i].width > db.device.width) {
                const ignored = db.fields.orderedRemove(i);
                std.log.warn("ignoring field '{s}' ({}-{}) in register '{s}' because it's outside it's size: {}", .{
                    ignored.name,
                    ignored.offset,
                    ignored.offset + ignored.width,
                    register.name,
                    db.device.width,
                });
            } else {
                current_bit = db.fields.items[i].offset + db.fields.items[i].width;
                i += 1;
            }
        }

        try db.fields_in_registers.append(db.arena.child_allocator, .{
            .register_idx = @intCast(u32, db.registers.items.len - 1),
            .field_range = .{
                .begin = @intCast(u32, field_begin_idx),
                .end = @intCast(u32, db.fields.items.len),
            },
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

pub fn initFromAtdf(allocator: std.mem.Allocator, doc: *xml.Doc) !Self {
    _ = doc;
    _ = allocator;
    return error.Todo;
}

pub fn deinit(self: *Self) void {
    const allocator = self.arena.child_allocator;
    self.peripherals.deinit();
    self.interrupts.deinit();
    self.registers.deinit();
    self.fields.deinit();
    self.clusters.deinit();
    self.peripherals_use_interrupts.deinit();
    self.registers_in_peripherals.deinit();
    self.fields_in_registers.deinit(allocator);
    self.clusters_in_peripherals.deinit();
    self.clusters_in_clusters.deinit();
    self.registers_in_clusters.deinit();
    self.dimensions.deinit();
    self.arena.deinit();
}

fn writeDescription(
    allocator: Allocator,
    writer: anytype,
    description: []const u8,
    indent: usize,
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
                    try writer.writeByteNTimes(' ', indent * 4);
                    try writer.print("///{s}\n", .{line.items});
                    line.clearRetainingCapacity();
                    try line.append(' ');
                    try line.appendSlice(token);
                } else {
                    try writer.writeByteNTimes(' ', indent * 4);
                    try writer.print("/// {s}\n", .{token});
                }
            } else {
                try line.append(' ');
                try line.appendSlice(token);
            }
        }

        if (line.items.len > 0) {
            try writer.writeByteNTimes(' ', indent * 4);
            try writer.print("///{s}\n", .{line.items});
        }
    }
}

pub fn toZig(self: *Self, writer: anytype) !void {
    try writer.writeAll("// this file is generated by regz\n//\n");
    if (self.device.vendor) |vendor_name|
        try writer.print("// vendor: {s}\n", .{vendor_name});

    if (self.device.name) |device_name|
        try writer.print("// device: {s}\n", .{device_name});

    if (self.cpu) |cpu| if (cpu.name) |cpu_name|
        try writer.print("// cpu: {s}\n", .{cpu_name});

    if (self.interrupts.items.len > 0 and self.cpu != null) {
        if (svd.CpuName.parse(self.cpu.?.name.?)) |cpu_type| {
            try writer.writeAll("\npub const VectorTable = struct {\n");

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

                if (interrupt.description) |description| if (!isUselessDescription(description))
                    try writeDescription(self.arena.child_allocator, writer, description, 1);

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
                if (peripheral.description) |description| if (!isUselessDescription(description))
                    try writeDescription(self.arena.child_allocator, writer, description, 1);
                try writer.print(
                    \\    pub const {s} = struct {{
                    \\        pub const base_address = 0x{x};
                    \\
                , .{ std.zig.fmtId(peripheral.name), peripheral.base_addr });
                if (peripheral.version) |version|
                    try writer.print("        pub const version = \"{s}\";\n", .{version});

                for (registers) |_, range_offset| {
                    const reg_idx = @intCast(u32, reg_range.begin + range_offset);
                    try self.genZigRegister(writer, peripheral.base_addr, reg_idx, 2, .namespaced);
                }

                if (has_clusters) {
                    for (self.clusters_in_peripherals.items) |cip| {
                        if (cip.peripheral_idx == peripheral_idx) {
                            try self.genZigCluster(writer, peripheral.base_addr, cip.cluster_idx, 2, .namespaced);
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
}

fn genZigCluster(
    db: *Self,
    writer: anytype,
    base_addr: usize,
    cluster_idx: u32,
    indent: usize,
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
                if (!isUselessDescription(description))
                    try writeDescription(db.arena.child_allocator, writer, description, indent);

            if (dimension_opt) |dimension| {
                const name = try std.mem.replaceOwned(u8, db.arena.allocator(), cluster.name, "[%s]", "");

                try writer.writeByteNTimes(' ', indent * 4);
                try writer.print("pub const {s} = @ptrCast(*volatile [{}]packed struct {{", .{ name, dimension.dim });

                // TODO: check address offset of register wrt the cluster
                var bits: usize = 0;
                for (registers) |register, offset| {
                    const reg_idx = @intCast(u32, range.begin + offset);
                    try db.genZigRegister(writer, base_addr, reg_idx, indent + 1, .contained);
                    bits += register.size;
                }

                if (bits % 8 != 0 or db.device.width % 8 != 0)
                    return error.InvalidWordSize;

                const bytes = bits / 8;
                const bytes_per_word = db.device.width / 8;
                if (bytes > dimension.increment)
                    return error.InvalidClusterSize;

                const num_padding_words = (dimension.increment - bytes) / bytes_per_word;
                var i: usize = 0;
                while (i < num_padding_words) : (i += 1) {
                    try writer.writeByteNTimes(' ', (indent + 1) * 4);
                    try writer.print("padding{}: u{},\n", .{ i, db.device.width });
                }

                try writer.writeByteNTimes(' ', indent * 4);
                try writer.print("}}, base_address + 0x{x});\n", .{cluster.addr_offset});
            } else {
                try writer.writeByteNTimes(' ', indent * 4);
                try writer.print("pub const {s} = struct {{\n", .{std.zig.fmtId(cluster.name)});
                for (registers) |_, offset| {
                    const reg_idx = @intCast(u32, range.begin + offset);
                    try db.genZigRegister(writer, base_addr, reg_idx, indent + 1, .namespaced);
                }

                try writer.writeByteNTimes(' ', indent * 4);
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
    addr_offset: usize,
    fields: []svd.Field,
    first_field_idx: u32,
    array_prefix: []const u8,
    indent: usize,
    nesting: Nesting,
) !void {
    const single_line_declaration = fields.len == 0 or (fields.len == 1 and std.mem.eql(u8, fields[0].name, name));
    if (single_line_declaration) {
        if (fields.len == 1 and fields[0].width < width) {
            try writer.writeByteNTimes(' ', indent * 4);
            switch (nesting) {
                .namespaced => try writer.print("pub const {s} = @intToPtr(*volatile {s}MmioInt({}, u{}), base_address + 0x{x});\n", .{
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
        } else if (fields.len == 1 and fields[0].width > width) {
            return error.BadWidth;
        } else {
            try writer.writeByteNTimes(' ', indent * 4);
            switch (nesting) {
                .namespaced => try writer.print("pub const {s} = @intToPtr(*volatile {s}u{}, base_address + 0x{x});\n", .{
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
    } else {
        try writer.writeByteNTimes(' ', indent * 4);
        switch (nesting) {
            .namespaced => try writer.print("pub const {s} = @intToPtr(*volatile {s}Mmio({}, packed struct{{\n", .{
                std.zig.fmtId(name),
                array_prefix,
                width,
            }),
            .contained => try writer.print("{s}: {s}Mmio({}, packed struct{{\n", .{
                std.zig.fmtId(name),
                array_prefix,
                width,
            }),
        }

        try self.genZigFields(
            writer,
            width,
            fields,
            first_field_idx,
            indent + 1,
        );

        try writer.writeByteNTimes(' ', indent * 4);
        switch (nesting) {
            .namespaced => try writer.print("}}), base_address + 0x{x});\n", .{addr_offset}),
            .contained => try writer.writeAll("}),\n"),
        }
    }
}

fn genZigFields(
    self: *Self,
    writer: anytype,
    reg_width: usize,
    fields: []svd.Field,
    first_field_idx: u32,
    indent: usize,
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
                    try writer.writeByteNTimes(' ', indent * 4);
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
                    try writer.writeByteNTimes(' ', indent * 4);
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
            try writer.writeByteNTimes(' ', indent * 4);
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

        // TODO: default values?
        if (field.description) |description|
            if (!isUselessDescription(description))
                try writeDescription(self.arena.child_allocator, writer, description, indent);

        try writer.writeByteNTimes(' ', indent * 4);
        try writer.print("{s}: u{},\n", .{ std.zig.fmtId(field.name), field.width });

        expected_bit += field.width;
    }

    var padding_num: usize = 0;

    while (expected_bit < reg_width) : ({
        expected_bit += 1;
        padding_num += 1;
    }) {
        try writer.writeByteNTimes(' ', indent * 4);
        try writer.print("padding{}: u1,\n", .{padding_num});
    }
}

fn genZigRegister(
    self: *Self,
    writer: anytype,
    base_addr: usize,
    reg_idx: u32,
    indent: usize,
    nesting: Nesting,
) !void {
    const register = self.registers.items[reg_idx];
    const fields = blk: {
        const range = self.fields_in_registers.items(.field_range)[reg_idx];
        break :blk self.fields.items[range.begin..range.end];
    };

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
                try writer.writeByteNTimes(' ', indent * 4);
                try writer.print("/// address: 0x{x}\n", .{base_addr + addr_offset});
            }

            if (register.description) |description|
                try writeDescription(self.arena.child_allocator, writer, description, indent);

            try self.genZigSingleRegister(
                writer,
                name,
                register.size,
                addr_offset,
                fields,
                self.fields_in_registers.items(.field_range)[reg_idx].begin,
                "",
                indent,
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
                try writer.writeByteNTimes(' ', indent * 4);
                try writer.print("/// address: 0x{x}\n", .{base_addr + addr_offset});
            }

            if (register.description) |description|
                try writeDescription(self.arena.child_allocator, writer, description, indent);

            try self.genZigSingleRegister(
                writer,
                name,
                register.size,
                addr_offset,
                fields,
                self.fields_in_registers.items(.field_range)[reg_idx].begin,
                "",
                indent,
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
            try writer.writeByteNTimes(' ', indent * 4);
            try writer.print("/// address: 0x{x}\n", .{base_addr + register.addr_offset});
        }

        if (register.description) |description|
            try writeDescription(self.arena.child_allocator, writer, description, indent);

        try self.genZigSingleRegister(
            writer,
            name,
            register.size,
            register.addr_offset,
            fields,
            self.fields_in_registers.items(.field_range)[reg_idx].begin,
            array_prefix,
            indent,
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

    std.log.info("  fields: {}", .{fields.len});
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

const useless_descriptions: []const []const u8 = &.{
    "Unspecified",
};

fn isUselessDescription(description: []const u8) bool {
    return for (useless_descriptions) |useless_description| {
        if (std.mem.eql(u8, description, useless_description))
            break true;
    } else false;
}
