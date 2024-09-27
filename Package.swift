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
            targets: ["tbb", "tbbmalloc"])
    ],
    targets: [
        .binaryTarget(
            name: "tbb",
            url: "https://github.com/audulus/tbb-spm/releases/download/v13/tbb.xcframework.zip",
            checksum: "e4dc6420df74d2c7af389a175a8714458a7a912eac72f4190eb46b7de9ff8471"
        ),
        .binaryTarget(
            name: "tbbmalloc",
            url: "https://github.com/audulus/tbb-spm/releases/download/v13/tbbmalloc.xcframework.zip",
            checksum: "241fb9b0fa72d61df07a11ad8af988c57b28ad7f489890c4fa3d98c59ad4ce49"
        )
    ]
)
