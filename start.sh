#!/bin/bash
# Start script for Eco Dedicated Server Docker Image

# Move steamcmd install to startup
if [ ! -f /app/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /app/steamcmd/
	cd /app/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi

# fix dotnet ICU
#export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
# Update game
/app/steamcmd/steamcmd.sh +force_install_dir /app +login anonymous +app_update 739590 +quit

# LAUNCH THE GAME!
cd /app && 
	./EcoServer
