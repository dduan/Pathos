// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Pathos",
    products: [
        .library(
            name: "Pathos",
            targets: ["Pathos"]
        ),
    ],
    targets: [
        .target(name: "Pathos", dependencies: ["WindowsHelpers"]),
        .target(name: "WindowsHelpers"),
        .target(
            name: "WindowsTests",
            dependencies: ["Pathos"],
            path: "./Tests/"
        ),
        .target(
            name: "ls",
            dependencies: ["Pathos"],
            path: "Examples/ls"
        ),
        .target(
            name: "readonly",
            dependencies: ["Pathos"],
            path: "Examples/readonly"
        ),
        .target(
            name: "lookup",
            dependencies: ["Pathos"],
            path: "Examples/lookup"
        ),
        .target(
            name: "mk",
            dependencies: ["Pathos"],
            path: "Examples/mk"
        ),
        .target(
            name: "rm",
            dependencies: ["Pathos"],
            path: "Examples/rm"
        ),
    ]
)
