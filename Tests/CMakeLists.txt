
add_library("PathosTests"
  "PathosTests/ChildrenTests.swift"
  "PathosTests/CommonPathTests.swift"
  "PathosTests/CopyFileTests.swift"
  "PathosTests/CurrentWorkingDirectoryTests.swift"
  "PathosTests/DefaultTemporaryDirectorySearchingTests.swift"
  "PathosTests/DefaultTemporaryDirectoryTests.swift"
  "PathosTests/DeleteTests.swift"
  "PathosTests/ExistsTests.swift"
  "PathosTests/ExpandUserDirectoryTests.swift"
  "PathosTests/FileExtensionTests.swift"
  "PathosTests/FixtureSupport.swift"
  "PathosTests/Fixtures"
  "PathosTests/GlobTests.swift"
  "PathosTests/IsAbsoluteTests.swift"
  "PathosTests/IsBlockDeviceTests.swift"
  "PathosTests/IsCharacterDeviceTests.swift"
  "PathosTests/IsDirectoryTests.swift"
  "PathosTests/IsFileTests.swift"
  "PathosTests/IsPipeTests.swift"
  "PathosTests/IsSocketTests.swift"
  "PathosTests/IsSymlinkTests.swift"
  "PathosTests/JoinPathTests.swift"
  "PathosTests/MakeAbsoluteTests.swift"
  "PathosTests/MakeDirectoryTests.swift"
  "PathosTests/MakeSymlinkTests.swift"
  "PathosTests/MetadataTests.swift"
  "PathosTests/MoveTests.swift"
  "PathosTests/NormalizePathTests.swift"
  "PathosTests/PathBasenameTests.swift"
  "PathosTests/PathDirectoryTests.swift"
  "PathosTests/PathTests.swift"
  "PathosTests/PermissionsTests.swift"
  "PathosTests/ReadingTests.swift"
  "PathosTests/RealPathTests.swift"
  "PathosTests/RelativePathInferringCurrentDirectoryTests.swift"
  "PathosTests/RelativePathTests.swift"
  "PathosTests/SameFileTests.swift"
  "PathosTests/SplitDriveTests.swift"
  "PathosTests/SplitExtensionTests.swift"
  "PathosTests/SplitPathTests.swift"
  "PathosTests/TemporaryDirectoryTests.swift"
  "PathosTests/TemporaryFileTests.swift"
  "PathosTests/WritingTests.swift"
  "PathosTests/Fixtures/hello"
)
set_target_properties("PathosTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("PathosTests" PRIVATE -enable-testing)
target_link_libraries("PathosTests" PRIVATE
  "Pathos"
)

add_executable(WindowsMain
  WindowsMain.swift
)

target_link_libraries(WindowsMain PRIVATE
  "PathosTests"
)

add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
