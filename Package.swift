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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.6.4/Starlink.xcframework.zip",
            checksum: "fcc29fd8a10c76e8b7866a76cb9b874e83f3259f49a161135a0c6fb4cb50dd93"
        )
    ]
)
