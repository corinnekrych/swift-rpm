echo on 
sudo dnf install -y rpm-build ninja-build clang libicu-devel gcc-c++ cmake libuuid-devel libedit-devel swig pkgconfig libbsd-devel libxml2-devel libsqlite3x-devel python-devel autoconf automake libtool libcurl-devel libatomic
sudo ln -s /usr/bin/ninja-build /usr/bin/ninja

# We need to manually get and deal with the blocks runtime
# TODO: Add check for whether files are already there
pushd /tmp
git clone git://github.com/tachoknight/blocksruntime
cd /tmp/blocksruntime
./buildlib
./checktests
sudo ./installlib
sudo ln -s /usr/local/lib/libBlocksRuntime.a /usr/lib/libBlocksRuntime.a
sudo ln -s /usr/local/include/Block.h /usr/include/Block.h
popd

RPMTOPDIR=~/rpmbuild
mkdir -p $RPMTOPDIR/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

TAG=4.0-RELEASE
VER=4.0
REL=RELEASE4.0


wget https://github.com/apple/swift/archive/swift-${TAG}.tar.gz -O swift.tar.gz
mv swift.tar.gz $RPMTOPDIR/SOURCES/swift.tar.gz
wget https://github.com/apple/swift-corelibs-foundation/archive/swift-${TAG}.tar.gz -O corelibs-foundation.tar.gz
mv corelibs-foundation.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-integration-tests/archive/swift-${TAG}.tar.gz -O swift-integration-tests.tar.gz
mv swift-integration-tests.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-corelibs-xctest/archive/swift-${TAG}.tar.gz -O corelibs-xctest.tar.gz
mv corelibs-xctest.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-clang/archive/swift-${TAG}.tar.gz -O clang.tar.gz
mv clang.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-package-manager/archive/swift-${TAG}.tar.gz -O package-manager.tar.gz
mv package-manager.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-lldb/archive/swift-${TAG}.tar.gz -O lldb.tar.gz
mv lldb.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-llvm/archive/swift-${TAG}.tar.gz -O llvm.tar.gz
mv llvm.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-llbuild/archive/swift-${TAG}.tar.gz -O llbuild.tar.gz
mv llbuild.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-cmark/archive/swift-${TAG}.tar.gz -O cmark.tar.gz
mv cmark.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/ninja-build/ninja/archive/v1.7.2.tar.gz -O ninja.tar.gz
mv ninja.tar.gz $RPMTOPDIR/SOURCES/
sed -e "s/%{ver}/$VER/" -e "s/%{rel}/$REL/" -e "s/%{tag}/$TAG/" swift.spec > $RPMTOPDIR/SPECS/swift.spec
rpmbuild -ba $RPMTOPDIR/SPECS/swift.spec	
