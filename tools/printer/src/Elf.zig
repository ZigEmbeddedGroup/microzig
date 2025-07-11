const std = @import("std");

const Elf = @This();

format: Format,
sections: Sections,
loaded_regions: []const Region,

pub const Format = enum {
    @"32",
    @"64",
};

pub const Sections = std.EnumMap(SectionTypes, []const u8);

pub const SectionTypes = enum {
    @".debug_info",
    @".debug_abbrev",
    @".debug_str",
    @".debug_line_str",
    @".debug_line",
    @".debug_ranges",
};

pub const Region = struct {
    start_address: u64,
    end_address: u64,
    flags: Flags,

    pub const Flags = packed struct {
        read: bool,
        write: bool,
        exec: bool,
    };
};

pub fn init(allocator: std.mem.Allocator, source: anytype) !Elf {
    var elf_header = try std.elf.Header.read(source);

    const format: Format = if (elf_header.is_64) .@"64" else .@"32";

    const string_table_data = blk: {
        var shdr: std.elf.Elf64_Shdr = undefined;
        if (format == .@"32") {
            var shdr32: std.elf.Elf32_Shdr = undefined;
            const offset = elf_header.shoff + @sizeOf(std.elf.Elf32_Shdr) * elf_header.shstrndx;
            try source.seekableStream().seekTo(offset);
            try source.reader().readNoEof(std.mem.asBytes(&shdr32));

            shdr = .{
                .sh_name = shdr32.sh_name,
                .sh_type = shdr32.sh_type,
                .sh_flags = shdr32.sh_flags,
                .sh_addr = shdr32.sh_addr,
                .sh_offset = shdr32.sh_offset,
                .sh_size = shdr32.sh_size,
                .sh_link = shdr32.sh_link,
                .sh_info = shdr32.sh_info,
                .sh_addralign = shdr32.sh_addralign,
                .sh_entsize = shdr32.sh_entsize,
            };
        } else {
            const offset = elf_header.shoff + @sizeOf(std.elf.Elf64_Shdr) * elf_header.shstrndx;
            try source.seekableStream().seekTo(offset);
            try source.reader().readNoEof(std.mem.asBytes(&shdr));
        }

        const section_data = try allocator.alloc(u8, shdr.sh_size);
        errdefer allocator.free(section_data);

        try source.seekableStream().seekTo(shdr.sh_offset);
        try source.reader().readNoEof(section_data);

        break :blk section_data;
    };
    defer allocator.free(string_table_data);

    var sections: Sections = .{};
    errdefer {
        var it = sections.iterator();
        while (it.next()) |entry| {
            allocator.free(entry.value.*);
        }
    }

    var section_header_it = elf_header.section_header_iterator(source);
    while (try section_header_it.next()) |shdr| {
        const name = std.mem.span(@as([*:0]const u8, @ptrCast(string_table_data[shdr.sh_name..])));
        inline for (@typeInfo(SectionTypes).@"enum".fields) |section_field| {
            if (std.mem.eql(u8, name, section_field.name)) {
                const section_data = try allocator.alloc(u8, shdr.sh_size);
                errdefer allocator.free(section_data);

                try source.seekableStream().seekTo(shdr.sh_offset);
                try source.reader().readNoEof(section_data);

                sections.put(@enumFromInt(section_field.value), section_data);
            }
        }
    }

    var loaded_regions: std.ArrayListUnmanaged(Region) = .empty;
    defer loaded_regions.deinit(allocator);

    var program_header_iterator = elf_header.program_header_iterator(source);
    while (try program_header_iterator.next()) |phdr| {
        if (phdr.p_type != std.elf.PT_LOAD) continue;

        try loaded_regions.append(allocator, .{
            .start_address = phdr.p_vaddr,
            .end_address = phdr.p_vaddr + phdr.p_memsz,
            .flags = .{
                .read = phdr.p_flags & std.elf.PF_R != 0,
                .write = phdr.p_flags & std.elf.PF_W != 0,
                .exec = phdr.p_flags & std.elf.PF_X != 0,
            },
        });
    }

    return .{
        .format = format,
        .sections = sections,
        .loaded_regions = try loaded_regions.toOwnedSlice(allocator),
    };
}

pub fn deinit(self: *Elf, allocator: std.mem.Allocator) void {
    var it = self.sections.iterator();
    while (it.next()) |entry| {
        allocator.free(entry.value.*);
    }

    allocator.free(self.loaded_regions);
}

pub fn is_address_executable(self: Elf, address: u64) bool {
    var inside_memory_map = false;
    for (self.loaded_regions) |region| {
        if (!region.flags.exec) {
            continue;
        }

        if (address >= region.start_address and address < region.end_address) {
            inside_memory_map = true;
            break;
        }
    }
    return inside_memory_map;
}
