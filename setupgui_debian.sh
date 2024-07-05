if [ -n "$GITHUB_WORKSPACE" ]; then
  echo "Github actions detected."
else
  echo "Non-github actions detected."
  echo "Setting variables up..."
  export GITHUB_WORKSPACE=($PWD)
fi
cd $GITHUB_WORKSPACE
echo "Building at $(pwd)"
chmod +x *
mkdir pbskids-dl_debian_gui
cd ./pbskids-dl_debian_gui
mkdir -p usr/bin
cd ./usr/bin
cp $GITHUB_WORKSPACE/pbskids-dl_gui.py .
ln -s ./pbskids-dl_gui.py ./pbskids-dl_gui
cd ../../
mkdir DEBIAN
cd ./DEBIAN
cp $GITHUB_WORKSPACE/.debian/control2 ./control
cp $GITHUB_WORKSPACE/.debian/changelog ./changelog
cd $GITHUB_WORKSPACE
dpkg --build ./pbskids-dl_debian_gui
sha256sum pbskids-dl_debian_gui.deb > pbskids-dl.sha256sum
echo "Build finished!"
echo "Check for errors after installing package."
