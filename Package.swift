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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/v1.7.2/Starlink.xcframework.zip",
            checksum: "c2b6c5282d3635cc1e5cb0cce6f775f8bffdd83edf769ddaaec728fde2c9f340"
        )
    ]
)
