## master

## BREAKING CHANGES

While the functionality of this library remain compatible with previous release, its public API has gone
through a major re-design, making this release significantly source-breaking.

The goals for the redesign are

1. Be more conventional in the Swift ecosystem by eliminating the "free functions".
2. Make the selection of APIs **cross-platform**, including macOS, Linux, Windows 10, and future platforms
   Swift runs on.

## 0.3.2

- Fix a bug where `children` always recusively visit its content when following symlinks.

## 0.3.1

- children() can follow symlinks found in the content if `followSymlink`
  parameter is set to `True`.
- expand Linux distro support to match that of Swift's.

## 0.3.0

### Fixes

- Warnings in Swift 5.3

### New

- Added a new type `Metadata`, which represents information from `stat` (Darwin,
  Linux).
- Added API to retrieve `Metadata`.
- `PathRepresentable.set(_:)` (permissions)


### Deprecations

The following APIs are deprecated in favor of metadata access APIs.

- `size(atPath)`
- `modificationTime(atPath:)`
- `accessTime(atPath:)`
- `metadataChangeTime(atPath:)`
- `PathRepresentable.size`
- `PathRepresentable.modificationTime`
- `PathRepresentable.accessTime`
- `PathRepresentable.metadataChangeTime`
- `permissions(forPath:)`
- `PathRepresentable.permissions`

Removed adding/removing permissions in favor of directly setting it:

- `add(_:forPath:)`
- `remove(_:forPath:)`
- `PathRepresentable.add(_:)`
- `PathRepresentable.remove(_:)`

Previously symbolic links were referred to as "symbol" or "symbolic link" in
APIs. From this version on, they'll be referred to as "symlink". This resulted
in the following changes:

- `createSymbolicLink(fromPath:toPath:)` -> `createSymlink(fromPath:toPath:)`
- `PathRepresentable.createSymbolicLink(at:)` -> `PathRepresentable.createSymlink(at:)`
- `readSymbolicLink(atPath:toPath)` -> `readSymlink(atPath:toPath)`
- `PathRepresentable.readSymbolicLink()` -> `PathRepresentable.readSymlink()`
- `FileType.symbolicLink` -> `FileType.symlink`

Carthage is no longer supported.

### Breaking changes

Previously symbolic links were referred to as "symbol" or "symbolic link" in
APIs. From this version on, they'll be referred to as "symlink". This resulted
in the following breaking changes:

- `exists(atPath:followSymbol:)` -> `exists(atPath:followSymlink:)`
- `PathRepresentable.exists(followSymbol:)` -> `PathRepresentable.exists(followSymlink:)`
- `copyFile(fromPath:toPath:followSymbolicLink:checkSize:)` -> `copyFile(fromPath:toPath:followSymlink:checkSize:)`
- `PathRepresentable.copy(to:followSymbolicLink:checkSize:)` -> `PathRepresentable.copy(to:followSymlink:checkSize:)`

## 0.2.3

- Re-implemented `children(inPath:recursive)` to fix issue #122

## 0.2.2

- Removed a build warning in Swift 5.2
