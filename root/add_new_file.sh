#!/bin/bash
# Added to check if new web_email_body.erb file exists, if not, add.
if [ -f /config/web_email_body.erb ]; then
  echo    # new line, do nothing
else
 # copy new file
 cp /opt/config/web_email_body.erb /config/
 chmod -R 666 /config/web_email_body.erb
fi
