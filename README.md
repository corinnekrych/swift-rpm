# swift-rpm
Swift RPM for Fedora.

## Install Swift RPM
```bash
sudo dnf install libbsd python gcc-c++ clang
sudo rpm -Uvh swift-3.1-RELEASE3.1.x86_64.rpm
```
Tested on Fedora 22, 23, 24, 25 - 64 bits.

## Run a RPM build

To build a new tag version of swift edit rpm-from-source.sh and change TAG, REL and VER accordingly.
```bash
./rpm-from-source.sh
```
