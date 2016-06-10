#!/bin/bash
# Bash script that copies plexreport files to various directories
# and walks the user through the initial setup
#

/bin/echo "This script will create a backup if a config exists, and then delete any plexReport config that you may already have"
read -p "Are you sure you want to run this? [Y/N] " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
# create backups
/bin/mkdir /config/backup
/bin/cp /config/* /config/backup/
/bin/echo "Backup complete. Find at /config/backup"

PLEX_REPORT_LIB='/var/lib/plexReport'
PLEX_REPORT_CONF='/config'

# /bin/echo "Creating plexreport library at /var/lib/plexReport"
/bin/mkdir -p $PLEX_REPORT_LIB

# /bin/echo "Moving plexreport and plexreport-setup to /usr/local/sbin"
/bin/cp -r bin/* /usr/local/sbin
#/bin/echo "Moving plexreport libraries to /var/lib/plexreport"
/bin/cp -r lib/* $PLEX_REPORT_LIB
#/bin/echo "Moving email_body.erb to /config"
/bin/cp -r etc/* $PLEX_REPORT_CONF
chmod +666 $PLEX_REPORT_CONF/email_body.erb
chmod +666 $PLEX_REPORT_CONF/email_schedule.cron

# /bin/echo "Creating /config/config.yaml"
/usr/bin/touch /config/config.yaml
# /bin/echo "Creating /config/plexReport.log"
/usr/bin/touch /config/plexReport.log

# /bin/echo "Installing ruby gem dependency"
/usr/bin/gem install bundler # fix world-writable bundle error
chmod +t -R ~/.bundle/cache
/usr/local/bin/bundle install

# /bin/echo "Running /usr/local/sbin/plexreport-setup"
/usr/local/sbin/plexreport-setup

/bin/echo "Setup complete! Please create a cronjob from within unRAID to call the plexReport on a schedule."
fi
