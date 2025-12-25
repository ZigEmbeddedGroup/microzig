# TODO Analysis Batch 26: tools/regz/src

**Batch Info**: Items 626-650 from TODO_INVENTORY.json

## Analysis Summary

This batch focuses entirely on the `tools/regz/src` directory, which contains the register generation tool (regz) for MicroZig. The TODOs span across ATDF parsing (`atdf.zig`), Embassy integration (`embassy.zig`), and CMSIS-SVD schema definition. Most items relate to incomplete features in register file parsing and code generation.

---

### TODO #626: Instances use name in module

**Location**: `tools/regz/src/atdf.zig:324`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: instances use name in module
```

**Code Context**:
```zig
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

- **Purpose**: Improve ATDF parsing to use the "name-in-module" attribute instead of just "name" for register group instances
- **Why Incomplete**: Part of the major regz rearchitecture - this specific naming convention wasn't fully implemented
- **Complexity**: Medium
- **Related Items**: This relates to other ATDF parsing TODOs in this batch

**Recommendation**: Implement proper name-in-module attribute handling for better register group instance naming consistency

---

### TODO #627: Infer register group size

**Location**: `tools/regz/src/atdf.zig:525`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: infer register group size?
```

**Code Context**:
```zig
try load_register_group_children(ctx, node, parent, struct_id);
// TODO: infer register group size?
// Do register groups ever operate as just namespaces?

// TODO: check size
```

**Analysis**:

- **Purpose**: Automatically calculate register group sizes based on contained registers when size attribute is missing
- **Why Incomplete**: Size inference logic wasn't implemented during the regz rearchitecture
- **Complexity**: Medium
- **Related Items**: Related to TODO #628 (check size)

**Recommendation**: Implement size inference by analyzing the highest offset + size of contained registers

---

### TODO #628: Check size

**Location**: `tools/regz/src/atdf.zig:528`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: check size
```

**Code Context**:
```zig
// TODO: infer register group size?
// Do register groups ever operate as just namespaces?

// TODO: check size
```

**Analysis**:

- **Purpose**: Validate that declared register group sizes match the actual space used by contained registers
- **Why Incomplete**: Size validation wasn't implemented during the regz rearchitecture
- **Complexity**: Low
- **Related Items**: Related to TODO #627 (infer register group size)

**Recommendation**: Add validation to ensure declared sizes are consistent with register layout

---

### TODO #629: Determine if it ever gets put in the register type

**Location**: `tools/regz/src/atdf.zig:534`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: determine if it ever gets put in the register type
```

**Code Context**:
```zig
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

- **Purpose**: Clarify whether mode information should be associated with register types or just peripheral types
- **Why Incomplete**: The mode system design wasn't fully specified during rearchitecture
- **Complexity**: Medium
- **Related Items**: Related to other mode TODOs (#631, #632, #635, #638)

**Recommendation**: Research ATDF specifications and existing usage patterns to determine proper mode placement

---

### TODO #630: "mask": "optional"

**Location**: `tools/regz/src/atdf.zig:550`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: "mask": "optional",
```

**Code Context**:
```zig
_ = try db.create_mode(parent, .{
    .name = node.get_attribute("name") orelse return error.MissingModeName,
    .description = node.get_attribute("caption"),
    .value = node.get_attribute("value") orelse return error.MissingModeValue,
    .qualifier = node.get_attribute("qualifier") orelse return error.MissingModeQualifier,
});

// TODO: "mask": "optional",
```

**Analysis**:

- **Purpose**: Handle optional mask attribute in mode definitions
- **Why Incomplete**: Mask handling for modes wasn't implemented during rearchitecture
- **Complexity**: Low
- **Related Items**: Part of the broader mode system implementation

**Recommendation**: Add optional mask attribute parsing and storage for mode definitions

---

### TODO #631: Assert unique mode name

**Location**: `tools/regz/src/atdf.zig:555`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: assert unique mode name
```

**Code Context**:
```zig
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

- **Purpose**: Validate that mode names are unique within their scope to prevent conflicts
- **Why Incomplete**: Mode validation wasn't implemented during rearchitecture
- **Complexity**: Low
- **Related Items**: Part of the broader mode system implementation

**Recommendation**: Add validation to ensure mode name uniqueness within peripheral/register group scope

---

### TODO #632: Modes

**Location**: `tools/regz/src/atdf.zig:556`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: modes
```

**Code Context**:
```zig
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

- **Purpose**: Complete the mode assignment system for registers
- **Why Incomplete**: Mode system wasn't fully implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Core part of mode system with TODOs #629, #631, #635, #638

**Recommendation**: Implement complete mode assignment and validation system

---

### TODO #633: Field specific r/w

**Location**: `tools/regz/src/atdf.zig:703`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// FIXME: field specific r/w
```

**Code Context**:
```zig
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

- **Purpose**: Implement field-level read/write access control instead of just register-level
- **Why Incomplete**: Field-level access control wasn't implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Related to TODO #636 (field based access)

**Recommendation**: Implement field-level access attribute parsing and storage in the database

---

### TODO #634: Struct field modes

**Location**: `tools/regz/src/atdf.zig:730`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// FIXME: struct field modes
```

**Code Context**:
```zig
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
```

**Analysis**:

- **Purpose**: Implement mode assignment for individual register fields
- **Why Incomplete**: Field-level mode system wasn't implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Part of broader mode system with TODOs #632, #635, #637, #638

**Recommendation**: Implement field-level mode assignment as part of the complete mode system

---

### TODO #635: Modes

**Location**: `tools/regz/src/atdf.zig:733`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: modes
```

**Code Context**:
```zig
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
```

**Analysis**:

- **Purpose**: Complete mode assignment implementation for register fields
- **Why Incomplete**: Part of the incomplete mode system from rearchitecture
- **Complexity**: Medium
- **Related Items**: Continuation of mode system implementation

**Recommendation**: Implement as part of the complete mode assignment system

---

### TODO #636: Field based access

**Location**: `tools/regz/src/atdf.zig:752`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// FIXME: field based access
```

**Code Context**:
```zig
// FIXME: field based access
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

- **Purpose**: Implement field-level access control (read-only, write-only, read-write)
- **Why Incomplete**: Field-level access wasn't implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Related to TODO #633 (field specific r/w)

**Recommendation**: Implement field-level access attribute handling in the database schema

---

### TODO #637: Struct_field modes

**Location**: `tools/regz/src/atdf.zig:779`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// FIXME: struct_field modes
```

**Code Context**:
```zig
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
```

**Analysis**:

- **Purpose**: Implement mode assignment for struct fields (similar to register fields)
- **Why Incomplete**: Part of the incomplete mode system from rearchitecture
- **Complexity**: Medium
- **Related Items**: Duplicate of TODO #634, part of mode system

**Recommendation**: Implement as part of the unified mode assignment system

---

### TODO #638: Modes

**Location**: `tools/regz/src/atdf.zig:782`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: modes
```

**Code Context**:
```zig
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
```

**Analysis**:

- **Purpose**: Complete mode assignment implementation (continuation of TODO #635)
- **Why Incomplete**: Part of the incomplete mode system from rearchitecture
- **Complexity**: Medium
- **Related Items**: Part of broader mode system implementation

**Recommendation**: Implement as part of the complete mode assignment system

---

### TODO #639: Namespace the enum to the appropriate register, register_group, or peripheral

**Location**: `tools/regz/src/atdf.zig:792`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: namespace the enum to the appropriate register, register_group, or peripheral
```

**Code Context**:
```zig
// values _should_ match to a known enum
// TODO: namespace the enum to the appropriate register, register_group, or peripheral
```

**Analysis**:

- **Purpose**: Implement proper enum scoping to avoid naming conflicts between different peripheral contexts
- **Why Incomplete**: Enum namespacing wasn't implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Important for code generation quality

**Recommendation**: Implement enum namespacing based on the containing peripheral/register group context

---

### TODO #640: Return error.Todo

**Location**: `tools/regz/src/atdf.zig:936`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
return error.Todo;
```

**Code Context**:
```zig
const offset_bytes: u64 = if (get_inlined_register_group(node, name)) |register_group_node| blk: {
    log.debug("inlining {s}", .{name});
    const offset_str = register_group_node.get_attribute("offset") orelse return error.MissingPeripheralOffset;
    const offset = try std.fmt.parseInt(u64, offset_str, 0);
    break :blk offset;
} else {
    return error.Todo;
    //unreachable;
    //var register_group_it = node.iterate(&.{}, &.{"register-group"});
    //while (register_group_it.next()) |register_group_node|
    //    loadRegisterGroupInstance(db, register_group_node, id, peripheral_type_id) catch {
    //        log.warn("skipping register group instance in {s}", .{name});
    //    };
};
```

**Analysis**:

- **Purpose**: Handle non-inlined register group instances properly
- **Why Incomplete**: Alternative code path wasn't implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Critical for handling complex peripheral instances

**Recommendation**: Implement the commented-out register group instance loading logic

---

### TODO #641: TodoInstanceWithMultipleRegisterGroups

**Location**: `tools/regz/src/atdf.zig:970`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
return error.TodoInstanceWithMultipleRegisterGroups;
```

**Code Context**:
```zig
const register_group_node = blk: {
    var it = node.iterate(&.{}, &.{"register-group"});
    const ret = it.next() orelse return error.MissingInstanceRegisterGroup;
    if (it.next() != null) {
        return error.TodoInstanceWithMultipleRegisterGroups;
    }

    break :blk ret;
};
```

**Analysis**:

- **Purpose**: Handle peripheral instances that contain multiple register groups
- **Why Incomplete**: Multi-register group handling wasn't implemented during rearchitecture
- **Complexity**: High
- **Related Items**: Important for complex peripherals

**Recommendation**: Implement support for peripheral instances with multiple register groups

---

### TODO #642: This isn't always a set value, not sure what to do if it's left out

**Location**: `tools/regz/src/atdf.zig:1020`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: this isn't always a set value, not sure what to do if it's left out
```

**Code Context**:
```zig
const id = db.create_entity();
errdefer db.destroy_entity(id);

log.debug("{}: creating register group instance", .{id});
const name = node.get_attribute("name") orelse return error.MissingInstanceName;
// TODO: this isn't always a set value, not sure what to do if it's left out
const name_in_module = node.get_attribute("name-in-module") orelse {
    log.warn("no 'name-in-module' for register group '{s}'", .{
        name,
    });

    return error.MissingNameInModule;
};
```

**Analysis**:

- **Purpose**: Handle cases where "name-in-module" attribute is missing from register group instances
- **Why Incomplete**: Fallback strategy wasn't determined during rearchitecture
- **Complexity**: Low
- **Related Items**: Related to TODO #626 about name-in-module usage

**Recommendation**: Implement fallback to use "name" attribute when "name-in-module" is missing

---

### TODO #643: Empty TODO

**Location**: `tools/regz/src/atdf.zig:1058`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO:
```

**Code Context**:
```zig
try db.add_child("instance.register_group", peripheral_id, id);

// TODO:
// "address-space": "optional",
// "version": "optional",
// "id": "optional",
```

**Analysis**:

- **Purpose**: Handle optional attributes for register group instances
- **Why Incomplete**: Optional attribute handling wasn't implemented during rearchitecture
- **Complexity**: Low
- **Related Items**: Part of complete ATDF attribute support

**Recommendation**: Implement parsing and storage of optional attributes (address-space, version, id)

---

### TODO #644: Pads

**Location**: `tools/regz/src/atdf.zig:1080`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: pads
```

**Code Context**:
```zig
fn load_signal(
    ctx: *Context,
    node: xml.Node,
    peripheral_id: DevicePeripheralID,
) !void {
    _ = ctx;
    _ = peripheral_id;
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
```

**Analysis**:

- **Purpose**: Implement signal/pad mapping for peripheral pins
- **Why Incomplete**: Pin/pad system wasn't implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Important for pin configuration generation

**Recommendation**: Implement signal/pad parsing and storage for pin mapping functionality

---

### TODO #645: There are fields like irq-index

**Location**: `tools/regz/src/atdf.zig:1083`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: there are fields like irq-index
```

**Code Context**:
```zig
// TODO: there are fields like irq-index
fn load_interrupt(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
) !void {
    const db = ctx.db;
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
```

**Analysis**:

- **Purpose**: Handle additional interrupt-related attributes like irq-index
- **Why Incomplete**: Extended interrupt attributes weren't implemented during rearchitecture
- **Complexity**: Low
- **Related Items**: Part of complete interrupt system

**Recommendation**: Implement parsing and storage of additional interrupt attributes

---

### TODO #646: Probably connects module instance to interrupt

**Location**: `tools/regz/src/atdf.zig:1097`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: probably connects module instance to interrupt
```

**Code Context**:
```zig
"irq-index",
"caption",
// TODO: probably connects module instance to interrupt
"module-instance",
"irq-name",
"alternate-caption",
```

**Analysis**:

- **Purpose**: Implement proper connection between module instances and their interrupts
- **Why Incomplete**: Module-interrupt relationship wasn't fully implemented during rearchitecture
- **Complexity**: Medium
- **Related Items**: Important for interrupt vector generation

**Recommendation**: Implement module instance to interrupt mapping for proper interrupt handling

---

### TODO #647: Better output

**Location**: `tools/regz/src/atdf.zig:1127`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: better output
```

**Code Context**:
```zig
// for now just emit warning logs when the input has attributes that it shouldn't have
// TODO: better output
fn validate_attrs(node: xml.Node, attrs: []const []const u8) void {
    var it = node.iterate_attrs();
    while (it.next()) |attr| {
        for (attrs) |expected_attr| {
            if (std.mem.eql(u8, attr.key, expected_attr))
                break;
        } else log.warn("line {}: the '{s}' isn't usually found in the '{s}' element, this could mean unhandled ATDF behaviour or your input is malformed", .{
            node.impl.line,
            attr.key,
            std.mem.span(node.impl.name),
        });
    }
}
```

**Analysis**:

- **Purpose**: Improve attribute validation error messages and reporting
- **Why Incomplete**: Better error reporting wasn't prioritized during rearchitecture
- **Complexity**: Low
- **Related Items**: Quality of life improvement

**Recommendation**: Implement more detailed and helpful attribute validation error messages

---

### TODO #648: V1.1: ARM processor name: Cortex-Mx / SCxxx

**Location**: `tools/regz/src/cmsis-svd.xsd:336`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
<!-- V1.1: ARM processor name: Cortex-Mx / SCxxx -->
```

**Code Context**:
```xml
<xs:complexType name="cpuType">
  <xs:sequence>
    <!-- V1.1: ARM processor name: Cortex-Mx / SCxxx -->
    <xs:element name="name" type="cpuNameType"/>
    <!-- V1.1: ARM defined revision of the cpu -->
    <xs:element name="revision" type="revisionType"/>
```

**Analysis**:

- **Purpose**: This is a schema documentation comment, not a TODO
- **Why Incomplete**: This is actually documentation, not incomplete work
- **Complexity**: N/A
- **Related Items**: Part of CMSIS-SVD schema definition

**Recommendation**: This is not a TODO but documentation - can be ignored or the comment format could be clarified

---

### TODO #649: Empty TODO

**Location**: `tools/regz/src/embassy.zig:429`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO
```

**Code Context**:
```zig
const device_id = try db.create_device(.{
    .name = chip_file.value.name,
    // TODO
    .arch = std.meta.stringToEnum(Arch, core_to_cpu.get(core.name).?).?,
});
```

**Analysis**:

- **Purpose**: Handle architecture mapping more robustly
- **Why Incomplete**: Architecture mapping wasn't fully implemented during rearchitecture
- **Complexity**: Low
- **Related Items**: Part of Embassy integration

**Recommendation**: Implement proper error handling for unknown architectures in Embassy chip files

---

### TODO #650: How do we want to handle multi core MCUs?

**Location**: `tools/regz/src/embassy.zig:436`  
**Author**: Matt Knight (2022-12-29)  
**Commit**: 9627d4196 - "Rearchitect Regz (#63)"

**Original Comment**:
```
// TODO: how do we want to handle multi core MCUs?
```

**Code Context**:
```zig
// TODO: how do we want to handle multi core MCUs?
//
// For now we're only using the first core. We'll likely have to combine the
// sets of peripherals, there will potentially be overlap, but if there
// are differences between cores that's something the user will have
// to keep track of.

for (core.interrupts) |interrupt| {
```

**Analysis**:

- **Purpose**: Design and implement proper multi-core MCU support in Embassy integration
- **Why Incomplete**: Multi-core support design wasn't finalized during rearchitecture
- **Complexity**: High
- **Related Items**: Architectural decision affecting Embassy integration

**Recommendation**: Design multi-core MCU handling strategy - either separate devices per core or unified device with core-specific peripherals

---

## Summary

**Total TODOs Analyzed**: 25

**Complexity Breakdown**:
- Low: 8 items
- Medium: 15 items  
- High: 2 items

**Key Themes**:
1. **Mode System**: Multiple TODOs (#629, #631, #632, #634, #635, #637, #638) relate to implementing a complete mode assignment system for registers and fields
2. **Field-Level Features**: Several TODOs (#633, #636) focus on field-level access control
3. **ATDF Parsing Completeness**: Many items involve completing ATDF attribute parsing and validation
4. **Embassy Integration**: TODOs #649, #650 relate to improving Embassy chip file integration
5. **Error Handling**: Several items involve implementing proper error handling and fallback strategies

**Priority Recommendations**:
1. **High Priority**: Complete the mode system implementation (TODOs #629-638)
2. **High Priority**: Implement multi-register group support (TODO #641)
3. **Medium Priority**: Complete field-level access control (TODOs #633, #636)
4. **Medium Priority**: Design multi-core MCU support strategy (TODO #650)
5. **Low Priority**: Improve error messages and optional attribute handling
