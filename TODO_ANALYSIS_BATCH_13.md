# TODO Analysis - Batch 13 (Items 62-77)

**Batch Overview**: Tools-related TODOs covering regz (register generator), esp-image, sorcerer (GUI), and uf2 utilities

---

### TODO #62: Get description for device peripheral

**Location**: `tools/regz/src/gen.zig:1069`  
**Author**: Matt Knight (2024-11-02)  
**Commit**: bbc62cc7 - "tools/regz: introduce VirtualFilesystem"

**Original Comment**:
```zig
// TODO: get description
```

**Code Context**:
```zig
fn write_device_peripheral(
    db: *Database,
    arena: Allocator,
    instance: *const DevicePeripheral,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("writing periph instance", .{});

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    const type_ref = try types_reference(db, arena, .{ .@"struct" = instance.struct_id });

    if (try get_device_peripheral_description(db, arena, instance)) |description|
        try write_doc_comment(arena, description, writer);

    // TODO: get description
    //else if (s.description) |desc|
    //    try write_doc_comment(arena, desc, writer);
```

**Analysis**:

- **Purpose**: Add fallback logic to retrieve and write description for device peripherals when the primary method doesn't provide one
- **Why Incomplete**: The commented code references `s.description` which is undefined in current scope - likely leftover from refactoring where the variable name changed
- **Complexity**: Low - Simple conditional logic to add alternative description source
- **Related Items**: Part of peripheral code generation in regz tool

**Recommendation**: Either remove the commented code if no longer needed, or fix the variable reference to properly access the peripheral's struct description as a fallback.

---

### TODO #63: Handle enum size assertion

**Location**: `tools/regz/src/gen.zig:1071`  
**Author**: Matt Knight (2024-11-02)  
**Commit**: bbc62cc7 - "tools/regz: introduce VirtualFilesystem"

**Original Comment**:
```zig
// TODO: handle this instead of assert
// assert(std.math.ceilPowerOfTwo(field_set.count()) <= size);
```

**Code Context**:
```zig
fn write_enum(db: *Database, arena: Allocator, e: *const Enum, out_writer: *std.Io.Writer) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    // TODO: handle this instead of assert
    // assert(std.math.ceilPowerOfTwo(field_set.count()) <= size);

    if (e.description) |description|
        try write_doc_comment(arena, description, writer);

    try writer.print("pub const {f} = enum(u{}) {{\n", .{
        std.zig.fmtId(e.name.?),
        e.size_bits,
    });
```

**Analysis**:

- **Purpose**: Properly validate that enum field count fits within the specified bit size, returning an error instead of asserting
- **Why Incomplete**: Current implementation doesn't validate this constraint - the assert is commented out
- **Complexity**: Low - Add proper error checking and return an error type
- **Related Items**: Part of enum code generation validation

**Recommendation**: Implement proper error handling: check if `std.math.ceilPowerOfTwo(field_set.count()) > size` and return `error.EnumFieldCountExceedsSize` with appropriate logging.

---

### TODO #64: Use size to format hex value

**Location**: `tools/regz/src/gen.zig:1152`  
**Author**: Matt Knight (2024-11-02)  
**Commit**: bbc62cc7 - "tools/regz: introduce VirtualFilesystem"

**Original Comment**:
```zig
// TODO: use size to print the hex value (pad with zeroes accordingly)
_ = size;
```

**Code Context**:
```zig
fn write_enum_field(
    arena: Allocator,
    enum_field: *const EnumField,
    size: u64,
    writer: *std.Io.Writer,
) !void {
    // TODO: use size to print the hex value (pad with zeroes accordingly)
    _ = size;
    if (enum_field.description) |description|
        try write_doc_comment(arena, description, writer);

    try writer.print("{f} = 0x{x},\n", .{ std.zig.fmtId(enum_field.name), enum_field.value });
}
```

**Analysis**:

- **Purpose**: Format enum field hex values with appropriate zero-padding based on the enum's bit size for better readability
- **Why Incomplete**: Size parameter is unused - need to calculate padding width from size and use it in format string
- **Complexity**: Low - Simple formatting improvement
- **Related Items**: Cosmetic improvement to generated code quality

**Recommendation**: Calculate hex digits needed: `const hex_width = (size + 3) / 4;` then use `try writer.print("{f} = 0x{x:0>[2]},\n", .{ std.zig.fmtId(enum_field.name), enum_field.value, hex_width });`

---

### TODO #65: Define error type for Directory

**Location**: `tools/regz/src/Directory.zig:9`  
**Author**: Matt Knight (2024-11-02)  
**Commit**: bbc62cc7 - "tools/regz: introduce VirtualFilesystem"

**Original Comment**:
```zig
pub const CreateFileError = error{
    TODO,
    System,
    OutOfMemory,
};
```

**Code Context**:
```zig
ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    create_file: *const fn (*anyopaque, path: []const u8, content: []const u8) CreateFileError!void,
};

pub const CreateFileError = error{
    TODO,
    System,
    OutOfMemory,
};
```

**Analysis**:

- **Purpose**: Define proper error types for file creation operations in the virtual filesystem abstraction
- **Why Incomplete**: Placeholder "TODO" error left from initial implementation - need to determine what specific errors can occur
- **Complexity**: Low - Replace with actual error types based on implementation needs
- **Related Items**: Part of VirtualFilesystem abstraction layer

**Recommendation**: Review actual file creation implementations and replace `TODO` with specific errors like `PathTooLong`, `InvalidPath`, `AccessDenied`, etc., or remove if not needed.

---

### TODO #66: Study mode qualifiers in regz

**Location**: `tools/regz/src/output_tests.zig:158`  
**Author**: Matt Knight (2024-11-02)  
**Commit**: bbc62cc7 - "tools/regz: introduce VirtualFilesystem"

**Original Comment**:
```zig
// TODO: study the types of qualifiers that come up. it's possible that
// we'll have to read different registers or read registers without fields.
//
// might also have registers with enum values
// naive implementation goes throuDatabase each mode and follows the qualifier,
// next level will determine if they're reading the same address even if
// different modes will use different union members
```

**Code Context**:
```zig
const mode1_id = try db.create_mode(struct_id, .{
    .name = "TEST_MODE1",
    .value = "0x00",
    .qualifier = "TEST_PERIPHERAL.TEST_MODE1.COMMON_REGISTER.TEST_FIELD",
});
const mode2_id = try db.create_mode(struct_id, .{
    .name = "TEST_MODE2",
    .value = "0x01",
    .qualifier = "TEST_PERIPHERAL.TEST_MODE2.COMMON_REGISTER.TEST_FIELD",
});

try db.add_register_mode(register1_id, mode1_id);
try db.add_register_mode(register2_id, mode2_id);

// TODO: study the types of qualifiers that come up...
```

**Analysis**:

- **Purpose**: Research and improve the mode qualifier parsing system to handle various peripheral mode detection scenarios
- **Why Incomplete**: Current implementation is basic - needs analysis of real-world SVD/ATDF files to handle edge cases
- **Complexity**: Medium - Requires studying various hardware description files and implementing robust parsing
- **Related Items**: Related to peripheral modes feature in regz

**Recommendation**: Analyze mode qualifiers from actual chip vendor SVD/ATDF files, document patterns, and implement a more sophisticated parser that handles enum values, multiple register reads, and address aliasing.

---

### TODO #67: Refactor esp-image for freestanding

**Location**: `tools/esp-image/src/esp_image.zig:3`  
**Author**: Matt Knight (2024-10-18)  
**Commit**: e8734cb0 - "tools: initial esp-image"

**Original Comment**:
```zig
// TODO: Refactor esp-image to allow reading esp images in freestanding. The
// elf specific image generation functionality should be kept in elf2image.
```

**Code Context**:
```zig
const std = @import("std");

// TODO: Refactor esp-image to allow reading esp images in freestanding. The
// elf specific image generation functionality should be kept in elf2image.

pub const SEGMENT_HEADER_LEN = 0x8;
pub const IMAGE_HEADER_LEN = 0x18;
pub const CHECKSUM_XOR_BYTE = 0xEF;
```

**Analysis**:

- **Purpose**: Separate ESP image format handling from ELF-specific code to enable freestanding (no-std) usage
- **Why Incomplete**: Initial implementation mixed concerns - esp_image.zig currently defines format structures but elf2image.zig has the main logic
- **Complexity**: Medium - Requires careful refactoring to separate format definitions from I/O operations
- **Related Items**: Affects architecture of esp-image tool

**Recommendation**: Move all ESP image format parsing/writing to esp_image.zig using freestanding-compatible code (no File I/O), keep only ELF reading and command-line interface in elf2image.zig.

---

### TODO #68: Move app_desc to image start

**Location**: `tools/esp-image/src/elf2image.zig:166`  
**Author**: Matt Knight (2024-10-18)  
**Commit**: e8734cb0 - "tools: initial esp-image"

**Original Comment**:
```zig
// TODO: move app desc to the start of the image. This is currently done
// accidentally on esp32c3 because of the memory map (DROM comes before
// IROM).
```

**Code Context**:
```zig
for (info_list.items) |segment_info| {
    if ((chip.irom_map_start <= segment_info.addr and segment_info.addr < chip.irom_map_end) or
        (chip.drom_map_start <= segment_info.addr and segment_info.addr < chip.drom_map_end))
    {
        try flash_segments.append(allocator, try .init(allocator, segment_info, &elf_file_reader));
    } else {
        try ram_segments.append(allocator, try .init(allocator, segment_info, &elf_file_reader));
    }
}

// TODO: move app desc to the start of the image. This is currently done
// accidentally on esp32c3 because of the memory map (DROM comes before
// IROM).
```

**Analysis**:

- **Purpose**: Ensure app descriptor appears at the beginning of flash image for all ESP32 variants, not just ESP32-C3
- **Why Incomplete**: Works by accident for C3 due to memory layout - needs explicit handling for other chips
- **Complexity**: Medium - Requires segment reordering logic and app_desc detection
- **Related Items**: Related to TODO #69

**Recommendation**: After segment collection, detect which segment contains app_desc (magic check), then explicitly reorder flash_segments array to place it first before merging.

---

### TODO #69: Check for segment overlaps

**Location**: `tools/esp-image/src/elf2image.zig:170`  
**Author**: Matt Knight (2024-10-18)  
**Commit**: e8734cb0 - "tools: initial esp-image"

**Original Comment**:
```zig
// TODO: maybe also check if sections overlap
```

**Code Context**:
```zig
// TODO: move app desc to the start of the image. This is currently done
// accidentally on esp32c3 because of the memory map (DROM comes before
// IROM).

// TODO: maybe also check if sections overlap

// merge segments
try do_segment_merge(allocator, &flash_segments);
try do_segment_merge(allocator, &ram_segments);
```

**Analysis**:

- **Purpose**: Add validation to detect overlapping memory segments in ELF file which could indicate problems
- **Why Incomplete**: Current code assumes well-formed ELF files - adding validation would improve robustness
- **Complexity**: Low - Iterate sorted segments checking if addr+size of one exceeds addr of next
- **Related Items**: General ELF validation improvement

**Recommendation**: After sorting segments, add validation loop: `for (segments, 1..) |seg, i| if (segments[i-1].addr + segments[i-1].size > seg.addr) return error.OverlappingSegments;`

---

### TODO #70: Figure out flash_pins_drive_settings

**Location**: `tools/esp-image/src/elf2image.zig:192`  
**Author**: Matt Knight (2024-10-18)  
**Commit**: e8734cb0 - "tools: initial esp-image"

**Original Comment**:
```zig
flash_pins_drive_settings: 0, // TODO: figure out what to set this to
```

**Code Context**:
```zig
const extended_file_header: ExtendedFileHeader = .{
    .wp = .disabled,
    .flash_pins_drive_settings: 0, // TODO: figure out what to set this to
    .chip_id: chip_id,
    .min_rev: min_rev,
    .max_rev: max_rev,
    .hash: !no_digest,
};
```

**Analysis**:

- **Purpose**: Determine correct value for flash pin drive strength settings in ESP32 image header
- **Why Incomplete**: Needs research into ESP32 bootloader documentation to understand valid values and their effects
- **Complexity**: Low - Research task, then add as command-line option or use sensible default
- **Related Items**: ESP32 bootloader configuration

**Recommendation**: Research Espressif documentation for flash drive settings, add as optional CLI parameter with safe default (0 is likely fine for most cases, meaning use chip defaults).

---

### TODO #71: Override time and date in app_desc

**Location**: `tools/esp-image/src/elf2image.zig:249`  
**Author**: Matt Knight (2024-10-18)  
**Commit**: e8734cb0 - "tools: initial esp-image"

**Original Comment**:
```zig
// TODO: override time and date
```

**Code Context**:
```zig
if (app_desc.magic == esp_image.AppDesc.MAGIC) {
    std.log.debug("detected app_desc... we shall modify it", .{});

    var writer: std.Io.Writer = .fixed(flash_segments.items[0].data);
    // TODO: override time and date
    app_desc.min_efuse_blk_rev_full = min_rev;
    app_desc.max_efuse_blk_rev_full = max_rev;
    app_desc.mmu_page_size = flash_mmu_page_size;
    app_desc.app_elf_sha256 = elf_file_hash;
    try writer.writeStruct(app_desc, .little);
}
```

**Analysis**:

- **Purpose**: Set build timestamp in app descriptor for reproducible builds or to reflect actual build time
- **Why Incomplete**: Currently preserves original timestamps from ELF - may want to override for reproducibility
- **Complexity**: Low - Get current time or use SOURCE_DATE_EPOCH, format as strings
- **Related Items**: Build reproducibility feature

**Recommendation**: Add option to set build timestamp, defaulting to SOURCE_DATE_EPOCH environment variable if set (for reproducible builds), otherwise use current time.

---

### TODO #72: Add secure boot signature

**Location**: `tools/esp-image/src/elf2image.zig:261`  
**Author**: Matt Knight (2024-10-18)  
**Commit**: e8734cb0 - "tools: initial esp-image"

**Original Comment**:
```zig
// TODO: Add secure boot option (v1 or v2) and append a signature if enabled.
```

**Code Context**:
```zig
try sha256_hasher.writer.writeAll(segment_data.written());

// TODO: Add secure boot option (v1 or v2) and append a signature if enabled.

try sha256_hasher.writer.flush(); // flush before getting the position
try sha256_hasher.writer.splatByteAll(0, 15 - output_file_writer.pos % 16);
try sha256_hasher.writer.writeByte(checksum);
```

**Analysis**:

- **Purpose**: Support ESP32 secure boot by adding cryptographic signatures to images
- **Why Incomplete**: Feature not yet implemented - requires cryptographic signing capabilities
- **Complexity**: High - Requires understanding ESP32 secure boot v1/v2, key management, RSA/ECDSA signing
- **Related Items**: Security feature for production devices

**Recommendation**: Research ESP32 secure boot documentation, add CLI options for signing keys, implement signature appending following Espressif spec. Consider using external signing tool initially.

---

### TODO #73: Handle missing register schema

**Location**: `tools/sorcerer/src/main.zig:283`  
**Author**: Matt Knight (2024-11-22)  
**Commit**: b3e2e835 - "tools: sorcerer, WIP for opening register schemas"

**Original Comment**:
```zig
// TODO: handle no schema usages
```

**Code Context**:
```zig
fn from_microzig_menu() void {
    if (!state.show_from_microzig_window)
        return;

    // TODO: handle no schema usages

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_from_microzig_window }, .{
        .min_size_content = .{ .w = 400, .h = 400 },
        .tag = "from_microzig_window",
    });
```

**Analysis**:

- **Purpose**: Display appropriate UI when no register schemas are available in the MicroZig database
- **Why Incomplete**: Current code assumes schemas exist - needs graceful handling of empty state
- **Complexity**: Low - Add conditional check and display informative message
- **Related Items**: UX improvement for sorcerer GUI tool

**Recommendation**: Check if `state.register_schema_usages` is null or empty, display helpful message like "No register schemas found. Please ensure MicroZig is properly configured."

---

### TODO #74: Track contained files in UF2 Archive

**Location**: `tools/uf2/src/uf2.zig:15`  
**Author**: Matt Knight (2024-11-04)  
**Commit**: 81f26fc7 - "tools/uf2: add test for read and write"

**Original Comment**:
```zig
// TODO: keep track of contained files
```

**Code Context**:
```zig
pub const Archive = struct {
    allocator: Allocator,
    blocks: std.ArrayList(Block),
    families: std.AutoArrayHashMapUnmanaged(FamilyId, void),
    // TODO: keep track of contained files

    pub fn init(allocator: std.mem.Allocator) Archive {
        return .{
            .allocator = allocator,
            .blocks = .empty,
            .families = .empty,
        };
    }
```

**Analysis**:

- **Purpose**: Maintain metadata about files embedded in UF2 archives for listing and extraction
- **Why Incomplete**: Archive currently tracks blocks but not file-level metadata  
- **Complexity**: Medium - Need data structure to map filenames to block ranges
- **Related Items**: Required for file extraction feature

**Recommendation**: Add `files: std.StringHashMapUnmanaged(FileInfo)` field where FileInfo contains block index range and size. Populate during `read_from` and `add_file`.

---

### TODO #75: Bundle source in UF2

**Location**: `tools/uf2/src/uf2.zig:73`  
**Author**: Matt Knight (2024-11-04)  
**Commit**: 81f26fc7 - "tools/uf2: add test for read and write"

**Original Comment**:
```zig
// TODO: when implemented set to true by default
bundle_source: bool = false,
```

**Code Context**:
```zig
pub const ELF_Options = struct {
    // TODO: when implemented set to true by default
    bundle_source: bool = false,
    family_id: ?FamilyId = null,
};
```

**Analysis**:

- **Purpose**: Option to include source code in UF2 files for debugging/reference
- **Why Incomplete**: Feature planned but not yet implemented
- **Complexity**: Medium - Need to collect source files and embed them in UF2 blocks
- **Related Items**: Related to TODO #76

**Recommendation**: Implement source bundling feature by collecting source files referenced in ELF debug info, then add them using `add_file()`. Once working, change default to true.

---

### TODO #76: Implement source bundling

**Location**: `tools/uf2/src/uf2.zig:114`  
**Author**: Matt Knight (2024-11-04)  
**Commit**: 81f26fc7 - "tools/uf2: add test for read and write"

**Original Comment**:
```zig
if (opts.bundle_source)
    @panic("TODO: bundle source in UF2 file");
```

**Code Context**:
```zig
        segment_offset += n_bytes;
    }
}

if (opts.bundle_source)
    @panic("TODO: bundle source in UF2 file");
}
```

**Analysis**:

- **Purpose**: Implement the actual source code bundling when option is enabled
- **Why Incomplete**: Feature not implemented - currently panics if enabled
- **Complexity**: Medium - Parse ELF debug info to find source files, add each via `add_file()`
- **Related Items**: Implementation for TODO #75

**Recommendation**: Parse DWARF debug info from ELF to extract source file paths, then call `self.add_file()` for each unique source file. Handle missing files gracefully.

---

### TODO #77: Check for segment overlaps in UF2

**Location**: `tools/uf2/src/uf2.zig:157`  
**Author**: Matt Knight (2024-11-04)  
**Commit**: 81f26fc7 - "tools/uf2: add test for read and write"

**Original Comment**:
```zig
// TODO: check for overlaps, assert no zero sized segments
```

**Code Context**:
```zig
if (segments.items.len == 0)
    return error.NoSegments;

std.sort.insertion(Segment, segments.items, {}, Segment.less_than);
// TODO: check for overlaps, assert no zero sized segments

var first = true;
for (segments.items) |segment| {
```

**Analysis**:

- **Purpose**: Validate ELF segments don't overlap and have non-zero size before processing
- **Why Incomplete**: Basic validation missing - could catch malformed ELF files earlier
- **Complexity**: Low - Simple validation loop after sorting
- **Related Items**: Similar to TODO #69 for esp-image

**Recommendation**: Add validation: `for (segments.items, 1..) |seg, i| { if (seg.size == 0) return error.ZeroSizedSegment; if (segments.items[i-1].addr + segments.items[i-1].size > seg.addr) return error.OverlappingSegments; }`

---

## Summary

**Batch Statistics**:
- Total TODOs: 16
- Low Complexity: 11
- Medium Complexity: 5
- High Complexity: 0

**By Category**:
- Code generation (regz): 5 TODOs
- ESP image tool: 5 TODOs  
- UF2 tool: 4 TODOs
- Sorcerer GUI: 1 TODO
- Infrastructure: 1 TODO

**Priority Recommendations**:
1. **High**: TODO #65 (Define proper error types) - affects API design
2. **High**: TODO #63 (Enum validation) - prevents invalid code generation
3. **Medium**: TODO #67 (Refactor esp-image) - architectural improvement
4. **Medium**: TODO #74-76 (UF2 file tracking/bundling) - related feature set
5. **Low**: Various formatting and validation improvements

**Common Themes**:
- Several validation TODOs (overlaps, enum sizes) that would improve robustness
- Multiple feature stubs waiting for implementation (secure boot, source bundling)
- Some formatting/cosmetic improvements for generated code quality
- Architectural refactoring needs (esp-image freestanding)
