## master

- Added a new type `Metadata`, which represents information from `stat` (Darwin,
  Linux).
- Added API to retrieve `Metadata`.

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

The following is added

- `PathRepresentable.set(_:)` (permissions)

## 0.2.3

- Re-implemented `children(inPath:recursive)` to fix issue #122

## 0.2.2

- Removed a build warning in Swift 5.2
