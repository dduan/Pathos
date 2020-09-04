add_executable(metadata
  metadata/main.swift)
target_link_libraries(metadata PRIVATE
  Pathos)

add_executable(ls
  ls/main.swift)
target_link_libraries(ls PRIVATE
  Pathos)
