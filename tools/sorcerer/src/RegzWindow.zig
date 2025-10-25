gpa: Allocator,
arena: std.heap.ArenaAllocator,
db: *regz.Database,
id_extra: usize,
title: []const u8,
show_window: bool = true,
path: []const u8,
vfs: VirtualFilesystem,
selected_file: ?VirtualFilesystem.ID = null,

const RegzWindow = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;

const regz = @import("regz");
const dvui = @import("dvui");
const VirtualFilesystem = @import("VirtualFilesystem.zig");

var count: usize = 0;

pub fn create(gpa: Allocator, format: regz.Database.Format, path: []const u8) !*RegzWindow {
    const window = try gpa.create(RegzWindow);
    errdefer gpa.destroy(window);

    var db = try regz.Database.create_from_path(gpa, format, path);
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
    };

    try db.to_zig(window.vfs.dir(), .{ .for_microzig = true });

    count += 1;

    return window;
}

pub fn destroy(w: *RegzWindow) void {
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

    var hbox = dvui.box(@src(), .{ .dir = .horizontal }, .{ .expand = .both });
    defer hbox.deinit();

    {
        const scroll_arena = dvui.scrollArea(@src(), .{}, .{});
        defer scroll_arena.deinit();

        try w.show_file_tree(
            arena.allocator(),
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
        );
    }

    const scroll_arena = dvui.scrollArea(@src(), .{}, .{});
    defer scroll_arena.deinit();

    var tl = dvui.textLayout(@src(), .{}, .{ .expand = .horizontal, .font_style = .body });
    defer tl.deinit();

    if (w.selected_file) |id|
        tl.addText(w.vfs.get_content(id), .{});
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
