const Database = @import("Database.zig");
const xml = @import("xml.zig");

pub fn load_into_db(db: *Database, doc: xml.Doc) !void {
    _ = db;
    _ = doc;
}
