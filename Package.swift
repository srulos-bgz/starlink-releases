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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.7.6/Starlink.xcframework.zip",
            checksum: "ae98a18dc518415f39b01b4a12ec7e906e5052267a0973da9bbda35e8977f348"
        )
    ]
)
