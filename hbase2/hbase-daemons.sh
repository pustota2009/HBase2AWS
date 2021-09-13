#!/usr/bin/env bash

HBASE_CONF_DIR=/etc/hbase/conf
HBASE_REGIONSERVERS=/etc/hbase/conf/regionservers


# if no args specified, show usage
if [ $# -le 1 ]; then
  echo $usage
  exit 1
fi

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

# default autostart args value indicating infinite window size and no retry limit
AUTOSTART_WINDOW_SIZE=0
AUTOSTART_WINDOW_RETRY_LIMIT=0

. $bin/hbase-config.sh

if [[ "$1" = "autostart" || "$1" = "autorestart" ]]
then
  autostart_args="--autostart-window-size ${AUTOSTART_WINDOW_SIZE} --autostart-window-retry-limit ${AUTOSTART_WINDOW_RETRY_LIMIT}"
fi

remote_cmd="$bin/hbase-daemon.sh --config ${HBASE_CONF_DIR} ${autostart_args} $@"
args="--hosts ${HBASE_REGIONSERVERS} --config ${HBASE_CONF_DIR} $remote_cmd"

exec "$bin/regionservers.sh" $args
