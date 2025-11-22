const std = @import("std");
const dwarf = std.dwarf;
const Elf = @import("Elf.zig");

const DebugInfo = @This();

directories: []const []const u8,
files: []const File,
loc_list: []const SourceLocation,
compile_unit_names: []const []const u8,
functions: []const Function,

pub const File = struct {
    path: []const u8,
    dir_index: usize,
};

pub const SourceLocation = struct {
    address: u64,
    line: u32,
    column: u32,
    file_index: usize,
};

pub const Function = struct {
    name: ?[]const u8,
    cu_index: usize,
    start_address: u64,
    end_address: u64,
};

pub fn init(allocator: std.mem.Allocator, elf: Elf) !DebugInfo {
    var arena_allocator: std.heap.ArenaAllocator = .init(allocator);
    defer arena_allocator.deinit();

    var parser: Parser = .{ .arena = arena_allocator.allocator() };
    try parser.parse_elf(elf);

    const directories = try allocator.dupe([]const u8, parser.directories.items);
    errdefer allocator.free(directories);

    const files = try allocator.dupe(File, parser.files.items);
    errdefer allocator.free(files);

    const loc_list = try allocator.dupe(SourceLocation, parser.loc_list.items);
    errdefer allocator.free(loc_list);

    const compile_unit_names = try allocator.dupe([]const u8, parser.compile_unit_names.items);
    errdefer allocator.free(compile_unit_names);

    const functions = try allocator.dupe(Function, parser.functions.items);
    errdefer allocator.free(functions);

    return .{
        .directories = directories,
        .files = files,
        .loc_list = loc_list,
        .compile_unit_names = compile_unit_names,
        .functions = functions,
    };
}

pub fn deinit(self: *DebugInfo, allocator: std.mem.Allocator) void {
    allocator.free(self.directories);
    allocator.free(self.files);
    allocator.free(self.loc_list);
    allocator.free(self.compile_unit_names);
    allocator.free(self.functions);
}

/// The `file_path` field has the same lifetime as `DebugInfo`.
pub const QueryResult = struct {
    source_location: ?ResolvedSourceLocation = null,
    function_name: ?[]const u8 = null,
    module_name: ?[]const u8 = null,
};

pub const ResolvedSourceLocation = struct {
    line: u32,
    column: u32,
    dir_path: []const u8,
    file_path: []const u8,
};

pub fn query(self: *DebugInfo, address: u64) QueryResult {
    var result: QueryResult = .{};

    const index = std.sort.upperBound(SourceLocation, self.loc_list, address, struct {
        pub fn compare(ctx: usize, item: SourceLocation) std.math.Order {
            return std.math.order(ctx, item.address);
        }
    }.compare);

    if (index > 0 and index != self.loc_list.len) {
        const src_loc = self.loc_list[index - 1];
        const file = &self.files[src_loc.file_index];
        const dir_path = self.directories[file.dir_index];

        result.source_location = .{
            .line = src_loc.line,
            .column = src_loc.column,
            .dir_path = dir_path,
            .file_path = file.path,
        };
    }

    for (self.functions) |function| {
        if (address >= function.start_address and address <= function.end_address) {
            result.function_name = function.name;
            result.module_name = self.compile_unit_names[function.cu_index];
            break;
        }
    }

    return result;
}

// Implementation heavly based on `std.debug.Dwarf` but should support any
// target (even 64 bit architectures).

const Parser = struct {
    arena: std.mem.Allocator,
    directories: std.ArrayList([]const u8) = .empty,
    files: std.ArrayList(File) = .empty,
    loc_list: std.ArrayList(SourceLocation) = .empty,
    compile_unit_names: std.ArrayList([]const u8) = .empty,
    functions: std.ArrayList(Function) = .empty,

    fn parse_elf(self: *Parser, elf: Elf) !void {
        const buf = elf.sections.get(.@".debug_info") orelse return bad();
        var reader: std.Io.Reader = .fixed(buf);

        var current_cu_index: ?usize = null;

        while (reader.seek < reader.buffer.len) {
            var length: u64 = try reader.takeInt(u32, elf.endian);
            var dwarf_format: dwarf.Format = .@"32";

            if (length == std.math.maxInt(u32)) {
                length = try reader.takeInt(u64, elf.endian);
                dwarf_format = .@"64";
            }

            if (length == 0) break;

            const version = try reader.takeInt(u16, elf.endian);
            if (version < 2 or version > 5) return bad();

            var address_size: u8 = 0;
            var abbrev_table_offset: u64 = 0;
            if (version >= 5) {
                const unit_type = try reader.takeByte();
                if (unit_type != dwarf.UT.compile) return bad();

                address_size = try reader.takeByte();
                abbrev_table_offset = try read_address(&reader, dwarf_format, elf.endian);
            } else {
                abbrev_table_offset = try read_address(&reader, dwarf_format, elf.endian);
                address_size = try reader.takeByte();
            }

            var abbrev_table = try self.get_abbrev_table(elf, abbrev_table_offset);

            var depth: usize = 0;
            while (true) {
                const abbrev_code = try reader.takeLeb128(u64);
                if (abbrev_code == 0) {
                    if (depth <= 1) {
                        break;
                    }
                    depth -= 1;
                    continue;
                }

                const abbrev_decl = abbrev_table.get(abbrev_code) orelse return bad();

                var parsed_attribs: std.AutoHashMapUnmanaged(u64, FormValue) = .empty;
                for (abbrev_decl.attrs) |attr| {
                    const form_value = try FormValue.parse(
                        &reader,
                        attr.form_id,
                        elf,
                        dwarf_format,
                        attr.implicit_const_val,
                    );
                    try parsed_attribs.put(self.arena, attr.id, form_value);
                }

                const TAG = dwarf.TAG;
                switch (abbrev_decl.tag) {
                    TAG.compile_unit => {
                        // register current compile unit
                        const name_attrib = parsed_attribs.get(dwarf.AT.name) orelse return bad();

                        current_cu_index = self.compile_unit_names.items.len;
                        try self.compile_unit_names.append(
                            self.arena,
                            try name_attrib.get_string(elf.sections),
                        );

                        // parse line number info
                        const stmt_list_attrib = parsed_attribs.get(dwarf.AT.stmt_list) orelse return bad();
                        const cu_cwd_attrib = parsed_attribs.get(dwarf.AT.comp_dir) orelse return bad();

                        try self.parse_line_number_info(
                            elf,
                            try stmt_list_attrib.get_sec_offset(),
                            try cu_cwd_attrib.get_string(elf.sections),
                        );
                    },
                    TAG.subprogram, TAG.inlined_subroutine, TAG.entry_point => {
                        // in `std.debug.Dwarf` they do more complicated things to
                        // get the name if it isn't specified

                        const maybe_name_attrib = parsed_attribs.get(dwarf.AT.name);

                        if (parsed_attribs.get(dwarf.AT.low_pc)) |low_pc_attrib| {
                            const low_pc_address = switch (low_pc_attrib) {
                                .addr => |addr| addr,
                                else => return bad(),
                            };

                            if (parsed_attribs.get(dwarf.AT.high_pc)) |high_pc_attrib| {
                                const high_pc_address = switch (high_pc_attrib) {
                                    .addr => |addr| addr,
                                    .udata => |offset| low_pc_address + offset,
                                    else => return bad(),
                                };

                                try self.functions.append(self.arena, .{
                                    .name = if (maybe_name_attrib) |name_attrib| try name_attrib.get_string(elf.sections) else null,
                                    .cu_index = current_cu_index orelse return bad(),
                                    .start_address = low_pc_address,
                                    .end_address = high_pc_address,
                                });
                            }
                        } else {
                            // TODO: should use `ranges` attribute
                        }
                    },
                    else => {},
                }

                if (abbrev_decl.has_children) {
                    depth += 1;
                }
            }
        }

        std.mem.sortUnstable(SourceLocation, self.loc_list.items, {}, struct {
            pub fn less_than(_: void, lhs: SourceLocation, rhs: SourceLocation) bool {
                return lhs.address < rhs.address;
            }
        }.less_than);
    }

    fn get_abbrev_table(self: *Parser, elf: Elf, offset: usize) !AbbrevTable {
        const buf = elf.sections.get(.@".debug_abbrev") orelse return bad();
        var reader: std.Io.Reader = .fixed(buf[offset..]);

        var abbrev_table: std.AutoHashMapUnmanaged(u64, AbbrevDecl) = .empty;

        while (true) {
            const code = try reader.takeLeb128(u64);
            if (code == 0) {
                break;
            }

            const tag = try reader.takeLeb128(u64);
            const has_children = try reader.takeByte();

            var attrs: std.ArrayList(AbbrevDecl.Attrib) = .empty;

            while (true) {
                const id = try reader.takeLeb128(u64);
                const form_id = try reader.takeLeb128(u64);
                if (id == 0 and form_id == 0) {
                    break;
                }

                var implicit_const_val: ?i64 = null;
                if (form_id == dwarf.FORM.implicit_const) {
                    implicit_const_val = try reader.takeLeb128(i64);
                }

                try attrs.append(self.arena, .{
                    .id = id,
                    .form_id = form_id,
                    .implicit_const_val = implicit_const_val,
                });
            }

            try abbrev_table.put(self.arena, code, .{
                .tag = tag,
                .has_children = has_children != 0,
                .attrs = try attrs.toOwnedSlice(self.arena),
            });
        }

        return abbrev_table;
    }

    const AbbrevDecl = struct {
        tag: u64,
        has_children: bool,
        attrs: []const Attrib,

        const Attrib = struct {
            id: u64,
            form_id: u64,
            implicit_const_val: ?i64,
        };
    };

    const AbbrevTable = std.AutoHashMapUnmanaged(u64, AbbrevDecl);

    fn parse_line_number_info(
        self: *Parser,
        elf: Elf,
        offset: usize,
        cu_cwd: []const u8,
    ) !void {
        const buf = elf.sections.get(.@".debug_line") orelse return bad();
        var reader: std.Io.Reader = .fixed(buf[offset..]);

        var unit_length: u64 = try reader.takeInt(u32, elf.endian);
        var dwarf_format: dwarf.Format = .@"32";
        if (unit_length == std.math.maxInt(u32)) {
            unit_length = try reader.takeInt(u64, elf.endian);
            dwarf_format = .@"64";
        }
        if (unit_length == 0) {
            return;
        }

        const next_unit_offset = reader.seek + unit_length;

        const version = try reader.takeInt(u16, elf.endian);
        if (version < 2) return bad();

        if (version >= 5) {
            _ = try reader.takeByte(); // address size
            _ = try reader.takeByte(); // segment size
        }

        const prologue_length = try read_address(&reader, dwarf_format, elf.endian);
        const prog_start_offset = reader.seek + prologue_length;

        const minimum_instruction_length = try reader.takeByte();
        if (minimum_instruction_length == 0) return bad();

        if (version >= 4) {
            _ = try reader.takeByte();
        }

        const default_is_stmt = (try reader.takeByte()) != 0;
        const line_base = try reader.takeByteSigned();

        const line_range = try reader.takeByte();
        if (line_range == 0) return bad();

        const opcode_base = try reader.takeByte();

        const standard_opcode_lengths = try reader.take(opcode_base - 1);

        const dir_index_offset = self.directories.items.len;
        const file_index_offset = self.files.items.len;

        if (version < 5) {
            try self.directories.append(self.arena, cu_cwd);

            while (true) {
                const dir = try reader.takeSentinel(0);
                if (dir.len == 0) break;
                try self.directories.append(self.arena, dir);
            }

            while (true) {
                const file_name = try reader.takeSentinel(0);
                if (file_name.len == 0) break;
                const dir_index = try reader.takeLeb128(usize);
                _ = try reader.takeLeb128(u64); // timestamp
                _ = try reader.takeLeb128(u64); // size
                try self.files.append(self.arena, .{
                    .path = file_name,
                    .dir_index = dir_index_offset + dir_index,
                    // .timestamp = timestamp,
                });
            }
        } else {
            const LNCT = dwarf.LNCT;

            const FileEntFmt = struct {
                content_type_code: u16,
                form_code: u16,
            };

            {
                const directory_entry_format_count = try reader.takeByte();
                const dir_ent_fmt_buf = try self.arena.alloc(FileEntFmt, directory_entry_format_count);

                for (dir_ent_fmt_buf[0..directory_entry_format_count]) |*ent_fmt| {
                    ent_fmt.* = .{
                        .content_type_code = try reader.takeLeb128(u8),
                        .form_code = try reader.takeLeb128(u16),
                    };
                }

                const directories_count = try reader.takeLeb128(usize);

                for (try self.directories.addManyAsSlice(self.arena, directories_count)) |*e| {
                    e.* = &.{};
                    for (dir_ent_fmt_buf[0..directory_entry_format_count]) |ent_fmt| {
                        const form_value = try FormValue.parse(
                            &reader,
                            ent_fmt.form_code,
                            elf,
                            dwarf_format,
                            null,
                        );

                        switch (ent_fmt.content_type_code) {
                            LNCT.path => e.* = try form_value.get_string(elf.sections),
                            else => continue,
                        }
                    }
                }
            }

            {
                const file_entry_format_count = try reader.takeByte();
                const file_ent_fmt_buf = try self.arena.alloc(FileEntFmt, file_entry_format_count);

                for (file_ent_fmt_buf[0..file_entry_format_count]) |*ent_fmt| {
                    ent_fmt.* = .{
                        .content_type_code = try reader.takeLeb128(u16),
                        .form_code = try reader.takeLeb128(u16),
                    };
                }

                const file_names_count = try reader.takeLeb128(usize);

                for (try self.files.addManyAsSlice(self.arena, file_names_count)) |*e| {
                    e.* = .{ .path = &.{}, .dir_index = 0 };
                    for (file_ent_fmt_buf[0..file_entry_format_count]) |ent_fmt| {
                        const form_value = try FormValue.parse(
                            &reader,
                            ent_fmt.form_code,
                            elf,
                            dwarf_format,
                            null,
                        );
                        switch (ent_fmt.content_type_code) {
                            LNCT.path => e.path = try form_value.get_string(elf.sections),
                            LNCT.directory_index => e.dir_index = dir_index_offset + try form_value.get_uint(usize),
                            // LNCT.timestamp => e.timestamp = try form_value.get_uint(u64),
                            // LNCT.MD5 => e.md5 = switch (form_value) {
                            //     .data16 => |data16| data16.*,
                            //     else => return bad(),
                            // },
                            else => continue,
                        }
                    }
                }
            }
        }

        var prog = LineNumberProgram.init(default_is_stmt, version);

        reader.seek = prog_start_offset;

        const LNE = dwarf.LNE;
        const LNS = dwarf.LNS;

        while (reader.seek < next_unit_offset) {
            const opcode = try reader.takeByte();

            if (opcode == LNS.extended_op) {
                const op_size = try reader.takeLeb128(u64);
                if (op_size < 1) return bad();
                const sub_op = try reader.takeByte();
                switch (sub_op) {
                    LNE.end_sequence => {
                        // The row being added here is an "end" address, meaning
                        // that it does not map to the source location here -
                        // rather it marks the previous address as the last address
                        // that maps to this source location.

                        // In this implementation we don't mark end of addresses.
                        // This is a performance optimization based on the fact
                        // that we don't need to know if an address is missing
                        // source location info; we are only interested in being
                        // able to look up source location info for addresses that
                        // are known to have debug info.
                        prog.reset();
                    },
                    LNE.set_address => {
                        const addr = switch (elf.format) {
                            .@"32" => try reader.takeInt(u32, elf.endian),
                            .@"64" => try reader.takeInt(u64, elf.endian),
                        };
                        prog.address = addr;
                    },
                    LNE.define_file => {
                        const path = try reader.takeSentinel(0);
                        const dir_index = try reader.takeLeb128(usize);
                        _ = try reader.takeLeb128(u64);
                        _ = try reader.takeLeb128(u64);
                        try self.files.append(self.arena, .{
                            .path = path,
                            .dir_index = dir_index_offset + dir_index,
                            // .timestamp = timestamp,
                        });
                    },
                    else => reader.toss(op_size - 1),
                }
            } else if (opcode >= opcode_base) {
                // special opcodes
                const adjusted_opcode = opcode - opcode_base;
                const inc_addr = minimum_instruction_length * (adjusted_opcode / line_range);
                const inc_line = @as(i32, line_base) + @as(i32, adjusted_opcode % line_range);
                prog.line += inc_line;
                prog.address += inc_addr;
                try prog.add_row(self, elf, file_index_offset);
                prog.basic_block = false;
            } else {
                switch (opcode) {
                    LNS.copy => {
                        try prog.add_row(self, elf, file_index_offset);
                        prog.basic_block = false;
                    },
                    LNS.advance_pc => {
                        const arg = try reader.takeLeb128(usize);
                        prog.address += arg * minimum_instruction_length;
                    },
                    LNS.advance_line => {
                        const arg = try reader.takeLeb128(i64);
                        prog.line += arg;
                    },
                    LNS.set_file => {
                        const arg = try reader.takeLeb128(usize);
                        prog.file = arg;
                    },
                    LNS.set_column => {
                        const arg = try reader.takeLeb128(u64);
                        prog.column = arg;
                    },
                    LNS.negate_stmt => {
                        prog.is_stmt = !prog.is_stmt;
                    },
                    LNS.set_basic_block => {
                        prog.basic_block = true;
                    },
                    LNS.const_add_pc => {
                        const inc_addr = minimum_instruction_length * ((255 - opcode_base) / line_range);
                        prog.address += inc_addr;
                    },
                    LNS.fixed_advance_pc => {
                        const arg = try reader.takeInt(u16, elf.endian);
                        prog.address += arg;
                    },
                    LNS.set_prologue_end => {},
                    else => {
                        if (opcode - 1 >= standard_opcode_lengths.len) return bad();
                        reader.toss(standard_opcode_lengths[opcode - 1]);
                    },
                }
            }
        }
    }

    const LineNumberProgram = struct {
        address: u64,
        file: usize,
        line: i64,
        column: u64,
        version: u16,
        is_stmt: bool,
        basic_block: bool,

        default_is_stmt: bool,

        // Reset the state machine following the DWARF specification
        fn reset(self: *LineNumberProgram) void {
            self.address = 0;
            self.file = 1;
            self.line = 1;
            self.column = 0;
            self.is_stmt = self.default_is_stmt;
            self.basic_block = false;
        }

        fn init(is_stmt: bool, version: u16) LineNumberProgram {
            return .{
                .address = 0,
                .file = 1,
                .line = 1,
                .column = 0,
                .version = version,
                .is_stmt = is_stmt,
                .basic_block = false,
                .default_is_stmt = is_stmt,
            };
        }

        fn add_row(
            prog: *LineNumberProgram,
            parser: *Parser,
            elf: Elf,
            index_offset: usize,
        ) !void {
            if (prog.line == 0) {
                return;
            }

            if (!elf.is_address_executable(prog.address)) {
                return;
            }

            try parser.loc_list.append(parser.arena, .{
                .address = prog.address,
                .line = std.math.cast(u32, prog.line) orelse return bad(),
                .column = std.math.cast(u32, prog.column) orelse return bad(),
                .file_index = index_offset + (std.math.cast(
                    usize,
                    if (prog.version < 5) prog.file -| 1 else prog.file,
                ) orelse return bad()),
            });
        }
    };

    const FormValue = union(enum) {
        addr: u64,
        addrx: u64,
        block: []const u8,
        udata: u64,
        data16: *const [16]u8,
        sdata: i64,
        exprloc: []const u8,
        flag: bool,
        sec_offset: u64,
        ref: u64,
        ref_addr: u64,
        string: [:0]const u8,
        strp: u64,
        strx: u64,
        line_strp: u64,
        loclistx: u64,
        rnglistx: u64,

        fn parse(
            reader: *std.Io.Reader,
            form_id: u64,
            elf: Elf,
            dwarf_format: dwarf.Format,
            implicit_const_val: ?i64,
        ) !FormValue {
            const FORM = dwarf.FORM;

            // TODO: check the use of `readAddress`
            return switch (form_id) {
                FORM.addr => .{ .addr = switch (elf.format) {
                    .@"32" => try reader.takeInt(u32, elf.endian),
                    .@"64" => try reader.takeInt(u64, elf.endian),
                } },
                FORM.addrx1 => .{ .addrx = try reader.takeInt(u8, elf.endian) },
                FORM.addrx2 => .{ .addrx = try reader.takeInt(u16, elf.endian) },
                FORM.addrx3 => .{ .addrx = try reader.takeInt(u24, elf.endian) },
                FORM.addrx4 => .{ .addrx = try reader.takeInt(u32, elf.endian) },
                FORM.addrx => .{ .addrx = try reader.takeLeb128(u64) },

                FORM.block1,
                FORM.block2,
                FORM.block4,
                FORM.block,
                => .{ .block = try reader.take(switch (form_id) {
                    FORM.block1 => try reader.takeInt(u8, elf.endian),
                    FORM.block2 => try reader.takeInt(u16, elf.endian),
                    FORM.block4 => try reader.takeInt(u32, elf.endian),
                    FORM.block => try reader.takeLeb128(u64),
                    else => unreachable,
                }) },

                FORM.data1 => .{ .udata = try reader.takeInt(u8, elf.endian) },
                FORM.data2 => .{ .udata = try reader.takeInt(u16, elf.endian) },
                FORM.data4 => .{ .udata = try reader.takeInt(u32, elf.endian) },
                FORM.data8 => .{ .udata = try reader.takeInt(u64, elf.endian) },
                FORM.data16 => .{ .data16 = (try reader.take(16))[0..16] },
                FORM.udata => .{ .udata = try reader.takeLeb128(u64) },
                FORM.sdata => .{ .sdata = try reader.takeLeb128(i64) },
                FORM.exprloc => .{ .exprloc = try reader.take(try reader.takeLeb128(u64)) },
                FORM.flag => .{ .flag = (try reader.takeByte()) != 0 },
                FORM.flag_present => .{ .flag = true },
                FORM.sec_offset => .{ .sec_offset = try read_address(reader, dwarf_format, elf.endian) },

                FORM.ref1 => .{ .ref = try reader.takeInt(u8, elf.endian) },
                FORM.ref2 => .{ .ref = try reader.takeInt(u16, elf.endian) },
                FORM.ref4 => .{ .ref = try reader.takeInt(u32, elf.endian) },
                FORM.ref8 => .{ .ref = try reader.takeInt(u64, elf.endian) },
                FORM.ref_udata => .{ .ref = try reader.takeLeb128(u64) },

                FORM.ref_addr => .{ .ref_addr = try read_address(reader, dwarf_format, elf.endian) },
                FORM.ref_sig8 => .{ .ref = try reader.takeInt(u64, elf.endian) },

                FORM.string => .{ .string = try reader.takeSentinel(0) },
                FORM.strp => .{ .strp = try read_address(reader, dwarf_format, elf.endian) },
                FORM.strx1 => .{ .strx = try reader.takeInt(u8, elf.endian) },
                FORM.strx2 => .{ .strx = try reader.takeInt(u16, elf.endian) },
                FORM.strx3 => .{ .strx = try reader.takeInt(u24, elf.endian) },
                FORM.strx4 => .{ .strx = try reader.takeInt(u32, elf.endian) },
                FORM.strx => .{ .strx = try reader.takeLeb128(u64) },
                FORM.line_strp => .{ .line_strp = try read_address(reader, dwarf_format, elf.endian) },
                FORM.implicit_const => .{ .sdata = implicit_const_val orelse return bad() },
                FORM.loclistx => .{ .loclistx = try reader.takeLeb128(u64) },
                FORM.rnglistx => .{ .rnglistx = try reader.takeLeb128(u64) },
                else => {
                    std.log.err("unimplemented form id: 0x{x}", .{form_id});
                    return unimplemented();
                },
            };
        }

        fn get_string(
            self: FormValue,
            sections: Elf.Sections,
        ) ![]const u8 {
            switch (self) {
                .string => |value| return value,
                .strp => |offset| {
                    const data = sections.get(.@".debug_str") orelse return bad();
                    return std.mem.sliceTo(data[offset..], 0);
                },
                .line_strp => |offset| {
                    const data = sections.get(.@".debug_line_str") orelse return bad();
                    return std.mem.sliceTo(data[offset..], 0);
                },
                .strx => |index| {
                    _ = index;
                    // const debug_str_offsets = di.section(.debug_str_offsets) orelse return bad();
                    // if (compile_unit.str_offsets_base == 0) return bad();
                    // switch (compile_unit.format) {
                    //     .@"32" => {
                    //         const byte_offset = compile_unit.str_offsets_base + 4 * index;
                    //         if (byte_offset + 4 > debug_str_offsets.len) return bad();
                    //         const offset = mem.readInt(u32, debug_str_offsets[byte_offset..][0..4], di.endian);
                    //         return getStringGeneric(opt_str, offset);
                    //     },
                    //     .@"64" => {
                    //         const byte_offset = compile_unit.str_offsets_base + 8 * index;
                    //         if (byte_offset + 8 > debug_str_offsets.len) return bad();
                    //         const offset = mem.readInt(u64, debug_str_offsets[byte_offset..][0..8], di.endian);
                    //         return getStringGeneric(opt_str, offset);
                    //     },
                    // }
                    return unimplemented();
                },
                else => return bad(),
            }
        }

        fn get_sec_offset(self: FormValue) !u64 {
            switch (self) {
                .sec_offset => return self.sec_offset,
                else => return bad(),
            }
        }

        fn get_uint(fv: FormValue, comptime U: type) !U {
            return switch (fv) {
                inline .udata,
                .sdata,
                .sec_offset,
                => |c| std.math.cast(U, c) orelse bad(),
                else => bad(),
            };
        }
    };

    fn read_address(reader: *std.Io.Reader, dwarf_format: dwarf.Format, endian: std.builtin.Endian) !u64 {
        return switch (dwarf_format) {
            .@"32" => try reader.takeInt(u32, endian),
            .@"64" => try reader.takeInt(u64, endian),
        };
    }
};

fn bad() error{InvalidDebugInfo} {
    return error.InvalidDebugInfo;
}

fn unimplemented() error{Unimplemented} {
    return error.Unimplemented;
}
