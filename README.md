# swift-rpm
Swift RPM for Fedora. - Updated to Swift 4.0

## Install Swift RPM
```bash
sudo dnf install libbsd python gcc-c++ clang

sudo rpm -Uvh swift-4.0-RELEASE4.0.x86_64.rpm
```
Tested on Fedora 26, 64-bit.


## Run a RPM build

To build a new tag version of swift edit rpm-from-source.sh and change TAG, REL and VER accordingly.
```bash
./rpm-from-source.sh
```
