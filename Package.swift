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
            url: "https://github.com/audulus/tbb-spm/releases/download/v12/tbb.xcframework.zip",
            checksum: "d9ebbcb4414cb31fac26ed5eaa6765a55453830d5f61870554f8e1466613e772"
        ),
        .binaryTarget(
            name: "tbbmalloc",
            url: "https://github.com/audulus/tbb-spm/releases/download/v12/tbbmalloc.xcframework.zip",
            checksum: "6835b08eb8d8dad71b3684d25047f7668be8480408063b9adbf53e7efff1e9b5"
        )
    ]
)
