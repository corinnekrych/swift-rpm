# swift-rpm
Swift RPM for Fedora.


## Install Swift RPM
Swift can now be installed directly via DNF:

``sudo dnf install swift-lang``

This will work for Fedora 28 and later.
## Pre-DNF version
If you're interested in trying out the latest beta version of Swift, check out the other branches in this repository. 

```bash
./rpm-from-source.sh

sudo rpm -Uvh swift-4.1.1-RELEASE4.1.1.x86_64.rpm
```
Tested on Fedora 27, 28, and Rawhide, 64-bit.

## Run a RPM build

To build a new tag version of swift edit rpm-from-source.sh and change TAG, REL and VER accordingly.
```bash
./rpm-from-source.sh
```

