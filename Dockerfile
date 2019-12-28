FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN export TZ=Europe/Rome && \
	apt-get update && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone && \
	apt-get -y install --no-install-recommends gnupg software-properties-common && \
	apt-get -y install --reinstall ca-certificates && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
	echo "deb https://download.mono-project.com/repo/debian stable-buster main" | \
	tee /etc/apt/sources.list.d/mono-official-stable.list && \
	apt-get update && \
	apt-get -y install mono-complete && \
	apt-get -y --purge remove software-properties-common gnupg && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*