add_library(Pathos
  "Algorithms.swift"
  "BinaryString.swift"
  "Box.swift"
  "Constants.swift"
  "Darwin/Metadata+Darwin.swift"
  "Darwin/Path+Darwin.swift"
  "FileTime.swift"
  "FileType.swift"
  "LazyBoxed.swift"
  "Linux/Metadata+Glibc.swift"
  "Linux/Path+Glibc.swift"
  "Metadata.swift"
  "POSIX/FileTime+POSIX.swift"
  "POSIX/POSIXConstants.swift"
  "POSIX/POSIXFileType.swift"
  "POSIX/POSIXPathConvertible.swift"
  "POSIX/POSIXPermissions.swift"
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
target_compile_options(Pathos PRIVATE
  $<$<BOOL:${BUILD_TESTING}>:-enable-testing>)
target_link_libraries(Pathos PRIVATE
  WindowsHelpers)
set_target_properties(Pathos PROPERTIES
  INTERFACE_COMPILE_OPTIONS "SHELL:-Xcc -I$<TARGET_PROPERTY:WindowsHelpers,INCLUDE_DIRECTORIES>"
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

set_property(GLOBAL APPEND PROPERTY Pathos_EXPORTS Pathos)

swift_install(TARGETS Pathos
  EXPORT PathosExports)
