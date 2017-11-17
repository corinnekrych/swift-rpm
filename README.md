# swift-rpm
Swift RPM for Fedora. - Updated to Swift 4.0.2

## Install Swift RPM
```bash
sudo dnf install libbsd python gcc-c++ clang

sudo rpm -Uvh swift-4.0.2-RELEASE4.0.2.x86_64.rpm
```
Tested on Fedora 26 and 27, 64-bit.


## Run a RPM build

To build a new tag version of swift edit rpm-from-source.sh and change TAG, REL and VER accordingly.
```bash
./rpm-from-source.sh
```
