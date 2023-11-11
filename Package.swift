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
            url: "https://github.com/audulus/tbb-spm/releases/download/v2/tbb.xcframework.zip",
            checksum: "c888a8f04fe0b0843c3e2246a888b98eb419ae6038e29ea535e8d3c7613a197b"
        )
    ]
)
