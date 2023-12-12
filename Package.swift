// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "BeamUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "BeamUI",
            targets: ["BeamUI"]),
    ],
    targets: [
        .target(
            name: "BeamUI"),
    ]
)
