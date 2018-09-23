// TODO: Missing implementation.
// TODO: Missing unit tests.
// TODO: Missing docstring.
public func makeTemporaryFile(withSuffix suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) throws -> String {
    fatalError("unimplemented")
}

// TODO: Missing implementation.
// TODO: Missing unit tests.
// TODO: Missing docstring.
public func makeTemporaryDirectory(withSuffix suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) throws -> String {
    fatalError("unimplemented")
}

extension PathRepresentable {
    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public func makeTemporaryFile(withSuffix suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) -> Self? {
        do {
            return Self(string: try Pathos.makeTemporaryFile(withSuffix:prefix:inDirectory:)(suffix, prefix, directory))
        } catch {
            return nil
        }
    }

    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public func makeTemporaryDirectory(withSuffix suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) -> Self? {
        do {
            return Self(string: try Pathos.makeTemporaryDirectory(withSuffix:prefix:inDirectory:)(suffix, prefix, directory))
        } catch {
            return nil
        }
    }

    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public static func makeTemporaryFile(withSuffix suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) -> Self? {
        do {
            return Self(string: try Pathos.makeTemporaryFile(withSuffix:prefix:inDirectory:)(suffix, prefix, directory))
        } catch {
            return nil
        }
    }

    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public static func makeTemporaryDirectory(withSuffix suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) -> Self? {
        do {
            return Self(string: try Pathos.makeTemporaryDirectory(withSuffix:prefix:inDirectory:)(suffix, prefix, directory))
        } catch {
            return nil
        }
    }
}
