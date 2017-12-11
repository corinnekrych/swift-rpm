#!/bin/bash

# These variables refer to the version of Swift you
# want to build, and must match what Apple has
# made available at https://github.com/apple/swift/releases
# (but note *not* to prepend "swift-" to it)
TAG=4.0.3-RELEASE
VER=4.0.3
# This is what decorates the package name
REL=RELEASE4.0.3


# We use /etc/os-release to determine the version of Fedora we're on
# which will be passed to the final rpm file
source /etc/os-release

sudo dnf install -y rpm-build ninja-build clang libicu-devel gcc-c++ cmake libuuid-devel libedit-devel swig pkgconfig libbsd-devel libxml2-devel libsqlite3x-devel python-devel autoconf automake libtool libcurl-devel libatomic
sudo ln -s /usr/bin/ninja-build /usr/bin/ninja

# We need to manually get and deal with the blocks runtime
# We have already built this; if the static lib or header is missing,
# we'll build it again
if [ ! -f /usr/lib/libBlocksRuntime.a ] || [ ! -f /usr/include/Block.h ]; then
	pushd /tmp
	git clone https://github.com/mackyle/blocksruntime
	cd /tmp/blocksruntime
	./buildlib
	./checktests
	sudo ./installlib
	sudo ln -s /usr/local/lib/libBlocksRuntime.a /usr/lib/libBlocksRuntime.a
	sudo ln -s /usr/local/include/Block.h /usr/include/Block.h
	popd
fi

RPMTOPDIR=~/rpmbuild
mkdir -p $RPMTOPDIR/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}


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
sed -e"s/%{fedora-ver}/$VERSION_ID/" -e "s/%{ver}/$VER/" -e "s/%{rel}/$REL/" -e "s/%{tag}/$TAG/" swift.spec > $RPMTOPDIR/SPECS/swift.spec
rpmbuild -ba $RPMTOPDIR/SPECS/swift.spec	
