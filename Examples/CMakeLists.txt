add_executable(ls
  ls/main.swift)
target_link_libraries(ls PRIVATE
  Pathos)

add_executable(readonly
  readonly/main.swift)
target_link_libraries(readonly PRIVATE
  Pathos)

add_executable(lookup
  lookup/main.swift)
target_link_libraries(lookup PRIVATE
  Pathos)

add_executable(mkdir
  mkdir/main.swift)
target_link_libraries(mkdir PRIVATE
  Pathos)
