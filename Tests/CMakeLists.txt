add_library("PathosTests"
  "PathosTests/POSIXBinaryStringTests.swift"
  "PathosTests/POSIXPartsParsingTests.swift"
  "PathosTests/POSIXPathInitializationTests.swift"
  "PathosTests/POSIXPathJoiningTests.swift"
  "PathosTests/PathJoiningOperatorTests.swift"
  "PathosTests/PurePOSIXPathJoiningOperatorTests.swift"
  "PathosTests/PurePOSIXPathTests.swift"
  "PathosTests/PureWindowsPathJoiningOperatorTests.swift"
  "PathosTests/PureWindowsPathTests.swift"
  "PathosTests/WindowsBinaryStringTests.swift"
  "PathosTests/WindowsPartsParsingTests.swift"
  "PathosTests/WindowsPathJoiningTests.swift"
  "PathosTests/WorkingDirectoryTests.swift"
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
)

add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
