#/bin/bash
# Start PHP-FPM Service
service php5-fpm start

# Start Nginx
nginx -g "daemon off;"
