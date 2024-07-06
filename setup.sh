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
mkdir pbskids-dl_debian
cd ./pbskids-dl_debian
mkdir -p usr/lib/pbskids-dl
cd ./usr/lib/pbskids-dl
cp $GITHUB_WORKSPACE/pbskids-dl.py .
cp $GITHUB_WORKSPACE/pbskids-dl.sh .
cp $GITHUB_WORKSPACE/pbskids-dl_gui.py .
cp $GITHUB_WORKSPACE/.debian/version .
cd ../../
mkdir bin
ln -sf ./pbskids-dl.py /usr/lib/pbskids-dl/pbskids-dl.py
ln -sf ./pbskids-dl_gui.py /usr/lib/pbskids-dl/pbskids-dl_gui.py
ln -sf ./pbskids-dl_gui.sh /usr/lib/pbskids-dl/pbskids-dl.sh
chmod +x *
cd ../../
mkdir DEBIAN
cd ./DEBIAN
cp $GITHUB_WORKSPACE/.debian/control ./control
cp $GITHUB_WORKSPACE/.debian/postinst ./postinst
cp $GITHUB_WORKSPACE/.debian/prerm ./prerm
cp $GITHUB_WORKSPACE/.debian/changelog ./changelog
cd $GITHUB_WORKSPACE
dpkg-deb --root-owner-group --build ./pbskids-dl_debian
sha256sum -b pbskids-dl_debian.deb > pbskids-dl_debian.sha256sum
echo "Build finished!"
echo "Check for errors after installing package."
