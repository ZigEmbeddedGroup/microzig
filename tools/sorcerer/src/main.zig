const std = @import("std");
const builtin = @import("builtin");
const dvui = @import("dvui");
const serial = @import("serial");
const regz = @import("regz");
const RegisterSchemaUsage = @import("RegisterSchemaUsage.zig");
const RegzWindow = @import("RegzWindow.zig");
const SrceryTheme = @import("SrceryTheme.zig");

const window_icon_png = @embedFile("zig-favicon.png");

// To be a dvui App:
// * declare "dvui_app"
// * expose the backend's main function
// * use the backend's log function
pub const dvui_app: dvui.App = .{
    .config = .{
        .options = .{
            .size = .{ .w = 800.0, .h = 600.0 },
            .min_size = .{ .w = 250.0, .h = 350.0 },
            .title = "Sorcerer",
            .icon = window_icon_png,
            .window_init_options = .{
                // Could set a default theme here
                // .theme = dvui.Theme.builtin.dracula,
            },
        },
    },
    .frameFn = AppFrame,
    .initFn = AppInit,
    .deinitFn = AppDeinit,
};
pub const main = dvui.App.main;
pub const panic = dvui.App.panic;
pub const std_options: std.Options = .{
    .logFn = dvui.App.logFn,
    .log_level = .info,
};

var gpa_instance = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = gpa_instance.allocator();
var arena: std.heap.ArenaAllocator = .init(gpa);

var state: State = .{};

const State = struct {
    orig_content_scale: f32 = 1.0,
    register_schema_path: []const u8 = "./zig-out/data/register_schemas.json",
    register_schema_usages: ?std.json.Parsed([]const RegisterSchemaUsage) = null,
    regz_windows: std.StringArrayHashMapUnmanaged(*RegzWindow) = .{},
    show_from_microzig_window: bool = false,
    show_stats_window: bool = true,
    show_search_chips_window: bool = false,
    chip_search_query: [256]u8 = [_]u8{0} ** 256,
    show_search_boards_window: bool = false,
    board_search_query: [256]u8 = [_]u8{0} ** 256,
    show_search_targets_window: bool = false,
    target_search_query: [256]u8 = [_]u8{0} ** 256,
    // Target selection popup state (for chip search)
    show_target_selection_window: bool = false,
    selected_chip_name: []const u8 = "",
    // Target selection popup state (for RSU/From MicroZig)
    show_rsu_target_selection_window: bool = false,
    selected_rsu_idx: ?usize = null,
};

// Runs before the first frame, after backend and dvui.Window.init()
// - runs between win.begin()/win.end()
pub fn AppInit(win: *dvui.Window) !void {
    state.orig_content_scale = win.content_scale;
    //try dvui.addFont("NOTO", @embedFile("../src/fonts/NotoSansKR-Regular.ttf"), null);

    // Use Srcery color scheme
    win.theme = SrceryTheme.theme;
    std.log.info("starting...", .{});
    const register_schema_file = try std.fs.cwd().openFile(state.register_schema_path, .{});
    defer register_schema_file.close();

    const text = try register_schema_file.readToEndAlloc(gpa, 1024 * 1024);
    defer gpa.free(text);

    state.register_schema_usages = try std.json.parseFromSlice([]const RegisterSchemaUsage, gpa, text, .{
        .allocate = .alloc_always,
    });

    //var it = try serial.list();
    //defer it.deinit();
    //while (try it.next()) |info| {
    //    tl2.addText(try arena.allocator().dupe(u8, info.display_name), .{});
    //    tl2.addText("\n\n", .{});
    //}
}

// Run as app is shutting down before dvui.Window.deinit()
pub fn AppDeinit() void {}

// Run each frame to do normal UI
pub fn AppFrame() !dvui.App.Result {
    return frame();
}

pub fn frame() !dvui.App.Result {
    arena.deinit();
    arena = .init(gpa);

    var scaler = dvui.scale(@src(), .{ .scale = &dvui.currentWindow().content_scale, .pinch_zoom = .global }, .{ .rect = .cast(dvui.windowRect()) });
    scaler.deinit();

    {
        var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .style = .window, .background = true, .expand = .horizontal });
        defer hbox.deinit();

        var m = dvui.menu(@src(), .horizontal, .{});
        defer m.deinit();

        if (dvui.menuItemLabel(@src(), "File", .{ .submenu = true }, .{ .tag = "first-focusable" })) |r| {
            var fw = dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            try open_register_schema_submenu(m);

            if (dvui.backend.kind != .web) {
                if (dvui.menuItemLabel(@src(), "Exit", .{}, .{ .expand = .horizontal }) != null) {
                    return .close;
                }
            }
        }

        if (dvui.menuItemLabel(@src(), "View", .{ .submenu = true }, .{})) |r| {
            var fw = dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            const stats_label = if (state.show_stats_window) "Hide Statistics" else "Show Statistics";
            if (dvui.menuItemLabel(@src(), stats_label, .{}, .{ .expand = .horizontal }) != null) {
                state.show_stats_window = !state.show_stats_window;
                m.close();
            }

            const demo_label = if (dvui.Examples.show_demo_window) "Hide Demo Window" else "Show Demo Window";
            if (dvui.menuItemLabel(@src(), demo_label, .{}, .{ .expand = .horizontal }) != null) {
                dvui.Examples.show_demo_window = !dvui.Examples.show_demo_window;
                m.close();
            }
        }
    }

    // Stats floating window
    show_stats_window();

    dvui.Examples.demo();

    from_microzig_menu();
    search_chips_window();
    search_boards_window();
    search_targets_window();
    target_selection_window();
    rsu_target_selection_window();

    for (state.regz_windows.values()) |regz_window|
        try regz_window.show();

    return .ok;
}

fn show_stats_window() void {
    if (!state.show_stats_window)
        return;

    if (state.register_schema_usages == null)
        return;

    const rsus = state.register_schema_usages.?.value;
    const stats = compute_stats(rsus);

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_stats_window }, .{
        .min_size_content = .{ .w = 250, .h = 200 },
        .tag = "stats_window",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("MicroZig Statistics", "", &state.show_stats_window));

    var scroll = dvui.scrollArea(@src(), .{}, .{ .expand = .both });
    defer scroll.deinit();

    var tl = dvui.textLayout(@src(), .{}, .{ .expand = .horizontal });
    defer tl.deinit();

    tl.format("Register Schemas: {d}\n", .{rsus.len}, .{});
    tl.format("Total Chips: {d}\n", .{stats.total_chips}, .{});
    tl.format("Total Boards: {d}\n", .{stats.total_boards}, .{});
    tl.format("Unique Ports: {d}\n", .{stats.unique_ports}, .{});
    tl.format("Chips with Patches: {d}\n\n", .{stats.chips_with_patches}, .{});

    tl.addText("Formats:\n", .{ .font = .{ .weight = .bold } });
    tl.format("  SVD: {d}\n", .{stats.svd_count}, .{});
    tl.format("  ATDF: {d}\n", .{stats.atdf_count}, .{});
    tl.format("  Embassy: {d}\n", .{stats.embassy_count}, .{});
    tl.format("  TargetDB: {d}\n", .{stats.targetdb_count}, .{});
}

const Stats = struct {
    total_chips: usize,
    total_boards: usize,
    unique_ports: usize,
    chips_with_patches: usize,
    svd_count: usize,
    atdf_count: usize,
    embassy_count: usize,
    targetdb_count: usize,
};

fn compute_stats(rsus: []const RegisterSchemaUsage) Stats {
    var stats: Stats = .{
        .total_chips = 0,
        .total_boards = 0,
        .unique_ports = 0,
        .chips_with_patches = 0,
        .svd_count = 0,
        .atdf_count = 0,
        .embassy_count = 0,
        .targetdb_count = 0,
    };

    var ports_seen = std.StringHashMap(void).init(gpa);
    defer ports_seen.deinit();

    for (rsus) |rsu| {
        stats.total_chips += rsu.chips.len;
        stats.total_boards += rsu.boards.len;

        for (rsu.chips) |chip| {
            if (chip.patch_files.len > 0) {
                stats.chips_with_patches += 1;
            }
        }

        const port_name = switch (rsu.location) {
            .src_path => |loc| loc.port_name,
            .dependency => |loc| loc.port_name,
        };
        ports_seen.put(port_name, {}) catch {};

        switch (rsu.format) {
            .svd => stats.svd_count += 1,
            .atdf => stats.atdf_count += 1,
            .embassy => stats.embassy_count += 1,
            .targetdb => stats.targetdb_count += 1,
        }
    }

    stats.unique_ports = ports_seen.count();
    return stats;
}

fn open_register_schema_submenu(m: *dvui.MenuWidget) !void {
    if (dvui.menuItemLabel(@src(), "Open Register Schema...", .{ .submenu = true }, .{ .expand = .horizontal })) |r| {
        var fw = dvui.floatingMenu(@src(), .{ .from = r }, .{});
        defer fw.deinit();

        if (dvui.menuItemLabel(@src(), "From File", .{}, .{ .expand = .horizontal }) != null) {
            m.close();
            const filename = dvui.dialogNativeFileOpen(dvui.currentWindow().arena(), .{
                .title = "dvui native file open",
                .filters = &.{ "*.svd", "*.atdf" },
                .filter_description = "images",
            }) catch |err| blk: {
                dvui.log.debug("Could not open file dialog, got {any}", .{err});
                break :blk null;
            };
            if (filename) |f| blk: {
                if (state.regz_windows.contains(f)) {
                    dvui.dialog(@src(), .{}, .{ .modal = false, .title = "Error", .ok_label = "Done", .message = "File is already currently open in a Regz window" });
                } else {
                    const extension = std.fs.path.extension(f);
                    const format: regz.Database.Format = if (std.mem.eql(u8, ".svd", extension))
                        .svd
                    else if (std.mem.eql(u8, ".atdf", extension))
                        .atdf
                    else {
                        const message = try std.fmt.allocPrint(arena.allocator(), "Extension not recognized: {s}", .{extension});
                        dvui.dialog(@src(), .{}, .{ .modal = false, .title = "Error", .ok_label = "Done", .message = message });
                        break :blk;
                    };

                    const path = try gpa.dupe(u8, f);
                    const register_schemas = if (state.register_schema_usages) |rsu| rsu.value else null;
                    const new_window = try RegzWindow.create(gpa, format, path, null, null, register_schemas);
                    errdefer new_window.destroy();

                    try state.regz_windows.put(gpa, f, new_window);
                }
            }
        }

        if (dvui.menuItemLabel(@src(), "From MicroZig", .{}, .{ .expand = .horizontal }) != null) {
            m.close();

            state.show_from_microzig_window = true;
        }

        if (dvui.menuItemLabel(@src(), "Search Chips", .{}, .{ .expand = .horizontal }) != null) {
            m.close();
            state.show_search_chips_window = true;
        }

        if (dvui.menuItemLabel(@src(), "Search Boards", .{}, .{ .expand = .horizontal }) != null) {
            m.close();
            state.show_search_boards_window = true;
        }

        if (dvui.menuItemLabel(@src(), "Search Targets", .{}, .{ .expand = .horizontal }) != null) {
            m.close();
            state.show_search_targets_window = true;
        }
    }
}

var highlight_style: dvui.GridWidget.CellStyle.HoveredRow = .{
    .cell_opts = .{
        .color_fill_hover = .gray,
        .background = true,
        .border = .{
            .y = 0,
            .h = 0,
            .x = 0,
            .w = 1,
        },
    },
};

const header_style: dvui.GridWidget.CellStyle = .{
    .cell_opts = .{
        .border = .{
            .y = 0,
            .h = 1,
            .x = 0,
            .w = 0,
        },
    },
};

fn from_microzig_menu() void {
    if (!state.show_from_microzig_window)
        return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_from_microzig_window }, .{
        .min_size_content = .{ .w = 400, .h = 400 },
        .tag = "from_microzig_window",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Open From MicroZig", "", &state.show_from_microzig_window));

    var grid = dvui.grid(@src(), .numCols(3), .{ .scroll_opts = .{ .horizontal_bar = .auto } }, .{ .expand = .both, .background = true });
    defer grid.deinit();

    const row_clicked: ?usize = blk: {
        for (dvui.events()) |*e| {
            if (!dvui.eventMatchSimple(e, grid.data())) continue;
            if (e.evt != .mouse) continue;
            const me = e.evt.mouse;
            if (me.action != .press) continue;
            if (grid.pointToCell(me.p)) |cell| {
                if (cell.col_num > 0) break :blk cell.row_num;
            }
        }
        break :blk null;
    };

    if (row_clicked) |row_num| {
        std.log.info("clicked row: {}", .{row_num});
        const register_schema = state.register_schema_usages.?.value[row_num];

        // Check if there are multiple chips/targets for this register schema
        if (register_schema.chips.len > 1) {
            // Show target selection popup
            state.selected_rsu_idx = row_num;
            state.show_rsu_target_selection_window = true;
            state.show_from_microzig_window = false;
        } else {
            // Open directly with the single chip (or no chip)
            const build_root = switch (register_schema.location) {
                inline else => |location| location.build_root,
            };
            const sub_path = switch (register_schema.location) {
                inline else => |location| location.sub_path,
            };
            const path = std.fs.path.join(gpa, &.{ build_root, sub_path }) catch unreachable;

            const format: regz.Database.Format = switch (register_schema.format) {
                .svd => .svd,
                .atdf => .atdf,
                .embassy => .embassy,
                .targetdb => .targetdb,
            };

            // Get chip info for patches (use first chip if available)
            const chip_info: ?RegzWindow.ChipInfo = if (register_schema.chips.len > 0)
                .{
                    .name = register_schema.chips[0].name,
                    .patch_files = register_schema.chips[0].patch_files,
                }
            else
                null;

            const rsus = if (state.register_schema_usages) |r| r.value else null;
            const new_window = RegzWindow.create(gpa, format, path, null, chip_info, rsus) catch unreachable;

            state.regz_windows.put(gpa, path, new_window) catch {
                new_window.destroy();
                unreachable;
            };

            // Close the "Open from MicroZig" window after successful selection
            state.show_from_microzig_window = false;
        }
    }

    dvui.gridHeading(@src(), grid, 0, "Port", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 1, "Package", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 2, "Location", .fixed, header_style);

    highlight_style.processEvents(grid);

    if (state.register_schema_usages) |rsus| {
        for (rsus.value, 0..) |rsu, row_num| {
            var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);
            switch (rsu.location) {
                .src_path => |src| {
                    {
                        defer cell_num.col_num += 1;
                        var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                        defer cell.deinit();

                        dvui.labelNoFmt(@src(), src.port_name, .{}, .{});
                    }
                    {
                        defer cell_num.col_num += 1;
                        var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                        defer cell.deinit();

                        dvui.labelNoFmt(@src(), "", .{}, .{});
                    }
                    {
                        defer cell_num.col_num += 1;
                        var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                        defer cell.deinit();

                        dvui.labelNoFmt(@src(), src.sub_path, .{}, .{});
                    }
                },
                .dependency => |dep| {
                    {
                        defer cell_num.col_num += 1;
                        var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                        defer cell.deinit();

                        dvui.labelNoFmt(@src(), dep.port_name, .{}, .{});
                    }
                    {
                        defer cell_num.col_num += 1;
                        var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                        defer cell.deinit();

                        dvui.labelNoFmt(@src(), dep.dep_name, .{}, .{});
                    }
                    {
                        defer cell_num.col_num += 1;
                        var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                        defer cell.deinit();

                        dvui.labelNoFmt(@src(), dep.sub_path, .{}, .{});
                    }
                },
            }
        }
    }
}

const ChipLocation = struct { rsu_idx: usize, chip_idx: usize };

fn search_chips_window() void {
    if (!state.show_search_chips_window)
        return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_search_chips_window }, .{
        .min_size_content = .{ .w = 500, .h = 400 },
        .tag = "search_chips_window",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Search Chips", "", &state.show_search_chips_window));

    const query = std.mem.sliceTo(&state.chip_search_query, 0);

    // Search input
    {
        var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .horizontal, .padding = dvui.Rect.all(4) });
        defer hbox.deinit();

        dvui.labelNoFmt(@src(), "Search:", .{}, .{ .gravity_y = 0.5 });

        var te = dvui.textEntry(@src(), .{
            .text = .{ .buffer = &state.chip_search_query },
        }, .{ .expand = .horizontal });
        if (dvui.firstFrame(te.data().id)) {
            dvui.focusWidget(te.data().id, null, null);
        }
        te.deinit();
    }

    // Results grid - use explicit column widths for proper alignment
    var col_widths = [_]f32{ 200, 150, 80 };
    var grid = dvui.grid(@src(), .colWidths(&col_widths), .{ .scroll_opts = .{ .horizontal_bar = .auto } }, .{ .expand = .both, .background = true });
    defer grid.deinit();

    const row_clicked: ?ChipLocation = blk: {
        for (dvui.events()) |*e| {
            if (!dvui.eventMatchSimple(e, grid.data())) continue;
            if (e.evt != .mouse) continue;
            const me = e.evt.mouse;
            if (me.action != .press) continue;
            if (grid.pointToCell(me.p)) |cell| {
                // Decode row_num to find which chip was clicked
                if (find_chip_by_row(query, cell.row_num)) |result| {
                    break :blk result;
                }
            }
        }
        break :blk null;
    };

    if (row_clicked) |clicked| {
        const rsus = state.register_schema_usages orelse return;
        if (clicked.rsu_idx >= rsus.value.len) return;
        const rsu = rsus.value[clicked.rsu_idx];
        if (clicked.chip_idx >= rsu.chips.len) return;
        const chip = rsu.chips[clicked.chip_idx];

        // Count how many targets have this chip name
        const target_count = count_targets_for_chip(chip.name);

        if (target_count > 1) {
            // Show target selection popup
            state.selected_chip_name = chip.name;
            state.show_target_selection_window = true;
            state.show_search_chips_window = false;
        } else {
            // Open directly
            open_chip_target(clicked.rsu_idx, clicked.chip_idx);
            state.show_search_chips_window = false;
        }
    }

    dvui.gridHeading(@src(), grid, 0, "Chip Name", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 1, "Port", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 2, "Format", .fixed, header_style);

    highlight_style.processEvents(grid);

    // Only show results if user has typed something
    if (query.len == 0) return;

    // Track seen chip names to avoid duplicates
    var seen_chips = std.StringHashMap(void).init(dvui.currentWindow().arena());

    const max_results: usize = 50;

    if (state.register_schema_usages) |rsus| {
        var row_num: usize = 0;
        outer: for (rsus.value) |rsu| {
            const port_name = switch (rsu.location) {
                .src_path => |loc| loc.port_name,
                .dependency => |loc| loc.port_name,
            };

            for (rsu.chips) |chip| {
                // Limit to max results
                if (row_num >= max_results) break :outer;

                // Filter by search query (case-insensitive)
                if (!contains_ignore_case(chip.name, query)) {
                    continue;
                }

                // Skip duplicate chip names
                if (seen_chips.contains(chip.name)) {
                    continue;
                }
                seen_chips.put(chip.name, {}) catch {};

                var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

                // Chip name column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    dvui.labelNoFmt(@src(), chip.name, .{}, .{});
                }

                // Port column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    dvui.labelNoFmt(@src(), port_name, .{}, .{});
                }

                // Format column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    const format_str: []const u8 = switch (rsu.format) {
                        .svd => "SVD",
                        .atdf => "ATDF",
                        .embassy => "Embassy",
                        .targetdb => "TargetDB",
                    };
                    dvui.labelNoFmt(@src(), format_str, .{}, .{});
                }

                row_num += 1;
            }
        }
    }
}

fn contains_ignore_case(haystack: []const u8, needle: []const u8) bool {
    if (needle.len > haystack.len) return false;

    var i: usize = 0;
    outer: while (i <= haystack.len - needle.len) : (i += 1) {
        for (needle, 0..) |nc, j| {
            const hc = haystack[i + j];
            if (std.ascii.toLower(hc) != std.ascii.toLower(nc)) {
                continue :outer;
            }
        }
        return true;
    }
    return false;
}

fn find_chip_by_row(query: []const u8, target_row: usize) ?ChipLocation {
    // No results if no query
    if (query.len == 0) return null;

    // Track seen chip names to match deduplication in display
    var seen_chips = std.StringHashMap(void).init(dvui.currentWindow().arena());

    const max_results: usize = 50;

    if (state.register_schema_usages) |rsus| {
        var row_num: usize = 0;
        outer: for (rsus.value, 0..) |rsu, rsu_idx| {
            for (rsu.chips, 0..) |chip, chip_idx| {
                // Limit to max results
                if (row_num >= max_results) break :outer;

                // Apply same filter
                if (!contains_ignore_case(chip.name, query)) {
                    continue;
                }

                // Skip duplicates (same as display logic)
                if (seen_chips.contains(chip.name)) {
                    continue;
                }
                seen_chips.put(chip.name, {}) catch {};

                if (row_num == target_row) {
                    return .{ .rsu_idx = rsu_idx, .chip_idx = chip_idx };
                }
                row_num += 1;
            }
        }
    }
    return null;
}

fn count_targets_for_chip(chip_name: []const u8) usize {
    const rsus = state.register_schema_usages orelse return 0;
    var count: usize = 0;
    for (rsus.value) |rsu| {
        for (rsu.chips) |chip| {
            if (std.mem.eql(u8, chip.name, chip_name)) {
                count += 1;
            }
        }
    }
    return count;
}

fn open_chip_target(rsu_idx: usize, chip_idx: usize) void {
    const rsus = state.register_schema_usages orelse return;
    if (rsu_idx >= rsus.value.len) return;

    const rsu = rsus.value[rsu_idx];
    if (chip_idx >= rsu.chips.len) return;

    const chip = rsu.chips[chip_idx];

    const build_root = switch (rsu.location) {
        inline else => |location| location.build_root,
    };
    const sub_path = switch (rsu.location) {
        inline else => |location| location.sub_path,
    };
    const path = std.fs.path.join(gpa, &.{ build_root, sub_path }) catch return;

    const format: regz.Database.Format = switch (rsu.format) {
        .svd => .svd,
        .atdf => .atdf,
        .embassy => .embassy,
        .targetdb => .targetdb,
    };

    const chip_info: RegzWindow.ChipInfo = .{
        .name = chip.name,
        .patch_files = chip.patch_files,
    };

    const new_window = RegzWindow.create(gpa, format, path, chip.name, chip_info, rsus.value) catch return;

    state.regz_windows.put(gpa, path, new_window) catch {
        new_window.destroy();
        return;
    };
}

fn target_selection_window() void {
    if (!state.show_target_selection_window)
        return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_target_selection_window }, .{
        .min_size_content = .{ .w = 400, .h = 300 },
        .tag = "target_selection_window",
    });
    defer float.deinit();

    const title = std.fmt.allocPrint(dvui.currentWindow().arena(), "Select Target for {s}", .{state.selected_chip_name}) catch "Select Target";
    float.dragAreaSet(dvui.windowHeader(title, "", &state.show_target_selection_window));

    // Results grid
    var col_widths = [_]f32{350};
    var grid = dvui.grid(@src(), .colWidths(&col_widths), .{ .scroll_opts = .{ .horizontal_bar = .auto } }, .{ .expand = .both, .background = true });
    defer grid.deinit();

    const row_clicked: ?TargetLocation = blk: {
        for (dvui.events()) |*e| {
            if (!dvui.eventMatchSimple(e, grid.data())) continue;
            if (e.evt != .mouse) continue;
            const me = e.evt.mouse;
            if (me.action != .press) continue;
            if (grid.pointToCell(me.p)) |cell| {
                if (find_target_by_row(state.selected_chip_name, cell.row_num)) |result| {
                    break :blk result;
                }
            }
        }
        break :blk null;
    };

    if (row_clicked) |clicked| {
        open_chip_target(clicked.rsu_idx, clicked.chip_idx);
        state.show_target_selection_window = false;
    }

    dvui.gridHeading(@src(), grid, 0, "Target", .fixed, header_style);

    highlight_style.processEvents(grid);

    const rsus = state.register_schema_usages orelse return;
    var row_num: usize = 0;

    for (rsus.value) |rsu| {
        for (rsu.chips) |chip| {
            if (!std.mem.eql(u8, chip.name, state.selected_chip_name)) {
                continue;
            }

            var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

            {
                defer cell_num.col_num += 1;
                var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                defer cell.deinit();
                dvui.labelNoFmt(@src(), chip.target_name, .{}, .{});
            }

            row_num += 1;
        }
    }
}

fn find_target_by_row(chip_name: []const u8, target_row: usize) ?TargetLocation {
    const rsus = state.register_schema_usages orelse return null;
    var row_num: usize = 0;

    for (rsus.value, 0..) |rsu, rsu_idx| {
        for (rsu.chips, 0..) |chip, chip_idx| {
            if (!std.mem.eql(u8, chip.name, chip_name)) {
                continue;
            }

            if (row_num == target_row) {
                return .{ .rsu_idx = rsu_idx, .chip_idx = chip_idx };
            }
            row_num += 1;
        }
    }
    return null;
}

fn rsu_target_selection_window() void {
    if (!state.show_rsu_target_selection_window)
        return;

    const rsu_idx = state.selected_rsu_idx orelse return;
    const rsus = state.register_schema_usages orelse return;
    if (rsu_idx >= rsus.value.len) return;
    const rsu = rsus.value[rsu_idx];

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_rsu_target_selection_window }, .{
        .min_size_content = .{ .w = 400, .h = 300 },
        .tag = "rsu_target_selection_window",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Select Target", "", &state.show_rsu_target_selection_window));

    // Results grid
    var col_widths = [_]f32{350};
    var grid = dvui.grid(@src(), .colWidths(&col_widths), .{ .scroll_opts = .{ .horizontal_bar = .auto } }, .{ .expand = .both, .background = true });
    defer grid.deinit();

    const row_clicked: ?usize = blk: {
        for (dvui.events()) |*e| {
            if (!dvui.eventMatchSimple(e, grid.data())) continue;
            if (e.evt != .mouse) continue;
            const me = e.evt.mouse;
            if (me.action != .press) continue;
            if (grid.pointToCell(me.p)) |cell| {
                break :blk cell.row_num;
            }
        }
        break :blk null;
    };

    if (row_clicked) |chip_idx| {
        if (chip_idx < rsu.chips.len) {
            open_chip_target(rsu_idx, chip_idx);
            state.show_rsu_target_selection_window = false;
            state.selected_rsu_idx = null;
        }
    }

    dvui.gridHeading(@src(), grid, 0, "Target", .fixed, header_style);

    highlight_style.processEvents(grid);

    for (rsu.chips, 0..) |chip, row_num| {
        var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

        {
            defer cell_num.col_num += 1;
            var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
            defer cell.deinit();
            dvui.labelNoFmt(@src(), chip.target_name, .{}, .{});
        }
    }
}

const BoardLocation = struct { rsu_idx: usize, board_idx: usize };
const TargetLocation = struct { rsu_idx: usize, chip_idx: usize };

fn search_boards_window() void {
    if (!state.show_search_boards_window)
        return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_search_boards_window }, .{
        .min_size_content = .{ .w = 500, .h = 400 },
        .tag = "search_boards_window",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Search Boards", "", &state.show_search_boards_window));

    const query = std.mem.sliceTo(&state.board_search_query, 0);

    // Search input
    {
        var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .horizontal, .padding = dvui.Rect.all(4) });
        defer hbox.deinit();

        dvui.labelNoFmt(@src(), "Search:", .{}, .{ .gravity_y = 0.5 });

        var te = dvui.textEntry(@src(), .{
            .text = .{ .buffer = &state.board_search_query },
        }, .{ .expand = .horizontal });
        if (dvui.firstFrame(te.data().id)) {
            dvui.focusWidget(te.data().id, null, null);
        }
        te.deinit();
    }

    // Results grid - use explicit column widths for proper alignment
    var col_widths = [_]f32{ 200, 150, 80 };
    var grid = dvui.grid(@src(), .colWidths(&col_widths), .{ .scroll_opts = .{ .horizontal_bar = .auto } }, .{ .expand = .both, .background = true });
    defer grid.deinit();

    const row_clicked: ?BoardLocation = blk: {
        for (dvui.events()) |*e| {
            if (!dvui.eventMatchSimple(e, grid.data())) continue;
            if (e.evt != .mouse) continue;
            const me = e.evt.mouse;
            if (me.action != .press) continue;
            if (grid.pointToCell(me.p)) |cell| {
                if (find_board_by_row(query, cell.row_num)) |result| {
                    break :blk result;
                }
            }
        }
        break :blk null;
    };

    if (row_clicked) |clicked| {
        open_board(clicked.rsu_idx, clicked.board_idx);
        state.show_search_boards_window = false;
    }

    dvui.gridHeading(@src(), grid, 0, "Board Name", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 1, "Port", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 2, "Format", .fixed, header_style);

    highlight_style.processEvents(grid);

    // Only show results if user has typed something
    if (query.len == 0) return;

    // Track seen board names to avoid duplicates
    var seen_boards = std.StringHashMap(void).init(dvui.currentWindow().arena());

    const max_results: usize = 50;

    if (state.register_schema_usages) |rsus| {
        var row_num: usize = 0;
        outer: for (rsus.value) |rsu| {
            const port_name = switch (rsu.location) {
                .src_path => |loc| loc.port_name,
                .dependency => |loc| loc.port_name,
            };

            for (rsu.boards) |board| {
                // Limit to max results
                if (row_num >= max_results) break :outer;

                // Filter by search query (case-insensitive)
                if (!contains_ignore_case(board.name, query)) {
                    continue;
                }

                // Skip duplicate board names
                if (seen_boards.contains(board.name)) {
                    continue;
                }
                seen_boards.put(board.name, {}) catch {};

                var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

                // Board name column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    dvui.labelNoFmt(@src(), board.name, .{}, .{});
                }

                // Port column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    dvui.labelNoFmt(@src(), port_name, .{}, .{});
                }

                // Format column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    const format_str: []const u8 = switch (rsu.format) {
                        .svd => "SVD",
                        .atdf => "ATDF",
                        .embassy => "Embassy",
                        .targetdb => "TargetDB",
                    };
                    dvui.labelNoFmt(@src(), format_str, .{}, .{});
                }

                row_num += 1;
            }
        }
    }
}

fn find_board_by_row(query: []const u8, target_row: usize) ?BoardLocation {
    // No results if no query
    if (query.len == 0) return null;

    // Track seen board names to match deduplication in display
    var seen_boards = std.StringHashMap(void).init(dvui.currentWindow().arena());

    const max_results: usize = 50;

    if (state.register_schema_usages) |rsus| {
        var row_num: usize = 0;
        outer: for (rsus.value, 0..) |rsu, rsu_idx| {
            for (rsu.boards, 0..) |board, board_idx| {
                // Limit to max results
                if (row_num >= max_results) break :outer;

                // Apply same filter
                if (!contains_ignore_case(board.name, query)) {
                    continue;
                }

                // Skip duplicates (same as display logic)
                if (seen_boards.contains(board.name)) {
                    continue;
                }
                seen_boards.put(board.name, {}) catch {};

                if (row_num == target_row) {
                    return .{ .rsu_idx = rsu_idx, .board_idx = board_idx };
                }
                row_num += 1;
            }
        }
    }
    return null;
}

fn open_board(rsu_idx: usize, board_idx: usize) void {
    const rsus = state.register_schema_usages orelse return;
    if (rsu_idx >= rsus.value.len) return;

    const rsu = rsus.value[rsu_idx];
    if (board_idx >= rsu.boards.len) return;

    // Boards don't have their own chip info, so we use the first chip from the schema if available
    const chip_info: ?RegzWindow.ChipInfo = if (rsu.chips.len > 0)
        .{
            .name = rsu.chips[0].name,
            .patch_files = rsu.chips[0].patch_files,
        }
    else
        null;

    const build_root = switch (rsu.location) {
        inline else => |location| location.build_root,
    };
    const sub_path = switch (rsu.location) {
        inline else => |location| location.sub_path,
    };
    const path = std.fs.path.join(gpa, &.{ build_root, sub_path }) catch return;

    const format: regz.Database.Format = switch (rsu.format) {
        .svd => .svd,
        .atdf => .atdf,
        .embassy => .embassy,
        .targetdb => .targetdb,
    };

    const new_window = RegzWindow.create(gpa, format, path, null, chip_info, rsus.value) catch return;

    state.regz_windows.put(gpa, path, new_window) catch {
        new_window.destroy();
        return;
    };
}

fn search_targets_window() void {
    if (!state.show_search_targets_window)
        return;

    var float = dvui.floatingWindow(@src(), .{ .open_flag = &state.show_search_targets_window }, .{
        .min_size_content = .{ .w = 500, .h = 400 },
        .tag = "search_targets_window",
    });
    defer float.deinit();

    float.dragAreaSet(dvui.windowHeader("Search Targets", "", &state.show_search_targets_window));

    const query = std.mem.sliceTo(&state.target_search_query, 0);

    // Search input
    {
        var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .horizontal, .padding = dvui.Rect.all(4) });
        defer hbox.deinit();

        dvui.labelNoFmt(@src(), "Search:", .{}, .{ .gravity_y = 0.5 });

        var te = dvui.textEntry(@src(), .{
            .text = .{ .buffer = &state.target_search_query },
        }, .{ .expand = .horizontal });
        if (dvui.firstFrame(te.data().id)) {
            dvui.focusWidget(te.data().id, null, null);
        }
        te.deinit();
    }

    // Results grid - use explicit column widths for proper alignment
    var col_widths = [_]f32{ 280, 100, 80 };
    var grid = dvui.grid(@src(), .colWidths(&col_widths), .{ .scroll_opts = .{ .horizontal_bar = .auto } }, .{ .expand = .both, .background = true });
    defer grid.deinit();

    const row_clicked: ?TargetLocation = blk: {
        for (dvui.events()) |*e| {
            if (!dvui.eventMatchSimple(e, grid.data())) continue;
            if (e.evt != .mouse) continue;
            const me = e.evt.mouse;
            if (me.action != .press) continue;
            if (grid.pointToCell(me.p)) |cell| {
                if (find_target_by_query_row(query, cell.row_num)) |result| {
                    break :blk result;
                }
            }
        }
        break :blk null;
    };

    if (row_clicked) |clicked| {
        open_chip_target(clicked.rsu_idx, clicked.chip_idx);
        state.show_search_targets_window = false;
    }

    dvui.gridHeading(@src(), grid, 0, "Target", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 1, "Chip", .fixed, header_style);
    dvui.gridHeading(@src(), grid, 2, "Format", .fixed, header_style);

    highlight_style.processEvents(grid);

    // Only show results if user has typed something
    if (query.len == 0) return;

    const max_results: usize = 50;

    if (state.register_schema_usages) |rsus| {
        var row_num: usize = 0;
        outer: for (rsus.value) |rsu| {
            for (rsu.chips) |chip| {
                // Limit to max results
                if (row_num >= max_results) break :outer;

                // Filter by search query on target_name (case-insensitive)
                if (!contains_ignore_case(chip.target_name, query)) {
                    continue;
                }

                var cell_num: dvui.GridWidget.Cell = .colRow(0, row_num);

                // Target name column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    dvui.labelNoFmt(@src(), chip.target_name, .{}, .{});
                }

                // Chip name column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    dvui.labelNoFmt(@src(), chip.name, .{}, .{});
                }

                // Format column
                {
                    defer cell_num.col_num += 1;
                    var cell = grid.bodyCell(@src(), cell_num, highlight_style.cellOptions(cell_num));
                    defer cell.deinit();
                    const format_str: []const u8 = switch (rsu.format) {
                        .svd => "SVD",
                        .atdf => "ATDF",
                        .embassy => "Embassy",
                        .targetdb => "TargetDB",
                    };
                    dvui.labelNoFmt(@src(), format_str, .{}, .{});
                }

                row_num += 1;
            }
        }
    }
}

fn find_target_by_query_row(query: []const u8, target_row: usize) ?TargetLocation {
    // No results if no query
    if (query.len == 0) return null;

    const max_results: usize = 50;

    if (state.register_schema_usages) |rsus| {
        var row_num: usize = 0;
        outer: for (rsus.value, 0..) |rsu, rsu_idx| {
            for (rsu.chips, 0..) |chip, chip_idx| {
                // Limit to max results
                if (row_num >= max_results) break :outer;

                // Apply same filter
                if (!contains_ignore_case(chip.target_name, query)) {
                    continue;
                }

                if (row_num == target_row) {
                    return .{ .rsu_idx = rsu_idx, .chip_idx = chip_idx };
                }
                row_num += 1;
            }
        }
    }
    return null;
}
