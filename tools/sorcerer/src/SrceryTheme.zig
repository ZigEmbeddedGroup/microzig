const dvui = @import("dvui");

// Srcery color palette from srcery-vim commit 38f52ba
// https://github.com/srcery-colors/srcery-vim
pub const black = dvui.Color.fromHex("1C1B19");
pub const red = dvui.Color.fromHex("EF2F27");
pub const green = dvui.Color.fromHex("519F50");
pub const yellow = dvui.Color.fromHex("FBB829");
pub const blue = dvui.Color.fromHex("2C78BF");
pub const magenta = dvui.Color.fromHex("E02C6D");
pub const cyan = dvui.Color.fromHex("0AAEB3");
pub const white = dvui.Color.fromHex("BAA67F");

pub const bright_black = dvui.Color.fromHex("918175");
pub const bright_red = dvui.Color.fromHex("F75341");
pub const bright_green = dvui.Color.fromHex("98BC37");
pub const bright_yellow = dvui.Color.fromHex("FED06E");
pub const bright_blue = dvui.Color.fromHex("68A8E4");
pub const bright_magenta = dvui.Color.fromHex("FF5C8F");
pub const bright_cyan = dvui.Color.fromHex("2BE4D0");
pub const bright_white = dvui.Color.fromHex("FCE8C3");

pub const orange = dvui.Color.fromHex("FF5F00");
pub const bright_orange = dvui.Color.fromHex("FF8700");

// Hard contrast background variants
pub const hard_black = dvui.Color.fromHex("121212");
pub const xgray1 = dvui.Color.fromHex("262626");
pub const xgray2 = dvui.Color.fromHex("303030");
pub const xgray3 = dvui.Color.fromHex("3A3A3A");
pub const xgray4 = dvui.Color.fromHex("444444");
pub const xgray5 = dvui.Color.fromHex("4E4E4E");
pub const xgray6 = dvui.Color.fromHex("585858");

pub const theme: dvui.Theme = blk: {
    @setEvalBranchQuota(5000);
    break :blk .{
        .name = "Srcery",
        .dark = true,

        .font_body = .find(.{ .family = "Vera" }),
        .font_heading = .find(.{ .family = "Vera", .weight = .bold }),
        .font_title = .find(.{ .family = "Vera", .size = 20 }),
        .font_mono = .find(.{ .family = "Vera" }),

        .focus = cyan,
        .text_select = xgray5, // Visual selection background in srcery-vim
        .fill = black,
        .text = bright_white,
        .border = bright_black,

        .control = .{
            .fill = xgray2,
            .fill_hover = xgray4,
            .fill_press = cyan,
            .text = bright_white,
            .text_press = black,
            .border = bright_black,
        },
        .window = .{
            .fill = xgray1,
            .border = bright_black,
        },
        .highlight = .{
            .fill = cyan,
            .fill_hover = bright_cyan,
            .text = black,
            .text_hover = black,
        },
        .err = .{
            .fill = red,
            .fill_hover = bright_red,
            .text = bright_white,
            .border = red,
        },
    };
};
