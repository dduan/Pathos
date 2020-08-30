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
            name: "WindowsTests",
            dependencies: ["Pathos"],
            path: "./Tests/"
        ),
    ]
)
