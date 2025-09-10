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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.7.3/Starlink.xcframework.zip",
            checksum: "a2d72e140d7feba9f2ef1ba47a7c62d61fa3ac39e57c8ab8b31f3d66bd89fa8e"
        )
    ]
)
