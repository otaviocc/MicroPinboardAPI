// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MicroPinboard",
    platforms: [
        .macOS(.v12), .iOS(.v13)
    ],
    products: [
        .library(
            name: "MicroPinboard",
            targets: ["MicroPinboard"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/otaviocc/MicroClient",
            from: "0.0.15"
        )
    ],
    targets: [
        .target(
            name: "MicroPinboard",
            dependencies: ["MicroClient"]
        ),
        .testTarget(
            name: "MicroPinboardTests",
            dependencies: ["MicroPinboard", "MicroClient"]
        )
    ]
)
