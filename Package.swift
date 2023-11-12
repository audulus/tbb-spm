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
            url: "https://github.com/audulus/tbb-spm/releases/download/v3/tbb.xcframework.zip",
            checksum: "51ad13a9944a2fd0099a3b161cd24b4c10235f1fa4bdb57742c225c0200da179"
        )
    ]
)
