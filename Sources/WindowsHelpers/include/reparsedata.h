#ifndef REPARSEDATA_H
#define REPARSEDATA_H

#if defined(__MINGW32__)
#   define  WINDOWSHELPERS_DECLARE(type)  type
#elif defined(WIN32)
#   if defined(WINDOWSHELPERS_DECLARE_STATIC)
#       define  WINDOWSHELPERS_DECLARE(type)  type
#   elif defined(WINDOWSHELPERS_DECLARE_EXPORT)
#       define  WINDOWSHELPERS_DECLARE(type)  __declspec(dllexport) type
#   else
#       define  WINDOWSHELPERS_DECLARE(type)  __declspec(dllimport) type
#   endif
#else
#   define  WINDOWSHELPERS_DECLARE(type)  type
#endif

#if defined (_WIN64)
#include <stdint.h>
#include <wchar.h>

#ifndef IO_REPARSE_TAG_SYMLINK
#define IO_REPARSE_TAG_SYMLINK (0xA000000CL)
#endif

#ifndef IO_REPARSE_TAG_MOUNT_POINT
#define IO_REPARSE_TAG_MOUNT_POINT (0xA0000003L)
#endif

typedef struct {
  unsigned long reparseTag;
  unsigned short reparseDataLength;
  unsigned short reserved;
  unsigned short substituteNameOffset;
  unsigned short substituteNameLength;
  unsigned short printNameOffset;
  unsigned short printNameLength;
  unsigned long flags;
  wchar_t pathBuffer[1];
} ReparseDataBuffer;

typedef ReparseDataBuffer SymbolicLinkReparseBuffer;

typedef struct {
  unsigned long reparseTag;
  unsigned short reparseDataLength;
  unsigned short reserved;
  unsigned short substituteNameOffset;
  unsigned short substituteNameLength;
  unsigned short printNameOffset;
  unsigned short printNameLength;
  wchar_t pathBuffer[1];
} MountPointReparseBuffer;
#endif

#endif
