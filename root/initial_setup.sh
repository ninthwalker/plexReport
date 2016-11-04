#!/bin/bash
#walks the user through the initial setup
echo

if [ -f /config/config.yaml ]; then
  echo "Config files detected. Using existing config"
  echo    # move to a new line
else
 # begin initial setup
 cp /opt/config/* /config/
 chmod -R 666 /config/*
 /usr/local/sbin/plexreport-setup
 echo "Setup complete! Please read directions for running this on a schedule."
fi
