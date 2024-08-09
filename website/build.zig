const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) void {
    // zine.scriptyReferenceDocs(b, "content/documentation/scripty/index.md");
    zine.website(b, .{
        .layouts_dir_path = "layouts",
        .content_dir_path = "content",
        .static_dir_path = "static",
        .host_url = "https://microzig.tech",
        .title = "Zig Embedded Group",
    });
}
