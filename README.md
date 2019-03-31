# Pathos

Pathos is everything you need for file system¹ inquiry and manipulation.

For a taste what that means, let's generate a static site from Markdown files!

```swift
// Create a unique, temporary directory.
let temporaryRoot = try createTemporaryDirectory()

// Find paths to .md files relative to current working directory, recursively.
for markdown in try glob("**/*.md") {

    // path/to/file.md -> path/to/file. This will be the URL.
    let url = basename(ofPath: markdown)

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

Pathos offers conventional OOP interfaces to all of these functions as well.

Read the [documentation][] to learn more.

For an example of real application, checkout [tre][].

¹ Unix [virtual file system][], as opposed to underlying system such as APFS,
Ext4, btrfs etc.

[tre]: https://github.com/dduan/tre
[documentation]: https://dduan.github.io/Pathos
[virtual file system]: https://en.wikipedia.org/wiki/Virtual_file_system

## Installation

#### With [CocoaPods](http://cocoapods.org/)

```ruby
use_frameworks!

pod "Pathos"
```

#### With [Carthage](https://github.com/Carthage/Carthage)

```
github "dduan/Pathos"
```

#### With [SwiftPM](https://swift.org/package-manager)

```
.package(url: "http://github.com/dduan/Pathos", from: "0.1.2")
```
## Overview

Pathos includes a ton of interfaces ([Battery included](#design-goals)). Here's
a rough breakdown and links to API [documentation][].

|Section                 | Description                                                               |
|------------------------|---------------------------------------------------------------------------|
| [POP and OOP][]        | Protocols and types for OOP interfaces.                                   |
| [Finding Files][]      | Discover child in folders by pattern or file type.                        |
| [File IO][]            | Reading and writing files and symoblic links.                             |
| [Manipulating Paths][] | Deleting/moving/creating directories.                                     |
| [Analyzing Paths][]    | Properties about the path, such as its equivalent absolute path.          |
| [Temporary Paths][]    | Temporary and unique files and directories.                               |
| [Relationships][]      | Relationships between multiple paths. Joining, common components, etc.    |
| [Working Directory][]  | Getting/setting current working directory.                                |
| [System Attributes][]  | File size, access time, permissions, etc.                                 |
| [Existence][]          | Find out if a path points to an existing file, the type of the file, etc. |
| [Constants][]          | Public constants.                                                         |
| [Errors][]             | Errors Pathos throw in various places.                                    |

[POP and OOP]: https://dduan.github.io/Pathos/POP%20and%20OOP.html
[Finding Files]: https://dduan.github.io/Pathos/Finding%20Files.html
[File IO]: https://dduan.github.io/Pathos/File%20IO.html
[Manipulating Paths]: https://dduan.github.io/Pathos/Manipulating%20Paths.html
[Analyzing Paths]: https://dduan.github.io/Pathos/Analyzing%20Paths.html
[Temporary Paths]: https://dduan.github.io/Pathos/Temporary%20Paths.html
[Relationships]: https://dduan.github.io/Pathos/Relationship.html
[Working Directory]: https://dduan.github.io/Pathos/Working%20Directory.html
[System Attributes]: https://dduan.github.io/Pathos/System%20Attributes.html
[Existence]: https://dduan.github.io/Pathos/Existence.html
[Constants]: https://dduan.github.io/Pathos/Constants.html
[Errors]: https://dduan.github.io/Pathos/Errors.html

## Design Goals

1. **Provide as few abstractions atop POSIX file API as possible, but no
   fewer.** Make conventional C APIs Swift-y, but avoid over-abstraction. Use
   string for path values for efficiency and simplicity. User can trivially and
   incrementally add on abstractions for their needs.
2. **Battery included**. Include a well-rounded set of convenience for file
   manipulations. (Python users, for example, should feel right at home).
3. **Support OOP**. Almost everything in Pathos is available in 2 paradigms:
   procedural (free functions) and OOP (methods). A _super_ simple protocol,
   `PathRepresentable`, serves as the root for all functionalities.
4. **Error handling can be optional**. In practice, specific POSIX error code is
   often not more actionable than _some_ indication that things went wrong.
   Therefore, the OOP interfaces from Pathos hides the system errors. Users can
   opt in and out of the overhead of dealing with POSIX errors by switching
   between paradigms. For example, instead of throwing out errors such as lack
   of permission, `PathRepresentable.delete()` simply returns `false` to
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
- `make test-docker` runs tests in Linux docker container (you'll need Docker
  installed in your host).

### Releasing

See `RELEASING.md`.

## License

MIT. See `LICENSE.md`.
