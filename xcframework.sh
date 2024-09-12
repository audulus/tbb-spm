
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

# Apply patch to header so the headers play nice with frameworks (ugh)
patch include/oneapi/tbb/tbb_allocator.h ../tbb.patch

# [Apple says](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle): 
# Avoid using dynamic library files (.dylib files) for dynamic linking.
# An XCFramework can include dynamic library files, but only macOS supports these libraries for dynamic linking.
# Dynamic linking on iOS, watchOS, and tvOS requires the XCFramework to contain .framework bundles.```

# Also: error: an xcframework cannot contain both frameworks and libraries.

# So we have to build frameworks for each target.

# macOS build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DTBB_BUILD_APPLE_FRAMEWORKS=On
make -j 12 
mkdir appleclang_15.0_cxx11_64_release/tbb.framework/Versions/12.13/Headers
cp -R ../include/oneapi/tbb/ appleclang_15.0_cxx11_64_release/tbb.framework/Versions/12.13/Headers

cd ..

# ios build

mkdir build_ios && cd build_ios
cmake .. -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_BUILD_TYPE=Release -DTBB_BUILD_APPLE_FRAMEWORKS=On 
make -j 12 target=ios
mkdir appleclang_15.0_cxx11_64_release/tbb.framework/Headers
cp -R ../include/oneapi/tbb/ appleclang_15.0_cxx11_64_release/tbb.framework/Headers

cd ..

xcodebuild -create-xcframework \
           -framework build/appleclang_15.0_cxx11_64_release/tbb.framework \
           -framework build_ios/appleclang_15.0_cxx11_64_release/tbb.framework \
           -output ../tbb.xcframework

xcodebuild -create-xcframework \
           -framework build/appleclang_15.0_cxx11_64_release/tbbmalloc.framework \
           -framework build_ios/appleclang_15.0_cxx11_64_release/tbbmalloc.framework \
           -output ../tbbmalloc.xcframework

cd ..
zip -r tbb.xcframework.zip tbb.xcframework
zip -r tbbmalloc.xcframework.zip tbbmalloc.xcframework
swift package compute-checksum tbb.xcframework.zip
swift package compute-checksum tbbmalloc.xcframework.zip
