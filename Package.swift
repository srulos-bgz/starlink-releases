// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Starlink",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Starlink",
            targets: ["Starlink"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Starlink",
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.8.4/Starlink.xcframework.zip",
            checksum: "6b09aefad10093aceace1e66e021ade61795d5d9aa3d23e8409caac43fcdf7c9"
        )
    ]
)
