#!/bin/bash

# Check if config exists. If not, copy in the sample config
if [ -f /config/config.yaml ]; then
  echo "Using existing config file."
  ln -s /config/config.yaml /etc/plexReport/config.yaml
else
  echo "Creating config from template."
  mv /opt/plexReport/etc/config.yaml.example /config/config.yaml
  chown nobody:users /config/config.yaml
  ln -s /config/config.yaml /etc/plexReport/config.yaml
fi

# Check if email_body.erb exists. If not, copy the original
if [ -f /config/email_body.erb ]; then
  echo "Using existing email_body file."
  ln -s /config/email_body.erb /etc/plexReport/email_body.erb
else
  echo "Creating email_body from template."
  cp /opt/plexReport/etc/email_body.erb /config/email_body.erb
  chown nobody:users /config/email_body.erb
  ln -s /config/email_body.erb /etc/plexReport/email_body.erb
fi
