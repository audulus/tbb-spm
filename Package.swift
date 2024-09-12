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
            url: "https://github.com/audulus/tbb-spm/releases/download/v10/tbb.xcframework.zip",
            checksum: "f4a31ed948781af7d34c66ac8fcd53bac04c95d28559e1bdcacce34ec00fd9a5"
        )
    ]
)
