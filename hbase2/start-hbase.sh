#!/usr/bin/env bash

HBASE_CONF_DIR=/etc/hbase/conf
HBASE_REGIONSERVERS=/etc/hbase/conf/regionservers

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

# default autostart args value indicating infinite window size and no retry limit
AUTOSTART_WINDOW_SIZE=0
AUTOSTART_WINDOW_RETRY_LIMIT=0

. "$bin"/hbase-config.sh

# start hbase daemons
errCode=$?
if [ $errCode -ne 0 ]
then
  exit $errCode
fi

if [ "$1" = "autostart" ]
then
  commandToRun="--autostart-window-size ${AUTOSTART_WINDOW_SIZE} --autostart-window-retry-limit ${AUTOSTART_WINDOW_RETRY_LIMIT} autostart"
else
  commandToRun="start"
fi


"$bin"/hbase-daemons.sh --config "${HBASE_CONF_DIR}" \ --hosts "${HBASE_REGIONSERVERS}" $commandToRun regionserver

