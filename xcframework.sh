
set -x
rm -rf oneTBB-2021.10.0
rm -f v2021.10.0.tar.gz 

wget https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.10.0.tar.gz
tar zxf v2021.10.0.tar.gz
cd oneTBB-2021.10.0
mkdir build && cd build
cmake ..
make -j 12

cd ..

mkdir build_ios && cd build_ios
cmake .. \
   -DCMAKE_SYSTEM_NAME=iOS \
   -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 
make -j 12

cd ..

xcodebuild -create-xcframework \
           -library build/appleclang_15.0_cxx11_64_relwithdebinfo/libtbb.dylib \
           -headers include \
           -library build_ios/appleclang_15.0_cxx11_64_relwithdebinfo/libtbb.dylib \
           -headers include \
           -output ../tbb.xcframework

cd ..
zip -r tbb.xcframework.zip tbb.xcframework
