#include <assert.h>

#ifndef FOUNDATION_LIBC_ASSERT
#error "FOUNDATION_LIBC_ASSERT wasn't implicitly or explicitly defined by assert.h"
#endif

#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wmissing-prototypes"
//

void assert_dynamic(int ok) {
    assert(ok);
}

void assert_ok(void) {
    assert(1);
}

// suppress noreturn diagnostic for missing "noreturn"
#pragma GCC diagnostic ignored "-Wmissing-noreturn"
//

void assert_bad(void) {
    assert(0);
}
