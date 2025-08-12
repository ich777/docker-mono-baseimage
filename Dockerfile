FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-mono-baseimage"

RUN export TZ=Europe/Rome && \
	apt-get update && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone && \
	apt-get -y install --no-install-recommends gnupg && \
	apt-get -y install --reinstall ca-certificates && \
	mkdir -p /usr/share/keyrings && \
	gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
	echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
	apt-get -o Acquire::AllowInsecureRepositories=true update && \
	apt-get -o Acquire::AllowInsecureRepositories=true -y --allow-unauthenticated install mono-complete && \
	apt-get -y --purge remove gnupg && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*