add_library(Pathos
  attributes.swift
  children.swift
  CMakeLists.txt
  constants.swift
  copy.swift
  currentWorkingDirectory.swift
  FilePermission.swift
  FileTime.swift
  FileType.swift
  glob.swift
  helpers.swift
  manipulate.swift
  Metadata.swift
  Path.swift
  pathAnalysis.swift
  pathAnalysisWithIO.swift
  PathosError.swift
  PathRepresentable.swift
  permissions.swift
  posixHelpers.swift
  readWrite.swift
  symlink.swift
  SystemError.swift
  temporary.swift)
# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(Pathos PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options(Pathos PRIVATE
  $<$<BOOL:${BUILD_TESTING}>:-enable-testing>)
target_link_libraries(Pathos PRIVATE
  $<$<NOT:$<PLATFORM_ID:Darwin>>:Foundation>)


_install_target(Pathos)
set_property(GLOBAL APPEND PROPERTY Pathos_EXPORTS Pathos)
