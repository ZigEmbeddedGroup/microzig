const std = @import("std");
const xml = @import("xml");
const Database = @import("Database");

const allocator = std.testing.allocator;
const expectEqual = std.testing.expectEqual;

test "cmsis example" {
    const text = @embedFile("svd/cmsis-example.svd");
    const doc: *xml.Doc = try xml.readFromMemory(text);
    defer xml.freeDoc(doc);

    var db = try Database.initFromSvd(allocator, doc);
    defer db.deinit();

    // CPU is not populated in this svd file
    try expectEqual(@as(@TypeOf(db.cpu), null), db.cpu);
}
