set(Pathos_EXPORTS_FILE ${CMAKE_CURRENT_BINARY_DIR}/PathosExports.cmake)

 configure_file(PathosConfig.cmake.in
   ${CMAKE_CURRENT_BINARY_DIR}/PathosConfig.cmake)

 get_property(Pathos_EXPORTS GLOBAL PROPERTY Pathos_EXPORTS)
 export(TARGETS ${Pathos_EXPORTS}
   FILE ${Pathos_EXPORTS_FILE})