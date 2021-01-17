#!/bin/bash
TARGET_DIR="/opt/gcc-armv8l/"
LINK="https://releases.linaro.org/components/toolchain/binaries/latest-7/armv8l-linux-gnueabihf/gcc-linaro-7.3.1-2018.05-x86_64_armv8l-linux-gnueabihf.tar.xz"

if [ "$1" == "aarch64" ]; then
	TARGET_DIR="/opt/gcc-aarch64/"
	LINK="https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz"
fi

echo "downloading the toolchain to $TARGET_DIR. There are ~100MB to download..."
mkdir -p $TARGET_DIR
wget -qO- $LINK | tar xJ -C $TARGET_DIR --strip-components=1

if [[ -z $(grep "$TARGET_DIR" ~/.bashrc) ]]; then
	echo "updating the PATH variable..."
	echo 'export PATH=$PATH'":$TARGET_DIR/bin" >> ~/.bashrc
	source ~/.bashrc
fi
