#!/bin/bash
HOST="mysql"
USER="admin"
PASSWORD="localpw"
OUTPUT="/var/backups"

databases=`mysql -h $HOST -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump -h $HOST -u $USER -p$PASSWORD --databases $db > $OUTPUT/`date +%Y%m%d`.$db.sql
       # gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done
