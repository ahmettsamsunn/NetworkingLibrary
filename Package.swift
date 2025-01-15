// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkingLibrary",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "NetworkingLibrary",
            targets: ["NetworkingLibrary"])
    ],
    dependencies: [
        // Add dependencies here
    ],
    targets: [
        .target(
            name: "NetworkingLibrary",
            dependencies: []),
        .testTarget(
            name: "NetworkingLibraryTests",
            dependencies: ["NetworkingLibrary"])
    ]
)
