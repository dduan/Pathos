![Banner](Resources/Assets/Banner.png)

Pathos offers cross-platform virtual file system APIs for Swift.

Pathos is implement from ground-up with on each OS's native API. It has zero dependencies.

Windows support is currently considered *experimental*.

| Swift 5.3 & 5.4.2 |
|-|
|[![Amazon Linux 2](https://github.com/dduan/Pathos/workflows/Amazon%20Linux%202/badge.svg)](https://github.com/dduan/Pathos/actions?query=workflow%3A%22Amazon+Linux+2%22)|
|[![CentOS 8](https://github.com/dduan/Pathos/workflows/CentOS%208/badge.svg)](https://github.com/dduan/Pathos/actions?query=workflow%3A%22CentOS+8%22)|
|[![macOS 11.15](https://github.com/dduan/Pathos/workflows/macOS%2011.15/badge.svg)](https://github.com/dduan/Pathos/actions?query=workflow%3A%22macOS+11.15%22)|
|[![Ubuntu Bionic](https://github.com/dduan/Pathos/workflows/Ubuntu%20Bionic/badge.svg)](https://github.com/dduan/Pathos/actions?query=workflow%3A%22Ubuntu+Bionic%22)|
|[![Ubuntu Focal](https://github.com/dduan/Pathos/workflows/Ubuntu%20Focal/badge.svg)](https://github.com/dduan/Pathos/actions?query=workflow%3A%22Ubuntu+Focal%22)|
|[![Windows 2019](https://github.com/dduan/Pathos/workflows/Windows%202019/badge.svg) (Experimental)](https://github.com/dduan/Pathos/actions?query=workflow%3A%22Windows+2019%22)

For a taste of Pathos, let's generate a static site from Markdown!

```swift
import Pathos

// Set the CWD and execute a closure
try Path("markdown-source-dir").asWorkingDirectory {
    // Build the site in a unique, temporary directory
    let temporaryRoot = try Path.makeTemporaryDirectory()
    
    // Joining path components that works across OSes.
    // E.g. `articles/**/*.md` on POSIX systems.
    let pattern = Path("articles") + "**" + "*.md"
    
    // Use glob to find files that matches the pattern
    for markdown in try pattern.glob() {
        // path/to/file.md => path/to/file
        let url = markdown.base
        
        // path that contains index.html
        let htmlDirectory = temporaryRoot + url
        
        // make a directory, including multiple levels
        try htmlDirectory.makeDirectory(withParents: true)
        
        // read content of a file
        let source = try markdown.readUTF8String()
        
        // write out the html, imagine `markdown2html` exists
        try (htmlDirectory + "index.html").write(utf8: markdown2html(source))
    }

    // all done! move the built site to output directory
    try temporaryRoot.move(to: "output")
}
// CWD is restored after the closure is done
```

As you can see, Pathos offers a whole suite of APIs for inspecting and manipulating the file system. Programs built with Pathos compile and work on all supported OS without the need to use `#if OS()` in the source.

There are more [Examples](./Examples) for the curious.

## Installation

#### With [SwiftPM](https://swift.org/package-manager)

```swift
.package(url: "http://github.com/dduan/Pathos", from: "0.4.0")
```

## Documentation

1. [User Guide][] - A tour of Pathos for introduction purposes.
2. [API Refererence][] - Complete reference to Pathos public APIs.
3. [Design][] - Answers for why an API is designed as such.
4. [Change Log][] - Change logs for all Pathos versions.

You may also checkout the [Example apps][].

## License

Pathos is released under the MIT license. See [LICENSE.md](./LICENSE.md)


[Design]: Documentation/design.md
[Change Log]: CHANGELOG.md
[User Guide]: Documentation/UserGuide.md
[API Refererence]: Documentation/APIs/README.md
[Example apps]: ./Examples
