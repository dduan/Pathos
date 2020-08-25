add_library(Pathos
  "BinaryString.swift"
  "Box.swift"
  "Constants.swift"
  "POSIX/Box+PurePOSIXPath.swift"
  "POSIX/POSIXConstants.swift"
  "POSIX/PathParts+POSIX.swift"
  "POSIX/PurePOSIXPath.swift"
  "Path.swift"
  "PathParts.swift"
  "PurePath.swift"
  "PurePathRepresentable.swift"
  "Windows/Box+PureWindowsPath.swift"
  "Windows/PathParts+Windows.swift"
  "Windows/PureWindowsPath.swift"
  "Windows/WindowsConstants.swift"
)
# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(Pathos PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options(Pathos PRIVATE
  $<$<BOOL:${BUILD_TESTING}>:-enable-testing>)


_install_target(Pathos)
set_property(GLOBAL APPEND PROPERTY Pathos_EXPORTS Pathos)
