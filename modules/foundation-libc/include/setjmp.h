#ifndef _FOUNDATION_LIBC_SETJMP_H_
#define _FOUNDATION_LIBC_SETJMP_H_

typedef unsigned int jmp_buf[1];

#define setjmp(env)

_Noreturn void longjmp(jmp_buf env, int val);

#endif
