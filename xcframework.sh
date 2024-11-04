#!/bin/zsh

set -euxo pipefail

rm -rf oneTBB-2021.13.0
rm -rf v2021.13.0.tar.gz
rm -rf tbb.xcframework
rm -rf tbb.xcframework.zip
rm -rf tbbmalloc.xcframework
rm -rf tbbmalloc.xcframework.zip

wget https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.13.0.tar.gz
tar zxf v2021.13.0.tar.gz
cd oneTBB-2021.13.0

# See https://github.com/Homebrew/homebrew-core/blob/master/Formula/t/tbb.rb

# Apply patch to header so the headers play nice with frameworks (ugh)
patch include/oneapi/tbb/tbb_allocator.h ../tbb.patch

# [Apple says](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle): 
# Avoid using dynamic library files (.dylib files) for dynamic linking.
# An XCFramework can include dynamic library files, but only macOS supports these libraries for dynamic linking.
# Dynamic linking on iOS, watchOS, and tvOS requires the XCFramework to contain .framework bundles.```

# Also: error: an xcframework cannot contain both frameworks and libraries.

# So we have to build frameworks for each target.

NAME=appleclang_16.0_cxx11_64_release

# macOS build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DBUILD_SHARED_LIBS=OFF
make -j 12 
ctest

cd ..

# ios build

mkdir build_ios && cd build_ios
cmake .. -DCMAKE_SYSTEM_NAME=iOS \
         -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
         -DCMAKE_BUILD_TYPE=Release \
         -DBUILD_SHARED_LIBS=OFF
make -j 12 target=ios

cd ..

libtool -static -o tbb_macos.a build/$NAME/libtbb.a build/$NAME/libtbbmalloc.a
libtool -static -o tbb_ios.a build_ios/$NAME/libtbb.a build_ios/$NAME/libtbbmalloc.a

xcodebuild -create-xcframework \
           -library tbb_macos.a -headers include \
           -library tbb_ios.a -headers include \
           -output ../tbb.xcframework

cd ..
zip -r tbb.xcframework.zip tbb.xcframework
swift package compute-checksum tbb.xcframework.zip
