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

            if (dvui.menuItemLabel(@src(), "Close Menu", .{}, .{ .expand = .horizontal }) != null) {
                m.close();
            }

            if (dvui.backend.kind != .web) {
                if (dvui.menuItemLabel(@src(), "Exit", .{}, .{ .expand = .horizontal }) != null) {
                    return .close;
                }
            }
        }
    }

    var scroll = dvui.scrollArea(@src(), .{}, .{ .expand = .both, .style = .window });
    defer scroll.deinit();

    var tl = dvui.textLayout(@src(), .{}, .{ .expand = .horizontal });
    const lorem = "This is a dvui.App example that can compile on multiple backends.";
    tl.addText(lorem, .{});
    tl.addText("\n\n", .{});
    tl.format("Current backend: {s}", .{@tagName(dvui.backend.kind)}, .{});
    if (dvui.backend.kind == .web) {
        tl.format(" : {s}", .{if (dvui.backend.wasm.wasm_about_webgl2() == 1) "webgl2" else "webgl (no mipmaps)"}, .{});
    }

    tl.deinit();

    var tl2 = dvui.textLayout(@src(), .{}, .{ .expand = .horizontal });

    tl2.addText(
        \\DVUI
        \\- paints the entire window
        \\- can show floating windows and dialogs
        \\- rest of the window is a scroll area
    , .{});
    tl2.addText("\n\n", .{});
    tl2.addText("Framerate is variable and adjusts as needed for input events and animations.", .{});
    tl2.addText("\n\n", .{});
    tl2.addText("Framerate is capped by vsync.", .{});
    tl2.addText("\n\n", .{});
    tl2.addText("Cursor is always being set by dvui.", .{});
    tl2.addText("\n\n", .{});

    if (dvui.useFreeType) {
        tl2.addText("Fonts are being rendered by FreeType 2.", .{});
    } else {
        tl2.addText("Fonts are being rendered by stb_truetype.", .{});
    }
    tl2.deinit();

    const label = if (dvui.Examples.show_demo_window) "Hide Demo Window" else "Show Demo Window";
    if (dvui.button(@src(), label, .{}, .{ .tag = "show-demo-btn" })) {
        dvui.Examples.show_demo_window = !dvui.Examples.show_demo_window;
    }

    if (dvui.button(@src(), "Debug Window", .{}, .{})) {
        dvui.toggleDebugWindow();
    }

    {
        var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{});
        defer hbox.deinit();
        dvui.label(@src(), "Pinch Zoom or Scale", .{}, .{});
        if (dvui.buttonIcon(@src(), "plus", dvui.entypo.plus, .{}, .{}, .{})) {
            dvui.currentWindow().content_scale *= 1.1;
        }

        if (dvui.buttonIcon(@src(), "minus", dvui.entypo.minus, .{}, .{}, .{})) {
            dvui.currentWindow().content_scale /= 1.1;
        }

        if (dvui.currentWindow().content_scale != state.orig_content_scale) {
            if (dvui.button(@src(), "Reset Scale", .{}, .{})) {
                dvui.currentWindow().content_scale = state.orig_content_scale;
            }
        }
    }

    dvui.Examples.demo();

    from_microzig_menu();

    for (state.regz_windows.values()) |regz_window|
        try regz_window.show();

    return .ok;
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
                    const new_window = try RegzWindow.create(gpa, format, path, null);
                    errdefer new_window.destroy();

                    try state.regz_windows.put(gpa, f, new_window);
                }
            }
        }

        if (dvui.menuItemLabel(@src(), "From MicroZig", .{}, .{ .expand = .horizontal }) != null) {
            m.close();

            state.show_from_microzig_window = true;
        }

        if (dvui.menuItemLabel(@src(), "Search Chips", .{}, .{ .expand = .horizontal }) != null) {}

        if (dvui.menuItemLabel(@src(), "Search Boards", .{}, .{ .expand = .horizontal }) != null) {}

        if (dvui.menuItemLabel(@src(), "Close Menu", .{}, .{ .expand = .horizontal }) != null) {
            fw.close();
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

        const new_window = RegzWindow.create(gpa, format, path, null) catch unreachable;

        state.regz_windows.put(gpa, path, new_window) catch {
            new_window.destroy();
            unreachable;
        };
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
