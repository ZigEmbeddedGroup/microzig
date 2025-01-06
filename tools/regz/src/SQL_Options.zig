primary_key: ?PrimaryKey = null,
foreign_keys: []const ForeignKey = &.{},
unique_constraints: []const Unique = &.{},

pub const Unique = []const []const u8;

pub const PrimaryKey = struct {
    name: []const u8,
    autoincrement: bool = false,
};

pub const On = enum {
    no_action,
    restrict,
    cascade,
    set_null,
    set_default,

    pub fn to_string(on: On) []const u8 {
        return switch (on) {
            .no_action => "NO ACTION",
            .restrict => "RESTRICT",
            .cascade => "CASCADE",
            .set_null => "SET NULL",
            .set_default => "SET DEFAULT",
        };
    }
};

pub const ForeignKey = struct {
    name: []const u8,
    on_delete: On = .no_action,
    on_update: On = .no_action,
};
