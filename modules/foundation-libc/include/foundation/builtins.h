#ifndef _FOUNDATION_LIBC_BUILTINS_H_
#define _FOUNDATION_LIBC_BUILTINS_H_

#include <stddef.h>

#define FOUNDATION_LIBC_ASSERT_DEFAULT 0
#define FOUNDATION_LIBC_ASSERT_NOFILE 1
#define FOUNDATION_LIBC_ASSERT_NOMSG 2
#define FOUNDATION_LIBC_ASSERT_EXPECTED 3

#ifndef FOUNDATION_LIBC_ASSERT
#define FOUNDATION_LIBC_ASSERT FOUNDATION_LIBC_ASSERT_DEFAULT
#endif

#define FOUNDATION_LIBC_STATIC_ASSERT _Static_assert

#if defined(__clang__)

#define FOUNDATION_LIBC_NORETURN __attribute__((__noreturn__))
#define FOUNDATION_LIBC_EXPECT(expr) (__builtin_expect(!(expr), 0))

#elif defined(__GNUC__) || defined(__GNUG__)

#define FOUNDATION_LIBC_NORETURN __attribute__((__noreturn__))
#define FOUNDATION_LIBC_EXPECT(expr) (__builtin_expect(!(expr), 0))

#elif defined(_MSC_VER)

#define FOUNDATION_LIBC_NORETURN __declspec(noreturn)
#define FOUNDATION_LIBC_EXPECT(expr) (__assume((expr)))

#else

#define FOUNDATION_LIBC_NORETURN
#define FOUNDATION_LIBC_EXPECT(expr)

#endif

#endif
