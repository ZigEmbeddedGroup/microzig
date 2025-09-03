const std = @import("std");
const regz = @import("regz");
const dvui = @import("dvui");
const VirtualFilesystem = @import("VirtualFilesystem.zig");

const window_icon_png = @embedFile("zig-favicon.png");

pub const dvui_app: dvui.App = .{
    .config = .{
        .options = .{
            .size = .{ .w = 800.0, .h = 600.0 },
            .min_size = .{ .w = 250.0, .h = 350.0 },
            .title = "Regz Wizard",
            .icon = window_icon_png,
        },
    },
    .frameFn = frame,
    .initFn = init,
    .deinitFn = deinit,
};

pub const main = dvui.App.main;
pub const panic = dvui.App.panic;
pub const std_options: std.Options = .{
    .logFn = dvui.App.logFn,
};

var db: ?*regz.Database = null;
var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
const gpa = debug_allocator.allocator();
var vfs: VirtualFilesystem = undefined;
var current_gen_file: usize = 0;

pub fn init(win: *dvui.Window) anyerror!void {
    _ = win;
    vfs = .init(gpa);
}

// Run as app is shutting down before dvui.Window.deinit()
pub fn deinit() void {
    if (db) |d| d.destroy();
    vfs.deinit();
    _ = debug_allocator.deinit();
}

// TODO: add mechanism to open a file, this creates a brand new db instance.
// - Some sort of menu bar
// - File -> Drop down

// Run each frame to do normal UI
pub fn frame() !dvui.App.Result {
    var scaler = dvui.scale(@src(), .{ .scale = &dvui.currentWindow().content_scale, .pinch_zoom = .global }, .{ .rect = .cast(dvui.windowRect()) });
    defer scaler.deinit();

    var scroll = dvui.scrollArea(@src(), .{}, .{
        .expand = .both,
    });
    defer scroll.deinit();

    var vbox = try dvui.box(@src(), .{ .vertical = true }, .{ .expand = .both, .margin = .{ .x = 4 } });
    defer vbox.deinit();

    {
        var m = try dvui.menu(@src(), .horizontal, .{});
        defer m.deinit();

        if (try dvui.menuItemLabel(@src(), "File", .{ .submenu = true }, .{ .expand = .horizontal })) |r| {
            var fw = try dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            if (try dvui.menuItemLabel(@src(), "Open", .{}, .{}) != null) blk: {
                defer fw.close();
                const filename = try dvui.dialogNativeFileOpen(dvui.currentWindow().arena(), .{ .title = "dvui native file open", .filters = &.{ "*.svd", "*.atdf" }, .filter_description = "images" });
                if (filename) |f| {
                    const ext = std.fs.path.extension(f);
                    const format: regz.Database.Format = if (std.mem.eql(u8, ext, ".svd"))
                        .svd
                    else if (std.mem.eql(u8, ext, ".atdf"))
                        .atdf
                    else
                        break :blk;

                    if (db) |d| d.destroy();

                    vfs.deinit();
                    vfs = .init(gpa);

                    db = try regz.Database.create_from_path(gpa, format, f);
                    try db.?.to_zig(vfs.dir(), .{ .for_microzig = true });
                }
            }

            if (try dvui.menuItemLabel(@src(), "Exit", .{}, .{})) |_| {
                return .close;
            }
        }

        if (db != null) if (try dvui.menuItemLabel(@src(), "Edit", .{ .submenu = true }, .{ .expand = .horizontal })) |r| {
            var fw = try dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            if (try dvui.menuItemLabel(@src(), "Apply Patches", .{}, .{})) |_| {
                defer fw.close();

                const filename = try dvui.dialogNativeFileOpen(dvui.currentWindow().arena(), .{ .title = "dvui native file open", .filters = &.{"*.json"}, .filter_description = "images" });
                _ = filename;
            }
        };

        if (try dvui.menuItemLabel(@src(), "View", .{ .submenu = true }, .{ .expand = .horizontal })) |r| {
            var fw = try dvui.floatingMenu(@src(), .{ .from = r }, .{});
            defer fw.deinit();

            if (try dvui.menuItemLabel(@src(), "Demo Window", .{}, .{})) |_| {
                dvui.Examples.show_demo_window = true;
                fw.close();
            }
        }
    }

    // look at demo() for examples of dvui widgets, shows in a floating window
    try dvui.Examples.demo();

    if (db != null) {
        const entries = vfs.map.keys();
        _ = try dvui.dropdown(@src(), entries, &current_gen_file, .{});

        const current = entries[current_gen_file];

        var font = dvui.themeGet().font_body;
        font.name = "VeraMono";

        var tl = dvui.TextLayoutWidget.init(@src(), .{}, .{ .expand = .horizontal, .font = font });
        try tl.install(.{});
        defer tl.deinit();

        try tl.addText(vfs.map.get(current).?, .{
            .font = font,
        });
    }

    return .ok;
}
