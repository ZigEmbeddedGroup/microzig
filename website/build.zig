const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) !void {
    b.getInstallStep().dependOn(&zine.website(b, .{}).step);

    const serve = b.step("serve", "Start the Zine dev server");
    const run_zine = zine.serve(b, .{});
    serve.dependOn(&run_zine.step);
}
