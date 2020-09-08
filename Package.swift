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
        .target(
            name: "Pathos",
            dependencies: []
        ),
        .target(
            name: "LinuxHelpers",
            dependencies: []
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
            name: "mkdir",
            dependencies: ["Pathos"],
            path: "Examples/mkdir"
        ),
        .testTarget(
            name: "PathosTests",
            dependencies: ["Pathos"],
            exclude: ["Fixtures"]
        ),
    ]
)
