# TODO Analysis - Batch 10

**Batch Info**: Items 284-11 from TODO_INVENTORY.json (25 items total)
**Directories**: port (RP2xxx, Aviron simulator), tools (linter, printer, regz), sim/aviron
**Analysis Date**: 2024-12-27

---

### TODO #284: Implement hardware lock claim

**Location**: `port/raspberrypi/rp2xxx/src/hal/hw.zig:8`  
**Author**: Matt Knight (2024-08-13)  
**Commit**: 58eee8b - "rp2xxx: pico2 support"

**Original Comment**:
```zig
@panic("TODO");
```

**Code Context**:
```zig
pub const Lock = struct {
    impl: u32,

    pub fn claim() Lock {
        @panic("TODO");
    }

    pub fn unlock(lock: Lock) void {
        _ = lock;
        @panic("TODO");
    }
};
```

**Analysis**:

- **Purpose**: Implement hardware spinlock claiming for RP2040/RP2350 multicore synchronization
- **Why Incomplete**: Part of initial Pico 2 (RP2350) support scaffolding; spinlock functionality not yet critical for single-core operation
- **Complexity**: Medium - requires understanding of RP2040/RP2350 hardware spinlock peripheral and proper atomic operations
- **Related Items**: TODO #285 (unlock function in same struct)

**Recommendation**: Implement proper spinlock claim/release using the hardware SPINLOCK peripheral registers. Reference the RP2040/RP2350 datasheet section on spinlocks and potentially the pico-sdk implementation.

---

### TODO #285: Implement hardware lock unlock

**Location**: `port/raspberrypi/rp2xxx/src/hal/hw.zig:13`  
**Author**: Matt Knight (2024-08-13)  
**Commit**: 58eee8b - "rp2xxx: pico2 support"

**Original Comment**:
```zig
@panic("TODO");
```

**Code Context**:
```zig
pub const Lock = struct {
    impl: u32,

    pub fn claim() Lock {
        @panic("TODO");
    }

    pub fn unlock(lock: Lock) void {
        _ = lock;
        @panic("TODO");
    }
};
```

**Analysis**:

- **Purpose**: Implement hardware spinlock release for RP2040/RP2350
- **Why Incomplete**: Companion to #284; same scaffolding for Pico 2 support
- **Complexity**: Medium - must properly write to spinlock registers to release
- **Related Items**: TODO #284 (claim function in same struct)

**Recommendation**: Implement together with #284 as a complete spinlock implementation. Both functions should be atomic and properly handle the hardware registers.

---

### TODO #286: Add automatic default pin configuration for board

**Location**: `port/raspberrypi/rp2xxx/src/boards/adafruit_metro_rp2350.zig:5`  
**Author**: Matt Knight (2024-10-21)  
**Commit**: 8c9b47e - "rp2xxx: boards and examples for new pin api"

**Original Comment**:
```zig
// ### TODO ### Add automatic default pin configuration for board pins
```

**Code Context**:
```zig
pub const xosc_freq = 12_000_000;

pub const has_rp2350b = true; // Uses RP2350B chip with extra I/O pins

// ### TODO ### Add automatic default pin configuration for board pins

const microzig = @import("microzig");
const hal = microzig.hal;
const pins = hal.pins;

pub const pin_config = pins.GlobalConfiguration{
    .GPIO12 = .{
        .name = "hstx_d2p",
        .function = .HSTX,
    },
```

**Analysis**:

- **Purpose**: Automatically configure all board pins to sensible defaults (likely safe/inactive states) for pins not explicitly configured
- **Why Incomplete**: New pin API implementation; default configuration system not yet designed
- **Complexity**: Low-Medium - needs design decision on default states and implementation of auto-configuration logic
- **Related Items**: None directly, but affects user experience with board support

**Recommendation**: Design a system where unconfigured pins default to safe states (e.g., input with pull-down) or allow board definition to specify defaults for each pin.

---

### TODO #306: Add EEPROM support to AVR simulator

**Location**: `sim/aviron/src/main.zig:16`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
// TODO: Add support for reading/writing EEPROM through IO
```

**Code Context**:
```zig
fn run_with_mcu(
    allocator: std.mem.Allocator,
    comptime mcu_config: anytype,
    options: Cli,
    positionals: []const []const u8,
) !u8 {
    // Allocate memory based on MCU configuration
    var flash_storage = aviron.Flash.Static(mcu_config.flash_size){};
    var sram = aviron.FixedSizeMemory(mcu_config.sram_size, .{ .address_type = u24 }){};
    // TODO: Add support for reading/writing EEPROM through IO

    var io = IO{
```

**Analysis**:

- **Purpose**: Implement EEPROM memory simulation with proper IO-mapped register interface for reading/writing EEPROM data
- **Why Incomplete**: Initial simulator implementation focused on Flash/SRAM; EEPROM less critical for basic testing
- **Complexity**: Medium - requires implementing EEPROM memory storage and the AVR EEPROM control registers (EECR, EEDR, EEARL/EEARH)
- **Related Items**: None directly

**Recommendation**: Add EEPROM memory buffer and implement the standard AVR EEPROM control registers. Reference ATmega328P datasheet for register behavior.

---

### TODO #307: Implement BREAK instruction

**Location**: `sim/aviron/src/lib/Cpu.zig:611`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// TODO!
```

**Code Context**:
```zig
fn op_BREAK(cpu: *Cpu) ExecutionResult {
    _ = cpu;
    /// TODO!
    return .executed;
}
```

**Analysis**:

- **Purpose**: Implement AVR BREAK instruction for debugging/breakpoint support
- **Why Incomplete**: BREAK is primarily used for debugging; not needed for basic program execution
- **Complexity**: Low-Medium - should trigger debugger/stop execution appropriately
- **Related Items**: TODO #308, #309 (other unimplemented CPU instructions)

**Recommendation**: Implement BREAK to return a specific execution result (e.g., `.breakpoint`) that can be handled at the simulator level. May want to integrate with actual debugger support later.

---

### TODO #308: Implement EICALL instruction  

**Location**: `sim/aviron/src/lib/Cpu.zig:618`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// TODO!
```

**Code Context**:
```zig
fn op_EICALL(cpu: *Cpu) ExecutionResult {
    _ = cpu;
    /// TODO!
    return .executed;
}
```

**Analysis**:

- **Purpose**: Implement Extended Indirect Call (EICALL) instruction for calling subroutines in extended program memory (>64K)
- **Why Incomplete**: Only needed for larger AVR MCUs with >64KB flash; less common use case
- **Complexity**: Medium - must handle extended addressing with EIND register
- **Related Items**: TODO #309 (EIJMP - related extended instruction)

**Recommendation**: Implement by reading target from Z register concatenated with EIND, pushing PC to stack, and updating PC. Test with ATmega2560 which uses extended addressing.

---

### TODO #309: Implement EIJMP instruction

**Location**: `sim/aviron/src/lib/Cpu.zig:625`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// TODO!
```

**Code Context**:
```zig
fn op_EIJMP(cpu: *Cpu) ExecutionResult {
    _ = cpu;
    /// TODO!
    return .executed;
}
```

**Analysis**:

- **Purpose**: Implement Extended Indirect Jump (EIJMP) instruction for jumping in extended program memory (>64K)
- **Why Incomplete**: Only needed for larger AVR MCUs; less common
- **Complexity**: Medium - must handle extended addressing with EIND register
- **Related Items**: TODO #308 (EICALL - related extended instruction)

**Recommendation**: Implement by reading target from Z register concatenated with EIND and updating PC directly (no stack push unlike EICALL).

---

### TODO #310: Implement ELPM instruction variants (later)

**Location**: `sim/aviron/src/lib/Cpu.zig:1445`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
```

**Code Context**:
```zig
fn op_ELPM_Z(cpu: *Cpu) ExecutionResult {
    _ = cpu;
    ///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
    return .executed;
}
```

**Analysis**:

- **Purpose**: Implement Extended Load Program Memory from Z pointer (for >64KB flash access)
- **Why Incomplete**: Explicitly deferred - primarily needed for bootloaders accessing extended memory
- **Complexity**: Medium - requires RAMPZ register and extended memory addressing
- **Related Items**: TODO #311 (ELPM with post-increment variant)

**Recommendation**: Defer until bootloader simulation is needed. When implemented, read from flash memory at address formed by RAMPZ:Z and load into destination register.

---

### TODO #311: Implement ELPM with post-increment

**Location**: `sim/aviron/src/lib/Cpu.zig:1463`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
```

**Code Context**:
```zig
fn op_ELPM_Z_inc(cpu: *Cpu) ExecutionResult {
    _ = cpu;
    ///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
    return .executed;
}
```

**Analysis**:

- **Purpose**: Implement ELPM with post-increment for sequential extended memory reads
- **Why Incomplete**: Same as #310 - deferred for bootloader support
- **Complexity**: Medium - same as #310 plus Z register increment handling
- **Related Items**: TODO #310 (base ELPM instruction)

**Recommendation**: Implement together with #310. After loading byte, increment Z (and handle RAMPZ overflow if Z wraps).

---

### TODO #312: Implement SPM_Z instruction (not required)

**Location**: `sim/aviron/src/lib/Cpu.zig:1556`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// TODO! (Not necessarily required for implementation, very weird use case)
```

**Code Context**:
```zig
fn op_SPM_Z(cpu: *Cpu) ExecutionResult {
    _ = cpu;
    /// TODO! (Not necessarily required for implementation, very weird use case)
    return .executed;
}
```

**Analysis**:

- **Purpose**: Implement Store Program Memory (SPM) instruction for self-programming (writing to flash)
- **Why Incomplete**: Explicitly noted as not required - very specialized bootloader operation
- **Complexity**: High - requires flash write simulation, page buffer, timing considerations
- **Related Items**: None

**Recommendation**: Skip unless bootloader simulation becomes critical. SPM is complex and rarely used outside of bootloaders.

---

### TODO #313: Implement DES instruction

**Location**: `sim/aviron/src/lib/Cpu.zig:1560`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
@panic("TODO: Implement DES instruction!");
```

**Code Context**:
```zig
fn op_DES(cpu: *Cpu, round: u4) ExecutionResult {
    _ = cpu;
    _ = round;
    @panic("TODO: Implement DES instruction!");
}
```

**Analysis**:

- **Purpose**: Implement DES (Data Encryption Standard) encryption instruction for AVR XMEGA
- **Why Incomplete**: DES instruction is XMEGA-specific and not commonly used
- **Complexity**: High - requires understanding DES algorithm and proper round implementation
- **Related Items**: None

**Recommendation**: Low priority - only implement if XMEGA-specific crypto applications need to be simulated. Requires DES algorithm knowledge.

---

### TODO #314: Fix register file mapping for classic AVR

**Location**: `sim/aviron/src/lib/mcu.zig:23`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// FIXME: The current io_window design doesn't properly model register file mapping for classic
```

**Code Context**:
```zig
const std = @import("std");

/// FIXME: The current io_window design doesn't properly model register file mapping for classic
/// and xmega parts. Per the spec, classic parts have the register file starting at 0x00 in the
/// data space and mapped again at 0x0000-0x001F, while xmega parts only have the register file
/// at 0x0000-0x001F in the data space without the duplicate mapping.
```

**Analysis**:

- **Purpose**: Fix address space mapping to properly handle Classic AVR's duplicated register file addresses vs XMega's single mapping
- **Why Incomplete**: Initial implementation used simplified memory model
- **Complexity**: Medium - requires redesigning memory mapping layer to handle different AVR architectures
- **Related Items**: TODO #315, #316 (related register file mapping issues)

**Recommendation**: Redesign io_window/memory mapping to conditionally include register file at 0x00-0x1F based on AVR architecture (Classic vs XMega).

---

### TODO #315: Implement register file in data space for classic AVR

**Location**: `sim/aviron/src/lib/mcu.zig:108`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
```

**Code Context**:
```zig
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
///        access whatever is at (0x00-0x1F) of io instead. Strictly speaking this is correct for
///        xmega parts, but not for classic parts. For classic parts, the register file is mirrored
///        at these addresses.
pub fn build_classic_spaces(
    allocator: Allocator,
    config: anytype,
    sram_bus: anytype,
    io_data_bus: anytype,
) !Spaces {
```

**Analysis**:

- **Purpose**: Map register file into data space for Classic AVR load/store instructions
- **Why Incomplete**: Same fundamental issue as #314
- **Complexity**: Medium - needs memory mapper that can alias register file
- **Related Items**: TODO #314, #316 (register file mapping issues)

**Recommendation**: Implement as part of #314 fix. Create memory bus that properly routes 0x00-0x1F in data space to CPU register file for Classic AVR.

---

### TODO #316: Implement register file in data space for newer AVR

**Location**: `sim/aviron/src/lib/mcu.zig:163`  
**Author**: Felix Queißner (2023-11-26)  
**Commit**: 4c2ae44 - "Implements AVR simulator based on AVR emulator from ZigAndroidTemplate."

**Original Comment**:
```zig
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
```

**Code Context**:
```zig
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
///        access whatever is at (0x00-0x1F) of io instead. Strictly speaking this is correct for
///        xmega parts, but not for classic parts. For classic parts, the register file is mirrored
///        at these addresses.
pub fn build_xmega_spaces(
    allocator: Allocator,
    config: anytype,
    sram_bus: anytype,
    io_data_bus: anytype,
) !Spaces {
```

**Analysis**:

- **Purpose**: Document that XMega correctly doesn't map register file (unlike Classic)
- **Why Incomplete**: Same issue as #314/#315 - needs proper architecture-specific handling
- **Complexity**: Medium - ensure XMega doesn't accidentally get Classic behavior
- **Related Items**: TODO #314, #315 (register file mapping)

**Recommendation**: When fixing #314/#315, ensure XMega spaces() function explicitly does NOT map register file to data space, maintaining correct XMega behavior.

---

### TODO #1: Check types for coding style abbreviations

**Location**: `tools/linter/src/main.zig:64`  
**Author**: Matt Knight (2023-08-07)  
**Commit**: 61c0ff1 - "experimenting with zig metaprogramming for linker scripts"

**Original Comment**:
```zig
// TODO: check types for common abbreviations and ensure they follow coding style.
```

**Code Context**:
```zig
.global_var_decl,
.local_var_decl,
.aligned_var_decl,
.simple_var_decl,
=> {
    // TODO: check types for common abbreviations and ensure they follow coding style.

},
else => {},
```

**Analysis**:

- **Purpose**: Extend linter to check type names for common abbreviations and ensure they follow MicroZig coding conventions
- **Why Incomplete**: Initial linter focused on function names; type checking added later
- **Complexity**: Low-Medium - parse type names and check against abbreviation style guide
- **Related Items**: None

**Recommendation**: Define acceptable abbreviations (e.g., GPIO, UART, I2C) and check that types use PascalCase. Extend the linter's AST traversal to validate type declarations.

---

### TODO #2: Use ranges attribute in DWARF parsing

**Location**: `tools/printer/src/DebugInfo.zig:238`  
**Author**: Matt Knight (2024-03-04)  
**Commit**: d3e74be - "add missing std prefix"

**Original Comment**:
```zig
// TODO: should use `ranges` attribute
```

**Code Context**:
```zig
fn dieContainsRange(
    di: *DebugInfo,
    die: *const std.DwarfInfo.Die,
    range: AddrRange,
) !bool {
    // TODO: should use `ranges` attribute
    const min = (try di.die_attr(die, AT.low_pc)) orelse return false;
    const max = (try di.die_attr(die, AT.high_pc)) orelse return false;
```

**Analysis**:

- **Purpose**: Use DWARF `DW_AT_ranges` attribute for more accurate address range checking instead of just low_pc/high_pc
- **Why Incomplete**: Simple low_pc/high_pc works for many cases; ranges support adds complexity
- **Complexity**: Medium - requires parsing DWARF ranges section
- **Related Items**: None

**Recommendation**: Implement DW_AT_ranges attribute parsing for cases where functions/scopes have non-contiguous address ranges. Check if `ranges` attribute exists before falling back to low_pc/high_pc.

---

### TODO #3: Check readAddress usage in DWARF

**Location**: `tools/printer/src/DebugInfo.zig:660`  
**Author**: Matt Knight (2024-03-04)  
**Commit**: d3e74be - "add missing std prefix"

**Original Comment**:
```zig
// TODO: check the use of `readAddress`
```

**Code Context**:
```zig
const frame_len = try std.DwarfInfo.readAddress(
    fde[4..],
    di.dwarf_endian,
    @intCast(di.dwarf_address_size),
);
// TODO: check the use of `readAddress`
```

**Analysis**:

- **Purpose**: Verify that `readAddress` is being called correctly with proper parameters for FDE parsing
- **Why Incomplete**: Code works but author uncertain if using the API correctly
- **Complexity**: Low - review and validate the readAddress call
- **Related Items**: None

**Recommendation**: Review DWARF specification for FDE format and confirm readAddress usage is correct. May need to handle different DWARF versions or address sizes.

---

### TODO #4: Handle XML node mismatch in regz

**Location**: `tools/regz/src/xml.zig:23`  
**Author**: Matt Knight (2023-10-30)  
**Commit**: a0ea9c3 - "update to zig 0.12.0-dev.1604+caae40c21"

**Original Comment**:
```zig
// TODO: what if current node doesn't fit the bill?
```

**Code Context**:
```zig
pub fn find_child_by_name(node: Node, name: []const u8) ?Node {
    for (node.children.items) |child| {
        const element = child.element() orelse continue;
        // TODO: what if current node doesn't fit the bill?
        if (std.mem.eql(u8, name, element.tag))
            return child;
    }
```

**Analysis**:

- **Purpose**: Handle case where XML element doesn't match expected schema
- **Why Incomplete**: Current implementation assumes well-formed input
- **Complexity**: Low - add error handling for unexpected nodes
- **Related Items**: TODO #5 (placeholder enum), #6 (empty TODO)

**Recommendation**: Return error or null if node structure doesn't match expectations. Add logging to help debug malformed SVD/ATDF files.

---

### TODO #5: Define placeholder enum for File

**Location**: `tools/regz/src/File.zig:9`  
**Author**: Matt Knight (2023-10-09)  
**Commit**: 7f73f31 - "update to latest nightly"

**Original Comment**:
```zig
TODO,
```

**Code Context**:
```zig
const File = @This();
const std = @import("std");

// just a placeholder, need to think about what info will go here
const Kind = enum {
    TODO,
};
```

**Analysis**:

- **Purpose**: Define actual file kinds/types for register generation output
- **Why Incomplete**: Placeholder during initial design
- **Complexity**: Low - design decision on file categorization
- **Related Items**: None

**Recommendation**: Define actual Kind enum values based on what file types regz generates (e.g., .chip, .peripheral, .register). May no longer be needed if File type is refactored.

---

### TODO #6: Empty TODO in Database

**Location**: `tools/regz/src/Database.zig:115`  
**Author**: Matt Knight (2023-08-08)  
**Commit**: f5aa3b0 - "refactorings to test and fix with nrf52832 and samda1e"

**Original Comment**:
```zig
// TODO:
```

**Code Context**:
```zig
pub const Enum = struct {
    id: EnumID,
    struct_id: ?StructID,
    size_bits: u8,
    name: ?[]const u8 = null,
    description: ?[]const u8 = null,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },

        // TODO:
        //  CHECK ((struct_id IS NULL AND name IS NULL) OR (struct_id IS NOT NULL AND name IS NOT NULL)),
    };
```

**Analysis**:

- **Purpose**: Add SQL CHECK constraint to ensure enum naming consistency
- **Why Incomplete**: Commented out constraint - may have caused issues or needs refinement
- **Complexity**: Low - SQL constraint definition
- **Related Items**: None

**Recommendation**: Investigate why constraint is commented. Either implement the CHECK constraint or remove the TODO if the constraint is not needed/enforceable.

---

### TODO #7: Refactor struct fields retrieval function

**Location**: `tools/regz/src/Database.zig:1190`  
**Author**: Matt Knight (2024-08-10)  
**Commit**: 1caca52 - "regz: allow enums to be associated with structs"

**Original Comment**:
```zig
// TODO: if we ever need a "get struct fields" function, refactor this to use it
```

**Code Context**:
```zig
pub const GetRegisterFieldsOptions = struct {
    /// Ensures that there is no overlap between fields, and that there is no
    /// name collisions
    distinct: bool = true,
};

// TODO: if we ever need a "get struct fields" function, refactor this to use it
pub fn get_register_fields(
    db: *Database,
    allocator: Allocator,
    register_id: RegisterID,
    comptime opts: GetRegisterFieldsOptions,
) ![]StructField {
```

**Analysis**:

- **Purpose**: Extract common struct field retrieval logic if a generic "get struct fields" function is needed
- **Why Incomplete**: Anticipates future refactoring; not needed yet
- **Complexity**: Low - code extraction refactoring
- **Related Items**: None

**Recommendation**: Wait until another function needs struct field retrieval, then extract common logic to avoid duplication.

---

### TODO #8: Create get_enum_id_by_name function

**Location**: `tools/regz/src/Database.zig:2069`  
**Author**: Matt Knight (2024-08-10)  
**Commit**: 1caca52 - "regz: allow enums to be associated with structs"

**Original Comment**:
```zig
// TODO: create a `get_enum_id_by_name()` function
```

**Code Context**:
```zig
pub fn get_enum_by_name(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
    name: []const u8,
) !Enum {
    log.debug("get_enum_by_name: struct_id={f} name='{s}'", .{ struct_id, name });
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM enums
        \\WHERE struct_id = ? AND name = ?
    , .{
        comptime gen_field_list(Enum, .{}),
    });

    return db.one_alloc(Enum, allocator, query, .{
        .struct_id = struct_id,
        .name = name,
    }) catch |err| switch (err) {
        error.MissingEntity => {
            // lookup the enum among the parents
            var parent_id = struct_id;
            var i: u8 = 0;
            const max_depth = 10;
            while (i <= max_depth) : (i += 1) {
                parent_id = db.get_parent_struct_id(parent_id) catch {
                    return err;
                };

                log.debug("get_enum_by_name: parent_id={f} name='{s}'", .{ parent_id, name });
                return db.one_alloc(Enum, allocator, query, .{
                    .struct_id = parent_id,
                    .name = name,
                }) catch {
                    continue;
                };
            }
            return err;
        },
        else => {
            return err;
        },
    };
}
```

**Analysis**:

- **Purpose**: Create a simpler function that returns just the EnumID instead of the full Enum struct
- **Why Incomplete**: May not be needed depending on usage patterns
- **Complexity**: Low - wrapper around existing get_enum_by_name
- **Related Items**: None

**Recommendation**: Only implement if there are performance or ergonomic benefits to having an ID-only version. Consider if callers typically need the full Enum or just the ID.

---

### TODO #9: Empty TODO in embassy generator

**Location**: `tools/regz/src/embassy.zig:429`  
**Author**: Matt Knight (2023-09-07)  
**Commit**: 8eb22d8 - "regz: convert embassy generator to use database"

**Original Comment**:
```zig
// TODO
```

**Code Context**:
```zig
fn load_interrupts(db: *Database, device_id: DeviceID, path: []const u8, allocator: Allocator) !void {
    const interrupts_path = try std.fs.path.join(allocator, &.{ path, "interrupts.yaml" });
    defer allocator.free(interrupts_path);

    // TODO
```

**Analysis**:

- **Purpose**: Implement interrupt loading from embassy YAML files
- **Why Incomplete**: Empty stub during conversion to database architecture
- **Complexity**: Medium - requires YAML parsing and database insertion
- **Related Items**: TODO #10, #11 (related embassy parsing issues)

**Recommendation**: Implement YAML parsing for interrupts.yaml file and create interrupt entries in database. Reference other embassy loaders for pattern.

---

### TODO #10: Handle multi-core MCUs in embassy

**Location**: `tools/regz/src/embassy.zig:436`  
**Author**: Matt Knight (2023-09-07)  
**Commit**: 8eb22d8 - "regz: convert embassy generator to use database"

**Original Comment**:
```zig
// TODO: how do we want to handle multi core MCUs?
```

**Code Context**:
```zig
fn load_cores(db: *Database, device_id: DeviceID, path: []const u8, allocator: Allocator) !void {
    _ = device_id;
    const cores_path = try std.fs.path.join(allocator, &.{ path, "cores.yaml" });
    defer allocator.free(cores_path);

    // TODO: how do we want to handle multi core MCUs?
```

**Analysis**:

- **Purpose**: Design architecture for multi-core MCU support in register generation
- **Why Incomplete**: Requires design decision on how to represent multiple cores
- **Complexity**: Medium-High - needs schema changes to support per-core peripherals/interrupts
- **Related Items**: None

**Recommendation**: Design decision needed: create separate device entries per core, or add core_id to relevant tables. Consider how users will select/configure specific cores.

---

### TODO #11: Handle null registers in embassy

**Location**: `tools/regz/src/embassy.zig:458`  
**Author**: Matt Knight (2023-09-07)  
**Commit**: 8eb22d8 - "regz: convert embassy generator to use database"

**Original Comment**:
```zig
// TODO: don't know what to do if registers is null, so skipping
```

**Code Context**:
```zig
fn load_peripheral_to_db(
    db: *Database,
    allocator: Allocator,
    device_id: DeviceID,
    peripheral: json_schema.Peripheral,
) !void {
    if (peripheral.registers == null) {
        // TODO: don't know what to do if registers is null, so skipping
        log.warn("peripheral '{s}' has no registers, skipping", .{peripheral.name});
        return;
    }
```

**Analysis**:

- **Purpose**: Handle peripherals that have no register definitions in embassy data
- **Why Incomplete**: Uncertain how to represent register-less peripherals
- **Complexity**: Low-Medium - design decision on whether to skip or create empty peripheral
- **Related Items**: None

**Recommendation**: Decision needed: either skip register-less peripherals with a warning (current behavior), or create peripheral entries without registers for completeness. Document the choice.

---

## Summary

**Total TODOs Analyzed**: 25

**By Complexity**:
- Low: 5 (20%)
- Low-Medium: 6 (24%)
- Medium: 12 (48%)
- Medium-High: 1 (4%)
- High: 2 (8%)

**By Category**:
- RP2xxx HAL (port): 3 items - Hardware locks, board configuration
- AVR Simulator (sim/aviron): 11 items - Instruction implementation, memory mapping
- Tooling (tools): 11 items - Linter, DWARF parsing, register generation

**Priority Recommendations**:
1. **High Priority**: TODOs #314-316 (AVR register file mapping) - affects simulator correctness
2. **Medium Priority**: TODOs #284-285 (RP2xxx hardware locks), #306 (EEPROM simulation)
3. **Low Priority**: Missing instruction implementations (#307-313), empty stubs (#5, #6, #9)
4. **Defer**: Bootloader-specific features (#310-312), DES instruction (#313)

**Common Themes**:
- Many TODOs are scaffolding from initial implementations
- Several involve design decisions (multi-core, file types, defaults)
- Simulator TODOs often marked as "not critical" or "implement later"
- Tool improvements are opportunistic enhancements
