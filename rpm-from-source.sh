echo on
RPMROOTDIR=~/rpmbuild
VER=4.0
BRANCH=swift-${VER}-branch
REL=DEVELOPMENT

# Dependencies
sudo dnf install -y rpm-build wget git clang libicu-devel gcc-c++ cmake libuuid-devel libedit-devel swig pkgconfig libbsd-devel libxml2-devel libsqlite3x-devel python-devel autoconf automake libtool libcurl-devel libatomic
# Might not be needed anymore since it's also pulled by git in build
sudo dnf install -y ninja-build

# libBlocksRuntime
ldd /usr/lib64/libBlocksRuntime.so.0
if [[ $? -ne 0 ]]
then
  cp libblocksruntime_0.1.tgz /tmp/
  sudo sh -c 'cd /; tar xzvf /tmp/libblocksruntime_0.1.tgz'
  sudo ldconfig
  rm -f /tmp/libblocksruntime_0.1.tgz
fi

# Fails if libBlocksRuntime not installed
ldd /usr/lib64/libBlocksRuntime.so.0
[[ $? -ne 0 ]] && exit

# rpm -ivh libatomic-7.1.1-6.fc27.x86_64.rpm

mkdir -p $RPMROOTDIR/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

wget https://github.com/apple/swift/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/swift.tar.gz
wget https://github.com/apple/swift-corelibs-foundation/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/corelibs-foundation.tar.gz
wget https://github.com/apple/swift-integration-tests/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/swift-integration-tests.tar.gz
wget https://github.com/apple/swift-corelibs-xctest/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/corelibs-xctest.tar.gz
wget https://github.com/apple/swift-clang/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/clang.tar.gz
wget https://github.com/apple/swift-package-manager/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/package-manager.tar.gz
wget https://github.com/apple/swift-lldb/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/lldb.tar.gz
wget https://github.com/apple/swift-llvm/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/llvm.tar.gz
wget https://github.com/apple/swift-llbuild/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/llbuild.tar.gz
wget https://github.com/apple/swift-cmark/archive/${BRANCH}.tar.gz -O $RPMROOTDIR/SOURCES/cmark.tar.gz

cp *.patch ${RPMROOTDIR}/SOURCES/

sed -e "s/%{ver}/$VER/" -e "s/%{rel}/$REL/" -e "s/%{branch}/$BRANCH/" swift.spec > $RPMROOTDIR/SPECS/swift.spec
rpmbuild -ba $RPMROOTDIR/SPECS/swift.spec
