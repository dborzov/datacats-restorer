#!/bin/bash
set -e

set_listen_addresses() {
	sedEscapedValue="$(echo "$1" | sed 's/[\/&]/\\&/g')"
	sed -ri "s/^#?(listen_addresses\s*=\s*)\S+/\1'$sedEscapedValue'/" "$DB_CLUSTER_DIR/postgresql.conf"
}

echo 'Hello everyone! This is me, your lovable datacats-restore db entry point!'
set_listen_addresses '*'
gosu postgres pg_ctl start -D $DB_CLUSTER_DIR -l /db_volume/logs
sleep 10
echo 'Ok, the db daemon is started, now Ill be listening to the logs'
tail -f /db_volume/logs
