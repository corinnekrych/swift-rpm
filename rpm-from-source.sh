echo on 
dnf install -y rpm-build ninja-build
sudo ln -s /usr/bin/ninja-build /usr/bin/ninja

RPMTOPDIR=~/rpmbuild
mkdir -p $RPMTOPDIR/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
TAG=2.2-SNAPSHOT-2015-12-10-a
VER=2.2
REL=SNAPSHOT20151210a

wget https://github.com/apple/swift/archive/swift-${TAG}.tar.gz -O swift.tar.gz
mv swift.tar.gz $RPMTOPDIR/SOURCES/swift.tar.gz
wget https://github.com/apple/swift-corelibs-foundation/archive/swift-${TAG}.tar.gz -O corelibs-foundation.tar.gz
mv corelibs-foundation.tar.gz $RPMTOPDIR/SOURCES/
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
wget https://github.com/apple/swift-cmark/archive/0.22.0.tar.gz -O cmark.tar.gz
mv cmark.tar.gz $RPMTOPDIR/SOURCES/

sed -e "s/%{ver}/$VER/" -e "s/%{rel}/$REL/" -e "s/%{tag}/$TAG/" swift.spec > $RPMTOPDIR/SPECS/swift.spec
rpmbuild -ba $RPMTOPDIR/SPECS/swift.spec	
