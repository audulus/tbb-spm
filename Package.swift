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
            url: "https://github.com/audulus/tbb-spm/releases/download/v1/tbb.xcframework.zip",
            checksum: "19adabd7c4ff8c9247ecc8156d0cc7d568e235bbb011011c4a5d4342349325ae"
        )
    ]
)
