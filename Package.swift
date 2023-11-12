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
            url: "https://github.com/audulus/tbb-spm/releases/download/v4/tbb.xcframework.zip",
            checksum: "cfdec064c1d5827f8d26a1ae623a650cb5d37ea580f56f7cb44e19937b4589c1"
        )
    ]
)
