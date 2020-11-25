# Pathos API Reference

This document is a complete reference to Pathos' public API.

Conventions used in this document:

* `var`s, `func`s, `static func`s are members of a type in the enclosing documentation section.
  Types are defined in the global scope of the package regardless of where the documentation is
  listed.
* Members of a type that satisfies a protocol is documented in the section of the protocol. It is
  omitted from the conforming type itself.

##### Table of content

* [Path][]
    * [Components of a path][]
    * [Joining/concatenating paths][]
    * [Working with temporary directories][]
    * [Current working directory][]
    * [Discover related paths][]
    * [Symbolic link (symlink)][]
    * [Working with metadata][]
    * [Editing the file system][]
    * [Reading/Writing normal files][]
* [PurePath][]
    * [PurePOSIXPath][]
    * [PureWindowsPath][]
* [Metadata][]
    * [FileTime][]
    * [FileType][]
        * [POSIXFileType][]
        * [WindowsFileType][]
    * [Permissions][]
        * [POSIXPermissions][]
        * [WindowsAttributes][]
* [PathConvertible][]
    * [POSIXPathConvertible][]
    * [WindowsPathConvertible][]
* [SystemError][]
* [NativeEncodingUnit][]
* [Constants][]
    * [WindowsConstants][]
    * [POSIXConstants][]


[Path]: Path.md
[Components of a path]: Path.md#components-of-a-path
[Joining/concatenating paths]: Path.md#joining-paths
[Working with temporary directories]: Path.md#working-with-temporary-directories
[Current working directory]: Path.md#current-working-directory
[Discover related paths]: Path.md#discover-related-paths
[Symbolic link (symlink)]: Path.md#symlink
[Working with metadata]: Path.md#working-with-metadata
[Editing the file system]: Path.md#editing-the-file-system
[Reading/Writing normal files]: Path.md#reading-writing-normal-files
[PathConvertible]: PathConvertible.md
[POSIXPathConvertible]: POSIXPathConvertible.md
[WindowsPathConvertible]: WindowsPathConvertible.md
[SystemError]: SystemError.md
[PurePath]: PurePath.md
[PurePOSIXPath]: PurePOSIXPath.md
[PureWindowsPath]: PureWindowsPath.md
[Metadata]: Metadata.md
[FileTime]: FileTime.md
[FileType]: FileType.md
[POSIXFileType]: POSIXFileType.md
[WindowsFileType]: WindowsFileType.md
[Permissions]: Permissions.md
[POSIXPermissions]: POSIXPermissions.md
[WindowsAttributes]: WindowsAttributes.md
[NativeEncodingUnit]: NativeEncodingUnit.md
[Constants]: Constants.md
[POSIXConstants]: POSIXConstants.md
[WindowsConstants]: WindowsConstants.md
