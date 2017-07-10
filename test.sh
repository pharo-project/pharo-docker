#!/bin/bash
VERSION=$1
IMAGE=$2

wget -O- get.pharo.org/${VERSION} | bash
docker run -ti --rm -v `pwd`:/var/data "$IMAGE" pharo /var/data/Pharo.image test '^Z.*'
