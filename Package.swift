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
            url: "https://github.com/audulus/tbb-spm/releases/download/v7/tbb.xcframework.zip",
            checksum: "8a52189cc725e96471bd15a13aff895322295ee4579c1a40de1d9a039c40e8c9"
        )
    ]
)
