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
            url: "https://github.com/audulus/tbb-spm/releases/download/v11/tbb.xcframework.zip",
            checksum: "5accbcc7588e41991645cf924869f2eba1d6d3c80ae63c143f0193d48000d7be"
        ),
        .binaryTarget(
            name: "tbbmalloc",
            url: "https://github.com/audulus/tbb-spm/releases/download/v11/tbbmalloc.xcframework.zip",
            checksum: "771debbb1b9e67e9b7bab60326d646d490db281457c14a995dfe98fb75d4926e"
        )
    ]
)
