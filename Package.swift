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
        .testTarget(
            name: "PathosTests",
            dependencies: ["Pathos"],
            exclude: ["Fixtures"]
        ),
    ]
)
