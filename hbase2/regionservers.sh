#!/usr/bin/env bash

HBASE_CONF_DIR=/etc/hbase/conf
HBASE_REGIONSERVERS=/etc/hbase/conf/regionservers

# if no args specified, show usage
if [ $# -le 0 ]; then
  echo $usage
  exit 1
fi

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

. "$bin"/hbase-config.sh

# If the regionservers file is specified in the command line,
# then it takes precedence over the definition in 
# hbase-env.sh. Save it here.
HOSTLIST=$HBASE_REGIONSERVERS

if [ "$HOSTLIST" = "" ]; then
  if [ "$HBASE_REGIONSERVERS" = "" ]; then
    export HOSTLIST="${HBASE_CONF_DIR}/regionservers"
  else
    export HOSTLIST="${HBASE_REGIONSERVERS}"
  fi
fi

regionservers=`cat "$HOSTLIST"`
  HBASE_REGIONSERVER_ARGS="\
    -Dhbase.regionserver.port=16201 \
    -Dhbase.regionserver.info.port=16301"

  $"${@// /\\ }" ${HBASE_REGIONSERVER_ARGS} \
        2>&1 | sed "s/^/$regionserver: /" &

wait
