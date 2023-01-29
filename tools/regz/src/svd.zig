const std = @import("std");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const xml = @import("xml.zig");
const arm = @import("arch/arm.zig");

const Database = @import("Database.zig");
const EntityId = Database.EntityId;
const Access = Database.Access;

const log = std.log.scoped(.svd);

// svd specific context to hold extra state like derived entities
const Context = struct {
    db: *Database,
    register_props: std.AutoArrayHashMapUnmanaged(EntityId, RegisterProperties) = .{},
    derived_entities: std.AutoArrayHashMapUnmanaged(EntityId, []const u8) = .{},

    fn deinit(ctx: *Context) void {
        ctx.register_props.deinit(ctx.db.gpa);
        ctx.derived_entities.deinit(ctx.db.gpa);
    }

    fn addDerivedEntity(ctx: *Context, id: EntityId, derived_from: []const u8) !void {
        try ctx.derived_entities.putNoClobber(ctx.db.gpa, id, derived_from);
        log.debug("{}: derived from '{s}'", .{ id, derived_from });
    }

    fn deriveRegisterPropertiesFrom(
        ctx: *Context,
        node: xml.Node,
        from: EntityId,
    ) !RegisterProperties {
        const register_props = try RegisterProperties.parse(node);
        var base_register_props = ctx.register_props.get(from) orelse unreachable;
        inline for (@typeInfo(RegisterProperties).Struct.fields) |field| {
            if (@field(register_props, field.name)) |value|
                @field(base_register_props, field.name) = value;
        }

        return base_register_props;
    }
};

const svd_boolean = std.ComptimeStringMap(bool, .{
    .{ "true", true },
    .{ "1", true },
    .{ "false", false },
    .{ "0", false },
});

pub fn loadIntoDb(db: *Database, doc: xml.Doc) !void {
    const root = try doc.getRootElement();

    const device_id = db.createEntity();
    try db.instances.devices.put(db.gpa, device_id, .{
        .arch = .unknown,
    });

    const name = root.getValue("name") orelse return error.MissingDeviceName;
    try db.addName(device_id, name);

    if (root.getValue("description")) |description|
        try db.addDescription(device_id, description);

    if (root.getValue("licenseText")) |license|
        try db.addDeviceProperty(device_id, "license", license);

    // vendor
    // vendorID
    // series
    // version
    // headerSystemFilename
    // headerDefinitionPrefix
    // addressUnitBits
    // width
    // registerPropertiesGroup
    // peripherals
    // vendorExtensions

    var cpu_it = root.iterate(&.{}, "cpu");
    if (cpu_it.next()) |cpu| {
        const cpu_name = cpu.getValue("name") orelse return error.MissingCpuName;
        const cpu_revision = cpu.getValue("revision") orelse return error.MissingCpuRevision;
        const nvic_prio_bits = cpu.getValue("nvicPrioBits") orelse return error.MissingNvicPrioBits;
        const vendor_systick_config = cpu.getValue("vendorSystickConfig") orelse return error.MissingVendorSystickConfig;

        const arch = archFromStr(cpu_name);
        db.instances.devices.getEntry(device_id).?.value_ptr.arch = arch;
        if (arch.isArm())
            try arm.loadSystemInterrupts(db, device_id);

        // TODO: is this the right logic?
        if (svd_boolean.get(vendor_systick_config)) |systick| {
            if (!systick)
                try arm.loadSysTickInterrupt(db, device_id);
        } else {
            try arm.loadSysTickInterrupt(db, device_id);
        }

        // TODO:

        // cpu name => arch
        try db.addDeviceProperty(device_id, "cpu.name", cpu_name);
        try db.addDeviceProperty(device_id, "cpu.revision", cpu_revision);
        try db.addDeviceProperty(device_id, "cpu.nvic_prio_bits", nvic_prio_bits);
        try db.addDeviceProperty(device_id, "cpu.vendor_systick_config", vendor_systick_config);

        if (cpu.getValue("endian")) |endian|
            try db.addDeviceProperty(device_id, "cpu.endian", endian);

        if (cpu.getValue("mpuPresent")) |mpu|
            try db.addDeviceProperty(device_id, "cpu.mpu", mpu);

        if (cpu.getValue("fpuPresent")) |fpu|
            try db.addDeviceProperty(device_id, "cpu.fpu", fpu);

        if (cpu.getValue("dspPresent")) |dsp|
            try db.addDeviceProperty(device_id, "cpu.dsp", dsp);

        if (cpu.getValue("icachePresent")) |icache|
            try db.addDeviceProperty(device_id, "cpu.icache", icache);

        if (cpu.getValue("dcachePresent")) |dcache|
            try db.addDeviceProperty(device_id, "cpu.dcache", dcache);

        if (cpu.getValue("itcmPresent")) |itcm|
            try db.addDeviceProperty(device_id, "cpu.itcm", itcm);

        if (cpu.getValue("dtcmPresent")) |dtcm|
            try db.addDeviceProperty(device_id, "cpu.dtcm", dtcm);

        if (cpu.getValue("vtorPresent")) |vtor|
            try db.addDeviceProperty(device_id, "cpu.vtor", vtor);

        if (cpu.getValue("deviceNumInterrupts")) |num_interrupts|
            try db.addDeviceProperty(device_id, "cpu.num_interrupts", num_interrupts);

        // fpuDP
        // sauNumRegions
        // sauRegionsConfig
    }

    if (cpu_it.next() != null)
        log.warn("there are multiple CPUs", .{});

    var ctx = Context{
        .db = db,
    };
    defer ctx.deinit();

    const register_props = try RegisterProperties.parse(root);
    try ctx.register_props.put(db.gpa, device_id, register_props);

    var peripheral_it = root.iterate(&.{"peripherals"}, "peripheral");
    while (peripheral_it.next()) |peripheral_node|
        loadPeripheral(&ctx, peripheral_node, device_id) catch |err|
            log.warn("failed to load peripheral: {}", .{err});

    var derive_it = ctx.derived_entities.iterator();
    while (derive_it.next()) |derived_entry| {
        const id = derived_entry.key_ptr.*;
        const derived_name = derived_entry.value_ptr.*;

        try deriveEntity(ctx.db.*, id, derived_name);
    }

    db.assertValid();
}

fn archFromStr(str: []const u8) Database.Arch {
    return if (std.mem.eql(u8, "CM0", str))
        .cortex_m0
    else if (std.mem.eql(u8, "CM0PLUS", str))
        .cortex_m0plus
    else if (std.mem.eql(u8, "CM0+", str))
        .cortex_m0plus
    else if (std.mem.eql(u8, "CM1", str))
        .cortex_m1
    else if (std.mem.eql(u8, "SC000", str))
        .sc000
    else if (std.mem.eql(u8, "CM23", str))
        .cortex_m23
    else if (std.mem.eql(u8, "CM3", str))
        .cortex_m3
    else if (std.mem.eql(u8, "CM33", str))
        .cortex_m33
    else if (std.mem.eql(u8, "CM35P", str))
        .cortex_m35p
    else if (std.mem.eql(u8, "CM55", str))
        .cortex_m55
    else if (std.mem.eql(u8, "SC300", str))
        .sc300
    else if (std.mem.eql(u8, "CM4", str))
        .cortex_m4
    else if (std.mem.eql(u8, "CM7", str))
        .cortex_m7
    else if (std.mem.eql(u8, "ARMV8MML", str))
        .arm_v81_mml
    else if (std.mem.eql(u8, "ARMV8MBL", str))
        .arm_v8_mbl
    else if (std.mem.eql(u8, "ARMV81MML", str))
        .arm_v8_mml
    else if (std.mem.eql(u8, "CA5", str))
        .cortex_a5
    else if (std.mem.eql(u8, "CA7", str))
        .cortex_a7
    else if (std.mem.eql(u8, "CA8", str))
        .cortex_a8
    else if (std.mem.eql(u8, "CA9", str))
        .cortex_a9
    else if (std.mem.eql(u8, "CA15", str))
        .cortex_a15
    else if (std.mem.eql(u8, "CA17", str))
        .cortex_a17
    else if (std.mem.eql(u8, "CA53", str))
        .cortex_a53
    else if (std.mem.eql(u8, "CA57", str))
        .cortex_a57
    else if (std.mem.eql(u8, "CA72", str))
        .cortex_a72
    else
        .unknown;
}

pub fn deriveEntity(db: Database, id: EntityId, derived_name: []const u8) !void {
    log.debug("{}: derived from {s}", .{ id, derived_name });
    const entity_type = db.getEntityType(id);
    log.warn("TODO: implement derivation for {?}", .{entity_type});
}

pub fn loadPeripheral(ctx: *Context, node: xml.Node, device_id: EntityId) !void {
    const db = ctx.db;

    const type_id = try loadPeripheralType(ctx, node);
    errdefer db.destroyEntity(type_id);

    const instance_id = try db.createPeripheralInstance(device_id, type_id, .{
        .name = node.getValue("name") orelse return error.PeripheralMissingName,
        .offset = if (node.getValue("baseAddress")) |base_address|
            try std.fmt.parseInt(u64, base_address, 0)
        else
            return error.PeripheralMissingBaseAddress,
    });
    errdefer db.destroyEntity(instance_id);

    const dim_elements = try DimElements.parse(node);
    if (dim_elements) |elements| {
        // peripherals can't have dimIndex set according to the spec
        if (elements.dim_index != null)
            return error.Malformed;

        if (elements.dim_name != null)
            return error.TodoDimElementsExtended;

        // count is applied to the specific instance
        try db.addCount(instance_id, elements.dim);

        // size is applied to the type
        try db.addSize(type_id, elements.dim_increment);
    }

    var interrupt_it = node.iterate(&.{}, "interrupt");
    while (interrupt_it.next()) |interrupt_node|
        try loadInterrupt(db, interrupt_node, device_id);

    if (node.getValue("description")) |description|
        try db.addDescription(instance_id, description);

    if (node.getValue("version")) |version|
        try db.addVersion(instance_id, version);

    if (node.getAttribute("derivedFrom")) |derived_from|
        try ctx.addDerivedEntity(instance_id, derived_from);

    const register_props = try ctx.deriveRegisterPropertiesFrom(node, device_id);
    try ctx.register_props.put(db.gpa, type_id, register_props);

    var register_it = node.iterate(&.{"registers"}, "register");
    while (register_it.next()) |register_node|
        loadRegister(ctx, register_node, type_id) catch |err|
            log.warn("failed to load register: {}", .{err});

    // TODO: handle errors when implemented
    var cluster_it = node.iterate(&.{"registers"}, "cluster");
    while (cluster_it.next()) |cluster_node|
        loadCluster(ctx, cluster_node, type_id) catch |err|
            log.warn("failed to load cluster: {}", .{err});

    // alternatePeripheral
    // groupName
    // prependToName
    // appendToName
    // headerStructName
    // disableCondition
    // addressBlock
}

fn loadPeripheralType(ctx: *Context, node: xml.Node) !EntityId {
    const db = ctx.db;

    // TODO: get version
    const id = try db.createPeripheral(.{
        .name = node.getValue("name") orelse return error.PeripheralMissingName,
    });
    errdefer db.destroyEntity(id);

    if (node.getValue("description")) |description|
        try db.addDescription(id, description);

    return id;
}

fn loadInterrupt(db: *Database, node: xml.Node, device_id: EntityId) !void {
    assert(db.entityIs("instance.device", device_id));

    const id = db.createEntity();
    errdefer db.destroyEntity(id);

    const name = node.getValue("name") orelse return error.MissingInterruptName;
    const value_str = node.getValue("value") orelse return error.MissingInterruptIndex;
    const value = std.fmt.parseInt(i32, value_str, 0) catch |err| {
        log.warn("failed to parse value '{s}' of interrupt '{s}'", .{
            value_str,
            name,
        });
        return err;
    };

    log.debug("{}: creating interrupt {}", .{ id, value });
    try db.instances.interrupts.put(db.gpa, id, value);
    try db.addName(id, name);
    if (node.getValue("description")) |description|
        try db.addDescription(id, description);

    try db.addChild("instance.interrupt", device_id, id);
}

fn loadCluster(
    ctx: *Context,
    node: xml.Node,
    parent_id: EntityId,
) !void {
    _ = ctx;
    _ = parent_id;

    const name = node.getValue("name") orelse return error.MissingClusterName;
    log.warn("TODO clusters. name: {s}", .{name});

    const dim_elements = try DimElements.parse(node);
    if (dim_elements != null)
        return error.TodoDimElements;
}

fn getNameWithoutSuffix(node: xml.Node, suffix: []const u8) ![]const u8 {
    return if (node.getValue("name")) |name|
        if (std.mem.endsWith(u8, name, suffix))
            name[0 .. name.len - suffix.len]
        else
            name
    else
        error.MissingName;
}

fn loadRegister(
    ctx: *Context,
    node: xml.Node,
    parent_id: EntityId,
) !void {
    const db = ctx.db;
    const register_props = try ctx.deriveRegisterPropertiesFrom(node, parent_id);
    const size = register_props.size orelse return error.MissingRegisterSize;
    const count: ?u64 = if (try DimElements.parse(node)) |elements| count: {
        if (elements.dim_index != null or elements.dim_name != null)
            return error.TodoDimElementsExtended;

        if ((elements.dim_increment * 8) != size)
            return error.DimIncrementSizeMismatch;

        break :count elements.dim;
    } else null;

    const id = try db.createRegister(parent_id, .{
        .name = try getNameWithoutSuffix(node, "[%s]"),
        .description = node.getValue("description"),
        .offset = if (node.getValue("addressOffset")) |offset_str|
            try std.fmt.parseInt(u64, offset_str, 0)
        else
            return error.MissingRegisterOffset,
        .size = size,
        .count = count,
        .access = register_props.access,
        .reset_mask = register_props.reset_mask,
        .reset_value = register_props.reset_value,
    });
    errdefer db.destroyEntity(id);

    var field_it = node.iterate(&.{"fields"}, "field");
    while (field_it.next()) |field_node|
        loadField(ctx, field_node, id) catch |err|
            log.warn("failed to load register: {}", .{err});

    if (node.getAttribute("derivedFrom")) |derived_from|
        try ctx.addDerivedEntity(id, derived_from);

    // TODO:
    // dimElementGroup
    // displayName
    // alternateGroup
    // alternateRegister
    // dataType
    // modifiedWriteValues
    // writeConstraint
    // readAction
}

fn loadField(ctx: *Context, node: xml.Node, register_id: EntityId) !void {
    const db = ctx.db;

    const bit_range = try BitRange.parse(node);
    const count: ?u64 = if (try DimElements.parse(node)) |elements| count: {
        if (elements.dim_index != null or elements.dim_name != null)
            return error.TodoDimElementsExtended;

        if (elements.dim_increment != bit_range.width)
            return error.DimIncrementSizeMismatch;

        break :count elements.dim;
    } else null;

    const id = try db.createField(register_id, .{
        .name = try getNameWithoutSuffix(node, "%s"),
        .description = node.getValue("description"),
        .size = bit_range.width,
        .offset = bit_range.offset,
        .count = count,
    });
    errdefer db.destroyEntity(id);

    if (node.getValue("access")) |access_str|
        try db.addAccess(id, try parseAccess(access_str));

    if (node.findChild("enumeratedValues")) |enum_values_node|
        try loadEnumeratedValues(ctx, enum_values_node, id);

    if (node.getAttribute("derivedFrom")) |derived_from|
        try ctx.addDerivedEntity(id, derived_from);

    // TODO:
    // modifiedWriteValues
    // writeConstraint
    // readAction
}

fn loadEnumeratedValues(ctx: *Context, node: xml.Node, field_id: EntityId) !void {
    const db = ctx.db;

    assert(db.entityIs("type.field", field_id));
    const peripheral_id = peripheral_id: {
        var id = field_id;
        break :peripheral_id while (db.attrs.parent.get(id)) |parent_id| : (id = parent_id) {
            if (.peripheral == db.getEntityType(parent_id).?)
                break parent_id;
        } else return error.NoPeripheralFound;
    };

    const id = try db.createEnum(peripheral_id, .{
        // TODO: find solution to potential name collisions for enums at the peripheral level.
        //.name = node.getValue("name"),
        .size = db.attrs.size.get(field_id),
    });
    errdefer db.destroyEntity(id);

    try db.attrs.@"enum".putNoClobber(db.gpa, field_id, id);

    var value_it = node.iterate(&.{}, "enumeratedValue");
    while (value_it.next()) |value_node|
        try loadEnumeratedValue(ctx, value_node, id);
}

fn loadEnumeratedValue(ctx: *Context, node: xml.Node, enum_id: EntityId) !void {
    const db = ctx.db;

    assert(db.entityIs("type.enum", enum_id));
    const id = try db.createEnumField(enum_id, .{
        .name = if (node.getValue("name")) |name|
            if (std.mem.eql(u8, "_", name))
                return error.InvalidEnumFieldName
            else
                name
        else
            return error.EnumFieldMissingName,
        .description = node.getValue("description"),
        .value = if (node.getValue("value")) |value_str|
            try std.fmt.parseInt(u32, value_str, 0)
        else
            return error.EnumFieldMissingValue,
    });
    errdefer db.destroyEntity(id);
}

pub const Revision = struct {
    release: u64,
    part: u64,

    fn parse(str: []const u8) !Revision {
        if (!std.mem.startsWith(u8, str, "r"))
            return error.Malformed;

        const p_index = std.mem.indexOf(u8, str, "p") orelse return error.Malformed;
        return Revision{
            .release = try std.fmt.parseInt(u64, str[1..p_index], 10),
            .part = try std.fmt.parseInt(u64, str[p_index + 1 ..], 10),
        };
    }
};

pub const Endian = enum {
    little,
    big,
    selectable,
    other,
};

pub const DataType = enum {
    uint8_t,
    uint16_t,
    uint32_t,
    uint64_t,
    int8_t,
    int16_t,
    int32_t,
    int64_t,
    @"uint8_t *",
    @"uint16_t *",
    @"uint32_t *",
    @"uint64_t *",
    @"int8_t *",
    @"int16_t *",
    @"int32_t *",
    @"int64_t *",
};

/// pattern: ((%s)|(%s)[_A-Za-z]{1}[_A-Za-z0-9]*)|([_A-Za-z]{1}[_A-Za-z0-9]*(\[%s\])?)|([_A-Za-z]{1}[_A-Za-z0-9]*(%s)?[_A-Za-z0-9]*)
///
/// The dimable identifier optionally has a %s to format where the id should
/// go, it may also be surrounded by []
pub const DimableIdentifier = struct {
    name: []const u8,
    pos: u32,
};

/// pattern: [0-9]+\-[0-9]+|[A-Z]-[A-Z]|[_0-9a-zA-Z]+(,\s*[_0-9a-zA-Z]+)+
pub const DimIndex = struct {};

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectError = std.testing.expectError;

const testing = @import("testing.zig");
const expectAttr = testing.expectAttr;

test "svd.Revision.parse" {
    try expectEqual(Revision{
        .release = 1,
        .part = 2,
    }, try Revision.parse("r1p2"));

    try expectEqual(Revision{
        .release = 50,
        .part = 100,
    }, try Revision.parse("r50p100"));

    try expectError(error.Malformed, Revision.parse("p"));
    try expectError(error.Malformed, Revision.parse("r"));
    try expectError(error.InvalidCharacter, Revision.parse("rp"));
    try expectError(error.InvalidCharacter, Revision.parse("r1p"));
    try expectError(error.InvalidCharacter, Revision.parse("rp2"));
}

//pub fn parsePeripheral(arena: *ArenaAllocator, nodes: *xml.Node) !Peripheral {
//    const allocator = arena.allocator();
//    return Peripheral{
//        .name = try allocator.dupe(u8, xml.findValueForKey(nodes, "name") orelse return error.NoName),
//        .version = if (xml.findValueForKey(nodes, "version")) |version|
//            try allocator.dupe(u8, version)
//        else
//            null,
//        .description = try xml.parseDescription(allocator, nodes, "description"),
//        .base_addr = (try xml.parseIntForKey(usize, arena.child_allocator, nodes, "baseAddress")) orelse return error.NoBaseAddr, // isDefault?
//    };
//}
//
//pub const Interrupt = struct {
//    name: []const u8,
//    description: ?[]const u8,
//    value: usize,
//
//    pub fn parse(arena: *ArenaAllocator, nodes: *xml.Node) !Interrupt {
//        const allocator = arena.allocator();
//        return Interrupt{
//            .name = try allocator.dupe(u8, xml.findValueForKey(nodes, "name") orelse return error.NoName),
//            .description = try xml.parseDescription(allocator, nodes, "description"),
//            .value = try std.fmt.parseInt(usize, xml.findValueForKey(nodes, "value") orelse return error.NoValue, 0),
//        };
//    }
//
//    pub fn lessThan(_: void, lhs: Interrupt, rhs: Interrupt) bool {
//        return lhs.value < rhs.value;
//    }
//
//    pub fn compare(_: void, lhs: Interrupt, rhs: Interrupt) std.math.Order {
//        return if (lhs.value < rhs.value)
//            std.math.Order.lt
//        else if (lhs.value == rhs.value)
//            std.math.Order.eq
//        else
//            std.math.Order.gt;
//    }
//};
//
//pub fn parseRegister(arena: *ArenaAllocator, nodes: *xml.Node) !Register {
//    const allocator = arena.allocator();
//    return Register{
//        .name = try allocator.dupe(u8, xml.findValueForKey(nodes, "name") orelse return error.NoName),
//        .description = try xml.parseDescription(allocator, nodes, "description"),
//        .addr_offset = try std.fmt.parseInt(usize, xml.findValueForKey(nodes, "addressOffset") orelse return error.NoAddrOffset, 0),
//        .size = null,
//        .access = .read_write,
//        .reset_value = if (xml.findValueForKey(nodes, "resetValue")) |value|
//            try std.fmt.parseInt(u64, value, 0)
//        else
//            null,
//        .reset_mask = if (xml.findValueForKey(nodes, "resetMask")) |value|
//            try std.fmt.parseInt(u64, value, 0)
//        else
//            null,
//    };
//}
//
//pub const Cluster = struct {
//    name: []const u8,
//    description: ?[]const u8,
//    addr_offset: usize,
//
//    pub fn parse(arena: *ArenaAllocator, nodes: *xml.Node) !Cluster {
//        const allocator = arena.allocator();
//        return Cluster{
//            .name = try allocator.dupe(u8, xml.findValueForKey(nodes, "name") orelse return error.NoName),
//            .description = try xml.parseDescription(allocator, nodes, "description"),
//            .addr_offset = try std.fmt.parseInt(usize, xml.findValueForKey(nodes, "addressOffset") orelse return error.NoAddrOffset, 0),
//        };
//    }
//};
//
//pub const EnumeratedValue = struct {
//    name: []const u8,
//    description: ?[]const u8,
//    value: ?usize,
//
//    pub fn parse(arena: *ArenaAllocator, nodes: *xml.Node) !EnumeratedValue {
//        const allocator = arena.allocator();
//        return EnumeratedValue{
//            .name = try allocator.dupe(u8, xml.findValueForKey(nodes, "name") orelse return error.NoName),
//            .description = try xml.parseDescription(allocator, nodes, "description"),
//            .value = try xml.parseIntForKey(usize, arena.child_allocator, nodes, "value"), // TODO: isDefault?
//        };
//    }
//};

// dimElementGroup specifies the number of array elements (dim), the
// address offset between to consecutive array elements and an a comma
// seperated list of strings being used for identifying each element in
// the array -->
const DimElements = struct {
    /// number of array elements
    dim: u64,
    /// address offset between consecutive array elements
    dim_increment: u64,

    /// dimIndexType specifies the subset and sequence of characters used for specifying the sequence of indices in register arrays -->
    /// pattern: [0-9]+\-[0-9]+|[A-Z]-[A-Z]|[_0-9a-zA-Z]+(,\s*[_0-9a-zA-Z]+)+
    dim_index: ?[]const u8 = null,
    dim_name: ?[]const u8 = null,
    // TODO: not sure what dimArrayIndexType means
    //dim_array_index: ?u64 = null,

    fn parse(node: xml.Node) !?DimElements {
        return DimElements{
            // these two are required for DimElements, so if either is not
            // found then just say there's no dimElementGroup. TODO: error
            // if only one is present because that's sus
            .dim = if (node.getValue("dim")) |dim_str|
                try std.fmt.parseInt(u64, dim_str, 0)
            else
                return null,
            .dim_increment = if (node.getValue("dimIncrement")) |dim_increment_str|
                try std.fmt.parseInt(u64, dim_increment_str, 0)
            else
                return null,

            .dim_index = node.getValue("dimIndex"),
            .dim_name = node.getValue("dimName"),
        };
    }
};

const BitRange = struct {
    offset: u64,
    width: u64,

    fn parse(node: xml.Node) !BitRange {
        const lsb_opt = node.getValue("lsb");
        const msb_opt = node.getValue("msb");

        if (lsb_opt != null and msb_opt != null) {
            const lsb = try std.fmt.parseInt(u8, lsb_opt.?, 0);
            const msb = try std.fmt.parseInt(u8, msb_opt.?, 0);

            if (msb < lsb)
                return error.InvalidRange;

            return BitRange{
                .offset = lsb,
                .width = msb - lsb + 1,
            };
        }

        const bit_offset_opt = node.getValue("bitOffset");
        const bit_width_opt = node.getValue("bitWidth");
        if (bit_offset_opt != null and bit_width_opt != null) {
            const offset = try std.fmt.parseInt(u8, bit_offset_opt.?, 0);
            const width = try std.fmt.parseInt(u8, bit_width_opt.?, 0);

            return BitRange{
                .offset = offset,
                .width = width,
            };
        }

        const bit_range_opt = node.getValue("bitRange");
        if (bit_range_opt) |bit_range_str| {
            var it = std.mem.tokenize(u8, bit_range_str, "[:]");
            const msb = try std.fmt.parseInt(u8, it.next() orelse return error.NoMsb, 0);
            const lsb = try std.fmt.parseInt(u8, it.next() orelse return error.NoLsb, 0);

            if (msb < lsb)
                return error.InvalidRange;

            return BitRange{
                .offset = lsb,
                .width = msb - lsb + 1,
            };
        }

        return error.InvalidRange;
    }
};

// can only be one of these
const Protection = enum {
    secure,
    non_secure,
    privileged,
};

const RegisterProperties = struct {
    size: ?u64,
    access: ?Access,
    protection: ?Protection,
    reset_value: ?u64,
    reset_mask: ?u64,

    fn parse(node: xml.Node) !RegisterProperties {
        return RegisterProperties{
            .size = if (node.getValue("size")) |size_str|
                try std.fmt.parseInt(u64, size_str, 0)
            else
                null,
            .access = if (node.getValue("access")) |access_str|
                try parseAccess(access_str)
            else
                null,
            .protection = null,
            .reset_value = if (node.getValue("resetValue")) |size_str|
                try std.fmt.parseInt(u64, size_str, 0)
            else
                null,
            .reset_mask = if (node.getValue("resetMask")) |size_str|
                try std.fmt.parseInt(u64, size_str, 0)
            else
                null,
        };
    }
};

fn parseAccess(str: []const u8) !Access {
    return if (std.mem.eql(u8, "read-only", str))
        Access.read_only
    else if (std.mem.eql(u8, "write-only", str))
        Access.write_only
    else if (std.mem.eql(u8, "read-write", str))
        Access.read_write
    else if (std.mem.eql(u8, "writeOnce", str))
        Access.write_once
    else if (std.mem.eql(u8, "read-writeOnce", str))
        Access.read_write_once
    else
        error.UnknownAccessType;
}

test "svd.device register properties" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    // these only have names attached, so if these functions fail the test will fail.
    _ = try db.getEntityIdByName("instance.device", "TEST_DEVICE");
    _ = try db.getEntityIdByName("instance.peripheral", "TEST_PERIPHERAL");
    _ = try db.getEntityIdByName("type.peripheral", "TEST_PERIPHERAL");

    const register_id = try db.getEntityIdByName("type.register", "TEST_REGISTER");
    try expectAttr(db, "size", 32, register_id);
    try expectAttr(db, "access", .read_only, register_id);
    try expectAttr(db, "reset_value", 0, register_id);
    try expectAttr(db, "reset_mask", 0xffffffff, register_id);
}

test "svd.peripheral register properties" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <size>16</size>
        \\      <access>write-only</access>
        \\      <resetValue>0x0001</resetValue>
        \\      <resetMask>0xffff</resetMask>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    // these only have names attached, so if these functions fail the test will fail.
    _ = try db.getEntityIdByName("instance.device", "TEST_DEVICE");
    _ = try db.getEntityIdByName("instance.peripheral", "TEST_PERIPHERAL");

    const register_id = try db.getEntityIdByName("type.register", "TEST_REGISTER");
    try expectAttr(db, "size", 16, register_id);
    try expectAttr(db, "access", .write_only, register_id);
    try expectAttr(db, "reset_value", 1, register_id);
    try expectAttr(db, "reset_mask", 0xffff, register_id);
}

test "svd.register register properties" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <size>16</size>
        \\      <access>write-only</access>
        \\      <resetValue>0x0001</resetValue>
        \\      <resetMask>0xffff</resetMask>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <size>8</size>
        \\          <access>read-write</access>
        \\          <resetValue>0x0002</resetValue>
        \\          <resetMask>0xff</resetMask>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    // these only have names attached, so if these functions fail the test will fail.
    _ = try db.getEntityIdByName("instance.device", "TEST_DEVICE");
    _ = try db.getEntityIdByName("instance.peripheral", "TEST_PERIPHERAL");

    const register_id = try db.getEntityIdByName("type.register", "TEST_REGISTER");
    try expectAttr(db, "size", 8, register_id);
    try expectAttr(db, "access", .read_write, register_id);
    try expectAttr(db, "reset_value", 2, register_id);
    try expectAttr(db, "reset_mask", 0xff, register_id);
}

test "svd.register with fields" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD</name>
        \\              <access>read-write</access>
        \\              <bitRange>[7:0]</bitRange>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    const field_id = try db.getEntityIdByName("type.field", "TEST_FIELD");
    try expectAttr(db, "size", 8, field_id);
    try expectAttr(db, "offset", 0, field_id);
    try expectAttr(db, "access", .read_write, field_id);
}

test "svd.field with enum value" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD</name>
        \\              <access>read-write</access>
        \\              <bitRange>[7:0]</bitRange>
        \\              <enumeratedValues>
        \\                <name>TEST_ENUM</name>
        \\                <enumeratedValue>
        \\                  <name>TEST_ENUM_FIELD1</name>
        \\                  <value>0</value>
        \\                  <description>test enum field 1</description>
        \\                </enumeratedValue>
        \\                <enumeratedValue>
        \\                  <name>TEST_ENUM_FIELD2</name>
        \\                  <value>1</value>
        \\                  <description>test enum field 2</description>
        \\                </enumeratedValue>
        \\              </enumeratedValues>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    const peripheral_id = try db.getEntityIdByName("type.peripheral", "TEST_PERIPHERAL");
    const field_id = try db.getEntityIdByName("type.field", "TEST_FIELD");

    // TODO: figure out a name collision avoidance mechanism for SVD. For now
    // we'll make all SVD enums anonymous
    const enum_id = db.attrs.@"enum".get(field_id).?;
    try expect(!db.attrs.name.contains(enum_id));

    // field
    try expectAttr(db, "enum", enum_id, field_id);

    // enum
    try expectAttr(db, "size", 8, enum_id);
    try expectAttr(db, "parent", peripheral_id, enum_id);

    const enum_field1_id = try db.getEntityIdByName("type.enum_field", "TEST_ENUM_FIELD1");
    try expectEqual(@as(u32, 0), db.types.enum_fields.get(enum_field1_id).?);
    try expectAttr(db, "parent", enum_id, enum_field1_id);
    try expectAttr(db, "description", "test enum field 1", enum_field1_id);

    const enum_field2_id = try db.getEntityIdByName("type.enum_field", "TEST_ENUM_FIELD2");
    try expectEqual(@as(u32, 1), db.types.enum_fields.get(enum_field2_id).?);
    try expectAttr(db, "parent", enum_id, enum_field2_id);
    try expectAttr(db, "description", "test enum field 2", enum_field2_id);
}

test "svd.peripheral with dimElementGroup" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <dim>4</dim>
        \\      <dimIncrement>4</dimIncrement>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    const peripheral_id = try db.getEntityIdByName("type.peripheral", "TEST_PERIPHERAL");
    try expectAttr(db, "size", 4, peripheral_id);

    const instance_id = try db.getEntityIdByName("instance.peripheral", "TEST_PERIPHERAL");
    try expectAttr(db, "count", 4, instance_id);
}

test "svd.peripheral with dimElementgroup, dimIndex set" {
    std.testing.log_level = .err;
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <dim>4</dim>
        \\      <dimIncrement>4</dimIncrement>
        \\      <dimIndex>foo</dimIndex>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    _ = try db.getEntityIdByName("instance.device", "TEST_DEVICE");

    // should not exist since dimIndex is not allowed to be defined for peripherals
    try expectError(error.NameNotFound, db.getEntityIdByName("type.peripheral", "TEST_PERIPHERAL"));
    try expectError(error.NameNotFound, db.getEntityIdByName("instance.peripheral", "TEST_PERIPHERAL"));
}

test "svd.register with dimElementGroup" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    const register_id = try db.getEntityIdByName("type.register", "TEST_REGISTER");
    try expectAttr(db, "count", 4, register_id);
}

test "svd.register with dimElementGroup, dimIncrement != size" {
    std.testing.log_level = .err;
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>8</dimIncrement>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD</name>
        \\              <access>read-write</access>
        \\              <bitRange>[7:0]</bitRange>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    _ = try db.getEntityIdByName("instance.device", "TEST_DEVICE");
    _ = try db.getEntityIdByName("instance.peripheral", "TEST_PERIPHERAL");
    _ = try db.getEntityIdByName("type.peripheral", "TEST_PERIPHERAL");

    // dimIncrement is different than the size of the register, so it should never be made
    try expectError(error.NameNotFound, db.getEntityIdByName("type.register", "TEST_REGISTER"));
}

test "svd.register with dimElementGroup, suffixed with [%s]" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER[%s]</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    // [%s] is dropped from name, it is redundant
    const register_id = try db.getEntityIdByName("type.register", "TEST_REGISTER");
    try expectAttr(db, "count", 4, register_id);
}

test "svd.field with dimElementGroup, suffixed with %s" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD%s</name>
        \\              <access>read-write</access>
        \\              <bitRange>[0:0]</bitRange>
        \\              <dim>2</dim>
        \\              <dimIncrement>1</dimIncrement>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var doc = try xml.Doc.fromMemory(text);
    var db = try Database.initFromSvd(std.testing.allocator, doc);
    defer db.deinit();

    // %s is dropped from name, it is redundant
    const register_id = try db.getEntityIdByName("type.field", "TEST_FIELD");
    try expectAttr(db, "count", 2, register_id);
}
