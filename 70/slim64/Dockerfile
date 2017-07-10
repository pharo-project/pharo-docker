#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM debian:stretch-slim

RUN set -ex \
	&& buildDeps='wget unzip' \
	&& runtimeDeps='libcairo2 libc6 libfreetype6' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps $runtimeDeps \
	&& cd /usr/local/bin \
	&& wget -O- http://get.pharo.org/64/vm70 | bash \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf /var/lib/apt/lists/* \
	&& true 

CMD ["pharo"]
	
