/* Hand-written stand-in for lib/config.h, normally produced by
   ./configure from lib/config.h.in. Targets both Linux (glibc) and
   Windows (mingw, via zig cc's `-target x86_64-windows-gnu`); the few
   values that differ per-OS are guarded by #ifdef _WIN32 below. */

#define ENABLE_EXTRA 0
#define ENABLE_RELOCATABLE 0

/* Both glibc and mingw provide a real mbstate_t via <wchar.h>. */
/* #undef mbstate_t */

#define HAVE_ICONV 0
#define ICONV_CONST /* empty */

#define HAVE_GETC_UNLOCKED 1
/* localcharset.c: HAVE_LANGINFO_CODESET is checked with #if (not #ifdef),
   so it must be an actual 0/1, not just "defined or not". mingw has no
   <langinfo.h>; localcharset.c instead takes its WINDOWS_NATIVE branch
   (defined whenever _WIN32 && !__CYGWIN__), so this only matters for
   picking the right branch, not for actually calling nl_langinfo(). */
#ifdef _WIN32
#define HAVE_LANGINFO_CODESET 0
#else
#define HAVE_LANGINFO_CODESET 1
#endif
#define HAVE_MBRTOWC 1
#define HAVE_SETLOCALE 1
#define HAVE_STDDEF_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRING_H 1
#define HAVE_VISIBILITY 1
#define HAVE_WCRTOMB 1
#define HAVE_WORKING_O_NOFOLLOW 1

#define WORDS_LITTLEENDIAN 1

#define INSTALLPREFIX ""

/* 'inline' is supported natively by the C99 compiler in use (clang/zig cc). */
#ifndef __cplusplus
/* #undef inline */
#endif

/* mode_t/ssize_t already provided by <sys/types.h> on this target. */
/* #undef mode_t */
/* #undef ssize_t */

/* Needed by export.h (only matters for BUILDING_LIBICONV, i.e. never
   for consumers); this build doesn't use export.h at all (see
   include/iconv.h, generated without it -- static-lib-only, no DLL
   export/import distinction needed). */
