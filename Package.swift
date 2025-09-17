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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.8.2/Starlink.xcframework.zip",
            checksum: "581f9a78b80b5dcb06b27094429ee65664e9fd4a2257ead46ff97f1f83630ffe"
        )
    ]
)
