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
            url: "https://github.com/srulos-bgz/starlink-releases/releases/download/1.1.0/Starlink.xcframework.zip",
            checksum: "b6fca11a7954395051e15753937699e7ca21ea211d943c756b6590de9a39655c"
        )
    ]
)
