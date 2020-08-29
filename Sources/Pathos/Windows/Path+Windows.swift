#if os(Windows)
extension Path {
    public static func workingDirectory() throws -> Path {
        throw SystemError.unspecified(errorCode: 0)
    }
}
#endif // os(Windows)
