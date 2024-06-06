
#/bin/bash

if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

echo "Starting installation..."

DIRECTORY='/opt/uvc-gadget-webcam'

if [ ! -d "$DIRECTORY" ]; then
  echo "Creating target directory $DIRECTORY"
  mkdir $DIRECTORY
else
  echo "Directory $DIRECTORY already exists"
fi

echo "Compiling v4l2loopback..."
cd v4l2loopback
make
echo "Installing v4l2loopback..."
make install
echo "Installing v4l2loopback-ctl..."
cp utils/v4l2loopback-ctl $DIRECTORY/v4l2loopback-ctl
echo "Refreshing driver modules..."
depmod -a
cd ..
echo "OK"

echo "Compiling UVC Gadget Drivers..."
cd uvc-gadget
make
echo "Installing UVC Gadget Drivers..."
make install
cd ..
echo "OK"

echo "Compiling UVC Program..."
cd uvc-prog
make
echo "Installing UVC Program..."
cp ./uvc-gadget $DIRECTORY/uvc-gadget
cd ..
echo "OK"

echo "Installing mediamtx..."
cp ./mediamtx $DIRECTORY/mediamtx
cp ./mediamtx.yml $DIRECTORY/mediamtx.yml
echo "OK"

echo "Installing driver scripts..."
cp ./rpi-uvc-gadget.sh $DIRECTORY/rpi-uvc-gadget.sh
cp ./uvc.py $DIRECTORY/uvc.py
echo "OK"