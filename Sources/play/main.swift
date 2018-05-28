import Pathos

let all = try children(inPath: makeAbsolute(path: "./Sources"), recursive: true)
    .joined(separator: "\n")
print(all)
