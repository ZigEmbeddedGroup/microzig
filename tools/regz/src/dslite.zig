const Database = @import("Database.zig");
const xml = @import("xml.zig");

pub fn loadIntoDb(db: *Database, doc: xml.Doc) !void {
    _ = db;
    _ = doc;
}
