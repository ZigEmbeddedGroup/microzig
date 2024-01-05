#ifndef _FOUNDATION_LIBC_ERRNO_H_
#define _FOUNDATION_LIBC_ERRNO_H_

#define EDOM 1
#define EILSEQ 2
#define ERANGE 3

#define errno (*__get_errno())

int * __get_errno(void);

#endif
