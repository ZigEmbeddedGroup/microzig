#ifndef _FOUNDATION_LIBC_UCHAR_H_
#define _FOUNDATION_LIBC_UCHAR_H_

#include <stdint.h>

typedef struct {
    int dummy; // TODO: fill in internal multi-byte conversion state
} mbstate_t;

typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;

size_t mbrtoc16(char16_t * restrict pc16, char const * restrict s, size_t n, mbstate_t * restrict ps);
size_t c16rtomb(char * restrict s, char16_t c16, mbstate_t * restrict ps);
size_t mbrtoc32(char32_t * restrict pc32, char const * restrict s, size_t n, mbstate_t * restrict ps);
size_t c32rtomb(char * restrict s, char32_t c32, mbstate_t * restrict ps);

#endif
