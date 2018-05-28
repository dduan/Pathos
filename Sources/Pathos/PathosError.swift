enum PathosError: Error {
    case attemptToCopyToNamedPipe(path: String)
    case copyingNeitherFileNorSymblink(path: String)
}
