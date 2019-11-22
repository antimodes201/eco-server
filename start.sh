#!/bin/bash
# Start script for Eco Dedicated Server Docker Image

# Update game
/steamcmd/steamcmd.sh +login anonymous +force_install_dir /eco +app_update 739590 +quit

# LAUNCH THE GAME!
cd /eco && 
	mono EcoServer.exe -nogui 
