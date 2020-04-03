## master

- Added a new type `Metadata`, which represents information from `stat` (Darwin,
  Linux) or `statx` (Linux).
- Added API to retrieve `Metadata`.

## 0.2.3

- Re-implemented `children(inPath:recursive)` to fix issue #122

## 0.2.2

- Removed a build warning in Swift 5.2
