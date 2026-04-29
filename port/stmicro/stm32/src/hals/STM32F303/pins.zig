const PinCommon = @import("../common/pins_v2.zig").get_pins(.{
    .portcount = 7,
});
pub const GlobalConfiguration = PinCommon.GlobalConfiguration;
