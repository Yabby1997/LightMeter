// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LightMeter",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LightMeter",
            targets: ["LightMeter"]
        ),
    ],
    targets: [
        .target(
            name: "LightMeter",
            path: "LightMeter"
        )
    ]
)
