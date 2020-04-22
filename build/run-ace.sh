#!/bin/bash
_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

cd /home/aceuser
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export SUMMARY="Integration Server for App Connect Enterprise"
export DESCRIPTION="Integration Server for App Connect Enterprise"
export PRODNAME=AppConnectEnterprise
export COMPNAME=IntegrationServer
export BASH_ENV=/usr/local/bin/ace_env.sh
export LOG_FORMAT=basic
source /usr/local/bin/ace_env.sh
env
runaceserver&
child=$!
wait "$child"
