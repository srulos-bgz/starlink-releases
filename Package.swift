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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/v1.7.0/Starlink.xcframework.zip",
            checksum: "8857e006aac2a7be658ae36e89d298ac984f0035dfb212cf2a0e7eac5ddbbced"
        )
    ]
)
