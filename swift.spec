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
Source4: corelibs-xctest.tar.gz
Source5: llbuild.tar.gz
Source6: lldb.tar.gz
Source7: llvm.tar.gz
Source8: package-manager.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{ver}-%{rel}

BuildRequires: clang,libicu-devel,gcc-c++,cmake,libuuid-devel,libedit-devel,swig,pkgconfig,libbsd-devel,libxml2-devel,libsqlite3x-devel,python-devel,ninja-build

%description
Build apple swift compiler from source

%prep
rm -fr *
gzip -dc ../SOURCES/swift.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/clang.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/cmark.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/corelibs-foundation.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/corelibs-xctest.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/llbuild.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/lldb.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/llvm.tar.gz | tar -xvvf -
gzip -dc ../SOURCES/package-manager.tar.gz | tar -xvvf -
mv swift-swift-%{tag} swift
mv swift-clang-swift-%{tag} clang
mv swift-cmark-0.22.0 cmark
mv swift-corelibs-foundation-swift-%{tag} swift-corelibs-foundation
mv swift-corelibs-xctest-swift-%{tag} swift-corelibs-xctest
mv swift-llbuild-swift-%{tag} llbuild
mv swift-lldb-swift-%{tag} lldb
mv swift-llvm-swift-%{tag} llvm
mv swift-package-manager-swift-%{tag} swiftpm

%install
sed -e s/lib\${LLVM_LIBDIR_SUFFIX}/lib64/g lldb/scripts/CMakeLists.txt > CMakeLists.txt.tmp && mv CMakeLists.txt.tmp lldb/scripts/CMakeLists.txt
cd swift
./utils/build-script --preset=buildbot_linux install_destdir=%{buildroot} installable_package=%{buildroot}/swift-%{ver}-%{rel}-fedora23.tar.gz
rm -fr %{buildroot}/swift-%{ver}-%{rel}-fedora23.tar.gz

%files
%defattr(-, root, root)
%{_bindir}/*
%{_includedir}/*
%{_libdir}/*
%{_usr}/lib/*
%{_mandir}/*

%clean
rm -rf %{buildroot}

#The changelog is built automatically from Git history
%changelog
