// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "tbb",
    platforms: [
        .macOS(.v11), .iOS(.v13)
    ],
    products: [
        .library(
            name: "tbb",
            targets: ["tbb"])
    ],
    targets: [
        .binaryTarget(
            name: "tbb",
            url: "https://github.com/audulus/tbb-spm/releases/download/v5/tbb.xcframework.zip",
            checksum: "6c08741ef37f01d0323104a0230c20bbf368a24904d7ed1db702b48b6b3ebd64"
        )
    ]
)
