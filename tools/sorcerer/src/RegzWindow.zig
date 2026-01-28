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
format: regz.Database.Format,
device: ?[]const u8,
patch_detail_tab: PatchDetailTab = .fields,
cached_diff: ?CachedDiff = null,
// Analysis view state
cached_analysis: ?CachedAnalysis = null,
selected_analysis_peripheral: ?usize = null,
selected_equivalence_group: ?usize = null,
analysis_col_widths: [3]f32 = .{ 150, 80, 200 },

// Unsaved state tracking
has_unsaved_patches: bool = false,

// Create patch dialog state
show_create_patch_dialog: bool = false,
pending_patch_creation: ?PendingPatchCreation = null,

// Close confirmation dialog
show_unsaved_warning: bool = false,

// Validation error dialog
show_validation_error: bool = false,
validation_error_message: ?[]const u8 = null,

// Reference to all register schema usages (for cross-target validation)
register_schema_usages: ?[]const RegisterSchemaUsage = null,

pub const View = enum {
    code_generation,
    patches,
    analysis,
};

pub const ChipInfo = struct {
    name: []const u8,
    patch_files: []const RegisterSchemaUsage.PatchFile,
};

pub const LoadedPatchFile = struct {
    path: []const u8,
    patches: ?[]const regz.Patch,
    pending_patches: std.ArrayList(regz.Patch),
    deleted_patch_indices: std.ArrayList(usize), // Indices of original patches marked for deletion
    parse_error: ?[]const u8 = null,
    is_editable: bool,
    is_dirty: bool = false,

    /// Check if an original patch index has been deleted
    pub fn is_patch_deleted(self: *const LoadedPatchFile, idx: usize) bool {
        for (self.deleted_patch_indices.items) |deleted_idx| {
            if (deleted_idx == idx) return true;
        }
        return false;
    }
};

pub const SelectedPatch = struct {
    file_index: usize,
    patch_index: usize,
};

pub const PendingPatchCreation = struct {
    peripheral_name: []const u8,
    group_idx: usize,
    enum_name_buffer: [128]u8 = [_]u8{0} ** 128,
    selected_file_index: ?usize = null,
};

pub const PatchDetailTab = enum {
    fields,
    diff,
};

pub const DiffLine = struct {
    kind: enum { context, added, removed },
    text: []const u8,
};

pub const CachedDiff = struct {
    file_index: usize,
    patch_index: usize,
    file_diffs: []const FileDiff,
    error_message: ?[]const u8 = null,
};

pub const FileDiff = struct {
    filename: []const u8,
    lines: []const DiffLine,
};

pub const CachedAnalysis = struct {
    /// Results for peripherals that have equivalence groups (actionable results)
    peripheral_results: []const PeripheralAnalysisResult,
};

pub const PeripheralAnalysisResult = struct {
    peripheral_name: []const u8,
    result: regz.Analysis.AnalysisResult,
};

const RegzWindow = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;

const regz = @import("regz");
const VirtualFilesystem = regz.VirtualFilesystem;
const RegisterSchemaUsage = @import("RegisterSchemaUsage.zig");
const diffz = @import("diffz");

const dvui = @import("dvui");

// Tree-sitter Zig language parser
extern fn tree_sitter_zig() callconv(.c) *dvui.c.TSLanguage;

// Tree-sitter Diff language parser
extern fn tree_sitter_diff() callconv(.c) *dvui.c.TSLanguage;

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

// Diff syntax highlighting queries (based on tree-sitter-diff highlights.scm)
const diff_queries =
    \\; Additions - green
    \\(new_file) @diff.plus
    \\(addition) @diff.plus
    \\
    \\; Deletions - red
    \\(old_file) @diff.minus
    \\(deletion) @diff.minus
    \\
    \\; Headers and metadata
    \\(block) @diff.header
    \\(location) @diff.location
    \\(filename) @string
    \\(index) @keyword
    \\(commit) @constant
    \\
    \\; Context lines - default
    \\(context) @diff.context
;

// Diff colorscheme
const diff_highlights: []const dvui.TextEntryWidget.SyntaxHighlight = blk: {
    @setEvalBranchQuota(20000);
    break :blk &.{
        .{ .name = "diff.plus", .opts = .{ .color_text = dvui.Color.fromHex("98BC37") } }, // Green for additions
        .{ .name = "diff.minus", .opts = .{ .color_text = dvui.Color.fromHex("EF2F27") } }, // Red for deletions
        .{ .name = "diff.header", .opts = .{ .color_text = dvui.Color.fromHex("0AAEB3") } }, // Cyan for headers
        .{ .name = "diff.location", .opts = .{ .color_text = dvui.Color.fromHex("E02C6D") } }, // Magenta for location
        .{ .name = "diff.context", .opts = .{ .color_text = dvui.Color.fromHex("FCE8C3") } }, // Default for context
        .{ .name = "string", .opts = .{ .color_text = dvui.Color.fromHex("FBB829") } }, // Yellow for filenames
        .{ .name = "keyword", .opts = .{ .color_text = dvui.Color.fromHex("0AAEB3") } }, // Cyan for index
        .{ .name = "constant", .opts = .{ .color_text = dvui.Color.fromHex("918175") } }, // Gray for commit
    };
};

var count: usize = 0;

pub fn create(
    gpa: Allocator,
    format: regz.Database.Format,
    path: []const u8,
    device: ?[]const u8,
    chip_info: ?ChipInfo,
    register_schema_usages: ?[]const RegisterSchemaUsage,
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
        .format = format,
        .device = device,
        .register_schema_usages = register_schema_usages,
    };

    try db.to_zig(window.vfs.dir(), .{});

    count += 1;

    return window;
}

pub fn destroy(w: *RegzWindow) void {
    // Clean up pending_patches and deleted_patch_indices ArrayLists
    for (w.loaded_patches.values()) |*loaded| {
        loaded.pending_patches.deinit(w.gpa);
        loaded.deleted_patch_indices.deinit(w.gpa);
    }

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

    // Use a local flag for the window header close button
    // so we can intercept it and check for unsaved changes
    var header_close_flag = true;

    var float = dvui.floatingWindow(@src(), .{}, .{
        .min_size_content = .{ .w = 400, .h = 400 },
        .max_size_content = .width(400),
        .id_extra = w.id_extra,
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Regz", w.title, &header_close_flag));

    // Check if user clicked the X button
    if (!header_close_flag) {
        if (w.has_unsaved_patches) {
            w.show_unsaved_warning = true;
            // Don't actually close yet
        } else {
            w.show_window = false;
        }
    }

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

            // Save Patches - only enabled when has_unsaved_patches
            if (dvui.menuItemLabel(@src(), "Save Patches", .{}, .{
                .expand = .horizontal,
                .color_text = if (!w.has_unsaved_patches) dvui.Color.fromHex("918175") else null,
            }) != null and w.has_unsaved_patches) {
                w.save_all_patches(arena.allocator()) catch |err| {
                    w.validation_error_message = std.fmt.allocPrint(w.arena.allocator(), "Failed to save patches: {s}", .{@errorName(err)}) catch "Save failed";
                    w.show_validation_error = true;
                };
                m.close();
            }

            if (dvui.menuItemLabel(@src(), "Close", .{}, .{ .expand = .horizontal }) != null) {
                if (w.has_unsaved_patches) {
                    w.show_unsaved_warning = true;
                } else {
                    w.show_window = false;
                }
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

            if (dvui.menuItemLabel(@src(), "Analysis", .{}, .{ .expand = .horizontal }) != null) {
                w.active_view = .analysis;
                m.close();
            }
        }
    }

    switch (w.active_view) {
        .code_generation => w.show_code_generation(arena.allocator()),
        .patches => w.show_patches(arena.allocator()),
        .analysis => w.show_analysis(arena.allocator()),
    }

    // Render dialogs
    w.show_create_patch_dialog_ui(arena.allocator());
    w.show_unsaved_warning_dialog();
    w.show_validation_error_dialog();
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
        w.load_patch_files();
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

        w.show_patch_tree(arena);
    }

    // Right panel: Patch details
    {
        var scroll = dvui.scrollArea(@src(), .{}, .{ .expand = .both });
        defer scroll.deinit();

        w.show_patch_details(arena);
    }
}

fn show_analysis(w: *RegzWindow, arena: Allocator) void {
    var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .both });
    defer hbox.deinit();

    // Left panel: Peripherals tree with analysis results
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

        w.show_analysis_tree(arena);
    }

    // Right panel: Equivalence group details
    {
        var scroll = dvui.scrollArea(@src(), .{}, .{ .expand = .both });
        defer scroll.deinit();

        w.show_analysis_details(arena);
    }
}

fn show_analysis_tree(w: *RegzWindow, arena: Allocator) void {
    // Run analysis on all peripherals if not cached
    const cached = w.get_or_run_full_analysis() orelse {
        _ = dvui.label(@src(), "Error running analysis", .{}, .{
            .color_text = dvui.Color.fromHex("EF2F27"),
        });
        return;
    };

    if (cached.peripheral_results.len == 0) {
        _ = dvui.label(@src(), "No duplicate anonymous enums found", .{}, .{
            .color_text = dvui.Color.fromHex("918175"),
        });
        return;
    }

    // Header with summary
    var total_groups: usize = 0;
    for (cached.peripheral_results) |pr| {
        total_groups += pr.result.equivalence_groups.len;
    }
    _ = dvui.label(@src(), "{d} peripherals with duplicates ({d} groups total)", .{
        cached.peripheral_results.len,
        total_groups,
    }, .{
        .color_text = dvui.Color.fromHex("98BC37"),
    });
    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    var tree = dvui.TreeWidget.tree(@src(), .{}, .{
        .background = true,
        .padding = dvui.Rect.all(4),
    });
    defer tree.deinit();

    for (cached.peripheral_results, 0..) |periph_result, periph_idx| {
        const is_selected = w.selected_analysis_peripheral != null and w.selected_analysis_peripheral.? == periph_idx;

        var branch = tree.branch(@src(), .{ .expanded = is_selected }, .{ .id_extra = periph_idx });
        defer branch.deinit();

        // Peripheral icon and name with group count
        dvui.icon(@src(), "PeriphIcon", dvui.entypo.drive, .{}, .{ .gravity_y = 0.5 });
        _ = dvui.label(@src(), "{s} [{d} groups]", .{
            periph_result.peripheral_name,
            periph_result.result.equivalence_groups.len,
        }, .{});

        // Expander arrow
        dvui.icon(
            @src(),
            "DropIcon",
            if (branch.expanded) dvui.entypo.triangle_down else dvui.entypo.triangle_right,
            .{},
            .{ .gravity_y = 0.5, .gravity_x = 1.0 },
        );

        // Handle click on peripheral to select
        if (branch.button.clicked()) {
            w.selected_analysis_peripheral = periph_idx;
            w.selected_equivalence_group = null;
        }

        if (branch.expander(@src(), .{ .indent = 14 }, .{ .margin = .{ .x = 14 } })) {
            const result = periph_result.result;

            // Show each equivalence group as a selectable item
            for (result.equivalence_groups, 0..) |group, group_idx| {
                var group_branch = tree.branch(@src(), .{}, .{ .id_extra = group_idx });
                defer group_branch.deinit();

                const is_group_selected = is_selected and
                    w.selected_equivalence_group != null and
                    w.selected_equivalence_group.? == group_idx;

                // Icon for group
                dvui.icon(@src(), "GroupIcon", dvui.entypo.flow_tree, .{}, .{ .gravity_y = 0.5 });

                // Group label: "Group N (M enums)"
                _ = dvui.label(@src(), "Group {d} ({d} enums)", .{ group_idx + 1, group.members.len }, .{
                    .color_text = if (is_group_selected)
                        dvui.Color.fromHex("FBB829") // Yellow highlight
                    else
                        dvui.Color.fromHex("98BC37"), // Green
                });

                if (group_branch.button.clicked()) {
                    w.selected_analysis_peripheral = periph_idx;
                    w.selected_equivalence_group = group_idx;
                }
            }

            // Show stats
            _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });
            _ = dvui.label(@src(), "Total anonymous: {d}, Unique: {d}", .{
                result.total_anonymous_enums,
                result.unique_enums.len,
            }, .{
                .color_text = dvui.Color.fromHex("918175"),
                .id_extra = periph_idx + 10000,
            });
        }
    }
    _ = arena;
}

fn show_analysis_details(w: *RegzWindow, arena: Allocator) void {
    // Check if a peripheral and group are selected
    const periph_idx = w.selected_analysis_peripheral orelse {
        var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
            .expand = .both,
            .padding = dvui.Rect.all(16),
        });
        defer vbox.deinit();

        _ = dvui.label(@src(), "Select an equivalence group to view details", .{}, .{});
        return;
    };

    const group_idx = w.selected_equivalence_group orelse {
        var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
            .expand = .both,
            .padding = dvui.Rect.all(16),
        });
        defer vbox.deinit();

        _ = dvui.label(@src(), "Select an equivalence group to view details", .{}, .{});
        return;
    };

    // Get cached analysis result
    const cached = w.cached_analysis orelse {
        _ = dvui.label(@src(), "No analysis data available", .{}, .{});
        return;
    };

    if (periph_idx >= cached.peripheral_results.len) {
        _ = dvui.label(@src(), "Invalid peripheral selection", .{}, .{});
        return;
    }

    const periph_result = cached.peripheral_results[periph_idx];

    if (group_idx >= periph_result.result.equivalence_groups.len) {
        _ = dvui.label(@src(), "Invalid group selection", .{}, .{});
        return;
    }

    const group = periph_result.result.equivalence_groups[group_idx];

    var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
        .expand = .both,
        .padding = dvui.Rect.all(8),
    });
    defer vbox.deinit();

    // Peripheral name header
    _ = dvui.label(@src(), "{s}", .{periph_result.peripheral_name}, .{
        .font = .{ .weight = .bold },
        .color_text = dvui.Color.fromHex("FBB829"),
    });
    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });

    // Group header
    _ = dvui.label(@src(), "{d} identical anonymous enums", .{group.members.len}, .{
        .font = .{ .weight = .bold },
        .color_text = dvui.Color.fromHex("98BC37"),
    });
    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });

    // Size
    _ = dvui.label(@src(), "Size: {d} bits", .{group.size_bits}, .{});

    // Description
    if (group.description) |desc| {
        _ = dvui.label(@src(), "Description: \"{s}\"", .{desc}, .{});
    } else {
        _ = dvui.label(@src(), "Description: (none)", .{}, .{
            .color_text = dvui.Color.fromHex("918175"),
        });
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 12 } });

    // Create Patch from Group button
    const has_editable_files = w.has_editable_patch_files();
    if (has_editable_files) {
        if (dvui.button(@src(), "Create Patch from Group", .{}, .{
            .color_fill = dvui.Color.fromHex("98BC37"),
            .color_fill_hover = dvui.Color.fromHex("b8dc57"),
            .color_text = dvui.Color.fromHex("1C1B19"),
        })) {
            // Initialize pending patch creation
            w.pending_patch_creation = .{
                .peripheral_name = periph_result.peripheral_name,
                .group_idx = group_idx,
            };
            w.show_create_patch_dialog = true;
        }
    } else {
        _ = dvui.label(@src(), "(No editable patch files)", .{}, .{
            .color_text = dvui.Color.fromHex("918175"),
        });
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 12 } });

    // Fields table
    if (group.fields.len > 0) {
        _ = dvui.label(@src(), "Fields:", .{}, .{
            .font = .{ .weight = .bold },
            .color_text = dvui.Color.fromHex("FBB829"),
        });
        _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });

        const header_style: dvui.GridWidget.CellStyle = .{
            .cell_opts = .{
                .border = .{ .y = 0, .h = 1, .x = 0, .w = 0 },
            },
        };

        var grid = dvui.grid(@src(), .{ .col_widths = &w.analysis_col_widths }, .{}, .{
            .expand = .both,
            .background = true,
            .padding = dvui.Rect.all(4),
        });
        defer grid.deinit();

        // Headers with resize handles
        dvui.gridHeading(@src(), grid, 0, "Name", .{
            .sizes = &w.analysis_col_widths,
            .num = 0,
            .min_size = 60,
            .max_size = 300,
        }, header_style);
        dvui.gridHeading(@src(), grid, 1, "Value", .{
            .sizes = &w.analysis_col_widths,
            .num = 1,
            .min_size = 40,
            .max_size = 150,
        }, header_style);
        dvui.gridHeading(@src(), grid, 2, "Description", .{
            .sizes = &w.analysis_col_widths,
            .num = 2,
            .min_size = 100,
            .max_size = 500,
        }, header_style);

        // Rows
        for (group.fields, 0..) |field, row_num| {
            var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

            // Name
            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, .{});
                defer cell.deinit();
                dvui.labelNoFmt(@src(), field.name, .{}, .{});
            }

            // Value
            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, .{});
                defer cell.deinit();
                const value_str = std.fmt.allocPrint(arena, "{d}", .{field.value}) catch "?";
                dvui.labelNoFmt(@src(), value_str, .{}, .{});
            }

            // Description
            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, .{});
                defer cell.deinit();
                dvui.labelNoFmt(@src(), field.description orelse "", .{}, .{});
            }
        }
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 12 } });

    // Usages list
    if (group.usages.len > 0) {
        _ = dvui.label(@src(), "Used by:", .{}, .{
            .font = .{ .weight = .bold },
            .color_text = dvui.Color.fromHex("FBB829"),
        });
        _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });

        for (group.usages, 0..) |usage, i| {
            _ = dvui.label(@src(), "  - {s}.{s}", .{ usage.register_name, usage.field_name }, .{
                .id_extra = i,
            });
        }
    }
}

fn get_or_run_full_analysis(w: *RegzWindow) ?*const CachedAnalysis {
    // Ensure patches are loaded and applied before running analysis
    if (!w.patches_loaded) {
        w.load_patch_files();
        w.patches_loaded = true;
    }

    // Return cached if available
    if (w.cached_analysis != null) {
        return &w.cached_analysis.?;
    }

    // Run analysis on all peripherals
    const alloc = w.arena.allocator();

    const peripherals = w.db.get_peripherals(alloc) catch {
        return null;
    };

    var results: std.ArrayList(PeripheralAnalysisResult) = .empty;
    var analysis = regz.Analysis.init(w.db);

    for (peripherals) |peripheral| {
        const result = analysis.find_equivalent_enums(alloc, peripheral.id) catch {
            continue;
        };

        // Only include peripherals with equivalence groups (actionable results)
        if (result.equivalence_groups.len > 0) {
            results.append(alloc, .{
                .peripheral_name = peripheral.name,
                .result = result,
            }) catch continue;
        }
    }

    // Cache result in window's arena (persists across frames)
    w.cached_analysis = .{
        .peripheral_results = results.toOwnedSlice(alloc) catch &.{},
    };

    return &w.cached_analysis.?;
}

fn load_patch_files(w: *RegzWindow) void {
    const chip = w.chip_info orelse return;

    // Use window's arena for persistent storage across frames
    const alloc = w.arena.allocator();

    for (chip.patch_files) |pf| {
        const path_result = construct_patch_path(alloc, pf);
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
                .pending_patches = .{},
                .deleted_patch_indices = .{},
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
                .pending_patches = .{},
                .deleted_patch_indices = .{},
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
                .pending_patches = .{},
                .deleted_patch_indices = .{},
                .parse_error = error_msg,
                .is_editable = is_editable,
            }) catch {};
            continue;
        };

        // Apply patches to the database so analysis reflects them
        for (patches) |patch| {
            apply_single_patch(w.db, alloc, patch) catch continue;
        }

        const owned_path = alloc.dupe(u8, path) catch continue;
        w.loaded_patches.put(w.gpa, owned_path, .{
            .path = owned_path,
            .patches = patches,
            .pending_patches = .{},
            .deleted_patch_indices = .{},
            .is_editable = is_editable,
        }) catch {};
    }

    // Regenerate VFS and invalidate caches since patches were applied
    w.on_database_changed();
}

fn construct_patch_path(arena: Allocator, pf: RegisterSchemaUsage.PatchFile) ?[]const u8 {
    return switch (pf) {
        .src_path => |sp| std.fs.path.join(arena, &.{ sp.build_root, sp.sub_path }) catch null,
        .dependency => |dp| std.fs.path.join(arena, &.{ dp.build_root, dp.sub_path }) catch null,
    };
}

fn show_patch_tree(w: *RegzWindow, arena: Allocator) void {
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
            } else {
                // Show original patches
                if (loaded.patches) |patches| {
                    for (patches, 0..) |patch, patch_idx| {
                        const is_deleted = loaded.is_patch_deleted(patch_idx);

                        var op_branch = tree.branch(@src(), .{}, .{ .id_extra = patch_idx });
                        defer op_branch.deinit();

                        const patch_label = get_patch_label(patch, arena);

                        if (is_deleted) {
                            // Show deleted patches with strikethrough style
                            _ = dvui.label(@src(), "{s} (deleted)", .{patch_label}, .{
                                .color_text = dvui.Color.fromHex("888888"),
                            });
                        } else {
                            _ = dvui.label(@src(), "{s}", .{patch_label}, .{});
                        }

                        if (op_branch.button.clicked() and !is_deleted) {
                            w.selected_patch = .{ .file_index = file_idx, .patch_index = patch_idx };
                        }
                    }
                }

                // Show pending patches (unsaved)
                const orig_count = if (loaded.patches) |p| p.len else 0;
                for (loaded.pending_patches.items, 0..) |patch, pending_idx| {
                    const full_idx = orig_count + pending_idx;
                    var op_branch = tree.branch(@src(), .{}, .{ .id_extra = full_idx + 10000 });
                    defer op_branch.deinit();

                    const patch_label = get_patch_label(patch, arena);
                    // Show pending patches with a visual indicator
                    _ = dvui.label(@src(), "{s} (unsaved)", .{patch_label}, .{
                        .color_text = dvui.Color.fromHex("FBB829"),
                    });

                    if (op_branch.button.clicked()) {
                        w.selected_patch = .{ .file_index = file_idx, .patch_index = full_idx };
                    }
                }
            }
        }
    }
}

fn get_patch_label(patch: regz.Patch, arena: Allocator) []const u8 {
    return switch (patch) {
        .override_arch => |p| std.fmt.allocPrint(arena, "override_arch: {s}", .{p.device_name}) catch "override_arch",
        .set_device_property => |p| std.fmt.allocPrint(arena, "set_device_property: {s}", .{p.key}) catch "set_device_property",
        .add_enum => |p| std.fmt.allocPrint(arena, "add_enum: {s}", .{p.@"enum".name}) catch "add_enum",
        .set_enum_type => |p| std.fmt.allocPrint(arena, "set_enum_type: {s}", .{p.of}) catch "set_enum_type",
        .add_interrupt => |p| std.fmt.allocPrint(arena, "add_interrupt: {s}", .{p.name}) catch "add_interrupt",
        .add_enum_and_apply => |p| std.fmt.allocPrint(arena, "add_enum_and_apply: {s}", .{p.@"enum".name}) catch "add_enum_and_apply",
    };
}

fn show_patch_details(w: *RegzWindow, arena: Allocator) void {
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

    // Determine if this is an original or pending patch
    const orig_count = if (loaded.patches) |p| p.len else 0;
    const is_pending = sel.patch_index >= orig_count;

    const patch = if (is_pending) blk: {
        const pending_idx = sel.patch_index - orig_count;
        if (pending_idx >= loaded.pending_patches.items.len) return;
        break :blk loaded.pending_patches.items[pending_idx];
    } else blk: {
        const patches = loaded.patches orelse return;
        if (sel.patch_index >= patches.len) return;
        break :blk patches[sel.patch_index];
    };

    // Invalidate cache if selected patch changed
    if (w.cached_diff) |cached| {
        if (cached.file_index != sel.file_index or cached.patch_index != sel.patch_index) {
            w.cached_diff = null;
        }
    }

    var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
        .expand = .both,
        .padding = dvui.Rect.all(8),
    });
    defer vbox.deinit();

    // Header with patch type and delete button
    {
        var header = dvui.box(@src(), .{ .dir = .horizontal }, .{
            .expand = .horizontal,
        });
        defer header.deinit();

        _ = dvui.label(@src(), "Patch Type: {s}", .{get_patch_label(patch, arena)}, .{
            .font = .{ .weight = .bold },
        });

        if (is_pending) {
            _ = dvui.label(@src(), " (unsaved)", .{}, .{
                .color_text = dvui.Color.fromHex("FBB829"),
            });
        }

        // Delete button for editable files
        if (loaded.is_editable) {
            if (dvui.button(@src(), "Delete Patch", .{}, .{
                .gravity_x = 1.0,
                .color_fill = dvui.Color.fromHex("EF2F27"),
                .color_text = dvui.Color.fromHex("FFFFFF"),
            })) {
                w.delete_patch(sel.file_index, sel.patch_index, is_pending);
            }
        }
    }
    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    // Tab bar
    {
        var tab_bar = dvui.box(@src(), .{ .dir = .horizontal }, .{
            .expand = .horizontal,
            .padding = dvui.Rect.all(2),
        });
        defer tab_bar.deinit();

        // Fields tab button
        const fields_selected = w.patch_detail_tab == .fields;
        if (dvui.button(@src(), "Fields", .{}, .{
            .background = fields_selected,
            .border = if (fields_selected) dvui.Rect.all(1) else dvui.Rect.all(0),
            .padding = dvui.Rect.all(4),
        })) {
            w.patch_detail_tab = .fields;
        }

        // Diff tab button
        const diff_selected = w.patch_detail_tab == .diff;
        if (dvui.button(@src(), "Diff", .{}, .{
            .background = diff_selected,
            .border = if (diff_selected) dvui.Rect.all(1) else dvui.Rect.all(0),
            .padding = dvui.Rect.all(4),
        })) {
            w.patch_detail_tab = .diff;
        }
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    // Tab content
    switch (w.patch_detail_tab) {
        .fields => {
            switch (patch) {
                .override_arch => |p| show_override_arch_widget(p),
                .set_device_property => |p| show_set_device_property_widget(p),
                .add_enum => |p| show_add_enum_widget(p, arena),
                .set_enum_type => |p| show_set_enum_type_widget(p),
                .add_interrupt => |p| show_add_interrupt_widget(p),
                .add_enum_and_apply => |p| show_add_enum_and_apply_widget(p, arena),
            }
        },
        .diff => {
            w.show_patch_diff(arena, sel, patch);
        },
    }
}

fn show_patch_diff(w: *RegzWindow, arena: Allocator, sel: SelectedPatch, patch: regz.Patch) void {
    // Check if cache is valid
    if (w.cached_diff) |cached| {
        if (cached.file_index == sel.file_index and cached.patch_index == sel.patch_index) {
            // Display cached diff
            if (cached.error_message) |err| {
                _ = dvui.label(@src(), "Error computing diff: {s}", .{err}, .{
                    .color_text = dvui.Color.fromHex("EF2F27"),
                });
                return;
            }

            w.display_diff(cached.file_diffs, sel);
            return;
        }
    }

    // Compute new diff
    w.compute_patch_diff(arena, sel, patch);

    // Display the newly computed diff
    if (w.cached_diff) |cached| {
        if (cached.error_message) |err| {
            _ = dvui.label(@src(), "Error computing diff: {s}", .{err}, .{
                .color_text = dvui.Color.fromHex("EF2F27"),
            });
            return;
        }

        w.display_diff(cached.file_diffs, sel);
    }
}

fn display_diff(w: *RegzWindow, file_diffs: []const FileDiff, sel: SelectedPatch) void {
    if (file_diffs.len == 0) {
        _ = dvui.label(@src(), "No changes detected", .{}, .{});
        return;
    }

    // Build unified diff format text
    var diff_text: std.ArrayList(u8) = .{};
    defer diff_text.deinit(w.gpa);

    for (file_diffs) |fd| {
        // Unified diff file headers
        diff_text.appendSlice(w.gpa, "--- a/") catch continue;
        diff_text.appendSlice(w.gpa, fd.filename) catch continue;
        diff_text.append(w.gpa, '\n') catch continue;
        diff_text.appendSlice(w.gpa, "+++ b/") catch continue;
        diff_text.appendSlice(w.gpa, fd.filename) catch continue;
        diff_text.append(w.gpa, '\n') catch continue;

        // Hunk header (simplified - just use @@ -1 +1 @@)
        diff_text.appendSlice(w.gpa, "@@ -1 +1 @@\n") catch continue;

        // Diff lines
        for (fd.lines) |line| {
            const prefix: u8 = switch (line.kind) {
                .context => ' ',
                .added => '+',
                .removed => '-',
            };
            diff_text.append(w.gpa, prefix) catch continue;
            diff_text.appendSlice(w.gpa, line.text) catch continue;
            diff_text.append(w.gpa, '\n') catch continue;
        }
        diff_text.append(w.gpa, '\n') catch continue;
    }

    // Copy button at the top
    if (dvui.button(@src(), "Copy Diff", .{}, .{})) {
        dvui.clipboardTextSet(diff_text.items);
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 } });

    // Create unique ID based on selected patch to force widget recreation
    const id_extra = sel.file_index * 1000 + sel.patch_index;

    if (dvui.useTreeSitter) {
        var te: dvui.TextEntryWidget = undefined;
        te.init(@src(), .{
            .multiline = true,
            .cache_layout = true,
            .text = .{ .internal = .{ .limit = 10_000_000 } },
            .tree_sitter = .{
                .language = tree_sitter_diff(),
                .queries = diff_queries,
                .highlights = diff_highlights,
                .log_captures = false,
            },
        }, .{ .expand = .both, .id_extra = id_extra });
        defer te.deinit();

        // Always set text content on first frame of this widget (unique per patch)
        if (dvui.firstFrame(te.data().id)) {
            te.textSet(diff_text.items, false);
            te.textLayout.selection.moveCursor(0, false);
        }

        // Process only read-only events
        process_read_only_events(&te);
        te.draw();
    } else {
        // Fallback without tree-sitter - use colored labels
        for (file_diffs, 0..) |fd, file_idx| {
            _ = dvui.label(@src(), "--- {s}", .{fd.filename}, .{
                .id_extra = file_idx * 2,
                .font = .{ .weight = .bold },
                .color_text = dvui.Color.fromHex("FBB829"),
            });

            for (fd.lines, 0..) |line, line_idx| {
                const prefix: []const u8 = switch (line.kind) {
                    .context => " ",
                    .added => "+",
                    .removed => "-",
                };
                const color = switch (line.kind) {
                    .context => dvui.Color.fromHex("FCE8C3"),
                    .added => dvui.Color.fromHex("98BC37"),
                    .removed => dvui.Color.fromHex("EF2F27"),
                };
                _ = dvui.label(@src(), "{s}{s}", .{ prefix, line.text }, .{
                    .id_extra = file_idx * 10000 + line_idx,
                    .color_text = color,
                });
            }

            _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 8 }, .id_extra = file_idx * 2 + 1 });
        }
    }
}

fn compute_patch_diff(w: *RegzWindow, temp_arena: Allocator, sel: SelectedPatch, patch: regz.Patch) void {
    _ = patch; // We'll get the patch from the loaded patches instead
    // Use window's persistent arena for cached data
    const arena = w.arena.allocator();

    // Create TWO fresh databases:
    // 1. before_db - with all patches BEFORE the selected one applied
    // 2. after_db - with all patches UP TO AND INCLUDING the selected one applied

    // Create before database
    var before_db = regz.Database.create_from_path(w.gpa, w.format, w.path, w.device) catch |err| {
        w.cached_diff = .{
            .file_index = sel.file_index,
            .patch_index = sel.patch_index,
            .file_diffs = &.{},
            .error_message = std.fmt.allocPrint(arena, "Failed to create before database: {s}", .{@errorName(err)}) catch "Failed to create database",
        };
        return;
    };
    defer before_db.destroy();

    // Create after database
    var after_db = regz.Database.create_from_path(w.gpa, w.format, w.path, w.device) catch |err| {
        w.cached_diff = .{
            .file_index = sel.file_index,
            .patch_index = sel.patch_index,
            .file_diffs = &.{},
            .error_message = std.fmt.allocPrint(arena, "Failed to create after database: {s}", .{@errorName(err)}) catch "Failed to create database",
        };
        return;
    };
    defer after_db.destroy();

    // Apply patches to both databases
    // For before_db: apply all patches from files [0..sel.file_index) and patches [0..sel.patch_index) from sel.file_index
    // For after_db: apply all patches from files [0..sel.file_index] and patches [0..sel.patch_index] from sel.file_index
    const keys = w.loaded_patches.keys();
    const values = w.loaded_patches.values();

    for (keys, values, 0..) |_, loaded, file_idx| {
        const patches = loaded.patches orelse continue;

        for (patches, 0..) |p, patch_idx| {
            const is_before_selected = (file_idx < sel.file_index) or
                (file_idx == sel.file_index and patch_idx < sel.patch_index);
            const is_selected_or_before = (file_idx < sel.file_index) or
                (file_idx == sel.file_index and patch_idx <= sel.patch_index);

            // Serialize this patch
            var zon_buf: std.Io.Writer.Allocating = .init(temp_arena);
            const patch_array: []const regz.Patch = &.{p};
            std.zon.stringify.serialize(patch_array, .{}, &zon_buf.writer) catch continue;
            const zon_text = temp_arena.dupeZ(u8, zon_buf.written()) catch continue;

            var diags: std.zon.parse.Diagnostics = .{};

            // Apply to before_db if this patch comes before the selected one
            if (is_before_selected) {
                before_db.apply_patch(zon_text, &diags) catch continue;
            }

            // Apply to after_db if this patch is the selected one or comes before it
            if (is_selected_or_before) {
                diags = .{};
                after_db.apply_patch(zon_text, &diags) catch continue;
            }
        }
    }

    // Generate code for before state
    var before_vfs: VirtualFilesystem = .init(w.gpa);
    defer before_vfs.deinit();

    before_db.to_zig(before_vfs.dir(), .{}) catch |err| {
        w.cached_diff = .{
            .file_index = sel.file_index,
            .patch_index = sel.patch_index,
            .file_diffs = &.{},
            .error_message = std.fmt.allocPrint(arena, "Failed to generate before code: {s}", .{@errorName(err)}) catch "Failed to generate code",
        };
        return;
    };

    // Generate code for after state
    var after_vfs: VirtualFilesystem = .init(w.gpa);
    defer after_vfs.deinit();

    after_db.to_zig(after_vfs.dir(), .{}) catch |err| {
        w.cached_diff = .{
            .file_index = sel.file_index,
            .patch_index = sel.patch_index,
            .file_diffs = &.{},
            .error_message = std.fmt.allocPrint(arena, "Failed to generate after code: {s}", .{@errorName(err)}) catch "Failed to generate code",
        };
        return;
    };

    // Compare files and build diffs (before vs after)
    var file_diffs: std.ArrayList(FileDiff) = .{};

    // Recursively compare all files
    compare_vfs_files(arena, &before_vfs, &after_vfs, &file_diffs, .root, "") catch {
        w.cached_diff = .{
            .file_index = sel.file_index,
            .patch_index = sel.patch_index,
            .file_diffs = &.{},
            .error_message = "Failed to compare files",
        };
        return;
    };

    w.cached_diff = .{
        .file_index = sel.file_index,
        .patch_index = sel.patch_index,
        .file_diffs = file_diffs.toOwnedSlice(arena) catch &.{},
    };
}

fn compare_vfs_files(
    arena: Allocator,
    original_vfs: *VirtualFilesystem,
    patched_vfs: *VirtualFilesystem,
    file_diffs: *std.ArrayList(FileDiff),
    dir_id: VirtualFilesystem.ID,
    path_prefix: []const u8,
) !void {
    const children = try original_vfs.get_children(arena, dir_id);

    for (children) |entry| {
        const name = original_vfs.get_name(entry.id);
        const full_path = if (path_prefix.len > 0)
            try std.fmt.allocPrint(arena, "{s}/{s}", .{ path_prefix, name })
        else
            try arena.dupe(u8, name);

        switch (entry.kind) {
            .directory => {
                // Find corresponding directory in patched VFS and recurse
                const patched_children = patched_vfs.get_children(arena, .root) catch continue;
                for (patched_children) |patched_entry| {
                    if (patched_entry.kind == .directory) {
                        const patched_name = patched_vfs.get_name(patched_entry.id);
                        if (std.mem.eql(u8, patched_name, name)) {
                            try compare_vfs_files(arena, original_vfs, patched_vfs, file_diffs, entry.id, full_path);
                            break;
                        }
                    }
                }
            },
            .file => {
                const original_content = original_vfs.get_content(entry.id);

                // Find corresponding file in patched VFS by full path
                const patched_id = patched_vfs.get_file(full_path) catch continue;
                if (patched_id == null) continue;

                const patched_content = patched_vfs.get_content(patched_id.?);

                // Skip if content is identical
                if (std.mem.eql(u8, original_content, patched_content)) continue;

                // Compute line diff (original -> patched)
                const diff_lines = compute_line_diff(arena, original_content, patched_content) catch continue;

                if (diff_lines.len > 0) {
                    try file_diffs.append(arena, .{
                        .filename = full_path,
                        .lines = diff_lines,
                    });
                }
            },
        }
    }
}

fn compute_line_diff(arena: Allocator, old_content: []const u8, new_content: []const u8) ![]const DiffLine {
    var result: std.ArrayList(DiffLine) = .{};

    // Split content into lines
    var old_lines: std.ArrayList([]const u8) = .{};
    var new_lines: std.ArrayList([]const u8) = .{};

    var old_iter = std.mem.splitScalar(u8, old_content, '\n');
    while (old_iter.next()) |line| {
        try old_lines.append(arena, line);
    }

    var new_iter = std.mem.splitScalar(u8, new_content, '\n');
    while (new_iter.next()) |line| {
        try new_lines.append(arena, line);
    }

    // Use simple LCS-based diff for lines (no character encoding limitation)
    // Compute LCS indices
    const lcs = try compute_lcs(arena, old_lines.items, new_lines.items);

    // Generate diff from LCS
    var old_idx: usize = 0;
    var new_idx: usize = 0;
    var lcs_idx: usize = 0;

    while (old_idx < old_lines.items.len or new_idx < new_lines.items.len) {
        // Check if current positions match LCS
        const old_in_lcs = lcs_idx < lcs.len and old_idx == lcs[lcs_idx].old_idx;
        const new_in_lcs = lcs_idx < lcs.len and new_idx == lcs[lcs_idx].new_idx;

        if (old_in_lcs and new_in_lcs) {
            // Common line (context)
            try result.append(arena, .{
                .kind = .context,
                .text = try arena.dupe(u8, old_lines.items[old_idx]),
            });
            old_idx += 1;
            new_idx += 1;
            lcs_idx += 1;
        } else if (old_idx < old_lines.items.len and !old_in_lcs) {
            // Line only in old (removed)
            try result.append(arena, .{
                .kind = .removed,
                .text = try arena.dupe(u8, old_lines.items[old_idx]),
            });
            old_idx += 1;
        } else if (new_idx < new_lines.items.len and !new_in_lcs) {
            // Line only in new (added)
            try result.append(arena, .{
                .kind = .added,
                .text = try arena.dupe(u8, new_lines.items[new_idx]),
            });
            new_idx += 1;
        } else {
            // Should not happen, but handle gracefully
            break;
        }
    }

    return result.toOwnedSlice(arena);
}

const LCS_Entry = struct {
    old_idx: usize,
    new_idx: usize,
};

fn compute_lcs(arena: Allocator, old_lines: []const []const u8, new_lines: []const []const u8) ![]const LCS_Entry {
    const m = old_lines.len;
    const n = new_lines.len;

    if (m == 0 or n == 0) return &.{};

    // Build DP table (space optimized - only need previous row)
    // dp[j] = length of LCS ending at new_lines[j-1]
    var prev_row = try arena.alloc(usize, n + 1);
    var curr_row = try arena.alloc(usize, n + 1);
    @memset(prev_row, 0);
    @memset(curr_row, 0);

    for (old_lines, 0..) |old_line, i| {
        for (new_lines, 0..) |new_line, j| {
            if (std.mem.eql(u8, old_line, new_line)) {
                curr_row[j + 1] = prev_row[j] + 1;
            } else {
                curr_row[j + 1] = @max(prev_row[j + 1], curr_row[j]);
            }
        }
        // Swap rows
        const tmp = prev_row;
        prev_row = curr_row;
        curr_row = tmp;
        @memset(curr_row, 0);
        _ = i;
    }

    // Backtrack to find LCS (need full table for this)
    // Rebuild full table for backtracking
    var dp = try arena.alloc([]usize, m + 1);
    for (dp, 0..) |*row, i| {
        row.* = try arena.alloc(usize, n + 1);
        @memset(row.*, 0);
        _ = i;
    }

    for (old_lines, 0..) |old_line, i| {
        for (new_lines, 0..) |new_line, j| {
            if (std.mem.eql(u8, old_line, new_line)) {
                dp[i + 1][j + 1] = dp[i][j] + 1;
            } else {
                dp[i + 1][j + 1] = @max(dp[i][j + 1], dp[i + 1][j]);
            }
        }
    }

    // Backtrack
    var lcs_result: std.ArrayList(LCS_Entry) = .{};
    var i = m;
    var j = n;
    while (i > 0 and j > 0) {
        if (std.mem.eql(u8, old_lines[i - 1], new_lines[j - 1])) {
            try lcs_result.append(arena, .{ .old_idx = i - 1, .new_idx = j - 1 });
            i -= 1;
            j -= 1;
        } else if (dp[i - 1][j] > dp[i][j - 1]) {
            i -= 1;
        } else {
            j -= 1;
        }
    }

    // Reverse since we built it backwards
    std.mem.reverse(LCS_Entry, lcs_result.items);
    return lcs_result.toOwnedSlice(arena);
}

fn show_override_arch_widget(p: anytype) void {
    labeled_field("Device Name", p.device_name);
    labeled_field("Architecture", @tagName(p.arch));
}

fn show_set_device_property_widget(p: anytype) void {
    labeled_field("Device Name", p.device_name);
    labeled_field("Key", p.key);
    labeled_field("Value", p.value);
    if (p.description) |desc| labeled_field("Description", desc);
}

fn show_add_enum_widget(p: anytype, arena: Allocator) void {
    labeled_field("Parent", p.parent);
    show_enum_details(p.@"enum", arena);
}

fn show_enum_details(e: anytype, arena: Allocator) void {
    labeled_field("Name", e.name);
    if (e.description) |d| labeled_field("Description", d);
    const bitsize_str = std.fmt.allocPrint(arena, "{d}", .{e.bitsize}) catch "?";
    labeled_field("Bit Size", bitsize_str);

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

fn show_set_enum_type_widget(p: anytype) void {
    labeled_field("Of", p.of);
    labeled_field("To", p.to orelse "(null)");
}

fn show_add_interrupt_widget(p: anytype) void {
    labeled_field("Device Name", p.device_name);
    var buf: [32]u8 = undefined;
    const idx_str = std.fmt.bufPrint(&buf, "{d}", .{p.idx}) catch "?";
    labeled_field("Index", idx_str);
    labeled_field("Name", p.name);
    if (p.description) |d| labeled_field("Description", d);
}

fn show_add_enum_and_apply_widget(p: anytype, arena: Allocator) void {
    labeled_field("Parent", p.parent);
    show_enum_details(p.@"enum", arena);

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

fn labeled_field(label_text: []const u8, value: []const u8) void {
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

/// Check if there are any editable patch files loaded
fn has_editable_patch_files(w: *RegzWindow) bool {
    // Ensure patches are loaded first
    if (!w.patches_loaded) {
        w.load_patch_files();
        w.patches_loaded = true;
    }

    for (w.loaded_patches.values()) |loaded| {
        if (loaded.is_editable and loaded.parse_error == null) {
            return true;
        }
    }
    return false;
}

/// Show the create patch dialog UI
fn show_create_patch_dialog_ui(w: *RegzWindow, arena: Allocator) void {
    if (!w.show_create_patch_dialog) return;

    const pending = &(w.pending_patch_creation orelse return);

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &w.show_create_patch_dialog }, .{
        .min_size_content = .{ .w = 350, .h = 250 },
        .tag = "create_patch_dialog",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Create Patch", "", &w.show_create_patch_dialog));

    var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
        .expand = .both,
        .padding = dvui.Rect.all(12),
    });
    defer vbox.deinit();

    // Enum name input
    _ = dvui.label(@src(), "Enum Name:", .{}, .{
        .font = .{ .weight = .bold },
    });
    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 4 } });

    var te = dvui.textEntry(@src(), .{
        .text = .{ .buffer = &pending.enum_name_buffer },
    }, .{ .expand = .horizontal });
    if (dvui.firstFrame(te.data().id)) {
        dvui.focusWidget(te.data().id, null, null);
    }
    te.deinit();

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 12 } });

    // Patch file selection
    var group = dvui.radioGroup(@src(), .{}, .{ .label = .{ .text = "Select Patch File:" } });
    defer group.deinit();

    // List of patch files
    var file_idx: usize = 0;
    for (w.loaded_patches.keys(), w.loaded_patches.values()) |path, loaded| {
        defer file_idx += 1;

        const basename = std.fs.path.basename(path);
        const is_selected = pending.selected_file_index != null and pending.selected_file_index.? == file_idx;

        if (loaded.is_editable and loaded.parse_error == null) {
            // Editable file - selectable radio button
            if (dvui.radio(@src(), is_selected, basename, .{ .id_extra = file_idx })) {
                pending.selected_file_index = file_idx;
            }
        } else {
            // Read-only or has error - show as disabled label
            const label = std.fmt.allocPrint(arena, "{s} (read-only)", .{basename}) catch basename;
            _ = dvui.label(@src(), "{s}", .{label}, .{
                .color_text = dvui.Color.fromHex("918175"),
                .id_extra = file_idx,
            });
        }
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 16 } });

    // Buttons
    {
        var button_box = dvui.box(@src(), .{ .dir = .horizontal }, .{
            .expand = .horizontal,
        });
        defer button_box.deinit();

        _ = dvui.spacer(@src(), .{ .expand = .horizontal });

        // Cancel button
        if (dvui.button(@src(), "Cancel", .{}, .{})) {
            w.show_create_patch_dialog = false;
            w.pending_patch_creation = null;
        }

        _ = dvui.spacer(@src(), .{ .min_size_content = .{ .w = 8 } });

        // Create button - enabled only when name entered and file selected
        const enum_name = std.mem.sliceTo(&pending.enum_name_buffer, 0);
        const can_create = enum_name.len > 0 and pending.selected_file_index != null;

        if (dvui.button(@src(), "Create", .{}, .{
            .color_fill = if (can_create) dvui.Color.fromHex("98BC37") else dvui.Color.fromHex("5a5a5a"),
            .color_text = if (can_create) dvui.Color.fromHex("1C1B19") else dvui.Color.fromHex("918175"),
        }) and can_create) {
            // Create the patch
            w.create_patch_from_group(arena, pending.*) catch |err| {
                w.validation_error_message = std.fmt.allocPrint(w.arena.allocator(), "Failed to create patch: {s}", .{@errorName(err)}) catch "Failed to create patch";
                w.show_validation_error = true;
            };
            w.show_create_patch_dialog = false;
            w.pending_patch_creation = null;
        }
    }
}

/// Create a patch from an equivalence group
fn create_patch_from_group(w: *RegzWindow, arena: Allocator, pending: PendingPatchCreation) !void {
    // Get the cached analysis result
    const cached = w.cached_analysis orelse return error.NoAnalysis;

    // Find the peripheral result
    const periph_idx = blk: {
        for (cached.peripheral_results, 0..) |pr, i| {
            if (std.mem.eql(u8, pr.peripheral_name, pending.peripheral_name)) {
                break :blk i;
            }
        }
        return error.PeripheralNotFound;
    };

    const periph_result = cached.peripheral_results[periph_idx];
    if (pending.group_idx >= periph_result.result.equivalence_groups.len) {
        return error.GroupNotFound;
    }

    const group = periph_result.result.equivalence_groups[pending.group_idx];

    // Get the enum name from buffer
    const enum_name = std.mem.sliceTo(&pending.enum_name_buffer, 0);
    if (enum_name.len == 0) return error.EmptyEnumName;

    // Create the add_enum_and_apply patch
    const patch = try create_add_enum_and_apply_patch(
        w.arena.allocator(),
        pending.peripheral_name,
        enum_name,
        group,
    );

    // Add to the selected patch file
    const file_index = pending.selected_file_index orelse return error.NoFileSelected;
    const keys = w.loaded_patches.keys();
    if (file_index >= keys.len) return error.InvalidFileIndex;

    const path = keys[file_index];
    const loaded = w.loaded_patches.getPtr(path) orelse return error.FileNotFound;

    try loaded.pending_patches.append(w.gpa, patch);
    loaded.is_dirty = true;
    w.has_unsaved_patches = true;

    // Apply the patch to the database so analysis reflects the change
    try apply_single_patch(w.db, arena, patch);

    // Refresh all views that depend on the database
    w.on_database_changed();
}

/// Delete a patch from a patch file
fn delete_patch(w: *RegzWindow, file_idx: usize, patch_idx: usize, is_pending: bool) void {
    const keys = w.loaded_patches.keys();
    if (file_idx >= keys.len) return;

    const path = keys[file_idx];
    const loaded = w.loaded_patches.getPtr(path) orelse return;

    if (!loaded.is_editable) return;

    const orig_count = if (loaded.patches) |p| p.len else 0;

    if (is_pending) {
        // Delete from pending patches
        const pending_idx = patch_idx - orig_count;
        if (pending_idx < loaded.pending_patches.items.len) {
            _ = loaded.pending_patches.orderedRemove(pending_idx);
        }
    } else {
        // Mark original patch as deleted
        if (patch_idx < orig_count) {
            loaded.deleted_patch_indices.append(w.gpa, patch_idx) catch return;
        }
    }

    loaded.is_dirty = true;
    w.has_unsaved_patches = true;

    // Clear selected patch if it was the deleted one
    if (w.selected_patch) |sel| {
        if (sel.file_index == file_idx and sel.patch_index == patch_idx) {
            w.selected_patch = null;
        }
    }

    // Rebuild database and reapply remaining patches
    w.rebuild_database_with_patches();
}

/// Rebuild the database from scratch and reapply all non-deleted patches
fn rebuild_database_with_patches(w: *RegzWindow) void {
    // Destroy current database
    w.db.destroy();

    // Recreate database from source
    w.db = regz.Database.create_from_path(w.gpa, w.format, w.path, w.device) catch |err| {
        std.log.err("Failed to recreate database: {}", .{err});
        return;
    };

    const alloc = w.arena.allocator();

    // Reapply all non-deleted patches from all files
    for (w.loaded_patches.values()) |loaded| {
        if (loaded.patches) |patches| {
            for (patches, 0..) |patch, idx| {
                if (!loaded.is_patch_deleted(idx)) {
                    apply_single_patch(w.db, alloc, patch) catch continue;
                }
            }
        }
        // Reapply pending patches
        for (loaded.pending_patches.items) |patch| {
            apply_single_patch(w.db, alloc, patch) catch continue;
        }
    }

    // Refresh all views that depend on the database
    w.on_database_changed();
}

/// Called when the database changes (patches added/deleted)
/// Regenerates VFS and invalidates all cached views
fn on_database_changed(w: *RegzWindow) void {
    // Regenerate the virtual file system with new code
    // Deinit old VFS and create new one
    w.vfs.deinit();
    w.vfs = .init(w.gpa);
    w.db.to_zig(w.vfs.dir(), .{}) catch |err| {
        std.log.err("Failed to regenerate code: {}", .{err});
    };

    // Reset displayed file to force refresh in code view
    w.displayed_file = null;
    w.selected_file = null;

    // Invalidate cached analysis
    w.cached_analysis = null;

    // Invalidate cached diff
    w.cached_diff = null;
}

/// Create an add_enum_and_apply patch from an equivalence group
fn create_add_enum_and_apply_patch(
    alloc: Allocator,
    peripheral_name: []const u8,
    enum_name: []const u8,
    group: regz.Analysis.EnumEquivalenceGroup,
) !regz.Patch {
    // Build parent path: "types.peripherals.{peripheral_name}"
    const parent = try std.fmt.allocPrint(alloc, "types.peripherals.{s}", .{peripheral_name});

    // Get the EnumField type from the Patch type using type introspection
    const AddEnumAndApply = std.meta.TagPayload(regz.Patch, .add_enum_and_apply);
    const EnumType = @TypeOf(@as(AddEnumAndApply, undefined).@"enum");
    const EnumFieldType = std.meta.Child(@TypeOf(@as(EnumType, undefined).fields));

    // Convert fields (note: Database.EnumField.value is u64, Patch.EnumField.value is u32)
    var fields = try alloc.alloc(EnumFieldType, group.fields.len);
    for (group.fields, 0..) |field, i| {
        fields[i] = .{
            .name = try alloc.dupe(u8, field.name),
            .description = if (field.description) |d| try alloc.dupe(u8, d) else null,
            .value = @intCast(field.value),
        };
    }

    // Build apply_to paths: "types.peripherals.{peripheral}.{register}.{field}"
    var apply_to = try alloc.alloc([]const u8, group.usages.len);
    for (group.usages, 0..) |usage, i| {
        apply_to[i] = try std.fmt.allocPrint(alloc, "types.peripherals.{s}.{s}.{s}", .{
            peripheral_name,
            usage.register_name,
            usage.field_name,
        });
    }

    return .{
        .add_enum_and_apply = .{
            .parent = parent,
            .@"enum" = .{
                .name = try alloc.dupe(u8, enum_name),
                .description = if (group.description) |d| try alloc.dupe(u8, d) else null,
                .bitsize = group.size_bits,
                .fields = fields,
            },
            .apply_to = apply_to,
        },
    };
}

/// Show the unsaved warning dialog
fn show_unsaved_warning_dialog(w: *RegzWindow) void {
    if (!w.show_unsaved_warning) return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &w.show_unsaved_warning }, .{
        .min_size_content = .{ .w = 300, .h = 120 },
        .tag = "unsaved_warning_dialog",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Unsaved Changes", "", &w.show_unsaved_warning));

    var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
        .expand = .both,
        .padding = dvui.Rect.all(12),
    });
    defer vbox.deinit();

    _ = dvui.label(@src(), "You have unsaved patch changes.", .{}, .{});
    _ = dvui.label(@src(), "Do you want to save before closing?", .{}, .{});

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 16 } });

    // Buttons
    {
        var button_box = dvui.box(@src(), .{ .dir = .horizontal }, .{
            .expand = .horizontal,
        });
        defer button_box.deinit();

        _ = dvui.spacer(@src(), .{ .expand = .horizontal });

        // Save and Close button
        if (dvui.button(@src(), "Save and Close", .{}, .{
            .color_fill = dvui.Color.fromHex("98BC37"),
            .color_text = dvui.Color.fromHex("1C1B19"),
        })) {
            // Try to save
            var temp_arena: std.heap.ArenaAllocator = .init(w.gpa);
            defer temp_arena.deinit();

            w.save_all_patches(temp_arena.allocator()) catch |err| {
                w.validation_error_message = std.fmt.allocPrint(w.arena.allocator(), "Failed to save patches: {s}", .{@errorName(err)}) catch "Save failed";
                w.show_validation_error = true;
                w.show_unsaved_warning = false;
                return;
            };
            w.show_unsaved_warning = false;
            w.show_window = false;
        }

        _ = dvui.spacer(@src(), .{ .min_size_content = .{ .w = 8 } });

        // Discard button
        if (dvui.button(@src(), "Discard", .{}, .{
            .color_fill = dvui.Color.fromHex("EF2F27"),
            .color_text = dvui.Color.fromHex("FCE8C3"),
        })) {
            w.show_unsaved_warning = false;
            w.show_window = false;
        }

        _ = dvui.spacer(@src(), .{ .min_size_content = .{ .w = 8 } });

        // Cancel button
        if (dvui.button(@src(), "Cancel", .{}, .{})) {
            w.show_unsaved_warning = false;
        }
    }
}

/// Show the validation error dialog
fn show_validation_error_dialog(w: *RegzWindow) void {
    if (!w.show_validation_error) return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &w.show_validation_error }, .{
        .min_size_content = .{ .w = 350, .h = 100 },
        .tag = "validation_error_dialog",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Error", "", &w.show_validation_error));

    var vbox = dvui.box(@src(), .{ .dir = .vertical }, .{
        .expand = .both,
        .padding = dvui.Rect.all(12),
    });
    defer vbox.deinit();

    if (w.validation_error_message) |msg| {
        _ = dvui.label(@src(), "{s}", .{msg}, .{
            .color_text = dvui.Color.fromHex("EF2F27"),
        });
    }

    _ = dvui.spacer(@src(), .{ .min_size_content = .{ .h = 16 } });

    // OK button
    {
        var button_box = dvui.box(@src(), .{ .dir = .horizontal }, .{
            .expand = .horizontal,
        });
        defer button_box.deinit();

        _ = dvui.spacer(@src(), .{ .expand = .horizontal });

        if (dvui.button(@src(), "OK", .{}, .{})) {
            w.show_validation_error = false;
            w.validation_error_message = null;
        }
    }
}

/// Save all dirty patch files
fn save_all_patches(w: *RegzWindow, arena: Allocator) !void {
    // First, validate all patches against targets
    for (w.loaded_patches.keys(), w.loaded_patches.values()) |path, loaded| {
        if (!loaded.is_dirty) continue;

        // Get targets using this patch file
        const targets = w.get_targets_using_patch_file(arena, path);

        // Validate against each target
        for (targets) |target| {
            w.validate_patch_file(arena, path, target) catch |err| {
                w.validation_error_message = std.fmt.allocPrint(w.arena.allocator(), "Validation failed for target '{s}': {s}", .{ target.name, @errorName(err) }) catch "Validation failed";
                w.show_validation_error = true;
                return err;
            };
        }
    }

    // All validations passed, write files
    for (w.loaded_patches.keys()) |path| {
        const loaded = w.loaded_patches.getPtr(path) orelse continue;
        if (!loaded.is_dirty) continue;

        try w.write_patch_file(path, loaded.*);

        // Clear dirty flag and reset state
        loaded.is_dirty = false;
        loaded.pending_patches.clearRetainingCapacity();
        loaded.deleted_patch_indices.clearRetainingCapacity();
    }

    w.has_unsaved_patches = false;
}

const TargetInfo = struct {
    name: []const u8,
    rsu_idx: usize,
    chip_idx: usize,
};

/// Get all targets that use a specific patch file
fn get_targets_using_patch_file(w: *RegzWindow, arena: Allocator, patch_path: []const u8) []const TargetInfo {
    const rsus = w.register_schema_usages orelse return &.{};

    var targets: std.ArrayList(TargetInfo) = .empty;

    for (rsus, 0..) |rsu, rsu_idx| {
        for (rsu.chips, 0..) |chip, chip_idx| {
            for (chip.patch_files) |pf| {
                const pf_path = construct_patch_path(arena, pf) orelse continue;
                if (std.mem.eql(u8, pf_path, patch_path)) {
                    targets.append(arena, .{
                        .name = chip.name,
                        .rsu_idx = rsu_idx,
                        .chip_idx = chip_idx,
                    }) catch continue;
                    break;
                }
            }
        }
    }

    return targets.toOwnedSlice(arena) catch &.{};
}

/// Validate a patch file against a target by attempting to apply all patches
fn validate_patch_file(w: *RegzWindow, arena: Allocator, patch_path: []const u8, target: TargetInfo) !void {
    const rsus = w.register_schema_usages orelse return error.NoSchemaUsages;
    if (target.rsu_idx >= rsus.len) return error.InvalidTarget;

    const rsu = rsus[target.rsu_idx];

    // Create a fresh database for validation
    const build_root = switch (rsu.location) {
        inline else => |location| location.build_root,
    };
    const sub_path = switch (rsu.location) {
        inline else => |location| location.sub_path,
    };
    const schema_path = try std.fs.path.join(arena, &.{ build_root, sub_path });

    const format: regz.Database.Format = switch (rsu.format) {
        .svd => .svd,
        .atdf => .atdf,
        .embassy => .embassy,
        .targetdb => .targetdb,
    };

    const chip_name = if (target.chip_idx < rsu.chips.len) rsu.chips[target.chip_idx].name else null;

    const db = try regz.Database.create_from_path(w.gpa, format, schema_path, chip_name);
    defer db.destroy();

    // Get the loaded patch data
    const loaded = w.loaded_patches.get(patch_path) orelse return error.PatchFileNotFound;

    // Apply original patches (excluding deleted ones)
    if (loaded.patches) |patches| {
        for (patches, 0..) |patch, idx| {
            if (!loaded.is_patch_deleted(idx)) {
                try apply_single_patch(db, arena, patch);
            }
        }
    }

    // Apply pending patches
    for (loaded.pending_patches.items) |patch| {
        try apply_single_patch(db, arena, patch);
    }
}

/// Apply a single patch to a database
fn apply_single_patch(db: *regz.Database, arena: Allocator, patch: regz.Patch) !void {
    var zon_buf: std.Io.Writer.Allocating = .init(arena);
    const patch_array: []const regz.Patch = &.{patch};
    try std.zon.stringify.serialize(patch_array, .{}, &zon_buf.writer);
    const zon_text = try arena.dupeZ(u8, zon_buf.written());

    var diags: std.zon.parse.Diagnostics = .{};
    try db.apply_patch(zon_text, &diags);
}

/// Write a patch file combining original (non-deleted) and pending patches
fn write_patch_file(w: *RegzWindow, path: []const u8, loaded: LoadedPatchFile) !void {
    // Count non-deleted original patches
    var non_deleted_count: usize = 0;
    if (loaded.patches) |patches| {
        for (0..patches.len) |idx| {
            if (!loaded.is_patch_deleted(idx)) {
                non_deleted_count += 1;
            }
        }
    }

    const total_len = non_deleted_count + loaded.pending_patches.items.len;

    var all_patches = try w.gpa.alloc(regz.Patch, total_len);
    defer w.gpa.free(all_patches);

    var idx: usize = 0;
    if (loaded.patches) |patches| {
        for (patches, 0..) |p, orig_idx| {
            if (!loaded.is_patch_deleted(orig_idx)) {
                all_patches[idx] = p;
                idx += 1;
            }
        }
    }
    for (loaded.pending_patches.items) |p| {
        all_patches[idx] = p;
        idx += 1;
    }

    // Serialize to ZON
    var zon_buf: std.Io.Writer.Allocating = .init(w.arena.allocator());
    try std.zon.stringify.serialize(all_patches, .{
        .emit_default_optional_fields = false,
    }, &zon_buf.writer);

    // Write to file
    const file = try std.fs.cwd().createFile(path, .{});
    defer file.close();
    try file.writeAll(zon_buf.written());
    try file.writeAll("\n");
}

// Unit tests for line diff computation
const testing = std.testing;

test "compute_line_diff - no changes" {
    const allocator = testing.allocator;
    const content = "line1\nline2\nline3\n";
    const result = try compute_line_diff(allocator, content, content);
    defer allocator.free(result);
    for (result) |line| {
        allocator.free(line.text);
    }

    // All lines should be context (unchanged)
    try testing.expectEqual(4, result.len);
    for (result) |line| {
        try testing.expectEqual(DiffLine.Kind.context, line.kind);
    }
}

test "compute_line_diff - simple addition" {
    const allocator = testing.allocator;
    const old = "line1\nline3\n";
    const new = "line1\nline2\nline3\n";
    const result = try compute_line_diff(allocator, old, new);
    defer {
        for (result) |line| allocator.free(line.text);
        allocator.free(result);
    }

    // Should have: context(line1), added(line2), context(line3), context("")
    try testing.expectEqual(4, result.len);
    try testing.expectEqual(DiffLine.Kind.context, result[0].kind);
    try testing.expectEqualStrings("line1", result[0].text);
    try testing.expectEqual(DiffLine.Kind.added, result[1].kind);
    try testing.expectEqualStrings("line2", result[1].text);
    try testing.expectEqual(DiffLine.Kind.context, result[2].kind);
    try testing.expectEqualStrings("line3", result[2].text);
}

test "compute_line_diff - simple removal" {
    const allocator = testing.allocator;
    const old = "line1\nline2\nline3\n";
    const new = "line1\nline3\n";
    const result = try compute_line_diff(allocator, old, new);
    defer {
        for (result) |line| allocator.free(line.text);
        allocator.free(result);
    }

    // Should have: context(line1), removed(line2), context(line3), context("")
    try testing.expectEqual(4, result.len);
    try testing.expectEqual(DiffLine.Kind.context, result[0].kind);
    try testing.expectEqualStrings("line1", result[0].text);
    try testing.expectEqual(DiffLine.Kind.removed, result[1].kind);
    try testing.expectEqualStrings("line2", result[1].text);
    try testing.expectEqual(DiffLine.Kind.context, result[2].kind);
    try testing.expectEqualStrings("line3", result[2].text);
}

test "compute_line_diff - line modification" {
    const allocator = testing.allocator;
    const old = "line1\nold_line\nline3\n";
    const new = "line1\nnew_line\nline3\n";
    const result = try compute_line_diff(allocator, old, new);
    defer {
        for (result) |line| allocator.free(line.text);
        allocator.free(result);
    }

    // Should have: context(line1), removed(old_line), added(new_line), context(line3), context("")
    try testing.expectEqual(5, result.len);
    try testing.expectEqual(DiffLine.Kind.context, result[0].kind);
    try testing.expectEqual(DiffLine.Kind.removed, result[1].kind);
    try testing.expectEqualStrings("old_line", result[1].text);
    try testing.expectEqual(DiffLine.Kind.added, result[2].kind);
    try testing.expectEqualStrings("new_line", result[2].text);
    try testing.expectEqual(DiffLine.Kind.context, result[3].kind);
}

test "compute_line_diff - enum value change" {
    const allocator = testing.allocator;
    const old =
        \\const Enum = enum {
        \\    value_a,
        \\    value_b,
        \\    _,
        \\};
    ;
    const new =
        \\const Enum = enum {
        \\    value_a,
        \\    value_b,
        \\};
    ;
    const result = try compute_line_diff(allocator, old, new);
    defer {
        for (result) |line| allocator.free(line.text);
        allocator.free(result);
    }

    // Print result for debugging
    std.debug.print("\nDiff result ({d} lines):\n", .{result.len});
    for (result) |line| {
        const prefix: u8 = switch (line.kind) {
            .context => ' ',
            .added => '+',
            .removed => '-',
        };
        std.debug.print("{c}{s}\n", .{ prefix, line.text });
    }

    // Find the removed "_," line
    var found_removed = false;
    for (result) |line| {
        if (line.kind == .removed and std.mem.eql(u8, std.mem.trim(u8, line.text, " \t"), "_,")) {
            found_removed = true;
            break;
        }
    }
    try testing.expect(found_removed);
}
