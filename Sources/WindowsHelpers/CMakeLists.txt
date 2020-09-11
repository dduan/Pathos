add_library(WindowsHelpers STATIC
  dummy.c)
if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(WindowsHelpers PRIVATE
    WINDOWSHELPERS_DECLARE_STATIC)
endif()
target_compile_definitions(WindowsHelpers PRIVATE
  WINDOWSHELPERS_DECLARE_EXPORT)
target_include_directories(WindowsHelpers PUBLIC
  include)
set_property(GLOBAL APPEND PROPERTY Pathos_EXPORTS WindowsHelpers)
install(TARGETS WindowsHelpers
  EXPORT PathosExports
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES
  include/module.modulemap
  include/reparsedata.h
  DESTINATION include/WindowsHelpers)
