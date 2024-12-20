const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) void {
    zine.website(b, .{
        .title = "Zig Embedded Group",
        .host_url = "https://ZigEmbeddedGroup/github.io/microzig",
        .content_dir_path = "content",
        .layouts_dir_path = "layouts",
        .assets_dir_path = "assets",
        //.output_path_prefix = "www",
    });
}
