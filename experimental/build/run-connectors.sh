#!/bin/bash

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM


cd /home/aceuser/connectors
PATH=/home/aceuser/connectors:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SUMMARY="App Connect Designer to run on software"
DESCRIPTION="Running flows on software, authoring flows on software"
PRODNAME=AppConnectEnterprise
COMPNAME=LCPSoftware
NODEJS_VERSION=10
HOME=/home/aceuser/connectors
APP_ROOT=/home/aceuser/connectors
NODE_ENV=production
NPM_CONFIG_PREFIX=/home/aceuser/connectors/.npm-global
SUPPRESS_NO_CONFIG_WARNING=true
WORKING_DIRECTORY=/home/aceuser/ace-server
bunyan__logfile__filename=/home/aceuser/ace-server/log/connectors.json

npx bytenode server.jsc&
child=$!
wait "$child"
