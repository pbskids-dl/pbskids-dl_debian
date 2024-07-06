#!/bin/bash
if [ -n "$GITHUB_WORKSPACE" ]; then
  echo "Github actions detected. No action needed."
else
  echo "Non-github actions detected."
  echo "Setting variables up..."
  export GITHUB_WORKSPACE=($PWD)
fi
cd $GITHUB_WORKSPACE
echo "Building at $(pwd)"
chmod +x *
mkdir pbskids-dl_debian_cli
cd ./pbskids-dl_debian_cli
mkdir -p usr/bin
cd ./usr/bin
cp $GITHUB_WORKSPACE/pbskids-dl.py .
cp $GITHUB_WORKSPACE/pbskids-dl.sh .
ln -s ./pbskids-dl.py ./pbskids-dl
cp $GITHUB_WORKSPACE/pbskids-dl_gui.py .
ln -s ./pbskids-dl_gui.py ./pbskids-dl_gui
chmod +x *
cd ../../
mkdir DEBIAN
cd ./DEBIAN
cp $GITHUB_WORKSPACE/.debian/control ./control
cp $GITHUB_WORKSPACE/.debian/changelog ./changelog
cd $GITHUB_WORKSPACE
dpkg-deb --root-owner-group --build ./pbskids-dl_debian
sha256sum -b pbskids-dl_debian.deb > pbskids-dl_debian.sha256sum
echo "Build finished!"
echo "Check for errors after installing package."
