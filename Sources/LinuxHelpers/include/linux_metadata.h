#if __linux__
#include <fcntl.h>
#include <linux/stat.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>
#define AT_STATX_SYNC_AS_STAT   0x0000  /* - Do whatever stat() does */
#ifdef __NR_statx


static inline ssize_t
_statx(int dfd, const char *filename, unsigned int flags, unsigned int mask, struct statx *buffer) {
    return syscall(__NR_statx, dfd, filename, flags, mask, buffer);
}

static inline ssize_t linux_metadata
(
    const char *filename,
    unsigned int flags,
    __u16 *mode,
    __u64 *size,
    struct timespec *atime,
    struct timespec *mtime,
    struct timespec *btime
) {
    struct statx statx_buffer = {0};
    *btime = (struct timespec) {0};

    ssize_t ret = _statx(AT_FDCWD, filename, flags | AT_STATX_SYNC_AS_STAT, STATX_ALL, &statx_buffer);
    if (ret == 0) {
        *mode = statx_buffer.stx_mode;
        *size = statx_buffer.stx_size;
        *atime = (struct timespec) {
            .tv_sec = statx_buffer.stx_atime.tv_sec,
            .tv_nsec = statx_buffer.stx_atime.tv_nsec
        };
        *mtime = (struct timespec) {
            .tv_sec = statx_buffer.stx_mtime.tv_sec,
            .tv_nsec = statx_buffer.stx_mtime.tv_nsec
        };
        // Check that stx_btime was set in the response, not all filesystems support it.
        if (statx_buffer.stx_mask & STATX_BTIME) {
            *btime = (struct timespec) {
                .tv_sec = statx_buffer.stx_btime.tv_sec,
                .tv_nsec = statx_buffer.stx_btime.tv_nsec
            };
        } else {
            *btime = (struct timespec) {
                .tv_sec = 0,
                .tv_nsec = 0
            };
        }
    }
    return ret;
}
#endif // __NR_statx
#endif // __linux__
