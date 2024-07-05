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
mkdir pbskids-dl_debian_all
cd ./pbskids-dl_debian_all
mkdir DEBIAN
cd ./DEBIAN
cp $GITHUB_WORKSPACE/.debian/control3 ./control3
cp $GITHUB_WORKSPACE/.debian/changelog ./changelog
cd $GITHUB_WORKSPACE
dpkg --build ./pbskids-dl_debian_all
sha256sum pbskids-dl_debian_all.deb > pbskids-dl.sha256sum
echo "Build finished!"
echo "Check for errors after installing package."
