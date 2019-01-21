#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring.
public func copyFile(fromPath source: String, toPath destination: String, followSymbolicLink: Bool = true, chunkSize: Int = 1024 * 16) throws {
    var sourceStatus = try _lstat(at: source)
    let destinationStatus = try? _stat(at: destination)
    if _ifmt(sourceStatus) != S_IFREG && _ifmt(sourceStatus) != S_IFLNK {
        throw PathosError.copyingNeitherFileNorSymlink(path: source)
    }

    if (destinationStatus.map { _ifmt($0) }) == S_IFIFO {
        throw PathosError.attemptToCopyToNamedPipe(path: destination)
    }

    if let destinationStatus = destinationStatus, _sameStat(sourceStatus, destinationStatus) {
        return // nothing to be done
    }

    // some question from Python's standard library: What about other special files? (sockets, devices...)

    let isLink = _ifmt(sourceStatus) == S_IFLNK
    if !followSymbolicLink && isLink {
        try makeSymbolicLink(fromPath: readSymbolicLink(atPath: source), toPath: destination)
        return
    }

    if isLink {
        sourceStatus = try _stat(at: source)
    }

    let sourceFD = open(source, O_RDONLY)
    if sourceFD == -1 {
        throw SystemError(posixErrorCode: errno)
    }
    defer { close(sourceFD) }
    let destinationFD = open(destination, O_WRONLY | O_CREAT)
    if destinationFD == -1 {
        throw SystemError(posixErrorCode: errno)
    }
    defer { close(destinationFD) }

    var buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: chunkSize)
    defer { buffer.deallocate() }

    defer {
        chmod(destination, sourceStatus.st_mode)
    }

    var position: off_t = 0
    while true {
        let length = pread(sourceFD, buffer.baseAddress!, chunkSize, position)
        if length == 0 {
            break
        }
        pwrite(destinationFD, buffer.baseAddress!, length, position)
        position = position + off_t(length)
    }
}

extension PathRepresentable {
    // TODO: missing docstring.
    public func copy(to destination: PathRepresentable, followSymbolicLink: Bool = true, chunkSize: Int = 1024 * 16) -> Bool {
        do {
            try copyFile(fromPath: self.pathString, toPath: destination.pathString, followSymbolicLink: followSymbolicLink, chunkSize: chunkSize)
        } catch {
            return false
        }
        return true
    }
}
