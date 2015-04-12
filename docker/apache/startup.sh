#/bin/bash

# Logging
mkdir -p /var/log/apache2
chmod 755 /var/log/apache2

# Start apache2 in foreground
/usr/sbin/apache2ctl -D FOREGROUND