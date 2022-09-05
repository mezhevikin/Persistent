// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Persistent",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Persistent",
            targets: ["Persistent"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Persistent",
            dependencies: []),
        .testTarget(
            name: "PersistentTests",
            dependencies: ["Persistent"]),
    ]
)
