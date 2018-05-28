// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Pathos",
    products: [
        .executable(
            name: "play",
            targets: ["play"]),
        .library(
            name: "Pathos",
            targets: ["Pathos"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "play",
            dependencies: ["Pathos"]),
        .target(
            name: "Pathos",
            dependencies: []),
        .testTarget(
            name: "PathosTests",
            dependencies: ["Pathos"]),
    ]
)
