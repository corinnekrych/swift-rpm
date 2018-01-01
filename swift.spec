Summary: Swift is the apple compiler for the swift language.
Name: swift
Version: %{ver}
Release: %{rel}
Group: Development/Tools
License: Apache 2.0
URL: https://github.com/apple/swift
Source0: swift.tar.gz
Source1: clang.tar.gz
Source2: cmark.tar.gz
Source3: corelibs-foundation.tar.gz
Source4: corelibs-libdispatch.tar.gz
Source5: corelibs-xctest.tar.gz
Source6: llbuild.tar.gz
# Explicitly commented out here as we get it from
# git below
#Source7: lldb.tar.gz
Source7: llvm.tar.gz
Source8: package-manager.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{ver}-%{rel}

BuildRequires: clang,libicu-devel,gcc-c++,cmake,libuuid-devel,libedit-devel,swig,pkgconfig,libbsd-devel,libxml2-devel,libsqlite3x-devel,python-devel,ninja-build
Requires: clang,libicu-devel

%description
Build apple swift compiler from source

%prep
rm -fr *
gzip -dc ../SOURCES/swift.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/swift-integration-tests.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/clang.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/cmark.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/corelibs-foundation.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/corelibs-libdispatch.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/corelibs-xctest.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/llbuild.tar.gz | tar -xvvf -
#gzip -dc ../SOURCES/lldb.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/llvm.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/package-manager.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/ninja.tar.gz | tar -xvvf -
mv ninja-1.7.2 ninja
mv swift-swift-%{tag} swift
mv swift-integration-tests-swift-%{tag} swift-integration-tests
mv swift-clang-swift-%{tag} clang
mv swift-cmark-swift-%{tag} cmark
mv swift-corelibs-foundation-swift-%{tag} swift-corelibs-foundation
mv swift-corelibs-libdispatch-swift-%{tag} swift-corelibs-libdispatch
mv swift-corelibs-xctest-swift-%{tag} swift-corelibs-xctest
mv swift-llbuild-swift-%{tag} llbuild
#mv swift-lldb-swift-%{tag} lldb
mv swift-llvm-swift-%{tag} llvm
mv swift-package-manager-swift-%{tag} swiftpm

# swift-lldb uses stable, not master
git clone https://github.com/apple/swift-lldb.git lldb
pushd lldb
git checkout stable
popd

# Explicit checkout of libdispatch so we can also initialize
# the submodules
#git clone https://github.com/apple/swift-corelibs-libdispatch swift-corelibs-libdispatch
#pushd swift-corelibs-libdispatch
#git checkout swift-4.1-branch
#git submodule init; git submodule update
#popd

%build
#sed -e s/lib\${LLVM_LIBDIR_SUFFIX}/lib64/g lldb/scripts/CMakeLists.txt > CMakeLists.txt.tmp && mv CMakeLists.txt.tmp lldb/scripts/CMakeLists.txt
cd swift
sed -i 's/SIGUNUSED/SIGSYS/' ../swiftpm/Sources/Basic/Process.swift

#
# We're finished with our modifications, so now we're going to actually build Swift, et al.
#

# This is the line that actually does the build. Grab a coffee or tea because this is going
# to take awhile
./utils/build-script --preset=buildbot_linux,no_test install_destdir=%{buildroot} installable_package=%{buildroot}/swift-%{ver}-%{rel}-fedora%{fedora-ver}.tar.gz

# If you would like to keep the tgz file, uncomment the 
# next line
#cp %{buildroot}/swift-%{ver}-%{rel}-fedora%{fedora-ver}.tar.gz ~

rm %{buildroot}/swift-%{ver}-%{rel}-fedora%{fedora-ver}.tar.gz

%files
%defattr(-, root, root)
%{_bindir}/*
%{_includedir}/*
%{_usr}/lib/*
%{_mandir}/*
%{_datarootdir}/*

%clean
echo "DATAROOTDIR==" %{_datarootdir}
echo "BUILDROOT=" %{buildroot}
rm -rf %{buildroot}

#The changelog is built automatically from Git history
%changelog
