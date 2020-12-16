add_library("PathosTests"
  "PathosTests/AbsoluteTests.swift"
  "PathosTests/BaseTests.swift"
  "PathosTests/ChildrenTests.swift"
  "PathosTests/CopyTests.swift"
  "PathosTests/GlobTests.swift"
  "PathosTests/HomeTests.swift"
  "PathosTests/MetadataTests.swift"
  "PathosTests/POSIXBinaryStringTests.swift"
  "PathosTests/POSIXPartsParsingTests.swift"
  "PathosTests/POSIXPathInitializationTests.swift"
  "PathosTests/POSIXPathJoiningTests.swift"
  "PathosTests/PathDeletionTests.swift"
  "PathosTests/PathExistsTests.swift"
  "PathosTests/PathExtensionTests.swift"
  "PathosTests/PathJoiningOperatorTests.swift"
  "PathosTests/PathNormalTests.swift"
  "PathosTests/PathParentsTests.swift"
  "PathosTests/PermissionsTests.swift"
  "PathosTests/PurePOSIXParentTests.swift"
  "PathosTests/PurePOSIXPathBaseTests.swift"
  "PathosTests/PurePOSIXPathExtensionTests.swift"
  "PathosTests/PurePOSIXPathIsAbsoluteTests.swift"
  "PathosTests/PurePOSIXPathJoiningOperatorTests.swift"
  "PathosTests/PurePOSIXPathNormalTests.swift"
  "PathosTests/PurePOSIXPathParentsTests.swift"
  "PathosTests/PurePOSIXPathRelativeTests.swift"
  "PathosTests/PurePOSIXPathTests.swift"
  "PathosTests/PureWindowsExtensionTests.swift"
  "PathosTests/PureWindowsPathBaseTests.swift"
  "PathosTests/PureWindowsPathIsAbsoluteTests.swift"
  "PathosTests/PureWindowsPathJoiningOperatorTests.swift"
  "PathosTests/PureWindowsPathNormalTests.swift"
  "PathosTests/PureWindowsPathParentTests.swift"
  "PathosTests/PureWindowsPathParentsTests.swift"
  "PathosTests/PureWindowsPathRelativeTests.swift"
  "PathosTests/PureWindowsPathTests.swift"
  "PathosTests/ReadStringTests.swift"
  "PathosTests/ReadTests.swift"
  "PathosTests/RealTests.swift"
  "PathosTests/SymlinkTests.swift"
  "PathosTests/TemporaryTests.swift"
  "PathosTests/WindowsBinaryStringTests.swift"
  "PathosTests/WindowsFileTimeTests.swift"
  "PathosTests/WindowsPartsParsingTests.swift"
  "PathosTests/WindowsPathJoiningTests.swift"
  "PathosTests/WorkingDirectoryTests.swift"
  "PathosTests/WriteTests.swift"
  "PathosTests/XCTestManifests.swift"
)

set_target_properties("PathosTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("PathosTests" PRIVATE -enable-testing)
target_link_libraries("PathosTests" PRIVATE
  "Pathos"
)

add_executable(WindowsMain
    LinuxMain.swift
)

target_link_libraries(WindowsMain PRIVATE
  "PathosTests"
  "WindowsHelpers"
)

add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
