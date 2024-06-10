#!/bin/bash

sudo apt-get install -y chromium-chromedriver

git clone --recurse-submodules https://github.com/SeleniumHQ/selenium.git
cd selenium/rust
curl https://sh.rustup.rs -sSf > install-rust.sh
chmod +x ./install-rust.sh
./install-rust.sh -y
. "$HOME/.cargo/env"
cargo build

sudo cp target/debug/selenium-manager /usr/bin/selenium-manager
export SE_MANAGER_PATH=/usr/bin/selenium-manager
echo "export SE_MANAGER_PATH=/usr/bin/selenium-manager" >> $HOME/.bashrc

echo "Let's cleanup!"
cd ../..
rm -rf "selenium"
echo "Script executed from: ${PWD}"

BASEDIR=$(dirname $0)
echo "Script location: ${BASEDIR}"

AUTOSTART_DIR=$HOME/.config/autostart
AUTOSTART_PATH=$AUTOSTART_DIR/audiostream.desktop

cd $HOME/.config/autostart/
mkdir $AUTOSTART_DIR
echo "[Desktop Entry]" | tee $AUTOSTART_PATH
echo "Type=Application" | tee -a $AUTOSTART_PATH
echo "Name=Audiostream" | tee -a $AUTOSTART_PATH
echo "Comment=Audiostream" | tee -a $AUTOSTART_PATH
echo "Exec=lxterminal --working-directory=${PWD} -e ./run.sh" | tee -a $AUTOSTART_PATH
echo "Type=Application" | tee -a $AUTOSTART_PATH

