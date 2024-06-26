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
mkdir pbskids-dl_deb
cd ./pbskids-dl_deb
mkdir -p usr/bin
cd ./usr/bin
cp $GITHUB_WORKSPACE/pbskids-dl.py .
cp $GITHUB_WORKSPACE/pbskids-dl.sh .
ln -s ./pbskids-dl.py ./pbskids-dl
chmod +x *
cd ../../
mkdir DEBIAN
cd ./DEBIAN
cp $GITHUB_WORKSPACE/.debian/control ./control
cd $GITHUB_WORKSPACE
dpkg --build ./pbskids-dl_deb
sha256sum pbskids-dl_deb.deb | gzip > pbskids-dl.sha256sum.gz
sha256sum pbskids-dl_deb.deb > pbskids-dl.sha256sum
echo "Build finished!"
echo "Check for errors after installing package."
