# Foundation libc

A C standard library that only implements a subset of functions that can be safely used without an operating system.
This is called a [freestanding environment](https://en.cppreference.com/w/cpp/freestanding).

This libc is primarily meant to be used with microcontrollers, hobbyist operating systems and so on.

## Support

The first goal is to reach full C11 *freestanding* support.

- No support for locales
- No allocator (ship your own!)
- No support for functions that require an operating system of sorts in the background.

## Development

Zig Version: 0.11


Run
```sh-session
user@microzig ~/foundation-libc $ zig build
user@microzig ~/foundation-libc $ 
```

to compile the libc and generate a lib file in `zig-out/lib` as well as the headers in `zig-out/include`.


## Links

- [C11 Standard](https://www.iso.org/standard/57853.html)
- [C11 Standard Draft](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf)

