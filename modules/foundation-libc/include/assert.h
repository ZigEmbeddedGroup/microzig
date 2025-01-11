#ifndef _FOUNDATION_LIBC_ASSERT_H_
#define _FOUNDATION_LIBC_ASSERT_H_

#include "foundation/builtins.h"

extern FOUNDATION_LIBC_NORETURN void foundation_libc_assert(char const * assertion, char const * file, unsigned line);

#if FOUNDATION_LIBC_ASSERT == FOUNDATION_LIBC_ASSERT_DEFAULT

#define assert(expr)                                           \
    do {                                                       \
        if ((expr) == 0) {                                     \
            foundation_libc_assert(#expr, __FILE__, __LINE__); \
        }                                                      \
    } while (0)

#elif FOUNDATION_LIBC_ASSERT == FOUNDATION_LIBC_ASSERT_NOFILE

#define assert(expr)                                     \
    do {                                                 \
        if ((expr) == 0) {                               \
            foundation_libc_assert(#expr, "", __LINE__); \
        }                                                \
    } while (0)

#elif FOUNDATION_LIBC_ASSERT == FOUNDATION_LIBC_ASSERT_NOMSG

#define assert(expr)                                  \
    do {                                              \
        if ((expr) == 0) {                            \
            foundation_libc_assert("", "", __LINE__); \
        }                                             \
    } while (0)

#elif FOUNDATION_LIBC_ASSERT == FOUNDATION_LIBC_ASSERT_EXPECTED

#define assert(expr) FOUNDATION_LIBC_EXPECT(expr)

#else
#error "bad definition of FOUNDATION_LIBC_ASSERT_DEFAULT!"
#endif

#if !defined(__cplusplus)
#undef static_assert
#define static_assert FOUNDATION_LIBC_STATIC_ASSERT
#endif

#endif
