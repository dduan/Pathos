add_executable(ls
  ls/main.swift)
target_link_libraries(ls PRIVATE
  Pathos)

add_executable(readonly
  readonly/main.swift)
target_link_libraries(readonly PRIVATE
  Pathos)
