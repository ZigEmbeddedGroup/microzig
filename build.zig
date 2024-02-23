const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) !void {
    // zine.scriptyReferenceDocs(b, "content/documentation/scripty/index.md");
    try zine.addWebsite(b, .{
        .layouts_dir_path = "layouts",
        .content_dir_path = "content",
        .static_dir_path = "static",
        .site = .{
            .base_url = "https://microzig.tech",
            .title = "Zig Embedded Group",
        },
    });
}
