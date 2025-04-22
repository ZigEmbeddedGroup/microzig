# Riscv32 Common definitions

[![Continuous Integration](https://github.com/ZigEmbeddedGroup/foundation-libc/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/ZigEmbeddedGroup/foundation-libc/actions/workflows/build.yml)

A C standard library that only implements a subset of functions that can be safely used without an operating system.
This is called a [freestanding environment](https://en.cppreference.com/w/cpp/freestanding).

This libc is primarily meant to be used with microcontrollers, hobbyist operating systems and so on.

## Support

The first goal is to reach full C11 *freestanding* support.

- No support for locales
- No allocator (ship your own!)
- No support for functions that require an operating system of sorts in the background.
- No support for `wchar_t` and `wchar.h` as it isn't portable between compilers.
- Multi-byte character strings are implemented as UTF-8.

## Customization

Foundation libc doesn't really support much customization/configuration except for the hard required options.

There is [`foundation/libc.h`](include/foundation/libc.h) which documents the behaviour of all required configurations.

Right now, the following configurations exist:

- `foundation_libc_panic_handler`, which allows users to catch detectable undefined behaviour.

You can also configure the libc by chosing the build mode:

- `Debug`: Implements additional safety checks and adds breakpoints in panics.
- `ReleaseSafe`: Keeps the safety checks, but removes breakpoints.
- `ReleaseSmall`: Still keeps a certain amount of safety, but drops long internal strings to reduce code and ram size.
- `ReleaseFast`: Gotta go fast. Drops all safety and assumes all code behaves well.

There are also certain "usage" configurations that can be chosen to affect behaviour when *using* the headers. Those are implemented as C macros/defines:

- `FOUNDATION_LIBC_ASSERT` is a global macro that defines how `assert()` should behave:
  - `FOUNDATION_LIBC_ASSERT_DEFAULT=0`: Behaves like a regular assert that can print file name, assertion message and line.
  - `FOUNDATION_LIBC_ASSERT_NOFILE=1`: Drops the filename from the assertion to reduce code size.
  - `FOUNDATION_LIBC_ASSERT_NOMSG=2`: Additionally drops the assertion message from the assertion to reduce code size.
  - `FOUNDATION_LIBC_ASSERT_EXPECTED=3`: Replaces `assert(…)` with a construct that tells the compiler the assertion is always met. Makes code very fast. Assertions aren't checked.

## Development

Zig Version: 0.11

Run
```sh-session
user@microzig ~/foundation-libc $ zig build
user@microzig ~/foundation-libc $
```

to compile the libc and generate a lib file in `zig-out/lib` as well as the headers in `zig-out/include`.

## Contribution

Start by grabbing a header marked with ⏳ or 🛠 and implement the functions from that header. See if others already have a PR open for those functions so you don't do work twice!

Leverage functions from Zig `std` if possible as they are already well tested and should work.

Which functions belong into which header can be figured out by taking a look at the *C11 Standard Draft* document or the *IBM libc functions* list. [cppreference.com](https://en.cppreference.com/w/c) usually has the better docs though, so best check out both.

### Style Guides

- The header files are ment to be as minimal as possible
  - Do not use comments documenting the functions, they are well documented everywhere else.
  - Only insert empty lines between functions if necessarity for clarity
  - Keep function names sorted alphabetically
- Try not to use macros at all
- Use `clang-format` with the provided style file.


## Links

- [C11 Standard](https://www.iso.org/standard/57853.html)
- [C11 Standard Draft](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf)
- [ziglibc](https://github.com/marler8997/ziglibc)
- [libc-test](https://wiki.musl-libc.org/libc-test.html) by musl
- [cppreference on freestanding](https://en.cppreference.com/w/cpp/freestanding)
- [GCC on freestanding](https://gcc.gnu.org/onlinedocs/gcc/Standards.html#C-Language)
- [IBM libc functions](https://www.ibm.com/docs/en/i/7.5?topic=extensions-standard-c-library-functions-table-by-name) (function to header map)
- [cppreference](https://en.cppreference.com/w/c)
- [clang-format style options](https://releases.llvm.org/16.0.0/tools/clang/docs/ClangFormatStyleOptions.html)

## Status

⏳ (not started), 🛠 (work in progress), ⚠️ (partial support), ✅ (full support), ❌ (no support), 🔮 (potential future support), 🔀 (implemented by compiler)

| Header File     | Header Status | Implementation Status | Description                                                                                             |
| --------------- | ------------- | --------------------- | ------------------------------------------------------------------------------------------------------- |
| `assert.h`      | ✅             | ✅                     | Conditionally compiled macro that compares its argument to zero                                         |
| `complex.h`     | ❌             |                       | (since C99) Complex number arithmetic                                                                   |
| `ctype.h`       | ✅             | ✅                     | Functions to determine the type contained in character data                                             |
| `errno.h`       | ✅             | ✅                     | Macros reporting error conditions                                                                       |
| `fenv.h`        | 🔮             |                       | (since C99) Floating-point environment                                                                  |
| `float.h`       | 🔀             |                       | Limits of floating-point types                                                                          |
| `inttypes.h`    | ⏳             | ⏳                     | (since C99) Format conversion of integer types                                                          |
| `iso646.h`      | 🔀             |                       | (since C95) Alternative operator spellings                                                              |
| `limits.h`      | 🔀             |                       | Ranges of integer types                                                                                 |
| `locale.h`      | ❌             |                       | Localization utilities                                                                                  |
| `math.h`        | 🛠             | ⏳                     | Common mathematics functions                                                                            |
| `setjmp.h`      | 🛠             | ⏳                     | Nonlocal jumps                                                                                          |
| `signal.h`      | ❌             |                       | Signal handling                                                                                         |
| `stdalign.h`    | 🔀             |                       | (since C11) alignas and alignof convenience macros                                                      |
| `stdarg.h`      | 🔀             |                       | Variable arguments                                                                                      |
| `stdatomic.h`   | 🔮             |                       | (since C11) Atomic operations                                                                           |
| `stdbit.h`      | 🔮             |                       | (since C23) Macros to work with the byte and bit representations of types                               |
| `stdbool.h`     | 🔀             |                       | (since C99) Macros for boolean type                                                                     |
| `stdckdint.h`   | 🔮             |                       | (since C23) macros for performing checked integer arithmetic                                            |
| `stddef.h`      | 🔀             |                       | Common macro definitions                                                                                |
| `stdint.h`      | 🔀             |                       | (since C99) Fixed-width integer types                                                                   |
| `stdio.h`       | ❌             |                       | Input/output                                                                                            |
| `stdlib.h`      | 🛠             | 🛠                     | General utilities: memory management, program utilities, string conversions, random numbers, algorithms |
| `stdnoreturn.h` | 🔀             |                       | (since C11) noreturn convenience macro                                                                  |
| `string.h`      | ✅             | 🛠                     | String handling                                                                                         |
| `tgmath.h`      | ⏳             | ⏳                     | (since C99) Type-generic math (macros wrapping math.h and complex.h)                                    |
| `threads.h`     | ❌             |                       | (since C11) Thread library                                                                              |
| `time.h`        | ❌             |                       | Time/date utilities                                                                                     |
| `uchar.h`       | 🛠             | ⏳                     | (since C11) UTF-16 and UTF-32 character utilities                                                       |
| `wchar.h`       | ❌             |                       | (since C95) Extended multibyte and wide character utilities                                             |
| `wctype.h`      | ❌             |                       | (since C95) Functions to determine the type contained in wide character data                            |


