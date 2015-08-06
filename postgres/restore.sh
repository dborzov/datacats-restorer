#!/bin/bash
set -e

export PGDATA="/db_volume"

echo '-------->  Restore to the resque'
mkdir -p "$PGDATA"
chown -R postgres "$PGDATA"

chmod g+s /run/postgresql
chown -R postgres /run/postgresql

echo '-------->  Init the db cluster (a dir where configs and data are stored)'
gosu postgres pg_ctl initdb -D "$PGDATA"
echo "local all  postgres    peer" >> $PGDATA/pg_hba.conf
echo "host  all  all    0.0.0.0/0  md5" >> $PGDATA/pg_hba.conf
echo '-------->  Start the daemon so we can feed it our SQL dump'
gosu postgres pg_ctl start -D "$PGDATA"
sleep 10
echo '-------->  Feeding the SQL dump to the db'
psql --username postgres -f /pg_backup_file.sql
echo '-------->  well db_container is supposed to work now'
