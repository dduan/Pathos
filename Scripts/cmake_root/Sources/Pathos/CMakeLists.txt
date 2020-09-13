add_library(Pathos
  $source_list
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
