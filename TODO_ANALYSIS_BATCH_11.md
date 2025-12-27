# TODO Analysis - Batch 11: tools

**Directory**: `tools`  
**Total TODOs**: 25  
**IDs**: 12-36  

---

## TODO #12: scratchpad datastructure for temporary string based relationships

**Location**: `tools/regz/src/atdf.zig:50`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: scratchpad datastructure for temporary string based relationships,
```

**Code Context** (lines 40-60):
```zig
const Context = struct {
    db: *Database,
    arena: std.heap.ArenaAllocator,
    interrupt_groups: std.StringHashMapUnmanaged(std.ArrayList(InterruptGroupEntry)) = .empty,
    inferred_register_group_offsets: std.AutoArrayHashMapUnmanaged(StructID, u64) = .{},

    fn init(db: *Database) Context {
        return Context{
            .db = db,
            .arena = std.heap.ArenaAllocator.init(db.gpa),
        };
    }

// TODO: scratchpad datastructure for temporary string based relationships,
// then stitch it all together in the end
pub fn load_into_db(db: *Database, doc: xml.Doc) !void {
    var ctx = Context.init(db);
    defer ctx.deinit();

    const root = try doc.get_root_element();
```

**Analysis**:

- **Purpose**: Create a temporary data structure for string-based relationships during ATDF parsing, to be resolved after the initial parse phase
- **Why Incomplete**: Initial implementation focused on core functionality; complex relationship resolution deferred
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to TODOs #15, #17 about instances and naming

**Recommendation**: Design temporary storage mechanism for string-based relationships during parse phase. Consider a two-pass approach: first pass collects entities and relationships, second pass resolves references.

---

## TODO #13: maybe others?

**Location**: `tools/regz/src/atdf.zig:105`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: maybe others?
```

**Code Context** (lines 95-115):
```zig
    var param_it = node.iterate(&.{"parameters"}, &.{"param"});
    while (param_it.next()) |param_node|
        try load_param(ctx, param_node, device_id);

    //try infer_peripheral_offsets(ctx);

    // TODO: maybe others?

    // TODO:
    // address-space.memory-segment
    // events.generators.generator
    // events.users.user
    // interfaces.interface.parameters.param

    // property-groups.property-group.property
}
```

**Analysis**:

- **Purpose**: Handle additional ATDF elements that may need parsing (address-space, events, interfaces, property-groups)
- **Why Incomplete**: Initial implementation focused on core peripheral/register parsing; auxiliary features deferred
- **Complexity**: Medium - Standard feature implementation
- **Related Items**: Related to TODO #14 which lists specific unhandled elements

**Recommendation**: Review ATDF specification and implement missing feature categories. Prioritize based on real-world ATDF file usage.

---

## TODO #14: (empty TODO)

**Location**: `tools/regz/src/atdf.zig:107`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO:
```

**Code Context** (lines 97-117):
```zig
    //try infer_peripheral_offsets(ctx);

    // TODO: maybe others?

    // TODO:
    // address-space.memory-segment
    // events.generators.generator
    // events.users.user
    // interfaces.interface.parameters.param

    // property-groups.property-group.property
}

fn load_param(ctx: *Context, node: xml.Node, device_id: DeviceID) !void {
```

**Analysis**:

- **Purpose**: Lists specific unimplemented ATDF elements: address-space memory-segment, events (generators/users), interfaces, and property-groups
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Continuation of TODO #13

**Recommendation**: Implement parsing for each listed element type. Start with address-space memory-segment as it's likely more commonly used than events/interfaces.

---

## TODO #15: assert that there's only one instance using this type

**Location**: `tools/regz/src/atdf.zig:229`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: assert that there's only one instance using this type
```

**Code Context** (lines 219-239):
```zig
fn infer_peripheral_offset(ctx: *Context, type_id: PeripheralID, instance_id: DevicePeripheralID) !void {
    const db = ctx.db;
    // TODO: assert that there's only one instance using this type

    var min_offset: ?u64 = null;
    var max_size: u64 = 8;
    // first find the min offset of all the registers for this peripheral
    const register_set = db.children.registers.get(type_id) orelse return;
    for (register_set.keys()) |register_id| {
        const offset = db.attrs.offset.get(register_id) orelse continue;
        if (min_offset == null)
            min_offset = offset
        else
            min_offset = @min(min_offset.?, offset);
```

**Analysis**:

- **Purpose**: Add validation to ensure only one peripheral instance uses this type before inferring offsets
- **Why Incomplete**: Initial implementation focused on core functionality; edge cases deferred
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Part of offset inference logic

**Recommendation**: Add validation check with descriptive error message. The function already receives both type_id and instance_id, so check that only one instance exists for the given type.

---

## TODO #16: assert consecutive

**Location**: `tools/regz/src/atdf.zig:290`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: assert consecutive
```

**Code Context** (lines 280-300):
```zig
                if (std.mem.eql(u8, values, value_group_name)) {
                    log.debug("found values={s}", .{values});
                    const mask_str = bitfield_node.get_attribute("mask") orelse continue;
                    const mask = try std.fmt.parseInt(u64, mask_str, 0);
                    try field_sizes.append(allocator, @popCount(mask));
                    // TODO: assert consecutive
                }
            }
        }
    }

    log.debug("found field usage count of: {}", .{field_sizes.items.len});
```

**Analysis**:

- **Purpose**: Add validation to ensure bitfield mask bits are consecutive (no gaps in the bit pattern)
- **Why Incomplete**: Initial implementation focused on core functionality; validation deferred
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Part of enum size inference from bitfield usage

**Recommendation**: Add validation checks with descriptive error messages. Check that `@popCount(mask) == @clz(mask) + @ctz(mask)` to ensure consecutive bits.

---

## TODO #17: instances use name in module

**Location**: `tools/regz/src/atdf.zig:324`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: instances use name in module
```

**Code Context** (lines 314-334):
```zig
    };
}

// TODO: instances use name in module
fn get_inlined_register_group(parent_node: xml.Node, parent_name: []const u8) ?xml.Node {
    var register_group_it = parent_node.iterate(&.{}, &.{"register-group"});
    const rg_node = register_group_it.next() orelse return null;
    const rg_name = rg_node.get_attribute("name") orelse return null;
    log.debug("rg name is {s}, parent is {s}", .{ rg_name, parent_name });
    if (register_group_it.next() != null) {
        log.debug("register group not alone", .{});
        return null;
    }
```

**Analysis**:

- **Purpose**: Handle naming strategy for module instances - clarify how "name-in-module" attribute should be used
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to TODO #12 about relationship handling

**Recommendation**: Review ATDF specification for proper instance naming semantics and implement consistent naming strategy across module instances.

---

## TODO #18: infer register group size?

**Location**: `tools/regz/src/atdf.zig:525`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: infer register group size?
```

**Code Context** (lines 515-535):
```zig
    try infer_register_group_offset(ctx, node, struct_id);
    try load_register_group_children(ctx, node, parent, struct_id);
    // TODO: infer register group size?
    // Do register groups ever operate as just namespaces?

    // TODO: check size
}

fn load_mode(ctx: *Context, node: xml.Node, parent: StructID) !void {
    const db = ctx.db;

    // TODO: determine if it ever gets put in the register type
```

**Analysis**:

- **Purpose**: Implement automatic size calculation for register groups based on their children
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to TODO #19 about size checking

**Recommendation**: Implement size/offset inference logic with fallback handling. Calculate size as max(register_offset + register_size) for all registers in the group.

---

## TODO #19: check size

**Location**: `tools/regz/src/atdf.zig:528`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: check size
```

**Code Context** (lines 518-538):
```zig
    try load_register_group_children(ctx, node, parent, struct_id);
    // TODO: infer register group size?
    // Do register groups ever operate as just namespaces?

    // TODO: check size
}

fn load_mode(ctx: *Context, node: xml.Node, parent: StructID) !void {
    const db = ctx.db;

    // TODO: determine if it ever gets put in the register type
    validate_attrs(node, &.{
```

**Analysis**:

- **Purpose**: Add size validation for registers/groups - verify declared size matches calculated size
- **Why Incomplete**: Initial implementation focused on core functionality; validation deferred
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Related to TODO #18 about inferring size

**Recommendation**: Add validation checks with descriptive error messages. Compare explicit size attribute against calculated size from register offsets.

---

## TODO #20: determine if it ever gets put in the register type

**Location**: `tools/regz/src/atdf.zig:534`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: determine if it ever gets put in the register type
```

**Code Context** (lines 524-544):
```zig
    // TODO: check size
}

fn load_mode(ctx: *Context, node: xml.Node, parent: StructID) !void {
    const db = ctx.db;

    // TODO: determine if it ever gets put in the register type
    validate_attrs(node, &.{
        "value",
        "mask",
        "name",
        "qualifier",
        "caption",
    });
```

**Analysis**:

- **Purpose**: Investigate whether mode attributes should be associated with register types rather than register groups
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to all mode handling TODOs (#22, #23, #26, #29)

**Recommendation**: Research ATDF mode specification to determine proper scoping. Survey real ATDF files to see where modes are actually defined.

---

## TODO #21: "mask": "optional"

**Location**: `tools/regz/src/atdf.zig:550`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: "mask": "optional",
```

**Code Context** (lines 540-560):
```zig
    _ = try db.create_mode(parent, .{
        .name = node.get_attribute("name") orelse return error.MissingModeName,
        .description = node.get_attribute("caption"),
        .value = node.get_attribute("value") orelse return error.MissingModeValue,
        .qualifier = node.get_attribute("qualifier") orelse return error.MissingModeQualifier,
    });

    // TODO: "mask": "optional",
}

// search for modes that the parent entity owns, and if the name matches,
// then we have our entry. If not found then the input is malformed.
// TODO: assert unique mode name
// TODO: modes
```

**Analysis**:

- **Purpose**: Handle optional mask attribute in mode definitions
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Part of mode handling system

**Recommendation**: Add support for optional mask attribute. Update mode creation to handle presence/absence of mask field.

---

## TODO #22: assert unique mode name

**Location**: `tools/regz/src/atdf.zig:555`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: assert unique mode name
```

**Code Context** (lines 545-565):
```zig
    });

    // TODO: "mask": "optional",
}

// search for modes that the parent entity owns, and if the name matches,
// then we have our entry. If not found then the input is malformed.
// TODO: assert unique mode name
// TODO: modes
fn assign_modes_to_register(
    ctx: *Context,
    register_id: RegisterID,
    parent: StructID,
    mode_names: []const u8,
) !void {
```

**Analysis**:

- **Purpose**: Add validation to ensure mode names are unique within their scope
- **Why Incomplete**: Initial implementation focused on core functionality; validation deferred
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Part of mode validation system

**Recommendation**: Add validation checks with descriptive error messages. Check for duplicate mode names when creating modes.

---

## TODO #23: modes

**Location**: `tools/regz/src/atdf.zig:556`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: modes
```

**Code Context** (lines 546-566):
```zig
    // TODO: "mask": "optional",
}

// search for modes that the parent entity owns, and if the name matches,
// then we have our entry. If not found then the input is malformed.
// TODO: assert unique mode name
// TODO: modes
fn assign_modes_to_register(
    ctx: *Context,
    register_id: RegisterID,
    parent: StructID,
    mode_names: []const u8,
) !void {
    log.debug("assigning mode_names='{s}' to {f} from {f}", .{ mode_names, register_id, parent });
```

**Analysis**:

- **Purpose**: Complete mode assignment system for registers
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: High - Requires architectural changes to mode/namespace handling
- **Related Items**: Central TODO for mode system - relates to #20, #21, #22, #25, #26, #28, #29

**Recommendation**: Implement mode handling system - review SVD parser for reference patterns. Modes are used to represent register variants based on configuration.

---

## TODO #24: FIXME: field specific r/w

**Location**: `tools/regz/src/atdf.zig:703`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// FIXME: field specific r/w
```

**Code Context** (lines 693-713):
```zig
                bit_count += 1;

                // FIXME: field specific r/w
                //if (node.get_attribute("rw")) |access_str| blk: {
                //    const access = access_from_string(access_str) catch break :blk;
                //    switch (access) {
                //        .read_only, .write_only => try db.attrs.access.put(
                //            db.gpa,
                //            id,
                //            access,
                //        ),
                //        else => {},
                //    }
                //}
```

**Analysis**:

- **Purpose**: Implement per-field read/write access control for bitfields
- **Why Incomplete**: Initial implementation focused on core functionality; per-field access deferred
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to TODO #27 (same issue for contiguous fields)

**Recommendation**: Implement per-field access tracking in database. The code is commented out and ready to be enabled once the database schema supports it.

---

## TODO #25: FIXME: struct field modes

**Location**: `tools/regz/src/atdf.zig:730`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// FIXME: struct field modes
```

**Code Context** (lines 720-740):
```zig
                    .enum_id = if (node.get_attribute("values")) |values| blk: {
                        const e = db.get_enum_by_name(arena, peripheral_struct_id, values) catch |err| {
                            log.warn("{s} failed to get_enum_by_name: {s}", .{ name, values });
                            return err;
                        };
                        break :blk e.id;
                    } else null,
                });

                // FIXME: struct field modes
                if (node.get_attribute("modes")) |modes| {
                    _ = modes;
                    // TODO: modes
                    //assign_modes_to_entity(ctx, id, register_id, modes) catch {
```

**Analysis**:

- **Purpose**: Implement mode support for struct fields (bitfields broken into single bits)
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: High - Requires architectural changes to mode/namespace handling
- **Related Items**: Part of overall mode system (#23, #26, #28, #29)

**Recommendation**: Implement mode handling system - review SVD parser for reference patterns. This is for discontiguous bitfields that are split into individual bits.

---

## TODO #26: modes

**Location**: `tools/regz/src/atdf.zig:733`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: modes
```

**Code Context** (lines 723-743):
```zig
                    } else null,
                });

                // FIXME: struct field modes
                if (node.get_attribute("modes")) |modes| {
                    _ = modes;
                    // TODO: modes
                    //assign_modes_to_entity(ctx, id, register_id, modes) catch {
                    //    log.warn("failed to find mode '{s}' for field '{s}'", .{
                    //        modes,
                    //        name,
                    //    });
                    //};
                }

                // discontiguous fields like this don't get to have enums
            }
```

**Analysis**:

- **Purpose**: Complete mode assignment for discontiguous bitfields
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: High - Requires architectural changes to mode/namespace handling
- **Related Items**: Continuation of TODO #25

**Recommendation**: Implement mode handling system - review SVD parser for reference patterns. Uncomment and adapt the assign_modes_to_entity call once mode system is complete.

---

## TODO #27: FIXME: field based access

**Location**: `tools/regz/src/atdf.zig:752`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// FIXME: field based access
```

**Code Context** (lines 742-762):
```zig
        const width = @popCount(mask);

        log.debug("field: name={s}", .{name});
        if (node.get_attribute("values")) |values|
            log.debug("  values={s}", .{values});

        // FIXME: field based access
        //if (node.get_attribute("rw")) |access_str| blk: {
        //    const access = access_from_string(access_str) catch break :blk;
        //    switch (access) {
        //        .read_only, .write_only => try db.attrs.access.put(
        //            db.gpa,
        //            id,
        //            access,
        //        ),
```

**Analysis**:

- **Purpose**: Implement per-field read/write access control for contiguous bitfields
- **Why Incomplete**: Initial implementation focused on core functionality; per-field access deferred
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Same issue as TODO #24, but for contiguous fields

**Recommendation**: Implement per-field access tracking in database. Enable the commented code once database supports field-level access attributes.

---

## TODO #28: FIXME: struct_field modes

**Location**: `tools/regz/src/atdf.zig:779`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// FIXME: struct_field modes
```

**Code Context** (lines 769-789):
```zig
            .enum_id = if (node.get_attribute("values")) |values| blk: {
                const e = db.get_enum_by_name(arena, peripheral_struct_id, values) catch |err| {
                    log.warn("{s} failed to get_enum_by_name: {s}", .{ name, values });
                    return err;
                };
                break :blk e.id;
            } else null,
        });

        // FIXME: struct_field modes
        if (node.get_attribute("modes")) |modes| {
            _ = modes;
            // TODO: modes
            //assign_modes_to_entity(ctx, id, register_id, modes) catch {
            //    log.warn("failed to find mode '{s}' for field '{s}'", .{
```

**Analysis**:

- **Purpose**: Implement mode support for contiguous struct fields
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: High - Requires architectural changes to mode/namespace handling
- **Related Items**: Similar to TODO #25 but for contiguous fields

**Recommendation**: Implement mode handling system - review SVD parser for reference patterns. This is the same mode issue but for normal contiguous bitfields.

---

## TODO #29: modes

**Location**: `tools/regz/src/atdf.zig:782`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: modes
```

**Code Context** (lines 772-792):
```zig
                break :blk e.id;
            } else null,
        });

        // FIXME: struct_field modes
        if (node.get_attribute("modes")) |modes| {
            _ = modes;
            // TODO: modes
            //assign_modes_to_entity(ctx, id, register_id, modes) catch {
            //    log.warn("failed to find mode '{s}' for field '{s}'", .{
            //        modes,
            //        name,
            //    });
            //};
        }

        // values _should_ match to a known enum
```

**Analysis**:

- **Purpose**: Complete mode assignment for contiguous bitfields
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: High - Requires architectural changes to mode/namespace handling
- **Related Items**: Continuation of TODO #28

**Recommendation**: Implement mode handling system - review SVD parser for reference patterns. Uncomment assign_modes_to_entity once mode system is implemented.

---

## TODO #30: namespace the enum to the appropriate register, register_group, or peripheral

**Location**: `tools/regz/src/atdf.zig:792`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: namespace the enum to the appropriate register, register_group, or peripheral
```

**Code Context** (lines 782-802):
```zig
            _ = modes;
            // TODO: modes
            //assign_modes_to_entity(ctx, id, register_id, modes) catch {
            //    log.warn("failed to find mode '{s}' for field '{s}'", .{
            //        modes,
            //        name,
            //    });
            //};
        }

        // values _should_ match to a known enum
        // TODO: namespace the enum to the appropriate register, register_group, or peripheral

    }
}

fn access_from_string(str: []const u8) !Database.Access {
```

**Analysis**:

- **Purpose**: Properly scope enums to their containing register/peripheral to prevent name collisions
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: High - Requires architectural changes to mode/namespace handling
- **Related Items**: Critical for avoiding enum name collisions across peripherals

**Recommendation**: Design enum scoping system to prevent name collisions. Consider hierarchical naming (peripheral.register.enum) or scope-based lookup.

---

## TODO #31: this isn't always a set value, not sure what to do if it's left out

**Location**: `tools/regz/src/atdf.zig:1020`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: this isn't always a set value, not sure what to do if it's left out
```

**Code Context** (lines 1010-1030):
```zig
    log.debug("{}: creating register group instance", .{id});
    const name = node.get_attribute("name") orelse return error.MissingInstanceName;
    // TODO: this isn't always a set value, not sure what to do if it's left out
    const name_in_module = node.get_attribute("name-in-module") orelse {
        log.warn("no 'name-in-module' for register group '{s}'", .{
            name,
        });

        return error.MissingNameInModule;
    };

    const type_id = blk: {
```

**Analysis**:

- **Purpose**: Handle cases where name-in-module attribute is missing in register group instances
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to naming and instance handling (#12, #17)

**Recommendation**: Implement fallback strategy when name-in-module is missing. Consider using the instance name or inferring from parent module structure.

---

## TODO #32: (empty TODO)

**Location**: `tools/regz/src/atdf.zig:1058`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO:
```

**Code Context** (lines 1048-1068):
```zig
    try db.add_child("instance.register_group", peripheral_id, id);

    // TODO:
    // "address-space": "optional",
    // "version": "optional",
    // "id": "optional",
}

fn load_signal(
    ctx: *Context,
    node: xml.Node,
    peripheral_id: DevicePeripheralID,
) !void {
```

**Analysis**:

- **Purpose**: Handle optional register group instance attributes: address-space, version, and id
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Part of register group instance handling

**Recommendation**: Implement handling for optional attributes. Add fields to database if they provide useful information, otherwise document why they're skipped.

---

## TODO #33: pads

**Location**: `tools/regz/src/atdf.zig:1080`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: pads
```

**Code Context** (lines 1070-1090):
```zig
    validate_attrs(node, &.{
        "group",
        "index",
        "pad",
        "function",
        "field",
        "ioset",
    });

    // TODO: pads
}

// TODO: there are fields like irq-index
fn load_interrupt(
```

**Analysis**:

- **Purpose**: Implement pad/signal handling for peripherals - maps peripheral signals to physical pins
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Part of pin/signal mapping system

**Recommendation**: Implement signal/pad parsing based on ATDF schema. Research how other tools handle peripheral-to-pin mapping.

---

## TODO #34: there are fields like irq-index

**Location**: `tools/regz/src/atdf.zig:1083`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: there are fields like irq-index
```

**Code Context** (lines 1073-1093):
```zig
        "function",
        "field",
        "ioset",
    });

    // TODO: pads
}

// TODO: there are fields like irq-index
fn load_interrupt(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
) !void {
    const db = ctx.db;
```

**Analysis**:

- **Purpose**: Handle interrupt index fields in ATDF that aren't currently parsed
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Related to TODO #35 about module-instance connections

**Recommendation**: Research ATDF interrupt group specification and implement handling. The irq-index field likely provides additional interrupt metadata.

---

## TODO #35: probably connects module instance to interrupt

**Location**: `tools/regz/src/atdf.zig:1097`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: probably connects module instance to interrupt
```

**Code Context** (lines 1087-1107):
```zig
    validate_attrs(node, &.{
        "index",
        "name",
        "irq-caption",
        "alternate-name",
        "irq-index",
        "caption",
        // TODO: probably connects module instance to interrupt
        "module-instance",
        "irq-name",
        "alternate-caption",
    });

    const name = node.get_attribute("name") orelse return error.MissingInterruptName;
```

**Analysis**:

- **Purpose**: Determine how module-instance attribute connects peripheral instances to their interrupts
- **Why Incomplete**: Feature deferred during initial ATDF parser development
- **Complexity**: Medium - Requires new data structures or parsing logic
- **Related Items**: Part of interrupt system (#34)

**Recommendation**: Research ATDF interrupt specification to understand module-instance linkage. Currently interrupts are created with module-instance prefix but the relationship isn't formally tracked.

---

## TODO #36: better output

**Location**: `tools/regz/src/atdf.zig:1127`  
**Author**: Matt Knight (2024-03-26)  
**Commit**: 8e5c0497 - "refactor(regz): split into modules"

**Original Comment**:
```zig
// TODO: better output
```

**Code Context** (lines 1117-1137):
```zig
    defer db.gpa.free(full_name);

    _ = try db.create_interrupt(device_id, .{
        .name = full_name,
        .idx = index,
        .description = node.get_attribute("caption"),
    });
}

// for now just emit warning logs when the input has attributes that it shouldn't have
// TODO: better output
fn validate_attrs(node: xml.Node, attrs: []const []const u8) void {
    var it = node.iterate_attrs();
    while (it.next()) |attr| {
        for (attrs) |expected_attr| {
            if (std.mem.eql(u8, attr.key, expected_attr))
                break;
```

**Analysis**:

- **Purpose**: Improve validation warnings/error messages for unexpected ATDF attributes
- **Why Incomplete**: Initial implementation uses basic logging; more detailed diagnostics deferred
- **Complexity**: Low - Add validation or improve error messages
- **Related Items**: Quality-of-life improvement for debugging ATDF parsing issues

**Recommendation**: Enhance error messages with line numbers and context. Consider adding severity levels (warning vs error) for different validation issues.

---

## Summary

Batch 11 contains 25 TODOs focused on the ATDF (Atmel Tools Device File) parser in the regz tool. Key themes:

1. **Mode System** (8 TODOs): Complex system for handling register/field variants needs architectural design
2. **Validation** (6 TODOs): Missing assertions and checks for data integrity
3. **Parsing Completeness** (5 TODOs): Several ATDF elements not yet parsed (signals, pads, events, property-groups)
4. **Naming/Scoping** (3 TODOs): Enum namespacing and instance naming need refinement
5. **Access Control** (2 TODOs): Field-level read/write permissions not implemented
6. **Size Inference** (1 TODO): Automatic size calculation for register groups

**Priority Recommendations**:
1. Complete mode system (high complexity, blocks multiple features)
2. Add validation checks (low complexity, high value for robustness)
3. Implement enum namespacing (prevents name collisions)
4. Parse remaining ATDF elements as needed by real-world files
