# Pharo 40 requires libssl1.0.0:i386, using older debian release (debian:jessie)

FROM debian:jessie-slim

ENV PHARO_VM 40

RUN set -ex \
	&& buildDeps='wget unzip' \
	&& runtimeDeps='libcairo2:i386 libc6:i386 libfreetype6:i386 libssl1.0.0:i386' \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps $runtimeDeps \
	&& cd /usr/local/bin \
	&& wget -O- http://get.pharo.org/vm${PHARO_VM} | bash \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf /var/lib/apt/lists/* \
	&& true 

CMD ["pharo"]
	
