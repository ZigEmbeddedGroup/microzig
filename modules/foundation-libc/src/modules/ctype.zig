//! implementation of `ctype.h`
//!
//! The header <ctype.h> declares several functions useful for classifying and mapping
//! characters. In all cases the argument is an int, the value of which shall be
//! representable as an unsigned char or shall equal the value of the macro EOF. If the
//! argument has any other value, the behavior is undefined.
//!

const std = @import("std");
const libc = @import("../libc.zig");

// Use an alias to std.ascii to allow potential future replacement
// of the locale implementation:
const locale = std.ascii;

const EOF = libc.h.EOF;

/// Convert input to u8, undefined behaviour
fn conv(c: c_int) ?u8 {
    if (c == EOF)
        return null;
    return std.math.cast(u8, c) orelse libc.undefined_behaviour("passed a value that is not unsigned char nor EOF to a ctype function");
}

/// The isalnum function tests for any character for which isalpha or isdigit is true.
export fn isalnum(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isAlphanumeric(u));
}

/// The isalpha function tests for any character for which isupper or islower is true,
/// or any character that is one of a locale-specific set of alphabetic characters for which
/// none of iscntrl, isdigit, ispunct, or isspace is true.200) In the "C" locale,
/// isalpha returns true only for the characters for which isupper or islower is true.
export fn isalpha(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isAlphabetic(u));
}

/// The isblank function tests for any character that is a standard blank character or is one
/// of a locale-specific set of characters for which isspace is true and that is used to
/// separate words within a line of text. The standard blank characters are the following:
/// space (' '), and horizontal tab ('\t'). In the "C" locale, isblank returns true only
/// for the standard blank characters.
export fn isblank(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(u == ' ' or u == '\t');
}

/// The iscntrl function tests for any control character.
export fn iscntrl(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isControl(u));
}

/// The isdigit function tests for any decimal-digit character (as defined in 5.2.1).
export fn isdigit(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isDigit(u));
}

/// The isgraph function tests for any printing character except space (' ').
export fn isgraph(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isPrint(u) and (c != ' '));
}

/// The islower function tests for any character that is a lowercase letter or is one of a
/// locale-specific set of characters for which none of iscntrl, isdigit, ispunct, or
/// isspace is true. In the "C" locale, islower returns true only for the lowercase
/// letters (as defined in 5.2.1).
export fn islower(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isLower(u));
}

/// The isprint function tests for any printing character including space (' ').
export fn isprint(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isPrint(u));
}

/// The ispunct function tests for any printing character that is one of a locale-specific set
/// of punctuation characters for which neither isspace nor isalnum is true. In the "C"
/// locale, ispunct returns true for every printing character for which neither isspace
/// nor isalnum is true.
export fn ispunct(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(!locale.isWhitespace(u) and !locale.isAlphanumeric(u));
}

/// The isspace function tests for any character that is a standard white-space character or
/// is one of a locale-specific set of characters for which isalnum is false. The standard
/// white-space characters are the following: space (' '), form feed ('\f'), new-line
/// ('\n'), carriage return ('\r'), horizontal tab ('\t'), and vertical tab ('\v'). In the
/// "C" locale, isspace returns true only for the standard white-space characters.
export fn isspace(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isWhitespace(u));
}

/// The isupper function tests for any character that is an uppercase letter or is one of a
/// locale-specific set of characters for which none of iscntrl, isdigit, ispunct, or
/// isspace is true. In the "C" locale, isupper returns true only for the uppercase
/// letters (as defined in 5.2.1).
export fn isupper(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isUpper(u));
}

/// The isxdigit function tests for any hexadecimal-digit character (as defined in 6.4.4.1).
export fn isxdigit(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return @intFromBool(locale.isHex(u));
}

/// The tolower function converts an uppercase letter to a corresponding lowercase letter.
export fn tolower(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return locale.toLower(u);
}

/// The toupper function converts a lowercase letter to a corresponding uppercase letter.
export fn toupper(c: c_int) c_int {
    const u = conv(c) orelse return EOF;
    return locale.toUpper(u);
}
