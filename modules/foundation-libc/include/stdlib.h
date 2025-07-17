#ifndef _FOUNDATION_LIBC_STDLIB_H_
#define _FOUNDATION_LIBC_STDLIB_H_

int atoi(char const * str);
void* malloc(size_t size);
void* calloc(size_t count, size_t size);
void free(void* ptr);

#endif
