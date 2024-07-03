// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Data")
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: ["Common", "Data"]),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"]),
    ]
)
