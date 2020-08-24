add_library(Pathos
  Box+PurePath.swift
  Box.swift
  Constants.swift
  PurePathRepresentable.swift
  PathParts.swift
  Windows/PureWindowsPath.swift
  Windows/WindowsConstants.swift
  POSIX/POSIXConstants.swift
  POSIX/PurePOSIXPath.swift
  BinaryString.swift)
# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(Pathos PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options(Pathos PRIVATE
  $<$<BOOL:${BUILD_TESTING}>:-enable-testing>)


_install_target(Pathos)
set_property(GLOBAL APPEND PROPERTY Pathos_EXPORTS Pathos)
