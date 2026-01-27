gpa: Allocator,
arena: std.heap.ArenaAllocator,
db: *regz.Database,
id_extra: usize,
title: []const u8,
show_window: bool = true,
path: []const u8,
vfs: VirtualFilesystem,
selected_file: ?VirtualFilesystem.ID = null,
displayed_file: ?VirtualFilesystem.ID = null,
active_view: View = .code_generation,
chip_info: ?ChipInfo = null,
loaded_patches: std.StringArrayHashMapUnmanaged(LoadedPatchFile) = .{},
selected_patch: ?SelectedPatch = null,
patches_loaded: bool = false,

pub const View = enum {
    code_generation,
    patches,
};

pub const ChipInfo = struct {
    name: []const u8,
    patch_files: []const RegisterSchemaUsage.PatchFile,
};

pub const LoadedPatchFile = struct {
    path: []const u8,
    patches: ?[]const regz.Patch,
    parse_error: ?[]const u8 = null,
    is_editable: bool,
};

pub const SelectedPatch = struct {
    file_index: usize,
    patch_index: usize,
};

const RegzWindow = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;

const regz = @import("regz");
const VirtualFilesystem = regz.VirtualFilesystem;
const RegisterSchemaUsage = @import("RegisterSchemaUsage.zig");

const dvui = @import("dvui");

// Tree-sitter Zig language parser
extern fn tree_sitter_zig() callconv(.c) *dvui.c.TSLanguage;

// Zig syntax highlighting queries (based on tree-sitter-zig highlights.scm)
const zig_queries =
    \\; Variables
    \\(identifier) @variable
    \\
    \\; Types
    \\(builtin_type) @type
    \\
    \\; Functions
    \\(builtin_identifier) @function
    \\(call_expression function: (identifier) @function)
    \\(function_declaration name: (identifier) @function)
    \\
    \\; Keywords
    \\["asm" "defer" "errdefer" "test" "error" "const" "var"] @keyword
    \\["struct" "union" "enum" "opaque"] @keyword
    \\["async" "await" "suspend" "nosuspend" "resume"] @keyword
    \\"fn" @keyword
    \\["and" "or" "orelse"] @keyword
    \\"return" @keyword
    \\["if" "else" "switch"] @keyword
    \\["for" "while" "break" "continue"] @keyword
    \\["usingnamespace" "export"] @keyword
    \\["try" "catch"] @keyword
    \\["volatile" "allowzero" "noalias" "addrspace" "align" "callconv" "linksection" "pub" "inline" "noinline" "extern" "comptime" "packed" "threadlocal"] @keyword
    \\
    \\; Literals
    \\(character) @string
    \\(string) @string
    \\(multiline_string) @string
    \\(integer) @number
    \\(float) @number
    \\(boolean) @constant
    \\["null" "unreachable" "undefined"] @constant
    \\
    \\; Comments
    \\(comment) @comment
    \\
    \\; Punctuation
    \\["[" "]" "(" ")" "{" "}"] @punctuation
    \\[";" "." "," ":" "=>" "->"] @punctuation
;

// Srcery colorscheme (https://srcery-colors.github.io)
const zig_highlights: []const dvui.TextEntryWidget.SyntaxHighlight = blk: {
    @setEvalBranchQuota(20000);
    break :blk &.{
        .{ .name = "keyword", .opts = .{ .color_text = dvui.Color.fromHex("EF2F27") } }, // Red - Statement
        .{ .name = "string", .opts = .{ .color_text = dvui.Color.fromHex("98BC37") } }, // BrightGreen
        .{ .name = "comment", .opts = .{ .color_text = dvui.Color.fromHex("918175") } }, // BrightBlack
        .{ .name = "number", .opts = .{ .color_text = dvui.Color.fromHex("E02C6D") } }, // Magenta
        .{ .name = "type", .opts = .{ .color_text = dvui.Color.fromHex("FBB829") } }, // Yellow
        .{ .name = "function", .opts = .{ .color_text = dvui.Color.fromHex("0AAEB3") } }, // Cyan
        .{ .name = "variable", .opts = .{ .color_text = dvui.Color.fromHex("FCE8C3") } }, // BrightWhite (foreground)
        .{ .name = "constant", .opts = .{ .color_text = dvui.Color.fromHex("E02C6D") } }, // Magenta
        .{ .name = "operator", .opts = .{ .color_text = dvui.Color.fromHex("0AAEB3") } }, // Cyan
        .{ .name = "punctuation", .opts = .{ .color_text = dvui.Color.fromHex("BAA67F") } }, // White
    };
};

var count: usize = 0;

pub fn create(
    gpa: Allocator,
    format: regz.Database.Format,
    path: []const u8,
    device: ?[]const u8,
    chip_info: ?ChipInfo,
) !*RegzWindow {
    const window = try gpa.create(RegzWindow);
    errdefer gpa.destroy(window);

    var db = try regz.Database.create_from_path(gpa, format, path, device);
    errdefer db.destroy();

    var arena: std.heap.ArenaAllocator = .init(gpa);
    errdefer arena.deinit();

    const devices = try db.get_devices(arena.allocator());
    const title = switch (format) {
        .embassy => "Embassy STM32",
        else => switch (devices.len) {
            0 => "<no device>",
            1 => devices[0].name,
            else => "<multiple devices>",
        },
    };

    window.* = .{
        .gpa = gpa,
        .db = db,
        .id_extra = count,
        .title = title,
        .arena = arena,
        .path = path,
        .vfs = .init(gpa),
        .chip_info = chip_info,
    };

    try db.to_zig(window.vfs.dir(), .{});

    count += 1;

    return window;
}

pub fn destroy(w: *RegzWindow) void {
    // Clean up loaded patches hashmap (strings are in w.arena, freed below)
    w.loaded_patches.deinit(w.gpa);

    w.vfs.deinit();
    w.arena.deinit();
    w.db.destroy();
}

pub fn show(w: *RegzWindow) !void {
    if (!w.show_window)
        return;

    var arena: std.heap.ArenaAllocator = .init(w.gpa);
    defer arena.deinit();

    var float = dvui.floatingWindow(@src(), .{}, .{
        .min_size_content = .{ .w = 400, .h = 400 },
        .max_size_content = .width(400),
        .id_extra = w.id_extra,
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Regz", w.title, &w.show_window));

    // Menu bar
    {
        var menubar = dvui.box(@src(), .{ .dir = .horizontal }, .{
            .expand = .horizontal,
            .background = true,
        });
        defer menubar.deinit();

        var m = dvui.menu(@src(), .horizontal, .{});
        defer m.deinit();

        if (dvui.menuItemLabel(@src(), "File", .{ .submenu = true }, .{})) |r| {
            var fw = dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            if (dvui.menuItemLabel(@src(), "Save As...", .{}, .{ .expand = .horizontal }) != null) {
                m.close();
                if (dvui.dialogNativeFolderSelect(dvui.currentWindow().arena(), .{
                    .title = "Save Generated Code To...",
                }) catch null) |folder_path| {
                    w.save_to_directory(folder_path) catch |err| {
                        std.log.err("Failed to save: {}", .{err});
                    };
                }
            }

            if (dvui.menuItemLabel(@src(), "Close", .{}, .{ .expand = .horizontal }) != null) {
                w.show_window = false;
                m.close();
            }
        }

        if (dvui.menuItemLabel(@src(), "View", .{ .submenu = true }, .{})) |r| {
            var fw = dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            if (dvui.menuItemLabel(@src(), "Code Generation", .{}, .{ .expand = .horizontal }) != null) {
                w.active_view = .code_generation;
                m.close();
            }

            if (dvui.menuItemLabel(@src(), "Patches", .{}, .{ .expand = .horizontal }) != null) {
                w.active_view = .patches;
                m.close();
            }
        }
    }

    switch (w.active_view) {
        .code_generation => w.show_code_generation(arena.allocator()),
        .patches => w.show_patches(arena.allocator()),
    }
}

fn show_code_generation(w: *RegzWindow, arena: Allocator) void {
    var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .both });
    defer hbox.deinit();

    {
        const scroll_arena = dvui.scrollArea(@src(), .{}, .{});
        defer scroll_arena.deinit();

        w.show_file_tree(
            arena,
            @src(),
            .{},
            .{
                .background = true,
                .border = dvui.Rect.all(1),
                .padding = dvui.Rect.all(4),
            },
            .{
                .padding = dvui.Rect.all(1),
            },
            .{
                .border = .{ .x = 1 },
                .corner_radius = dvui.Rect.all(4),
                .box_shadow = .{
                    .color = .black,
                    .offset = .{ .x = -5, .y = 5 },
                    .shrink = 5,
                    .fade = 10,
                    .alpha = 0.15,
                },
            },
        ) catch {};
    }

    if (dvui.useTreeSitter) {
        var te: dvui.TextEntryWidget = undefined;
        te.init(@src(), .{
            .multiline = true,
            .cache_layout = true,
            .text = .{ .internal = .{ .limit = 10_000_000 } },
            .tree_sitter = .{
                .language = tree_sitter_zig(),
                .queries = zig_queries,
                .highlights = zig_highlights,
                .log_captures = false,
            },
        }, .{ .expand = .both });
        defer te.deinit();

        if (w.selected_file) |id| {
            // Update text when file selection changes
            if (w.displayed_file != id or dvui.firstFrame(te.data().id)) {
                te.textSet(w.vfs.get_content(id), false);
                te.textLayout.selection.moveCursor(0, false);
                w.displayed_file = id;
            }
        }

        // Process only read-only events (selection, copy, navigation, scroll)
        process_read_only_events(&te);
        te.draw();
    } else {
        // Fallback to plain textLayout when tree-sitter unavailable
        const scroll_arena = dvui.scrollArea(@src(), .{}, .{});
        defer scroll_arena.deinit();

        var tl = dvui.textLayout(@src(), .{}, .{ .expand = .horizontal });
        defer tl.deinit();

        if (w.selected_file) |id|
            tl.addText(w.vfs.get_content(id), .{});
    }
}

fn show_patches(w: *RegzWindow, arena: Allocator) void {
    // Load patches on first view
    if (!w.patches_loaded) {
        w.loadPatchFiles();
        w.patches_loaded = true;
    }

    var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .both });
    defer hbox.deinit();

    // Left panel: Patch tree
    {
        var left_box = dvui.box(@src(), .{ .dir = .vertical }, .{
            .expand = .vertical,
            .background = true,
            .border = dvui.Rect.all(1),
            .padding = dvui.Rect.all(4),
        });
        defer left_box.deinit();

        var scroll = dvui.scrollArea(@src(), .{}, .{ .expand = .vertical });
        defer scroll.deinit();

        w.showPatchTree(arena);
    }

    // Right panel: Patch details
    {
        var scroll = dvui.scrollArea(@src(), .{}, .{ .expand = .both });
        defer scroll.deinit();

        w.showPatchDetails(arena);
    }
}

fn loadPatchFiles(w: *RegzWindow) void {
    const chip = w.chip_info orelse return;

    // Use window's arena for persistent storage across frames
    const alloc = w.arena.allocator();

    for (chip.patch_files) |pf| {
        const path_result = constructPatchPath(alloc, pf);
        const path = path_result orelse continue;

        const is_editable = switch (pf) {
            .src_path => true,
            .dependency => false,
        };

        // Read and parse ZON file
        const file = std.fs.cwd().openFile(path, .{}) catch |err| {
            const owned_path = alloc.dupe(u8, path) catch continue;
            const error_msg = std.fmt.allocPrint(alloc, "Failed to open file: {s}", .{@errorName(err)}) catch continue;
            w.loaded_patches.put(w.gpa, owned_path, .{
                .path = owned_path,
                .patches = null,
                .parse_error = error_msg,
                .is_editable = is_editable,
            }) catch {};
            continue;
        };
        defer file.close();

        const content = file.readToEndAllocOptions(alloc, 10 * 1024 * 1024, null, .of(u8), 0) catch |err| {
            const owned_path = alloc.dupe(u8, path) catch continue;
            const error_msg = std.fmt.allocPrint(alloc, "Failed to read file: {s}", .{@errorName(err)}) catch continue;
            w.loaded_patches.put(w.gpa, owned_path, .{
                .path = owned_path,
                .patches = null,
                .parse_error = error_msg,
                .is_editable = is_editable,
            }) catch {};
            continue;
        };

        const patches = std.zon.parse.fromSlice([]const regz.Patch, alloc, content, null, .{}) catch |err| {
            const owned_path = alloc.dupe(u8, path) catch continue;
            const error_msg = std.fmt.allocPrint(alloc, "Failed to parse ZON: {s}", .{@errorName(err)}) catch continue;
            w.loaded_patches.put(w.gpa, owned_path, .{
                .path = owned_path,
                .patches = null,
                .parse_error = error_msg,
                .is_editable = is_editable,
            }) catch {};
            continue;
        };

        const owned_path = alloc.dupe(u8, path) catch continue;
        w.loaded_patches.put(w.gpa, owned_path, .{
            .path = owned_path,
            .patches = patches,
            .is_editable = is_editable,
        }) catch {};
    }
}

fn constructPatchPath(arena: Allocator, pf: RegisterSchemaUsage.PatchFile) ?[]const u8 {
    return switch (pf) {
        .src_path => |sp| std.fs.path.join(arena, &.{ sp.build_root, sp.sub_path }) catch null,
        .dependency => |dp| std.fs.path.join(arena, &.{ dp.build_root, dp.sub_path }) catch null,
    };
}

fn showPatchTree(w: *RegzWindow, arena: Allocator) void {
    if (w.loaded_patches.count() == 0) {
        _ = dvui.label(@src(), "No patch files", .{}, .{});
        return;
    }

    var tree = dvui.TreeWidget.tree(@src(), .{}, .{
        .background = true,
        .padding = dvui.Rect.all(4),
    });
    defer tree.deinit();

    var file_idx: usize = 0;
    for (w.loaded_patches.keys(), w.loaded_patches.values()) |path, loaded| {
        defer file_idx += 1;

        var branch = tree.branch(@src(), .{ .expanded = true }, .{ .id_extra = file_idx });
        defer branch.deinit();

        // File icon and name
        const icon = if (loaded.parse_error != null) dvui.entypo.warning else dvui.entypo.documents;
        dvui.icon(@src(), "FileIcon", icon, .{}, .{ .gravity_y = 0.5 });

        const basename = std.fs.path.basename(path);
        const editable_suffix: []const u8 = if (loaded.is_editable) "" else " (read-only)";
        _ = dvui.label(@src(), "{s}{s}", .{ basename, editable_suffix }, .{});

        // Expander arrow
        dvui.icon(
            @src(),
            "DropIcon",
            if (branch.expanded) dvui.entypo.triangle_down else dvui.entypo.triangle_right,
            .{},
            .{ .gravity_y = 0.5, .gravity_x = 1.0 },
        );

        if (branch.expander(@src(), .{ .indent = 14 }, .{ .margin = .{ .x = 14 } })) {
            if (loaded.parse_error) |err| {
                _ = dvui.label(@src(), "Error: {s}", .{err}, .{
                    .color_text = dvui.Color.fromHex("EF2F27"),
                });
            } else if (loaded.patches) |patches| {
                for (patches, 0..) |patch, patch_idx| {
                    var op_branch = tree.branch(@src(), .{}, .{ .id_extra = patch_idx });
                    defer op_branch.deinit();

                    const patch_label = getPatchLabel(patch, arena);
                    _ = dvui.label(@src(), "{s}", .{patch_label}, .{});

                    if (op_branch.button.clicked()) {
                        w.selected_patch = .{ .file_index = file_idx, .patch_index = patch_idx };
                    }
                }
            }
        }
    }
}

fn getPatchLabel(patch: regz.Patch, arena: Allocator) []const u8 {
    return switch (patch) {
        .override_arch => |p| std.fmt.allocPrint(arena, "override_arch: {s}", .{p.device_name}) catch "override_arch",
        .set_device_property => |p| std.fmt.allocPrint(arena, "set_device_property: {s}", .{p.key}) catch "set_device_property",
        .add_enum => |p| std.fmt.allocPrint(arena, "add_enum: {s}", .{p.@"enum".name}) catch "add_enum",
        .set_enum_type => |p| std.fmt.allocPrint(arena, "set_enum_type: {s}", .{p.of}) catch "set_enum_type",
        .add_interrupt => |p| std.fmt.allocPrint(arena, "add_interrupt: {s}", .{p.name}) catch "add_interrupt",
        .add_enum_and_apply => |p| std.fmt.allocPrint(arena, "add_enum_and_apply: {s}", .{p.@"enum".name}) catch "add_enum_and_apply",
    };
}

fn showPatchDetails(w: *RegzWindow, arena: Allocator) void {
    // Empty state - no patches available
    if (w.loaded_patches.count() == 0) {
        var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
            .expand = .both,
            .padding = dvui.Rect.all(16),
        });
        defer vbox.deinit();

        _ = dvui.label(@src(), "No patches available for this target.", .{}, .{});
        _ = dvui.label(@src(), "To add patches, create a patch file manually.", .{}, .{});
        return;
    }

    const sel = w.selected_patch orelse {
        var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
            .expand = .both,
            .padding = dvui.Rect.all(16),
        });
        defer vbox.deinit();

        _ = dvui.label(@src(), "Select a patch to view details", .{}, .{});
        return;
    };

    const keys = w.loaded_patches.keys();
    if (sel.file_index >= keys.len) return;

    const path = keys[sel.file_index];
    const loaded = w.loaded_patches.get(path) orelse return;

    if (loaded.parse_error != null) {
        _ = dvui.label(@src(), "Cannot display details: file has parse errors", .{}, .{
            .color_text = dvui.Color.fromHex("EF2F27"),
        });
        return;
    }

    const patches = loaded.patches orelse return;
    if (sel.patch_index >= patches.len) return;

    const patch = patches[sel.patch_index];

    var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
        .expand = .both,
        .padding = dvui.Rect.all(8),
    });
    defer vbox.deinit();

    // Header with patch type
    _ = dvui.label(@src(), "Patch Type: {s}", .{getPatchLabel(patch, arena)}, .{
        .font = .{ .weight = .bold },
    });
    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    switch (patch) {
        .override_arch => |p| showOverrideArchWidget(p),
        .set_device_property => |p| showSetDevicePropertyWidget(p),
        .add_enum => |p| showAddEnumWidget(p, arena),
        .set_enum_type => |p| showSetEnumTypeWidget(p),
        .add_interrupt => |p| showAddInterruptWidget(p),
        .add_enum_and_apply => |p| showAddEnumAndApplyWidget(p, arena),
    }
}

fn showOverrideArchWidget(p: anytype) void {
    labeledField("Device Name", p.device_name);
    labeledField("Architecture", @tagName(p.arch));
}

fn showSetDevicePropertyWidget(p: anytype) void {
    labeledField("Device Name", p.device_name);
    labeledField("Key", p.key);
    labeledField("Value", p.value);
    if (p.description) |desc| labeledField("Description", desc);
}

fn showAddEnumWidget(p: anytype, arena: Allocator) void {
    labeledField("Parent", p.parent);
    showEnumDetails(p.@"enum", arena);
}

fn showEnumDetails(e: anytype, arena: Allocator) void {
    labeledField("Name", e.name);
    if (e.description) |d| labeledField("Description", d);
    const bitsize_str = std.fmt.allocPrint(arena, "{d}", .{e.bitsize}) catch "?";
    labeledField("Bit Size", bitsize_str);

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    if (e.fields.len > 0) {
        _ = dvui.label(@src(), "Fields:", .{}, .{
            .font = .{ .weight = .bold },
            .color_text = dvui.Color.fromHex("FBB829"),
        });

        _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });

        // Table for enum fields
        const header_style: dvui.GridWidget.CellStyle = .{
            .cell_opts = .{
                .border = .{ .y = 0, .h = 1, .x = 0, .w = 0 },
            },
        };

        // Column widths: Name (120 fixed), Value (60 fixed), Description (proportional -1)
        var col_widths: [3]f32 = .{ 0, 0, 0 };
        var grid = dvui.grid(@src(), .{ .col_widths = &col_widths }, .{}, .{
            .expand = .both,
            .background = true,
            .padding = dvui.Rect.all(4),
        });
        defer grid.deinit();

        // Layout: fixed 120 for Name, fixed 60 for Value, rest for Description
        dvui.columnLayoutProportional(&.{ 120, 60, -1 }, &col_widths, grid.data().contentRect().w);

        // Table headers
        dvui.gridHeading(@src(), grid, 0, "Name", .fixed, header_style);
        dvui.gridHeading(@src(), grid, 1, "Value", .fixed, header_style);
        dvui.gridHeading(@src(), grid, 2, "Description", .fixed, header_style);

        // Table rows
        for (e.fields, 0..) |field, row_num| {
            var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

            // Name column
            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, .{});
                defer cell.deinit();
                dvui.labelNoFmt(@src(), field.name, .{}, .{});
            }

            // Value column
            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, .{});
                defer cell.deinit();
                const value_str = std.fmt.allocPrint(arena, "{d}", .{field.value}) catch "?";
                dvui.labelNoFmt(@src(), value_str, .{}, .{});
            }

            // Description column
            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, .{});
                defer cell.deinit();
                dvui.labelNoFmt(@src(), field.description orelse "", .{}, .{});
            }
        }
    }
}

fn showSetEnumTypeWidget(p: anytype) void {
    labeledField("Of", p.of);
    labeledField("To", p.to orelse "(null)");
}

fn showAddInterruptWidget(p: anytype) void {
    labeledField("Device Name", p.device_name);
    var buf: [32]u8 = undefined;
    const idx_str = std.fmt.bufPrint(&buf, "{d}", .{p.idx}) catch "?";
    labeledField("Index", idx_str);
    labeledField("Name", p.name);
    if (p.description) |d| labeledField("Description", d);
}

fn showAddEnumAndApplyWidget(p: anytype, arena: Allocator) void {
    labeledField("Parent", p.parent);
    showEnumDetails(p.@"enum", arena);

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    if (p.apply_to.len > 0) {
        _ = dvui.label(@src(), "Apply To:", .{}, .{
            .font = .{ .weight = .bold },
            .color_text = dvui.Color.fromHex("FBB829"),
        });

        for (p.apply_to, 0..) |target, i| {
            _ = dvui.label(@src(), "  {s}", .{target}, .{ .id_extra = i });
        }
    }
}

fn labeledField(label_text: []const u8, value: []const u8) void {
    // Use hash of label text as unique ID to avoid duplicate widget IDs
    const label_hash = std.hash.Wyhash.hash(0, label_text);

    var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{
        .expand = .horizontal,
        .id_extra = label_hash,
    });
    defer hbox.deinit();

    _ = dvui.label(@src(), "{s}:", .{label_text}, .{
        .color_text = dvui.Color.fromHex("FBB829"),
    });
    _ = dvui.label(@src(), " {s}", .{value}, .{});
}

fn save_to_directory(w: *RegzWindow, folder_path: []const u8) !void {
    var output_dir = try std.fs.cwd().makeOpenPath(folder_path, .{});
    defer output_dir.close();

    try w.save_vfs_recursive(output_dir, .root);
}

fn save_vfs_recursive(w: *RegzWindow, output_dir: std.fs.Dir, parent_id: VirtualFilesystem.ID) !void {
    const children = try w.vfs.get_children(w.gpa, parent_id);
    defer w.gpa.free(children);

    for (children) |entry| {
        const name = w.vfs.get_name(entry.id);
        switch (entry.kind) {
            .directory => {
                var subdir = try output_dir.makeOpenPath(name, .{});
                defer subdir.close();
                try w.save_vfs_recursive(subdir, entry.id);
            },
            .file => {
                const content = w.vfs.get_content(entry.id);
                const file = try output_dir.createFile(name, .{});
                defer file.close();
                try file.writeAll(content);
            },
        }
    }
}

fn show_file_tree(
    w: *RegzWindow,
    arena: Allocator,
    src: std.builtin.SourceLocation,
    tree_init_options: dvui.TreeWidget.InitOptions,
    tree_options: dvui.Options,
    branch_options: dvui.Options,
    expander_options: dvui.Options,
) !void {
    const unique_id = dvui.parentGet().extendId(@src(), 0);

    var tree = dvui.TreeWidget.tree(src, tree_init_options, tree_options);
    defer tree.deinit();

    const children = try w.vfs.get_children(arena, .root);
    try w.show_file_tree_recursive(arena, .root, children, tree, unique_id, branch_options, expander_options);
}

fn show_file_tree_recursive(
    w: *RegzWindow,
    arena: Allocator,
    directory: VirtualFilesystem.ID,
    children: []const VirtualFilesystem.Entry,
    tree: *dvui.TreeWidget,
    unique_id: dvui.Id,
    branch_options: dvui.Options,
    expander_options: dvui.Options,
) !void {
    var id_extra: usize = 0;
    for (children, 0..) |child_entry, i| {
        if (directory == .root and w.selected_file == null and i == 0) {
            w.selected_file = child_entry.id;
        }
        id_extra += 1;
        var branch_opts_override = dvui.Options{
            .id_extra = id_extra,
            .expand = .horizontal,
        };
        const expanded = true;
        //oconst branch_id = tree.data().id.update(w.vfs.get_name(directory));

        const branch = tree.branch(@src(), .{ .expanded = expanded }, branch_opts_override.override(branch_options));
        defer branch.deinit();
        switch (child_entry.kind) {
            .directory => {
                dvui.icon(
                    @src(),
                    "FolderIcon",
                    dvui.entypo.folder,
                    .{},
                    .{
                        .gravity_y = 0.5,
                    },
                );

                const name = w.vfs.get_name(child_entry.id);
                _ = dvui.label(@src(), "{s}", .{name}, .{});

                dvui.icon(
                    @src(),
                    "DropIcon",
                    if (branch.expanded) dvui.entypo.triangle_down else dvui.entypo.triangle_right,
                    .{
                        //.fill_color = color
                    },
                    .{
                        .gravity_y = 0.5,
                        .gravity_x = 1.0,
                    },
                );

                var expander_opts_override = dvui.Options{
                    .margin = .{ .x = 14 },
                    //.color_border = color,
                    .background = if (expander_options.border != null) true else false,
                    .expand = .horizontal,
                };

                if (branch.expander(@src(), .{ .indent = 14 }, expander_opts_override.override(expander_options))) {
                    // The expander is open, so we need to add the branch to our tracking map
                    //reorder_tree_open_branches.put(branch_id, {}) catch {
                    //    dvui.log.debug("Failed to track branch state!", .{});
                    //};

                    var box = dvui.box(@src(), .{ .dir = .vertical }, .{
                        .expand = .horizontal,
                        .background = false,
                        .gravity_y = 1.0,
                    });
                    defer box.deinit();
                }

                const grandchildren = try w.vfs.get_children(arena, child_entry.id);
                try w.show_file_tree_recursive(arena, child_entry.id, grandchildren, tree, unique_id, branch_options, expander_options);
            },
            .file => {
                dvui.icon(@src(), "FileIcon", dvui.entypo.text_document, .{}, .{
                    .gravity_y = 0.5,
                });

                const name = w.vfs.get_name(child_entry.id);
                _ = dvui.label(@src(), "{s}", .{name}, .{});

                if (branch.button.clicked()) {
                    w.selected_file = child_entry.id;
                    std.log.info("Clicked: {s}", .{name});
                }
            },
        }
    }
}

/// Process events for read-only text display (allows selection, copy, navigation, scroll)
fn process_read_only_events(te: *dvui.TextEntryWidget) void {
    const evts = dvui.events();
    for (evts) |*e| {
        if (!te.matchEvent(e))
            continue;

        // Let scroll handle events first
        te.scroll.scroll.?.processEvent(e);
        if (e.handled) continue;

        switch (e.evt) {
            .key => |ke| {
                // Allow copy
                if (ke.action == .down and ke.matchBind("copy")) {
                    e.handle(@src(), te.data());
                    te.copy();
                    continue;
                }

                // Allow select all
                if (ke.action == .down and ke.matchBind("select_all")) {
                    e.handle(@src(), te.data());
                    te.textLayout.selection.selectAll();
                    continue;
                }

                // Allow navigation: arrows, home, end, page up/down
                if ((ke.action == .down or ke.action == .repeat) and
                    (ke.matchBind("char_left") or ke.matchBind("char_right") or
                        ke.matchBind("char_up") or ke.matchBind("char_down") or
                        ke.matchBind("word_left") or ke.matchBind("word_right") or
                        ke.matchBind("line_start") or ke.matchBind("line_end") or
                        ke.matchBind("text_start") or ke.matchBind("text_end") or
                        ke.matchBind("page_up") or ke.matchBind("page_down")))
                {
                    te.processEvent(e);
                    continue;
                }

                // Allow tab navigation between widgets
                if ((ke.action == .down or ke.action == .repeat) and
                    (ke.matchBind("next_widget") or ke.matchBind("prev_widget")))
                {
                    te.processEvent(e);
                    continue;
                }
            },
            // Allow all mouse events for selection
            .mouse => {
                te.processEvent(e);
            },
            // Block text input events
            .text => {},
            else => {},
        }
    }
}
