## ⚠️ Warning: In Development ⚠️

This library is in pre-release status. Using it in production is probably not
a great idea just yet.

# Pathos

A file management library for Swift.

## Development

Use `make` targets for development.

- `make build` builds the library in release configuration. This command also
    checks whether there's any test changes and update the Linux test manifest
    on macOS (or remind you to do so on Linux).
- `make test` runs all tests.
- `make generate-linux-test-manifest` updates the test manifest for Linux. This
    downloads [Sourcery](https://github.com/krzysztofzablocki/Sourcery) version
    specified in `.sourcery-version` if necessary. This command is ran on macOS
    during `make build`.
- `make clean` deletes build artifacts including SPM build folders and other
    artifacts.

