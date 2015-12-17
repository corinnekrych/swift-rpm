# swift-rpm
Swift RPM for Fedora.

## Install Swift RPM
```bash
sudo dnf install libbsd python gcc-c++ clang
sudo rpm -Uvh swift-2.2-SNAPSHOT20151210a.x86_64.rpm
```
## Run a RPM build

To build a new tag version of swift edit rpm-from-source.sh and change TAG, REL and VER accordingly.
```bash
./rpm-from-source.sh
```
