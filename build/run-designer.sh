#!/bin/bash
_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

cd /home/aceuser/designer
PATH=/home/aceuser/designer:/opt/app-root/src/node_modules/.bin/:/opt/app-root/src/.npm-global/bin/:/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
APP_ROOT=/home/aceuser/designer
HOME=/home/aceuser/designer
PLATFORM=el8
NODEJS_VER=10
NODEJS_VERSION=10
NPM_RUN=start
NAME=nodejs
NPM_CONFIG_PREFIX=/home/aceuser/designer/.npm-global
PRODNAME=AppConnectEnterprise
COMPNAME=designer-flows
NODE_ENV=production
SUPPRESS_NO_CONFIG_WARNING=true
LOG_REDACTION=false
WORKING_DIRECTORY=/home/aceuser/ace-server
bunyan__logfile__filename=/home/aceuser/ace-server/log/designer.json
npx bytenode server.jsc&
child=$!
wait "$child
