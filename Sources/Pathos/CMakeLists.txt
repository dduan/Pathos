add_library(Pathos
  "Algorithms.swift"
  "BinaryString.swift"
  "Box.swift"
  "Constants.swift"
  "FileTime.swift"
  "FileType.swift"
  "LazyBoxed.swift"
  "Metadata.swift"
  "POSIX/FileTime+POSIX.swift"
  "POSIX/Metadata+Darwin.swift"
  "POSIX/Metadata+Glibc.swift"
  "POSIX/POSIXConstants.swift"
  "POSIX/POSIXFileType.swift"
  "POSIX/POSIXPathConvertible.swift"
  "POSIX/POSIXPermissions.swift"
  "POSIX/Path+Darwin.swift"
  "POSIX/Path+Glibc.swift"
  "POSIX/Path+POSIX.swift"
  "POSIX/PathParts+POSIX.swift"
  "POSIX/PurePOSIXPath.swift"
  "Path+Joining.swift"
  "Path+Temporary.swift"
  "Path.swift"
  "PathParts.swift"
  "Permissions.swift"
  "PurePath.swift"
  "PurePathRepresentable.swift"
  "SystemError.swift"
  "Windows/FileTime+Windows.swift"
  "Windows/Metadata+Windows.swift"
  "Windows/Path+Windows.swift"
  "Windows/PathParts+Windows.swift"
  "Windows/PureWindowsPath.swift"
  "Windows/WindowsAttributes.swift"
  "Windows/WindowsConstants.swift"
  "Windows/WindowsFileType.swift"
  "Windows/WindowsPathConvertible.swift"
)
# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(Pathos PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options(Pathos PRIVATE
  $<$<BOOL:${BUILD_TESTING}>:-enable-testing>)


_install_target(Pathos)
set_property(GLOBAL APPEND PROPERTY Pathos_EXPORTS Pathos)
