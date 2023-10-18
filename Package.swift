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
            checksum: "f0668183810edd95442c51ba1c5f110634b9e5fff0a8f9799598f641ad87b302"
        )
    ]
)
