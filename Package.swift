// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageColors",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "ImageColors",
            targets: ["ImageColors"]),
    ],
    targets: [
        .target(
            name: "ImageColors",
            dependencies: []),
        .testTarget(
            name: "ImageColorsTests",
            dependencies: ["ImageColors"]),
    ]
)
