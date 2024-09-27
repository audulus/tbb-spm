// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "tbb",
    platforms: [
        .macOS(.v11), .iOS(.v13)
    ],
    products: [
        .library(
            name: "tbb",
            targets: ["tbb_headers", "tbb", "tbbmalloc"])
    ],
    targets: [
        .target(
            name: "tbb_headers"
        ),
        .binaryTarget(
            name: "tbb",
            url: "https://github.com/audulus/tbb-spm/releases/download/v14/tbb.xcframework.zip",
            checksum: "7d5a8677b51ac90f356d504ae03b082cabbe2a24cf76353688308263eb655510"
        ),
        .binaryTarget(
            name: "tbbmalloc",
            url: "https://github.com/audulus/tbb-spm/releases/download/v14/tbbmalloc.xcframework.zip",
            checksum: "120e6c39d871f6485210160eedc374bccb3148704950caf3a65c6328bf2411f5"
        )
    ],
    cxxLanguageStandard: .cxx20
)
