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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.8.0/Starlink.xcframework.zip",
            checksum: "0e55651cb9d9e0ec302b2c6dc9d7b52ed1870ba42fa0217fd62c9d69d44d0553"
        )
    ]
)
