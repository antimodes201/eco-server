FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

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
		libgdiplus  \
		libc6-dev \
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
        && mkdir -p /app \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /app \
		&& chown steamuser:steamuser /scripts 

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE ${GAME_PORT} ${WEB_PORT}/udp
EXPOSE ${GAME_PORT} ${WEB_PORT}/tcp

USER steamuser

# Make a volume
# contains configs and world saves
VOLUME /app

CMD ["/scripts/start.sh"]
