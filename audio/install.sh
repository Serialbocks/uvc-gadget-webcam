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
