FROM mono:6.0

MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

USER root

# Set some Variables
ENV TZ "America/New_York"
ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV GAME_PORT "3000"
ENV WEB_PORT "3001"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		lib32gcc1 \
		wget \
		unzip \
		tzdata \
		ca-certificates 

# add steamuser user
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /steamcmd \
        && mkdir -p /eco \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /eco \
        && chown steamuser:steamuser /steamcmd \
		&& chown steamuser:steamuser /scripts 

# Install Steamcmd
USER steamuser
RUN cd /steamcmd && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xf steamcmd_linux.tar.gz && \
	rm steamcmd_linux.tar.gz && \
	/steamcmd/steamcmd.sh +quit

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE ${GAME_PORT} ${WEB_PORT}/udp
EXPOSE ${GAME_PORT} ${WEB_PORT}/tcp

# Make a volume
# contains configs and world saves
VOLUME /eco

# Set Timezone


CMD ["/scripts/start.sh"]
