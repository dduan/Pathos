#if os(Windows)
import WinSDK

private let _EPERM: SystemError.Code = 1
private let _ENOENT: SystemError.Code = 2
private let _ESRCH: SystemError.Code = 3
private let _EINTR: SystemError.Code = 4
private let _EIO: SystemError.Code = 5
private let _ENXIO: SystemError.Code = 6
private let _E2BIG: SystemError.Code = 7
private let _ENOEXEC: SystemError.Code = 8
private let _EBADF: SystemError.Code = 9
private let _ECHILD: SystemError.Code = 10
private let _EAGAIN: SystemError.Code = 11
private let _ENOMEM: SystemError.Code = 12
private let _EACCES: SystemError.Code = 13
private let _EFAULT: SystemError.Code = 14
private let _EBUSY: SystemError.Code = 16
private let _EEXIST: SystemError.Code = 17
private let _EXDEV: SystemError.Code = 18
private let _ENODEV: SystemError.Code = 19
private let _ENOTDIR: SystemError.Code = 20
private let _EISDIR: SystemError.Code = 21
private let _EINVAL: SystemError.Code = 22
private let _ENFILE: SystemError.Code = 23
private let _EMFILE: SystemError.Code = 24
private let _EFBIG: SystemError.Code = 27
private let _ENOSPC: SystemError.Code = 28
private let _ESPIPE: SystemError.Code = 29
private let _EROFS: SystemError.Code = 30
private let _EMLINK: SystemError.Code = 31
private let _EPIPE: SystemError.Code = 32
private let _EDOM: SystemError.Code = 33
private let _ERANGE: SystemError.Code = 34
private let _EDEADLK: SystemError.Code = 36
private let _ENAMETOOLONG: SystemError.Code = 38
private let _ENOLCK: SystemError.Code = 39
private let _ENOSYS: SystemError.Code = 40
private let _ENOTEMPTY: SystemError.Code = 41
private let _EILSEQ: SystemError.Code = 42
private let _EWOULDBLOCK: SystemError.Code = 10035
private let _EINPROGRESS: SystemError.Code = 10036
private let _EALREADY: SystemError.Code = 10037
private let _ENOTSOCK: SystemError.Code = 10038
private let _EDESTADDRREQ: SystemError.Code = 10039
private let _EMSGSIZE: SystemError.Code = 10040
private let _EPROTOTYPE: SystemError.Code = 10041
private let _ENOPROTOOPT: SystemError.Code = 10042
private let _EPROTONOSUPPORT: SystemError.Code = 10043
private let _ESOCKTNOSUPPORT: SystemError.Code = 10044
private let _EOPNOTSUPP: SystemError.Code = 10045
private let _EPFNOSUPPORT: SystemError.Code = 10046
private let _EAFNOSUPPORT: SystemError.Code = 10047
private let _EADDRINUSE: SystemError.Code = 10048
private let _EADDRNOTAVAIL: SystemError.Code = 10049
private let _ENETDOWN: SystemError.Code = 10050
private let _ENETUNREACH: SystemError.Code = 10051
private let _ENETRESET: SystemError.Code = 10052
private let _ECONNABORTED: SystemError.Code = 10053
private let _ECONNRESET: SystemError.Code = 10054
private let _ENOBUFS: SystemError.Code = 10055
private let _EISCONN: SystemError.Code = 10056
private let _ENOTCONN: SystemError.Code = 10057
private let _ESHUTDOWN: SystemError.Code = 10058
private let _ETOOMANYREFS: SystemError.Code = 10059
private let _ETIMEDOUT: SystemError.Code = 10060
private let _ECONNREFUSED: SystemError.Code = 10061
private let _ELOOP: SystemError.Code = 10062
private let _EHOSTDOWN: SystemError.Code = 10064
private let _EHOSTUNREACH: SystemError.Code = 10065
private let _EUSERS: SystemError.Code = 10068
private let _EDQUOT: SystemError.Code = 10069
private let _ESTALE: SystemError.Code = 10070
private let _EREMOTE: SystemError.Code = 10071
private let _ECANCELED: SystemError.Code = 10103

#else

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)

private let _EPERM: SystemError.Code = EPERM
private let _ENOENT: SystemError.Code = ENOENT
private let _ESRCH: SystemError.Code = ESRCH
private let _EINTR: SystemError.Code = EINTR
private let _EIO: SystemError.Code = EIO
private let _ENXIO: SystemError.Code = ENXIO
private let _E2BIG: SystemError.Code = E2BIG
private let _ENOEXEC: SystemError.Code = ENOEXEC
private let _EBADF: SystemError.Code = EBADF
private let _ECHILD: SystemError.Code = ECHILD
private let _EDEADLK: SystemError.Code = EDEADLK
private let _ENOMEM: SystemError.Code = ENOMEM
private let _EACCES: SystemError.Code = EACCES
private let _EFAULT: SystemError.Code = EFAULT
private let _EBUSY: SystemError.Code = EBUSY
private let _EEXIST: SystemError.Code = EEXIST
private let _EXDEV: SystemError.Code = EXDEV
private let _ENODEV: SystemError.Code = ENODEV
private let _ENOTDIR: SystemError.Code = ENOTDIR
private let _EISDIR: SystemError.Code = EISDIR
private let _EINVAL: SystemError.Code = EINVAL
private let _ENFILE: SystemError.Code = ENFILE
private let _EMFILE: SystemError.Code = EMFILE
private let _EFBIG: SystemError.Code = EFBIG
private let _ENOSPC: SystemError.Code = ENOSPC
private let _ESPIPE: SystemError.Code = ESPIPE
private let _EROFS: SystemError.Code = EROFS
private let _EMLINK: SystemError.Code = EMLINK
private let _EPIPE: SystemError.Code = EPIPE
private let _EDOM: SystemError.Code = EDOM
private let _ERANGE: SystemError.Code = ERANGE
private let _EAGAIN: SystemError.Code = EAGAIN
private let _EINPROGRESS: SystemError.Code = EINPROGRESS
private let _EALREADY: SystemError.Code = EALREADY
private let _ENOTSOCK: SystemError.Code = ENOTSOCK
private let _EDESTADDRREQ: SystemError.Code = EDESTADDRREQ
private let _EMSGSIZE: SystemError.Code = EMSGSIZE
private let _EPROTOTYPE: SystemError.Code = EPROTOTYPE
private let _ENOPROTOOPT: SystemError.Code = ENOPROTOOPT
private let _EPROTONOSUPPORT: SystemError.Code = EPROTONOSUPPORT
private let _ESOCKTNOSUPPORT: SystemError.Code = ESOCKTNOSUPPORT
private let _EPFNOSUPPORT: SystemError.Code = EPFNOSUPPORT
private let _EAFNOSUPPORT: SystemError.Code = EAFNOSUPPORT
private let _EADDRINUSE: SystemError.Code = EADDRINUSE
private let _EADDRNOTAVAIL: SystemError.Code = EADDRNOTAVAIL
private let _ENETDOWN: SystemError.Code = ENETDOWN
private let _ENETUNREACH: SystemError.Code = ENETUNREACH
private let _ENETRESET: SystemError.Code = ENETRESET
private let _ECONNABORTED: SystemError.Code = ECONNABORTED
private let _ECONNRESET: SystemError.Code = ECONNRESET
private let _ENOBUFS: SystemError.Code = ENOBUFS
private let _EISCONN: SystemError.Code = EISCONN
private let _ENOTCONN: SystemError.Code = ENOTCONN
private let _ESHUTDOWN: SystemError.Code = ESHUTDOWN
private let _ETIMEDOUT: SystemError.Code = ETIMEDOUT
private let _ECONNREFUSED: SystemError.Code = ECONNREFUSED
private let _ELOOP: SystemError.Code = ELOOP
private let _ENAMETOOLONG: SystemError.Code = ENAMETOOLONG
private let _EHOSTDOWN: SystemError.Code = EHOSTDOWN
private let _EHOSTUNREACH: SystemError.Code = EHOSTUNREACH
private let _ENOTEMPTY: SystemError.Code = ENOTEMPTY
private let _EUSERS: SystemError.Code = EUSERS
private let _EDQUOT: SystemError.Code = EDQUOT
private let _ESTALE: SystemError.Code = ESTALE
private let _ENOLCK: SystemError.Code = ENOLCK
private let _ENOSYS: SystemError.Code = ENOSYS
private let _ECANCELED: SystemError.Code = ECANCELED
private let _EILSEQ: SystemError.Code = EILSEQ
private let _EOPNOTSUPP: SystemError.Code = EOPNOTSUPP
private let _EWOULDBLOCK: SystemError.Code = EWOULDBLOCK
private let _ETOOMANYREFS: SystemError.Code = ETOOMANYREFS
private let _EREMOTE: SystemError.Code = EREMOTE

#endif // os(Windows)

/// An error returned by the OS.
public enum SystemError: Error, Equatable {
    /// Operation not permitted.
    ///
    /// An attempt was made to perform an operation
    /// limited to processes with appropriate privileges
    /// or to the owner of a file or other resources.
    ///
    /// The corresponding C error is `EPERM`.
    case notPermitted

    /// No such file or directory.
    ///
    /// A component of a specified pathname didn't exist,
    /// or the pathname was an empty string.
    ///
    /// The corresponding C error is `ENOENT`.
    case noSuchFileOrDirectory

    /// No such process.
    ///
    /// There isn't a process that corresponds to the specified process ID.
    ///
    /// The corresponding C error is `ESRCH`.
    case noSuchProcess

    /// Interrupted function call.
    ///
    /// The process caught an asynchronous signal (such as `SIGINT` or `SIGQUIT`)
    /// during the execution of an interruptible function.
    /// If the signal handler performs a normal return,
    /// the caller of the interrupted function call receives this error.
    ///
    /// The corresponding C error is `EINTR`.
    case interrupted

    /// Input/output error.
    ///
    /// Some physical input or output error occurred.
    /// This error isn't reported until
    /// you attempt a subsequent operation on the same file descriptor,
    /// and the error may be lost (overwritten) by subsequent errors.
    ///
    /// The corresponding C error is `EIO`.
    case ioError

    /// No such device or address.
    ///
    /// Input or output on a special file referred to a device that didn't exist,
    /// or made a request beyond the limits of the device.
    /// This error may also occur when, for example,
    /// a tape drive isn't online or when there isn't a disk pack loaded on a drive.
    ///
    /// The corresponding C error is `ENXIO`.
    case noSuchAddressOrDevice

    /// The argument list is too long.
    ///
    /// The number of bytes
    /// used for the argument and environment list of the new process
    /// exceeded the limit `NCARGS`, as defined in `<sys/param.h>`.
    ///
    /// The corresponding C error is `E2BIG`.
    case argListTooLong

    /// Executable format error.
    ///
    /// A request was made to execute a file that,
    /// although it has the appropriate permissions,
    /// isn't in the format required for an executable file.
    ///
    /// The corresponding C error is `ENOEXEC`.
    case execFormatError

    /// Bad file descriptor.
    ///
    /// A file descriptor argument was out of range,
    /// referred to no open file,
    /// or a read (write) request was made to a file
    /// that was only open for writing (reading).
    ///
    /// The corresponding C error is `EBADF`.
    case badFileDescriptor

    /// No child processes.
    ///
    /// A `wait(2)` or `waitpid(2)` function was executed
    /// by a process that dosn't have any existing child processes
    /// or whose child processes are all already being waited for.
    ///
    /// The corresponding C error is `ECHILD`.
    case noChildProcess

    /// Resource deadlock avoided.
    ///
    /// You attempted to lock a system resource
    /// that would have resulted in a deadlock.
    ///
    /// The corresponding C error is `EDEADLK`.
    case deadlock

    /// Can't allocate memory.
    ///
    /// The new process image required more memory
    /// than was allowed by the hardware
    /// or by system-imposed memory management constraints.
    /// A lack of swap space is normally temporary;
    /// however, a lack of core is not.
    /// You can increase soft limits up to their corresponding hard limits.
    ///
    /// The corresponding C error is `ENOMEM`.
    case noMemory

    /// Permission denied.
    ///
    /// You attempted to access a file
    /// in a way that's forbidden by the file's access permissions.
    ///
    /// The corresponding C error is `EACCES`.
    case permissionDenied

    /// Bad address.
    ///
    /// An address passed as an argument to a system call was invalid.
    ///
    /// The corresponding C error is `EFAULT`.
    case badAddress

    /// Resource busy.
    ///
    /// You attempted to use a system resource which was in use at the time,
    /// in a manner that would have conflicted with the request.
    ///
    /// The corresponding C error is `EBUSY`.
    case resourceBusy

    /// File exists.
    ///
    /// An existing file was mentioned in an inappropriate context;
    /// for example, as the new link name in a link function.
    ///
    /// The corresponding C error is `EEXIST`.
    case fileExists

    /// Improper link.
    ///
    /// You attempted to create a hard link to a file on another file system.
    ///
    /// The corresponding C error is `EXDEV`.
    case improperLink

    /// Operation not supported by device.
    ///
    /// You attempted to apply an inappropriate function to a device;
    /// for example, trying to read a write-only device such as a printer.
    ///
    /// The corresponding C error is `ENODEV`.
    case operationNotSupportedByDevice

    /// Not a directory.
    ///
    /// A component of the specified pathname exists,
    /// but it wasn't a directory,
    /// when a directory was expected.
    ///
    /// The corresponding C error is `ENOTDIR`.
    case notDirectory

    /// Is a directory.
    ///
    /// You attempted to open a directory with write mode specified.
    /// Directories can be opened only in read mode.
    ///
    /// The corresponding C error is `EISDIR`.
    case isDirectory

    /// Invalid argument.
    ///
    /// One or more of the specified arguments wasn't valid;
    /// for example, specifying an undefined signal to a signal or kill function.
    ///
    /// The corresponding C error is `EINVAL`.
    case invalidArgument

    /// The system has too many open files.
    ///
    /// The maximum number of file descriptors
    /// allowable on the system has been reached;
    /// requests to open a file can't be satisfied
    /// until you close at least one file descriptor.
    ///
    /// The corresponding C error is `ENFILE`.
    case tooManyOpenFilesInSystem

    /// This process has too many open files.
    ///
    /// To check the current limit,
    /// call the `getdtablesize` function.
    ///
    /// The corresponding C error is `EMFILE`.
    case tooManyOpenFiles

    /// The file is too large.
    ///
    /// The file exceeds the maximum size allowed by the file system.
    /// For example, the maximum size on UFS is about 2.1 gigabytes,
    /// and about 9,223 petabytes on HFS-Plus and Apple File System.
    ///
    /// The corresponding C error is `EFBIG`.
    case fileTooLarge

    /// Device out of space.
    ///
    /// A write to an ordinary file,
    /// the creation of a directory or symbolic link,
    /// or the creation of a directory entry failed
    /// because there aren't any available disk blocks on the file system,
    /// or the allocation of an inode for a newly created file failed
    /// because there aren't any inodes available on the file system.
    ///
    /// The corresponding C error is `ENOSPC`.
    case noSpace

    /// Illegal seek.
    ///
    /// An `lseek(2)` function was issued on a socket, pipe or FIFO.
    ///
    /// The corresponding C error is `ESPIPE`.
    case illegalSeek

    /// Read-only file system.
    ///
    /// You attempted to modify a file or directory
    /// on a file system that was read-only at the time.
    ///
    /// The corresponding C error is `EROFS`.
    case readOnlyFileSystem

    /// Too many links.
    ///
    /// The maximum number of hard links to a single file (32767)
    /// has been exceeded.
    ///
    /// The corresponding C error is `EMLINK`.
    case tooManyLinks

    /// Broken pipe.
    ///
    /// You attempted to write to a pipe, socket, or FIFO
    /// that doesn't have a process reading its data.
    ///
    /// The corresponding C error is `EPIPE`.
    case brokenPipe

    /// Numerical argument out of domain.
    ///
    /// A numerical input argument was outside the defined domain of the
    /// mathematical function.
    ///
    /// The corresponding C error is `EDOM`.
    case outOfDomain

    /// Numerical result out of range.
    ///
    /// A numerical result of the function
    /// was too large to fit in the available space;
    /// for example, because it exceeded a floating point number's
    /// level of precision.
    ///
    /// The corresponding C error is `ERANGE`.
    case outOfRange

    /// Resource temporarily unavailable.
    ///
    /// This is a temporary condition;
    /// later calls to the same routine may complete normally.
    /// Make the same function call again later.
    ///
    /// The corresponding C error is `EAGAIN`.
    case resourceTemporarilyUnavailable

    /// Operation now in progress.
    ///
    /// You attempted an operation that takes a long time to complete,
    /// such as `connect(2)` or `connectx(2)`,
    /// on a nonblocking object.
    /// See also `fcntl(2)`.
    ///
    /// The corresponding C error is `EINPROGRESS`.
    case nowInProgress

    /// Operation already in progress.
    ///
    /// You attempted an operation on a nonblocking object
    /// that already had an operation in progress.
    ///
    /// The corresponding C error is `EALREADY`.
    case alreadyInProcess

    /// Destination address required.
    ///
    /// A required address was omitted from a socket operation.
    ///
    /// The corresponding C error is `EDESTADDRREQ`.
    case addressRequired

    /// A socket operation was performed on something that isn't a socket.
    ///
    /// The corresponding C error is `ENOTSOCK`.
    case notSocket

    /// Message too long.
    ///
    /// A message sent on a socket was larger than
    /// the internal message buffer or some other network limit.
    ///
    /// The corresponding C error is `EMSGSIZE`.
    case messageTooLong

    /// Protocol wrong for socket type.
    ///
    /// A protocol was specified that doesn't support
    /// the semantics of the socket type requested.
    /// For example,
    /// you can't use the ARPA Internet UDP protocol with type `SOCK_STREAM`.
    ///
    /// The corresponding C error is `EPROTOTYPE`.
    case protocolWrongTypeForSocket

    /// Protocol not available.
    ///
    /// A bad option or level was specified
    /// in a `getsockopt(2)` or `setsockopt(2)` call.
    ///
    /// The corresponding C error is `ENOPROTOOPT`.
    case protocolNotAvailable

    /// Protocol not supported.
    ///
    /// The protocol hasn't been configured into the system,
    /// or no implementation for it exists.
    ///
    /// The corresponding C error is `EPROTONOSUPPORT`.
    case protocolNotSupported

    /// Socket type not supported.
    ///
    /// Support for the socket type hasn't been configured into the system
    /// or no implementation for it exists.
    ///
    /// The corresponding C error is `ESOCKTNOSUPPORT`.
    case socketTypeNotSupported

    /// Protocol family not supported.
    ///
    /// The protocol family hasn't been configured into the system
    /// or no implementation for it exists.
    ///
    /// The corresponding C error is `EPFNOSUPPORT`.
    case protocolFamilyNotSupported

    /// The address family isn't supported by the protocol family.
    ///
    /// An address incompatible with the requested protocol was used.
    /// For example, you shouldn't necessarily expect
    /// to be able to use name server addresses with ARPA Internet protocols.
    ///
    /// The corresponding C error is `EAFNOSUPPORT`.
    case addressFamilyNotSupported

    /// Address already in use.
    ///
    /// Only one use of each address is normally permitted.
    ///
    /// The corresponding C error is `EADDRINUSE`.
    case addressInUse

    /// Can't assign the requested address.
    ///
    /// This error normally results from
    /// an attempt to create a socket with an address that isn't on this machine.
    ///
    /// The corresponding C error is `EADDRNOTAVAIL`.
    case addressNotAvailable

    /// Network is down.
    ///
    /// A socket operation encountered a dead network.
    ///
    /// The corresponding C error is `ENETDOWN`.
    case networkDown

    /// Network is unreachable.
    ///
    /// A socket operation was attempted to an unreachable network.
    ///
    /// The corresponding C error is `ENETUNREACH`.
    case networkUnreachable

    /// Network dropped connection on reset.
    ///
    /// The host you were connected to crashed and restarted.
    ///
    /// The corresponding C error is `ENETRESET`.
    case networkReset

    /// Software caused a connection abort.
    ///
    /// A connection abort was caused internal to your host machine.
    ///
    /// The corresponding C error is `ECONNABORTED`.
    case connectionAbort

    /// Connection reset by peer.
    ///
    /// A connection was forcibly closed by a peer.
    /// This normally results from a loss of the connection
    /// on the remote socket due to a timeout or a reboot.
    ///
    /// The corresponding C error is `ECONNRESET`.
    case connectionReset

    /// No buffer space available.
    ///
    /// An operation on a socket or pipe wasn't performed
    /// because the system lacked sufficient buffer space
    /// or because a queue was full.
    ///
    /// The corresponding C error is `ENOBUFS`.
    case noBufferSpace

    /// Socket is already connected.
    ///
    /// A `connect(2)` or `connectx(2)` request was made
    /// on an already connected socket,
    /// or a `sendto(2)` or `sendmsg(2)` request was made
    /// on a connected socket specified a destination when already connected.
    ///
    /// The corresponding C error is `EISCONN`.
    case socketIsConnected

    /// Socket is not connected.
    ///
    /// A request to send or receive data wasn't permitted
    /// because the socket wasn't connected and,
    /// when sending on a datagram socket,
    /// no address was supplied.
    ///
    /// The corresponding C error is `ENOTCONN`.
    case socketNotConnected

    /// Can't send after socket shutdown.
    ///
    /// A request to send data wasn't permitted
    /// because the socket had already been shut down
    /// with a previous `shutdown(2)` call.
    ///
    /// The corresponding C error is `ESHUTDOWN`.
    case socketShutdown

    /// Operation timed out.
    ///
    /// A `connect(2)`, `connectx(2)` or `send(2)` request failed
    /// because the connected party didn't properly respond
    /// within the required period of time.
    /// The timeout period is dependent on the communication protocol.
    ///
    /// The corresponding C error is `ETIMEDOUT`.
    case timedOut

    /// Connection refused.
    ///
    /// No connection could be made
    /// because the target machine actively refused it.
    /// This usually results from trying to connect to a service
    /// that's inactive on the foreign host.
    ///
    /// The corresponding C error is `ECONNREFUSED`.
    case connectionRefused

    /// Too many levels of symbolic links.
    ///
    /// A pathname lookup involved more than eight symbolic links.
    ///
    /// The corresponding C error is `ELOOP`.
    case tooManySymbolicLinkLevels

    /// The file name is too long.
    ///
    /// A component of a pathname exceeded 255 (`MAXNAMELEN`) characters,
    /// or an entire pathname exceeded 1023 (`MAXPATHLEN-1`) characters.
    ///
    /// The corresponding C error is `ENAMETOOLONG`.
    case fileNameTooLong

    /// The host is down.
    ///
    /// A socket operation failed because the destination host was down.
    ///
    /// The corresponding C error is `EHOSTDOWN`.
    case hostIsDown

    /// No route to host.
    ///
    /// A socket operation failed because the destination host was unreachable.
    ///
    /// The corresponding C error is `EHOSTUNREACH`.
    case noRouteToHost

    /// Directory not empty.
    ///
    /// A directory with entries other than `.` and `..`
    /// was supplied to a `remove(2)` directory or `rename(2)` call.
    ///
    /// The corresponding C error is `ENOTEMPTY`.
    case directoryNotEmpty

    /// Too many users.
    ///
    /// The quota system ran out of table entries.
    ///
    /// The corresponding C error is `EUSERS`.
    case tooManyUsers

    /// Disk quota exceeded.
    ///
    /// A write to an ordinary file,
    /// the creation of a directory or symbolic link,
    /// or the creation of a directory entry failed
    /// because the user's quota of disk blocks was exhausted,
    /// or the allocation of an inode for a newly created file failed
    /// because the user's quota of inodes was exhausted.
    ///
    /// The corresponding C error is `EDQUOT`.
    case diskQuotaExceeded

    /// Stale NFS file handle.
    ///
    /// You attempted access an open file on an NFS filesystem,
    /// which is now unavailable as referenced by the given file descriptor.
    /// This may indicate that the file was deleted on the NFS server
    /// or that some other catastrophic event occurred.
    ///
    /// The corresponding C error is `ESTALE`.
    case staleNFSFileHandle

    /// No locks available.
    ///
    /// You have reached the system-imposed limit
    /// on the number of simultaneous files.
    ///
    /// The corresponding C error is `ENOLCK`.
    case noLocks

    /// Function not implemented.
    ///
    /// You attempted a system call that isn't available on this system.
    ///
    /// The corresponding C error is `ENOSYS`.
    case noFunction

    /// Operation canceled.
    ///
    /// The scheduled operation was canceled.
    ///
    /// The corresponding C error is `ECANCELED`.
    case canceled

    /// Illegal byte sequence.
    ///
    /// While decoding a multibyte character,
    /// the function encountered an invalid or incomplete sequence of bytes,
    /// or the given wide character is invalid.
    ///
    /// The corresponding C error is `EILSEQ`.
    case illegalByteSequence

    /// Operation not supported on socket.
    ///
    /// The attempted operation isn't supported for the type of socket referenced;
    /// for example, trying to accept a connection on a datagram socket.
    ///
    /// The corresponding C error is `EOPNOTSUPP`.
    case notSupportedOnSocket

    /// Operation would block.
    ///
    /// The corresponding C error is `EWOULDBLOCK`.
    case wouldBlock

    /// Too many references: can't splice.
    ///
    /// The corresponding C error is `ETOOMANYREFS`.
    case tooManyReferences

    /// Too many levels of remote in path.
    ///
    /// The corresponding C error is `EREMOTE`.
    case tooManyRemoteLevels

    /// Unspecified error returned by the OS.
    case unspecified(errorCode: Code)

    public init(code: Code) {
        switch code {
        case _EPERM:
            self = .notPermitted
        case _ENOENT:
            self = .noSuchFileOrDirectory
        case _ESRCH:
            self = .noSuchProcess
        case _EINTR:
            self = .interrupted
        case _EIO:
            self = .ioError
        case _ENXIO:
            self = .noSuchAddressOrDevice
        case _E2BIG:
            self = .argListTooLong
        case _ENOEXEC:
            self = .execFormatError
        case _EBADF:
            self = .badFileDescriptor
        case _ECHILD:
            self = .noChildProcess
        case _EDEADLK:
            self = .deadlock
        case _ENOMEM:
            self = .noMemory
        case _EACCES:
            self = .permissionDenied
        case _EFAULT:
            self = .badAddress
        case _EBUSY:
            self = .resourceBusy
        case _EEXIST:
            self = .fileExists
        case _EXDEV:
            self = .improperLink
        case _ENODEV:
            self = .operationNotSupportedByDevice
        case _ENOTDIR:
            self = .notDirectory
        case _EISDIR:
            self = .isDirectory
        case _EINVAL:
            self = .invalidArgument
        case _ENFILE:
            self = .tooManyOpenFilesInSystem
        case _EMFILE:
            self = .tooManyOpenFiles
        case _EFBIG:
            self = .fileTooLarge
        case _ENOSPC:
            self = .noSpace
        case _ESPIPE:
            self = .illegalSeek
        case _EROFS:
            self = .readOnlyFileSystem
        case _EMLINK:
            self = .tooManyLinks
        case _EPIPE:
            self = .brokenPipe
        case _EDOM:
            self = .outOfDomain
        case _ERANGE:
            self = .outOfRange
        case _EAGAIN:
            self = .resourceTemporarilyUnavailable
        case _EINPROGRESS:
            self = .nowInProgress
        case _EALREADY:
            self = .alreadyInProcess
        case _ENOTSOCK:
            self = .notSocket
        case _EDESTADDRREQ:
            self = .addressRequired
        case _EMSGSIZE:
            self = .messageTooLong
        case _EPROTOTYPE:
            self = .protocolWrongTypeForSocket
        case _ENOPROTOOPT:
            self = .protocolNotAvailable
        case _EPROTONOSUPPORT:
            self = .protocolNotSupported
        case _ESOCKTNOSUPPORT:
            self = .socketTypeNotSupported
        case _EPFNOSUPPORT:
            self = .protocolFamilyNotSupported
        case _EAFNOSUPPORT:
            self = .addressFamilyNotSupported
        case _EADDRINUSE:
            self = .addressInUse
        case _EADDRNOTAVAIL:
            self = .addressNotAvailable
        case _ENETDOWN:
            self = .networkDown
        case _ENETUNREACH:
            self = .networkUnreachable
        case _ENETRESET:
            self = .networkReset
        case _ECONNABORTED:
            self = .connectionAbort
        case _ECONNRESET:
            self = .connectionReset
        case _ENOBUFS:
            self = .noBufferSpace
        case _EISCONN:
            self = .socketIsConnected
        case _ENOTCONN:
            self = .socketNotConnected
        case _ESHUTDOWN:
            self = .socketShutdown
        case _ETIMEDOUT:
            self = .timedOut
        case _ECONNREFUSED:
            self = .connectionRefused
        case _ELOOP:
            self = .tooManySymbolicLinkLevels
        case _ENAMETOOLONG:
            self = .fileNameTooLong
        case _EHOSTDOWN:
            self = .hostIsDown
        case _EHOSTUNREACH:
            self = .noRouteToHost
        case _ENOTEMPTY:
            self = .directoryNotEmpty
        case _EUSERS:
            self = .tooManyUsers
        case _EDQUOT:
            self = .diskQuotaExceeded
        case _ESTALE:
            self = .staleNFSFileHandle
        case _ENOLCK:
            self = .noLocks
        case _ENOSYS:
            self = .noFunction
        case _ECANCELED:
            self = .canceled
        case _EILSEQ:
            self = .illegalByteSequence
        case _EOPNOTSUPP:
            self = .notSupportedOnSocket
        case _EWOULDBLOCK:
            self = .wouldBlock
        case _ETOOMANYREFS:
            self = .tooManyReferences
        case _EREMOTE:
            self = .tooManyRemoteLevels
        default:
            self = .unspecified(errorCode: code)
        }
    }

    #if os(Windows)
    public typealias Code = UInt32
    #else
    public typealias Code = Int32
    #endif

    var rawValue: Code {
        switch self {
        case .notPermitted:
            return _EPERM
        case .noSuchFileOrDirectory:
            return _ENOENT
        case .noSuchProcess:
            return _ESRCH
        case .interrupted:
            return _EINTR
        case .ioError:
            return _EIO
        case .noSuchAddressOrDevice:
            return _ENXIO
        case .argListTooLong:
            return _E2BIG
        case .execFormatError:
            return _ENOEXEC
        case .badFileDescriptor:
            return _EBADF
        case .noChildProcess:
            return _ECHILD
        case .deadlock:
            return _EDEADLK
        case .noMemory:
            return _ENOMEM
        case .permissionDenied:
            return _EACCES
        case .badAddress:
            return _EFAULT
        case .resourceBusy:
            return _EBUSY
        case .fileExists:
            return _EEXIST
        case .improperLink:
            return _EXDEV
        case .operationNotSupportedByDevice:
            return _ENODEV
        case .notDirectory:
            return _ENOTDIR
        case .isDirectory:
            return _EISDIR
        case .invalidArgument:
            return _EINVAL
        case .tooManyOpenFilesInSystem:
            return _ENFILE
        case .tooManyOpenFiles:
            return _EMFILE
        case .fileTooLarge:
            return _EFBIG
        case .noSpace:
            return _ENOSPC
        case .illegalSeek:
            return _ESPIPE
        case .readOnlyFileSystem:
            return _EROFS
        case .tooManyLinks:
            return _EMLINK
        case .brokenPipe:
            return _EPIPE
        case .outOfDomain:
            return _EDOM
        case .outOfRange:
            return _ERANGE
        case .resourceTemporarilyUnavailable:
            return _EAGAIN
        case .nowInProgress:
            return _EINPROGRESS
        case .alreadyInProcess:
            return _EALREADY
        case .notSocket:
            return _ENOTSOCK
        case .addressRequired:
            return _EDESTADDRREQ
        case .messageTooLong:
            return _EMSGSIZE
        case .protocolWrongTypeForSocket:
            return _EPROTOTYPE
        case .protocolNotAvailable:
            return _ENOPROTOOPT
        case .protocolNotSupported:
            return _EPROTONOSUPPORT
        case .socketTypeNotSupported:
            return _ESOCKTNOSUPPORT
        case .protocolFamilyNotSupported:
            return _EPFNOSUPPORT
        case .addressFamilyNotSupported:
            return _EAFNOSUPPORT
        case .addressInUse:
            return _EADDRINUSE
        case .addressNotAvailable:
            return _EADDRNOTAVAIL
        case .networkDown:
            return _ENETDOWN
        case .networkUnreachable:
            return _ENETUNREACH
        case .networkReset:
            return _ENETRESET
        case .connectionAbort:
            return _ECONNABORTED
        case .connectionReset:
            return _ECONNRESET
        case .noBufferSpace:
            return _ENOBUFS
        case .socketIsConnected:
            return _EISCONN
        case .socketNotConnected:
            return _ENOTCONN
        case .socketShutdown:
            return _ESHUTDOWN
        case .timedOut:
            return _ETIMEDOUT
        case .connectionRefused:
            return _ECONNREFUSED
        case .tooManySymbolicLinkLevels:
            return _ELOOP
        case .fileNameTooLong:
            return _ENAMETOOLONG
        case .hostIsDown:
            return _EHOSTDOWN
        case .noRouteToHost:
            return _EHOSTUNREACH
        case .directoryNotEmpty:
            return _ENOTEMPTY
        case .tooManyUsers:
            return _EUSERS
        case .diskQuotaExceeded:
            return _EDQUOT
        case .staleNFSFileHandle:
            return _ESTALE
        case .noLocks:
            return _ENOLCK
        case .noFunction:
            return _ENOSYS
        case .canceled:
            return _ECANCELED
        case .illegalByteSequence:
            return _EILSEQ
        case .notSupportedOnSocket:
            return _EOPNOTSUPP
        case .wouldBlock:
            return _EWOULDBLOCK
        case .tooManyReferences:
            return _ETOOMANYREFS
        case .tooManyRemoteLevels:
            return _EREMOTE
        case let .unspecified(code):
            return code
        }
    }
}
