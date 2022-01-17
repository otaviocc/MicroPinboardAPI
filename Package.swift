// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PinboardKit",
    platforms: [
        .macOS(.v12), .iOS(.v13)
    ],
    products: [
        .library(
            name: "PinboardKit",
            targets: ["PinboardKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/MicroClientSwift/MicroClient",
            from: "0.0.3"
        )
    ],
    targets: [
        .target(
            name: "PinboardKit",
            dependencies: ["MicroClient"]
        ),
        .testTarget(
            name: "PinboardKitTests",
            dependencies: ["PinboardKit", "MicroClient"]
        )
    ]
)
