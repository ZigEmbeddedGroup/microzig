# defmt


## Roadmap

This is from `std.Io.Writer`, this module's goal is to reimplement the print
format strings, so that transitioning to defmt is smooth.

```
Renders `fmt` string with `args`, calling `w` with slices of bytes.

The format string must be comptime-known and may contain placeholders
following this format:

{[argument][specifier]:[fill][alignment][width].[precision]}

Above, each word including its surrounding [ and ] is a parameter to be replaced with:

- **argument** is either the numeric index or the field name of the argument that should be inserted.
  - When using a field name, the field name (an identifier) must be enclosed in square
    brackets, e.g. `{[score]...}` as opposed to the numeric index form which can be written e.g. `{2...}`.
- **specifier** is a type-dependent formatting option that determines how a type should formatted (see below).
- **fill** is a single byte which is used to pad formatted numbers.
- **alignment** is one of the three bytes '<', '^', or '>' to make numbers
  left, center, or right-aligned, respectively.
  - Not all specifiers support alignment.
  - Alignment is not Unicode-aware; appropriate only when used with raw
    bytes or ASCII.
- **width** is the total size of the field in bytes, only applicable to
  number formatting.
- **precision** specifies how many decimals a formatted number should have.

Most of the parameters are optional and may be omitted. The separators (':'
and '.') may be omitted when all parameters afterwards are omitted.

The **fill** parameter is an exception. If a non-zero **fill** character is
required at the same time as **width** is specified, **alignment** is
required, otherwise the digit following ':' is interpreted as **width**.

**specifier** supports:
- "x" and "X": numeric value in hexadecimal notation, or string in hexadecimal bytes
- "s":
  - for pointer-to-many and C pointers of u8, print as a C-string using zero-termination
  - for slices of u8, print the entire slice as a string without zero-termination
- "t":
  - for enums and tagged unions: prints the tag name
  - for error sets: prints the error name
- "b64": string as standard base64
- "e": floating point value in scientific notation
- "d": numeric value in decimal notation
- "b": integer value in binary notation
- "o": integer value in octal notation
- "c": integer as an ASCII character. Integer type must have 8 bits at max.
- "u": integer as an UTF-8 sequence. Integer type must have 21 bits at max.
- "B": bytes in SI units (decimal)
- "Bi": bytes in IEC units (binary)
- "?": optional value as either the unwrapped value, or `null`; may be
  followed by a format specifier for the underlying value.
- "!": error union value as either the unwrapped value, or the formatted
  error value; may be followed by a format specifier for the underlying
  value.
- "*": the address of the value instead of the value itself.
- "any": a value of any type using its default format.
- "f": delegates to the `format` method of the type, passing `*Writer` and
  expecting `Error!void` returned.
- "q": prints as a double-quote escaped string. Inside the double-quoted
  string, everything is passed through unmodified, except for the following
  transformations:
  - escaped: '\n', '\r', '\t', '\\', '"'
  - hex-encoded: ASCII control characters
- "qf": delegates to the `format` method of the type, while double-quote
  escaping.

Literal curly braces can be escaped in the format string via doubling, e.g.
"{{" or "}}".
```
