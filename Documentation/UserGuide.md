# Pathos User Guide

## Overview

Pathos is a cross-platform library for the virtual file system. It lets you inspect and manipulate
disk content on Windows and Unix without `#if os(…)`s. Pathos has no external dependencies (not even
Foundation).

Pathos includes enough APIs to for writing a typical file manager application. Or, if you prefer,
"coreutils" on Unix systems. One can perform the basic [CRUD][] actions on files, directories,
symlinks, etc. There's also conveniences such as `glob` with support for recursive patterns,
analysis for the file extensions... Pathos should meet most applications' needs for interacting
with the file system. Its API selection is comparable to Python's `os.path`.

## A brief tour

Pathos organizes its APIs around the type `Path` (surprise!). A `Path` is a address to some content
on the disk. This line creates a directory with all parent paths leading to it:

```swift
let p = Path("path/to/victory")
try p.makeDirectory(withParents: true)
```

By design, Pathos does not distinguish files and directories, nor does it promise the path points
to some thing that actually exists. Users are responsible for checking what they are dealing with:

```swift
p.exsits() // `true` means it points to something on the disk
try p.metadata().fileType.isSymlink // is this a symlink?
```

When retrieving content of directories, file types are included:

```swift
for (path, type) in try p.children() { // … }
```

A "pure path" has a subset of `Path`'s API, but they work on the "wrong" platforms. For example, one
may create and use a `PureWindowsPath` on Linux.


*The [design][] document explains why these choices were made.*

`Path`s themselves are simple binary values. You can join them:

```swift
p.joined(with: "yay") // evaluates to Path("path/to/victory/yay")
p + "yay" // alternative syntax
```

One good reason to join them this way is to make your code work cross-platform.

Sometimes it's useful to learn parts of the path:

```swift
let doc = Path(#"C:\Users\Dan\Documents\journal.md"#)
doc.drive // "C:"
doc.root // "/"
doc.segments // ["Users", "Dan", "Documents", "journal.md"]
doc.isAbsolute // true
doc.extension // ".md"
doc.parent // Path(#"C:\Users\Dan\Documents"#)
// ...
```

Earlier we used `p.metadata()`. It returns a `Metadata` type that describes information about the
file/directory:

```swift
let meta = doc.metadata()
meta.fileType.isFile
meta.permissions.isReadOnly
meta.size // file size
meta.accessed // last access time
meta.created // file creation time
// ...
```

A file's `Permission` is a protocol. To get more platform-specific information from it, cast it
to the native type `POSIXPermission` or `WindowsAttributes`:

```swift
#if !os(Windows)
if let permissions = meta.permissions as? POSIXPermission {
    permissions.contains(.groupExecute) /// is the group execution bit on?
}
#endif
```

It's common to alter the current working directory to perform some work and restore the original:

```swift
try Path("an/other/place").asWorkingDirectory {
    // Code here will run with "an/other/place" as the cwd
}
// the cwd here is the same as start of this segment
```

… you can manually set and reset the working directory as well.

Working with temporary directory is similar:

```swift
try Path.withTemporaryDirectory { temp in
    // temp is a directory that's guaranteed to be writable
}
// "temp" no longer exists here.
```

Finally, basic reading/writing operations are included for practicality. Although this is not the
focus of Pathos.

```swift
try doc.readBytes() // [CChar]
try doc.readUTFString() // String decoded as UTF-8
try doc.write("寿司", encoding: UTF16.self, truncate: true) // replace the file with UTF-16 encoded string.
```

That's a brief introduction to what Pathos has to offer. Many more APIs aren't covered here. You
can find them in API references.

[CRUD]: https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
[design]: design.md
