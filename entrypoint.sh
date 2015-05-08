#!/bin/bash

set -x

set -e

cat /opt/lib/setup.yml

echo DB_CONTAINER_NAME: ${DB_CONTAINER_NAME:=${0##*/}}
echo DB_SERVER_DBMS: ${DB_SERVER_DBMS:=mysql}
echo DB_SERVER_HOST: ${DB_SERVER_HOST:=$DB_PORT_3306_TCP_ADDR}
echo DB_SERVER_PORT: ${DB_SERVER_PORT:=$DB_PORT_3306_TCP_PORT}
echo DB_SERVER_USER: ${DB_SERVER_USER:=jobscheduler}
echo DB_SERVER_PASSWORD: ${DB_SERVER_PASSWORD:=jobscheduler}
echo DB_SERVER_DATABASE: ${DB_SERVER_DATABASE:=jobscheduler}
#echo REDIS_SERVER_HOST: ${REDIS_SERVER_HOST:=$REDIS_PORT_6379_TCP_ADDR}
#echo REDIS_SERVER_PORT: ${REDIS_SERVER_PORT:=$REDIS_PORT_6379_TCP_PORT}
echo DB_WAIT_CONTAINER_KEY: ${DB_WAIT_CONTAINER_KEY:=sample-database}

cat /opt/lib/setup.yml

sed -i -e "s/{{DB_SERVER_DBMS}}/$DB_SERVER_DBMS/g" /opt/lib/setup.yml
sed -i -e "s/{{DB_SERVER_HOST}}/$DB_SERVER_HOST/g" /opt/lib/setup.yml
sed -i -e "s/{{DB_SERVER_PORT}}/$DB_SERVER_PORT/g" /opt/lib/setup.yml
sed -i -e "s/{{DB_SERVER_USER}}/$DB_SERVER_USER/g" /opt/lib/setup.yml
sed -i -e "s/{{DB_SERVER_PASSWORD}}/$DB_SERVER_PASSWORD/g" /opt/lib/setup.yml
sed -i -e "s/{{DB_SERVER_DATABASE}}/$DB_SERVER_DATABASE/g" /opt/lib/setup.yml

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source $DIR/mysql-java-embulk-docker-lib.sh

cat /opt/lib/setup.yml

ls -l /opt/lib/

is_install=true

if [ $is_install=true ]; then
    echo "embulk run setup.yml"
    cd /opt/lib && /opt/embulk run setup.yml
fi

if [ -n "$REDIS_SERVER_HOST" ]; then
    redis-cli -h $REDIS_SERVER_HOST -p $REDIS_SERVER_PORT SET $DB_WAIT_CONTAINER_KEY up
fi
