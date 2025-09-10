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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.6.3/Starlink.xcframework.zip",
            checksum: "8fb9c3738d58140371f20e6a4b1cbea959fe3c4efcf32c2c4abdbdf9375e4c9b"
        )
    ]
)
