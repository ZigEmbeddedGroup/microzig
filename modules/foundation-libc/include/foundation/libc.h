#ifndef _FOUNDATION_LIBC_INTERNALS_H_
#define _FOUNDATION_LIBC_INTERNALS_H_

#include <stddef.h>

///
/// Panic handler for undefined, but catchable behaviour in safe modes.
///
/// This will be invoked when Zig detects undefined behaviour at runtime,
/// or when foundation libc can recognize illegal arguments.
///
/// The function receives a non-terminated pointer to the panic message
/// with `msg_len` bytes of UTF-8 encoded payload.
///
/// It has a weak default implementation shipped, so just implement this
/// function to plug in your own custom behaviour.
/// The default implementation is done by invoking a `trap` instruction to
/// emit an illegal instruction or otherwise crash the program execution.
///
/// NOTE: This function must never return, because otherwise, the undefined
///       behaviour will be actually undefined!
///
void foundation_libc_panic_handler(char const * msg_ptr, size_t msg_len);

#endif
