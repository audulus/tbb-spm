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
            url: "https://github.com/audulus/tbb-spm/releases/download/v6/tbb.xcframework.zip",
            checksum: "f0e151ad78206432f1092defb5484dcc00a751036c25f26be680894a3d9539fa"
        )
    ]
)
