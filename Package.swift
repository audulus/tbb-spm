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
            url: "https://github.com/audulus/tbb-spm/releases/download/v9/tbb.xcframework.zip",
            checksum: "29e082ca1a61cbba88f27fb87e22766d767853f4fd45518497529600c1d04213"
        )
    ]
)
