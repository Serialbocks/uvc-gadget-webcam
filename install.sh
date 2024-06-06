
#/bin/bash

if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

echo "Starting installation..."

echo "Installing Dependencies..."
apt update
apt full-upgrade -y
apt install git meson libcamera-dev libjpeg-dev -y
echo "OK"

DIRECTORY='/opt/uvc-gadget-webcam'
SERVICE="uvc-gadget-webcam.service"
SERVICE_PATH="/lib/systemd/system/$SERVICE"

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
#cp ./run-ffmpeg.sh $DIRECTORY/run-ffmpeg.sh
cp ./uvc.py $DIRECTORY/uvc.py
echo "OK"

DTOVERLAY_DIR="$DIRECTORY/dtoverlay"
if [ ! -d "$DTOVERLAY_DIR" ]; then
  mkdir $DTOVERLAY_DIR
  echo "Enabling dtoverlay otg firmware..."
  echo "dtoverlay=dwc2,dr_mode=otg" | tee -a /boot/firmware/config.txt
  echo "OK"
else
  echo "dtoverlay already enabled"
fi

echo "Installing service..."
echo "[Unit]" | tee $SERVICE_PATH
echo "Description=UVC Webcam Gadget Stream Service" | tee -a $SERVICE_PATH
echo "After=multi-user.target" | tee -a $SERVICE_PATH
echo "" | tee -a $SERVICE_PATH
echo "[Service]" | tee -a $SERVICE_PATH
echo "Type=simple" | tee -a $SERVICE_PATH
echo "WorkingDirectory=$DIRECTORY" | tee -a $SERVICE_PATH
echo "ExecStart=/usr/bin/python $DIRECTORY/uvc.py" | tee -a $SERVICE_PATH
echo "Restart=on-abort" | tee -a $SERVICE_PATH
echo "" | tee -a $SERVICE_PATH
echo "[Install]" | tee -a $SERVICE_PATH
echo "WantedBy=multi-user.target" | tee -a $SERVICE_PATH
chmod 644 $SERVICE_PATH
chmod +x $DIRECTORY/uvc.py
systemctl daemon-reload
systemctl enable $SERVICE
echo "OK"

echo "Installation complete! Please restart to get driver working."