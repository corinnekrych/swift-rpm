# swift-rpm
Swift RPM for Fedora.

## Requirements
To be compiled on Fedora 25 because gcc-7 is not supported yet on Fedora 26.

### Dependencies
libatomic and libBlocksRuntime are now needed too.

The official Fedora RPM for libBlocksRuntime-devel doesn't exist yet.
Unless the libBlocksRuntime RPM is installed by alternative ways, the [./libblocksruntime-0.1.gz](archive with headers and dynamic library files compiled on Fedora 25)
will be installed.

In later case the library are not registered to RPM's database and the resulting RPM package to be installed without dependencies using
`rpm -ivh --nodeps`


## Install Swift RPM
If libBlocksRuntime is not provided add option ```--nodeps```

```bash
sudo dnf install libbsd python2 gcc-c++ clang
sudo rpm -Uvh swift-4.0-DEVELOPMENT

cat >> ~/.bashrc <<EOF
# Swift language - https://bugs.swift.org/browse/SR-5524
export C_INCLUDE_PATH=/usr/lib/swift/clang/include/
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH
EOF
```

Tested on Fedora 25, 26 - 64 bits.

## Run a RPM build

To build a new tag version of swift edit rpm-from-source.sh and change TAG, REL and VER accordingly.
```bash
./rpm-from-source.sh
```
## Issues
lldb is compiled but CLI has characters issues (maybe libicu version) - This seems same issue as on Swift-3.1 rpm.
