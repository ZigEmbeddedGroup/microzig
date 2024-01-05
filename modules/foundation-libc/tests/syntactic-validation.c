
// our own files must be included as non-system includes to trigger warnings:
#include "ctype.h"
#include "errno.h"
#include "inttypes.h"
#include "math.h"
#include "setjmp.h"
#include "stdlib.h"
#include "string.h"
#include "tgmath.h"
#include "uchar.h"

// those files should be present still, but are compiler provided:
#include <float.h>
#include <iso646.h>
#include <limits.h>
#include <stdalign.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdnoreturn.h>
