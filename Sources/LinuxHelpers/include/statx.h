#if __linux__
// required for statx() system call
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

static inline ssize_t
_stat_with_btime(const char *filename, unsigned int flags, struct stat *buffer, struct timespec *btime) {
    struct statx statx_buffer = {0};
    *btime = (struct timespec) {0};

    ssize_t ret = _statx(AT_FDCWD, filename, flags | AT_STATX_SYNC_AS_STAT, STATX_ALL, &statx_buffer);
    if (ret == 0) {
        *buffer = (struct stat) {
            .st_ino = statx_buffer.stx_ino,
            .st_mode = statx_buffer.stx_mode,
            .st_size = statx_buffer.stx_size,
            .st_atim = { .tv_sec = statx_buffer.stx_atime.tv_sec, .tv_nsec = statx_buffer.stx_atime.tv_nsec },
            .st_mtim = { .tv_sec = statx_buffer.stx_mtime.tv_sec, .tv_nsec = statx_buffer.stx_mtime.tv_nsec },
            .st_ctim = { .tv_sec = statx_buffer.stx_ctime.tv_sec, .tv_nsec = statx_buffer.stx_ctime.tv_nsec },
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
