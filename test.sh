#!/bin/bash
ARCH=$1
VERSION=$2
IMAGE=$3

if [ $ARCH = "64" ]; then
	echo wget -O- get.pharo.org/64/${VERSION} | bash
else
	echo wget -O- get.pharo.org/${VERSION} | bash
fi

# a copy from https://github.com/pharo-project/pharo-vm/blob/master/scripts/run-tests.sh
NO_TEST="^(?!Metacello)"		# too long
NO_TEST="$NO_TEST(?!Versionner)"	# too long
NO_TEST="$NO_TEST(?!GT)"		# too slow
#NO_TEST="$NO_TEST(?!Athens)"		# no cairo, no athens
#NO_TEST="$NO_TEST(?!OSWindow)"		# no cairo, no oswindow
#NO_TEST="$NO_TEST(?!TxText)"		# no cairo, no TxText
NO_TEST="$NO_TEST(?!ReleaseTests)"	# just not now :)

docker run -ti --rm -v `pwd`:/var/data "$IMAGE" pharo /var/data/Pharo.image test --no-xterm --fail-on-failure "$NO_TEST[A-Z].*"
