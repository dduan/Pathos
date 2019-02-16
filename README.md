# Pathos

A file management library for Swift.

## Overview

For a taste of what Pathos can do, let's generate a static site from Markdown
files!

```swift
// Current working directory.
let cwd = try getCurrentWorkingDirectory()
// Create a unique, temporary directory.
let temporaryRoot = try createTemporaryDirectory()
// Find paths to all .md files, recursively.
for markdown in try glob("**/*.md") {
    // Find common prefixes among paths.
    let common = commonPath(amongPaths: cwd, markdown)
    // path/to/file.md -> path/to/file. This will be the URL.
    let url = basename(ofPath: String(markdown.dropFirst(common.count)))
    // Join path segements. File system location for the URL.
    let urlPath = join(paths: temporaryRoot, url)
    // Make a directory.
    try createDirectory(atPath: urlPath)
    // Read from a file.
    let source = try readString(atPath: markdown)
    // Write to a file. `markdown2html` … just imagine it exists.
    try write(markdown2html(source), atPath: join(paths: url, "index.html"))
}
// Move a directory. Move it to where we want it!
try movePath(temporaryRoot, toPath: "output")
```

Pathos offers more conventional OOP interfaces to all of these functions as
well.

For an example of real application, checkout [tre][].

[tre]: https://github.com/dduan/tre

## Design

Pathos is designed with the following philosophy in mind.

1. **Provide as few abstractions atop POSIX file API as possible, but no
   fewer.** Make conventional C APIs Swift-y, but avoid over-abstraction. Use
   string for path values for efficiency and simplicity. User can trivially and
   incrementally add on abstractions for their needs. A _super_ simple protocol,
   `PathRepresentable`, paired with a equally simple `Path` type, serve as
   bridge to the OO world.
2. **Battery included**. Include a well-rounded set of convenience for file
   manipulations. (Python users, for example, should feel right at home).
3. **An object-oriented secondary layer hides system errors**. In production
   systems, specific POSIX error code is often not more actionable than _some_
   indication that things went wrong. This additional layer also hides most
   original system error. For example, instead of throwing out errors such as
   lack of permission, `PathRepresentable.delete()` simply returns `false` to
   indication the operation failure.

## Development

Use `make` targets for development.

- `make build` builds the library in release configuration. This command also
  checks whether there's any test changes and update the Linux test manifest
  on macOS (or remind you to do so on Linux).
- `make clean` deletes build artifacts including SPM build folders and other
  artifacts.
- `develop-linux-docker` launches a docker container with Swift. The project is
  mirrored at `/Pathos`. You can edit from the host and run/test in the
  container.
- `make carthage-archive` generates a Xcode project and a `Pathos.framework.zip`
  that can be uploaded for releases to support Carthage. This only works on
  macOS.

Also, see "Testing".

### Testing

`XCTest` is used for testing.

- `make test` runs all tests.
- `make generate-linux-test-manifest` updates the test manifest for Linux, this
  only works on macOS.
- `make test-linux-docker` runs tests in Linux docker container (you'll need
  Docker installed in your host).

### Releasing

See `RELEASING.md`.

### License

MIT. See `LICENSE.md`.
