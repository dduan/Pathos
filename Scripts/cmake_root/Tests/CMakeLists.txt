add_library("PathosTests"
  $source_list
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
