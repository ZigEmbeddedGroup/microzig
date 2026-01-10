const std = @import("std");
const core = @import("out/MCXN947_cm33_core0.zig");
const peripherals = @import("out/types.zig").peripherals;

const Field = struct {
	name: []const u8,
	i: usize,
	offset: usize
};

// used to generate `syscon.Module`
// We encode the control register index and the bit offset of a given module in the enum fields.
// The name change somewhat between AHBCLKCTRL and PRESETCTRL, but they correspond to the same modules.
// every module in AHBCLKCTRL is also in PRESETCTRL, but not the other way around
pub fn main() void {
	std.debug.print("pub const Module = enum(u8) {{\n", .{});
	const fields1 = print_fields("AHBCLKCTRL", null);
	std.debug.print("}};", .{});
	std.debug.print("\n\n\n\n", .{});
	const fields2 = print_fields("PRESETCTRL", "_RST");
	std.debug.print("\n\n\n\n", .{});

	outer: for(fields1) |field| {
		for(fields2) |f| {
			if(std.mem.eql(u8, f.name, field.name)) continue :outer;
		}
		std.debug.print("ahb \"{s}\" not in preset\n", .{field.name});
	}
	std.debug.print("\n\n", .{});
	outer: for(fields2) |field| {
		for(fields1) |f| {
			if(std.mem.eql(u8, f.name, field.name)) continue :outer;
		}
		std.debug.print("preset \"{s}\" not in ahb\n", .{field.name});
	}
}
pub fn print_fields(comptime ty: []const u8, comptime suffix_: ?[]const u8) []Field {
	@setEvalBranchQuota(100000);
	var fields_: [4*32]Field = undefined;
	var len: usize = 0;
	var max_len: usize = 0;

	inline for(0..4) |i| {
		const num: []const u8 = &[_]u8 { comptime std.fmt.digitToChar(i, .lower) };
		const T = @FieldType(peripherals.SYSCON0, ty ++ num).underlying_type;
		inline for(comptime std.meta.fieldNames(T)) |name| {
			if(comptime std.mem.indexOf(u8, name, "reserved") != null or std.mem.indexOf(u8, name, "padding") != null) continue;
			const suf_i: ?usize = if(suffix_) |suffix| comptime std.mem.indexOf(u8, name, suffix) else name.len;
			if(suf_i == null) @compileError("field doesn't have suffix");
			fields_[len] = .{
				.name = name[0..suf_i.?],
				.i = i,
				.offset = get_field_offset(T, name)
			};
			max_len = @max(max_len, fields_[len].name.len);
			len += 1;
		}
	}
	const fields = fields_[0..len];
	var last_i = fields[0].i;
	const spaces = " " ** 20;
	for(fields) |field| {
		if(last_i != field.i) {
			last_i = field.i;
			std.debug.print("\n", .{});
		}
		const n_space = max_len + 1 - field.name.len;
		std.debug.print("\t{s}{s}= {: >2} | {} << 5,\n", .{field.name, spaces[0..n_space], field.offset, field.i});
	}

	return fields;
}

/// For a given packed structure `T`, this function returns
/// the bit index its the field named `field_name`.
fn get_field_offset(comptime T: type, comptime field_name: []const u8) u8 {
    std.debug.assert(@typeInfo(T) == .@"struct");
    std.debug.assert(std.meta.containerLayout(T) == .@"packed");
    std.debug.assert(std.meta.fieldIndex(T, field_name) != null);

    var offset: u8 = 0;
    inline for(std.meta.fields(T)) |field| {
        if(std.mem.eql(u8, field.name, field_name)) return offset;
        offset += @bitSizeOf(field.type);
    }
    unreachable;
}
