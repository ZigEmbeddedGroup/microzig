#ifndef _FOUNDATION_LIBC_STRING_H_
#define _FOUNDATION_LIBC_STRING_H_

#include <stddef.h>

void * memchr(void const * s, int c, size_t n);
int    memcmp(void const * s1, void const * s2, size_t n);
void * memcpy(void * restrict s1, void const * restrict s2, size_t n);
void * memmove(void * s1, void const * s2, size_t n);
void * memset(void * s, int c, size_t n);
char * strcat(char * restrict s1, char const * restrict s2);
char * strchr(char const * str, int ch);
int    strcmp(char const * s1, char const * s2);
char * strcpy(char * restrict s1, char const * restrict s2);
size_t strcspn(char const * s1, char const * s2);
char * strerror(int errnum);
size_t strlen(char const * str);
char * strncat(char * restrict s1, char const * restrict s2, size_t n);
int    strncmp(char const * lhs, char const * rhs, size_t count);
char * strncpy(char * restrict s1, char const * restrict s2, size_t n);
char * strpbrk(char const * s1, char const * s2);
char * strrchr(char const * s, int c);
size_t strspn(char const * s1, char const * s2);
char * strstr(char const * s1, char const * s2);
char * strtok(char * restrict s1, char const * restrict s2);

// locale dependent: size_t strxfrm(char * restrict s1, const char * restrict
// s2, size_t n); locale dependent: int strcoll(const char *s1, const char *s2);

#endif
