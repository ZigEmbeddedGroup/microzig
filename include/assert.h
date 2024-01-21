#ifndef _FOUNDATION_LIBC_ASSERT_H_
#define _FOUNDATION_LIBC_ASSERT_H_

#ifndef NDEBUG
#define assert(expr)
#else
extern void __assert(char const * assertion, char const * file, unsigned line) __attribute__((__noreturn__));

#define assert(expr) \
    ((expr)          \
         ? void(0)   \
         : __assert(#expr, __FILE__, __LINE__))

#endif

#endif
