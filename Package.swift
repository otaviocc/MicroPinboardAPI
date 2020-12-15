// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PinboardKit",
    platforms: [
        .macOS(.v11), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "PinboardKit",
            targets: ["PinboardKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PinboardKit",
            dependencies: []
        ),
        .testTarget(
            name: "PinboardKitTests",
            dependencies: ["PinboardKit"]
        )
    ]
)
