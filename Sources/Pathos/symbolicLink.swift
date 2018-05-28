#if os(Linux)
import Glibc
#else
import Darwin
#endif

func makeSymbolicLink(fromPath source: String, toPath destination: String) throws {
    if symlink(source, destination) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    func makeSymbolicLink(to destination: Self) -> Bool {
        return (try? makeSymbolicLink(fromPath:toPath:)(self.pathString, destination.pathString)) != nil
    }
}
