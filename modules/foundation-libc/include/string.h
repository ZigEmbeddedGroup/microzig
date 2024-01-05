#ifndef _FOUNDATION_LIBC_STRING_H_
#define _FOUNDATION_LIBC_STRING_H_

#include <stddef.h>

void * memchr(const void *s, int c, size_t n);
int    memcmp(const void *s1, const void *s2, size_t n);
void * memcpy(void * restrict s1, const void * restrict s2, size_t n);
void * memmove(void *s1, const void *s2, size_t n);
void * memset(void *s, int c, size_t n);
char * strcat(char * restrict s1, const char * restrict s2);
char * strchr( const char *str, int ch );
int    strcmp(const char *s1, const char *s2);
char * strcpy(char * restrict s1, const char * restrict s2);
size_t strcspn(const char *s1, const char *s2);
char * strerror(int errnum);
size_t strlen( const char *str );
char * strncat(char * restrict s1, const char * restrict s2, size_t n);
int    strncmp( const char* lhs, const char* rhs, size_t count );
char * strncpy(char * restrict s1, const char * restrict s2, size_t n);
char * strpbrk(const char *s1, const char *s2);
char * strrchr(const char *s, int c);
size_t strspn(const char *s1, const char *s2);
char * strstr(const char *s1, const char *s2);
char * strtok(char * restrict s1, const char * restrict s2);

// locale dependent: size_t strxfrm(char * restrict s1, const char * restrict s2, size_t n);
// locale dependent: int strcoll(const char *s1, const char *s2);

#endif
