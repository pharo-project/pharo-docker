#!/bin/bash
ARCH=$1
VERSION=$2
IMAGE=$3

if [ $ARCH = "64" ]; then
	wget -O- get.pharo.org/64/${VERSION} | bash
else
	wget -O- get.pharo.org/${VERSION} | bash
fi

# Just the basics to ensure image is alright
TEST="^(Kernel-Tests)"
TEST="$TEST|(Athens.*)"
TEST="$TEST|(Zodiac-Tests)"

docker run -ti --rm -v `pwd`:/var/data "$IMAGE" pharo /var/data/Pharo.image test --no-xterm --fail-on-failure "${TEST}"
