const std = @import("std");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const xml = @import("xml.zig");

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

    fn getRegisterPropsDerivedFromParent(
        ctx: *Context,
        id: EntityId,
        node: xml.Node,
    ) !RegisterProperties {
        const register_props = try RegisterProperties.parse(node);
        try ctx.addRegisterPropertiesDerivedFromParent(id, register_props);

        return ctx.register_props.get(id).?;
    }

    fn addRegisterPropertiesDerivedFrom(
        ctx: *Context,
        id: EntityId,
        from: EntityId,
        register_props: RegisterProperties,
    ) !void {
        const db = ctx.db;
        var base_register_props = ctx.register_props.get(from) orelse unreachable;

        inline for (@typeInfo(RegisterProperties).Struct.fields) |field| {
            if (@field(register_props, field.name)) |value|
                @field(base_register_props, field.name) = value;
        }

        log.debug("deriving register props: {}", .{base_register_props});
        try ctx.register_props.put(db.gpa, id, base_register_props);
    }

    fn addRegisterPropertiesDerivedFromParent(
        ctx: *Context,
        id: EntityId,
        register_props: RegisterProperties,
    ) !void {
        const db = ctx.db;

        if (db.attrs.parent.get(id)) |parent_id|
            try ctx.addRegisterPropertiesDerivedFrom(id, parent_id, register_props)
        else
            try ctx.register_props.put(db.gpa, id, register_props);
    }
};

pub fn loadIntoDb(db: *Database, doc: xml.Doc) !void {
    const root = try doc.getRootElement();

    const device_id = db.createEntity();
    try db.instances.devices.put(db.gpa, device_id, .{});

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

        // cpu name => arch
        try db.addDeviceProperty(device_id, "arch", cpu_name);
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
    log.debug("parsed register props: {}", .{register_props});
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

pub fn deriveEntity(db: Database, id: EntityId, derived_name: []const u8) !void {
    log.debug("{}: derived from {s}", .{ id, derived_name });
    const entity_type = db.getEntityType(id);
    log.warn("TODO: implement derivation for {}", .{entity_type});
}

pub fn loadPeripheral(ctx: *Context, node: xml.Node, device_id: EntityId) !void {
    const db = ctx.db;
    const name = node.getValue("name") orelse return error.PeripheralMissingName;
    const base_address = node.getValue("baseAddress") orelse return error.PeripheralMissingBaseAddress;
    const offset = try std.fmt.parseInt(u64, base_address, 0);

    const type_id = try db.createPeripheral(.{});
    errdefer db.destroyEntity(type_id);

    const instance_id = try db.createPeripheralInstance(device_id, type_id, .{
        .name = name,
        .offset = offset,
    });
    errdefer db.destroyEntity(instance_id);

    const dim_elements = try DimElements.parse(node);
    if (dim_elements != null)
        return error.TodoDimElements;

    if (node.findChild("interrupt")) |interrupt_node|
        try loadInterrupt(db, interrupt_node, device_id);

    // TODO: skip if:
    //  - any dimElementGroup values are set

    log.debug("{}: created peripheral instance", .{instance_id});
    // TODO: what to do with a half baked instance?

    if (node.getValue("description")) |description|
        try db.addDescription(instance_id, description);

    if (node.getValue("version")) |version|
        try db.addVersion(instance_id, version);

    if (node.getAttribute("derivedFrom")) |derived_from|
        try ctx.addDerivedEntity(instance_id, derived_from);

    const register_props = try RegisterProperties.parse(node);
    log.debug("parsed register props: {}", .{register_props});
    try ctx.addRegisterPropertiesDerivedFrom(type_id, device_id, register_props);

    var register_it = node.iterate(&.{"registers"}, "register");
    while (register_it.next()) |register_node|
        loadRegister(ctx, register_node, type_id) catch |err|
            log.warn("failed to load register: {}", .{err});

    // TODO: handle errors when implemented
    var cluster_it = node.iterate(&.{"registers"}, "cluster");
    while (cluster_it.next()) |cluster_node|
        loadCluster(ctx, cluster_node, type_id) catch |err|
            log.warn("failed to load cluster: {}", .{err});

    // dimElementGroup
    // alternatePeripheral
    // groupName
    // prependToName
    // appendToName
    // headerStructName
    // disableCondition
    // addressBlock
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

fn loadRegister(
    ctx: *Context,
    node: xml.Node,
    parent_id: EntityId,
) !void {
    const db = ctx.db;
    const id = try db.createRegister(parent_id, .{
        .name = node.getValue("name") orelse return error.MissingRegisterName,
        .description = node.getValue("description"),
        .offset = if (node.getValue("addressOffset")) |offset_str|
            try std.fmt.parseInt(u64, offset_str, 0)
        else
            null,
    });
    errdefer db.destroyEntity(id);

    const dim_elements = try DimElements.parse(node);
    if (dim_elements != null)
        return error.TodoDimElements;

    const register_props = try ctx.getRegisterPropsDerivedFromParent(id, node);
    if (register_props.size) |size|
        try db.addSize(id, size);

    // TODO: protection
    if (register_props.access) |access|
        try db.addAccess(id, access);

    if (register_props.reset_mask) |reset_mask|
        try db.addResetMask(id, reset_mask);

    if (register_props.reset_value) |reset_value|
        try db.addResetValue(id, reset_value);

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
    const id = try db.createField(register_id, .{
        .name = node.getValue("name") orelse return error.MissingFieldName,
        .description = node.getValue("description"),
        .size = bit_range.width,
        .offset = bit_range.offset,
    });
    errdefer db.destroyEntity(id);

    const dim_elements = try DimElements.parse(node);
    if (dim_elements != null)
        return error.TodoDimElements;

    if (node.getValue("access")) |access_str|
        try db.addAccess(id, try parseAccess(access_str));

    if (node.findChild("enumeratedValues")) |enum_values_node|
        try loadEnumeratedValues(ctx, enum_values_node, id);

    if (node.getAttribute("derivedFrom")) |derived_from|
        try ctx.addDerivedEntity(id, derived_from);

    // TODO:
    // dimElementGroup
    // modifiedWriteValues
    // writeConstraint
    // readAction
    // enumeratedValues

}

fn loadEnumeratedValues(ctx: *Context, node: xml.Node, field_id: EntityId) !void {
    const db = ctx.db;

    assert(db.entityIs("type.field", field_id));
    const id = try db.createEnum(field_id, .{
        .name = node.getValue("name"),
        .size = db.attrs.size.get(field_id),
    });
    defer db.destroyEntity(id);

    try db.attrs.@"enum".putNoClobber(db.gpa, field_id, id);

    var value_it = node.iterate(&.{}, "enumeratedValue");
    while (value_it.next()) |value_node|
        try loadEnumeratedValue(ctx, value_node, id);
}

fn loadEnumeratedValue(ctx: *Context, node: xml.Node, enum_id: EntityId) !void {
    const db = ctx.db;

    assert(db.entityIs("type.enum", enum_id));
    const id = try db.createEnumField(enum_id, .{
        .name = node.getValue("name") orelse return error.EnumFieldMissingName,
        .description = node.getValue("description"),
        .value = if (node.getValue("value")) |value_str|
            try std.fmt.parseInt(u32, value_str, 0)
        else
            return error.EnumFieldMissingValue,
    });
    defer db.destroyEntity(id);
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

pub const Endian = enum { little, big, selectable, other };

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

//
//pub const CpuName = enum {
//    cortex_m0,
//    cortex_m0plus,
//    cortex_m1,
//    sc000, // kindof like an m3
//    cortex_m23,
//    cortex_m3,
//    cortex_m33,
//    cortex_m35p,
//    cortex_m55,
//    sc300,
//    cortex_m4,
//    cortex_m7,
//    arm_v8_mml,
//    arm_v8_mbl,
//    arm_v81_mml,
//    cortex_a5,
//    cortex_a7,
//    cortex_a8,
//    cortex_a9,
//    cortex_a15,
//    cortex_a17,
//    cortex_a53,
//    cortex_a57,
//    cortex_a72,
//
//    // avr
//    avr,
//    other,
//
//    // TODO: finish
//    pub fn parse(str: []const u8) ?CpuName {
//        return if (std.mem.eql(u8, "CM0", str))
//            CpuName.cortex_m0
//        else if (std.mem.eql(u8, "CM0PLUS", str))
//            CpuName.cortex_m0plus
//        else if (std.mem.eql(u8, "CM0+", str))
//            CpuName.cortex_m0plus
//        else if (std.mem.eql(u8, "CM1", str))
//            CpuName.cortex_m1
//        else if (std.mem.eql(u8, "SC000", str))
//            CpuName.sc000
//        else if (std.mem.eql(u8, "CM23", str))
//            CpuName.cortex_m23
//        else if (std.mem.eql(u8, "CM3", str))
//            CpuName.cortex_m3
//        else if (std.mem.eql(u8, "CM33", str))
//            CpuName.cortex_m33
//        else if (std.mem.eql(u8, "CM35P", str))
//            CpuName.cortex_m35p
//        else if (std.mem.eql(u8, "CM55", str))
//            CpuName.cortex_m55
//        else if (std.mem.eql(u8, "SC300", str))
//            CpuName.sc300
//        else if (std.mem.eql(u8, "CM4", str))
//            CpuName.cortex_m4
//        else if (std.mem.eql(u8, "CM7", str))
//            CpuName.cortex_m7
//        else if (std.mem.eql(u8, "AVR8", str))
//            CpuName.avr
//        else
//            null;
//    }
//};
//
//pub const Endian = enum {
//    little,
//    big,
//    selectable,
//    other,
//
//    pub fn parse(str: []const u8) !Endian {
//        return if (std.meta.stringToEnum(Endian, str)) |val|
//            val
//        else
//            error.UnknownEndianType;
//    }
//};
//
//pub const Cpu = struct {
//    //name: ?CpuName,
//    name: ?[]const u8,
//    revision: []const u8,
//    endian: Endian,
//    mpu_present: bool,
//    //fpu_present: bool,
//    //fpu_dp: bool,
//    //dsp_present: bool,
//    //icache_present: bool,
//    //dcache_present: bool,
//    //itcm_present: bool,
//    //dtcm_present: bool,
//    vtor_present: bool,
//    nvic_prio_bits: u8,
//    vendor_systick_config: bool,
//    device_num_interrupts: ?usize,
//    //sau_num_regions: usize,
//
//    pub fn parse(arena: *ArenaAllocator, nodes: *xml.Node) !Cpu {
//        return Cpu{
//            .name = if (xml.findValueForKey(nodes, "name")) |name| try arena.allocator().dupe(u8, name) else null,
//            .revision = xml.findValueForKey(nodes, "revision") orelse unreachable,
//            .endian = try Endian.parse(xml.findValueForKey(nodes, "endian") orelse unreachable),
//            .nvic_prio_bits = if (xml.findValueForKey(nodes, "nvicPrioBits")) |nvic_prio_bits|
//                try std.fmt.parseInt(u8, nvic_prio_bits, 0)
//            else
//                0,
//            // TODO: booleans
//            .vendor_systick_config = (try xml.parseBoolean(arena.child_allocator, nodes, "vendorSystickConfig")) orelse false,
//            .device_num_interrupts = if (xml.findValueForKey(nodes, "deviceNumInterrupts")) |size_str|
//                try std.fmt.parseInt(usize, size_str, 0)
//            else
//                null,
//            .vtor_present = (try xml.parseBoolean(arena.child_allocator, nodes, "vtorPresent")) orelse false,
//            .mpu_present = (try xml.parseBoolean(arena.child_allocator, nodes, "mpuPresent")) orelse false,
//        };
//    }
//};
//
//pub const Access = enum {
//    read_only,
//    write_only,
//    read_write,
//    writeonce,
//    read_writeonce,
//
//    pub fn parse(str: []const u8) !Access {
//        return if (std.mem.eql(u8, "read-only", str))
//            Access.read_only
//        else if (std.mem.eql(u8, "write-only", str))
//            Access.write_only
//        else if (std.mem.eql(u8, "read-write", str))
//            Access.read_write
//        else if (std.mem.eql(u8, "writeOnce", str))
//            Access.writeonce
//        else if (std.mem.eql(u8, "read-writeOnce", str))
//            Access.read_writeonce
//        else
//            error.UnknownAccessType;
//    }
//};
//
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

//pub const Dimension = struct {
//    dim: usize,
//    increment: usize,
//    /// a range of 0-index, only index is recorded
//    index: ?Index,
//    name: ?[]const u8,
//    //array_index: ,
//
//    const Index = union(enum) {
//        num: usize,
//        list: std.ArrayList([]const u8),
//    };
//
//    pub fn parse(arena: *ArenaAllocator, nodes: *xml.Node) !?Dimension {
//        const allocator = arena.allocator();
//        return Dimension{
//            .dim = (try xml.parseIntForKey(usize, arena.child_allocator, nodes, "dim")) orelse return null,
//            .increment = (try xml.parseIntForKey(usize, arena.child_allocator, nodes, "dimIncrement")) orelse return null,
//            .index = if (xml.findValueForKey(nodes, "dimIndex")) |index_str|
//                if (std.mem.indexOf(u8, index_str, ",") != null) blk: {
//                    var list = std.ArrayList([]const u8).init(allocator);
//                    var it = std.mem.tokenize(u8, index_str, ",");
//                    var expected: usize = 0;
//                    while (it.next()) |token| : (expected += 1)
//                        try list.append(try allocator.dupe(u8, token));
//
//                    break :blk Index{
//                        .list = list,
//                    };
//                } else blk: {
//                    var it = std.mem.tokenize(u8, index_str, "-");
//                    const begin = try std.fmt.parseInt(usize, it.next() orelse return error.InvalidDimIndex, 10);
//                    const end = try std.fmt.parseInt(usize, it.next() orelse return error.InvalidDimIndex, 10);
//
//                    if (begin == 0)
//                        break :blk Index{
//                            .num = end + 1,
//                        };
//
//                    var list = std.ArrayList([]const u8).init(allocator);
//                    var i = begin;
//                    while (i <= end) : (i += 1)
//                        try list.append(try std.fmt.allocPrint(allocator, "{}", .{i}));
//
//                    break :blk Index{
//                        .list = list,
//                    };
//                }
//            else
//                null,
//            .name = if (xml.findValueForKey(nodes, "dimName")) |name_str|
//                try allocator.dupe(u8, name_str)
//            else
//                null,
//        };
//    }
//};

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

test "device register properties" {
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
    try expectAttr(db, "size", 32, register_id);
    try expectAttr(db, "access", .read_only, register_id);
    try expectAttr(db, "reset_value", 0, register_id);
    try expectAttr(db, "reset_mask", 0xffffffff, register_id);
}

test "peripheral register properties" {
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

test "register register properties" {
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

test "register with fields" {
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

test "field with enum value" {
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

    const field_id = try db.getEntityIdByName("type.field", "TEST_FIELD");
    const enum_id = try db.getEntityIdByName("type.enum", "TEST_ENUM");

    // field
    try expectAttr(db, "enum", enum_id, field_id);

    // enum
    try expectAttr(db, "size", 8, enum_id);
    try expectAttr(db, "parent", field_id, enum_id);

    const enum_field1_id = try db.getEntityIdByName("type.enum_field", "TEST_ENUM_FIELD1");
    try expectEqual(@as(u32, 0), db.types.enum_fields.get(enum_field1_id).?);
    try expectAttr(db, "parent", enum_id, enum_field1_id);
    try expectAttr(db, "description", "test enum field 1", enum_field1_id);

    const enum_field2_id = try db.getEntityIdByName("type.enum_field", "TEST_ENUM_FIELD2");
    try expectEqual(@as(u32, 1), db.types.enum_fields.get(enum_field2_id).?);
    try expectAttr(db, "parent", enum_id, enum_field2_id);
    try expectAttr(db, "description", "test enum field 2", enum_field2_id);
}
