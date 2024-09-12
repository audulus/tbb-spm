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
            url: "https://github.com/audulus/tbb-spm/releases/download/v8/tbb.xcframework.zip",
            checksum: "4882c22b3bd445a12b05cbd3f7a13aa888624b9a7ee8fac69cfa60d7f818c9ca"
        )
    ]
)
