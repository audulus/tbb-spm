
set -euxo pipefail

rm -rf oneTBB-2021.10.0
rm -rf v2021.10.0.tar.gz
rm -rf tbb.xcframework
rm -rf tbb.xcframework.zip

wget https://github.com/oneapi-src/oneTBB/archive/refs/tags/2021.13.0.tar.gz
tar zxf v2021.10.0.tar.gz
cd oneTBB-2021.10.0

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
cmake ..
make -j 12 tbb

# Framework directory structure: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/FrameworkAnatomy.html
mkdir tbb.framework
mkdir tbb.framework/Versions
mkdir tbb.framework/Versions/A
mkdir tbb.framework/Versions/A/Resources
mkdir tbb.framework/Versions/A/Headers
cp -R ../include/oneapi/tbb/ tbb.framework/Versions/A/Headers
install_name_tool -id @executable_path/tbb.framework/tbb appleclang_15.0_cxx11_64_relwithdebinfo/libtbb.12.10.dylib
lipo -create appleclang_15.0_cxx11_64_relwithdebinfo/libtbb.12.10.dylib -output tbb.framework/Versions/A/tbb
cp ../../Info-macOS.plist tbb.framework/Versions/A/Resources/Info.plist
ln -s A tbb.framework/Versions/Current
ln -s Versions/Current/tbb tbb.framework/tbb
ln -s Versions/Current/Resources tbb.framework/Resources
ln -s Versions/Current/Headers tbb.framework/Headers

cd ..

# ios build

mkdir build_ios && cd build_ios
cmake -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      ..
make -j 12 tbb target=ios
mkdir tbb.framework
mkdir tbb.framework/Headers
cp -R ../include/oneapi/tbb/ tbb.framework/Headers
cp ../../Info-iOS.plist tbb.framework/Info.plist
install_name_tool -id @executable_path/Frameworks/tbb.framework/tbb appleclang_15.0_cxx11_64_relwithdebinfo/libtbb.12.10.dylib
lipo -create appleclang_15.0_cxx11_64_relwithdebinfo/libtbb.12.10.dylib -output tbb.framework/tbb

cd ..

xcodebuild -create-xcframework \
           -framework build/tbb.framework \
           -framework build_ios/tbb.framework \
           -output ../tbb.xcframework

cd ..
zip -r tbb.xcframework.zip tbb.xcframework
swift package compute-checksum tbb.xcframework.zip
