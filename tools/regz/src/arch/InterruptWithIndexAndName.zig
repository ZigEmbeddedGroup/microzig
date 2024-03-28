id: EntityId,
name: []const u8,
index: i32,

const InterruptWithIndexAndName = @This();
const EntityId = @import("../Database.zig").EntityId;

pub fn less_than(
    _: void,
    lhs: InterruptWithIndexAndName,
    rhs: InterruptWithIndexAndName,
) bool {
    return lhs.index < rhs.index;
}
