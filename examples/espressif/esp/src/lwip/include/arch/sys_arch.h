#ifndef __SYS_ARCH_H__
#define __SYS_ARCH_H__

#include <stdint.h>

typedef void* sys_sem_t;
typedef void* sys_mutex_t;
typedef void* sys_mbox_t;
typedef void* sys_thread_t;

typedef uint32_t sys_prot_t;

#define SYS_MBOX_NULL  NULL
#define SYS_SEM_NULL   NULL
#define SYS_MUTEX_NULL NULL

void* malloc(size_t size);
void* calloc(size_t count, size_t size);
void free(void* ptr);

#endif /* __SYS_ARCH_H__ */
