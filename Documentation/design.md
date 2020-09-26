# Design of Pathos

Pathos offers a common API for inspecting and manipulating file systems across different operating
systems. 


## Path

Pathos operates on top of the virtual file system (referred to as "file system" in the rest of this
document) abstraction. As the name implies, its APIs are organized around the central concept of
a *path*.

In Pathos, a path refers to a *potential* location in the file system. It does not represent what
actually resides on the hard drive. Think of it as a pointer in C: it is merely an address. The
location it represents

* could be a file, a directory, or any other file types the operating system supports.
* could be a file when the process of a program starts, and becomes a directory while the process is
  still alive, or be removed.
* could turn out to be nothing at all.

Pathos does offer functionality to manipulate actual content of the file system. But it is user's
responsibility to ensure that the path points to the thing they expect, or handle errors originated
from the OS otherwise.

Paths themselves, when analyzed, are validated according to the OS convention (On Windows, UNC drive
are recognized properly, path segments are connected by `\`, for example.)

This separation of "address" and "memory" means operations such as creating a path value, or telling
whether a path is absolute, does not require access to the hard drive at all. A subset of
functionalities that belongs in this category are offered on all platforms, by "pure paths". For
example, one can create a `PureWindowsPath` on macOS and use the entirety of its APIs. "Pure path"
APIs are a strict subset of the more general "path".

While reading/writing normal files is included for practical purposes, it is not the focus of the
library. Sophisticated I/O operations such as seeking locations, streaming, buffering, etc, are not
supported.

## Naming convention

Pathos follows the API Design Guidelines on Swift.org

In addition, it uses the following naming scheme to indicate some implementation details:

1. Pure in-memory operations that doesn't call system APIs are **getter**s. For example,
   `Path.isAboslute`.
2. Operations that accesses the file system, but generally aren't expected to make any changes to
   the file system, have a noun or an adjective as function names¹. For example, `Path.metadata()`.
3. Operations that make changes to the file system have a verb in their function names. For example,
   `Path.makeDirectory()`.
4. Functions that starts with "with" or "as" all accept a closure as its final argument. These
   functions set up a environment for the current process, executes the closure in the new
   environment, and restores the process to the previous environment afterwards. For example,
   `Path.withTemporaryDirectory` creates a temporary directory, sets it as the working directory,
   and undo all of that at the end.

*¹ The act of reading something off the file system often updates the thing's latest access time.
Its content, location, type, and most other metadata remain unchanged. The naming scheme disregard
this special case and considers the file system unchanged.*

## Path is binary, if you care

Internally, Path is stored in binary format (as opposed to `Swift.String`) for the following
reasons:

1. The path value is agnostic to character encoding. Path values from system APIs are kept as-is.
   A potential failure in character encoding does not necessarily invalidates the path in this way,
   as the OS clearly thinks the bytes sequence is valid.
2. It is common to pass the path value in and out of C APIs. Storing the value directly means we
   don't spend time decoding and encoding between path and strings. Although one could argue whether
   the saving here is meaningful, since calling the C API often means hitting the hard drive.

A users doesn't need to deal with binary values directly. They may use Swift strings to create
a path. When they inspect parts of the path, they get string values (`var drive: String`).  They may
join paths and strings together. A path in string interpolation looks like a normal path… the
encoding and decoding is handled transparently in the native format the operating system supports.
The user doesn't have to care about this implementation detail unless they want to do.

## Beyond the common denominator

Cross-platform doesn't mean only the common subset of system APIs can be included. Take the path
`Metadata` for example, its interface is shared across all supported operating systems. But
`Metadata.permissions` is an existential (has a protocol as its type). To get and set permissions
unique to POSIX but not on Windows, the value can be casted to a `POSIXPermissions`; on Windows, it
can be casted as a `WindowsAttributes`. This way, the full range of system functionalities is
offered as an extension of the common, cross-platform API. Power users can harness it with some `#if
os()` conditions.

Of course, offering *all* native file system API unique to each platform is a non-goal for this
library. The technique described above is applied only when it make sense for the library's existing
APIs.
