#ifndef _PICO_PLATFORM_COMMON_H
#define _PICO_PLATFORM_COMMON_H

// PICO_CONFIG: PICO_MINIMAL_STORED_VECTOR_TABLE, Only store a very minimal vector table in the binary on Arm, type=bool, default=0, advanced=true, group=pico_crt0
#ifndef PICO_MINIMAL_STORED_VECTOR_TABLE
#define PICO_MINIMAL_STORED_VECTOR_TABLE 0
#endif

/*! \brief No-op function for the body of tight loops
 *  \ingroup pico_platform
 *
 * No-op function intended to be called by any tight hardware polling loop. Using this ubiquitously
 * makes it much easier to find tight loops, but also in the future \#ifdef-ed support for lockup
 * debugging might be added
 */
static __force_inline void tight_loop_contents(void) {}


#endif