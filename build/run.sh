#! /bin/bash

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$designer" 2>/dev/null
  kill -TERM "$connectors" 2>/dev/null
  kill -TERM "$ace" 2>/dev/null
}

trap _term SIGTERM

echo "starting"
npm start &
child=$!
wait "$child"
echo "completed"&


./run-designer.sh &
designer=$!
./run-connectors.sh &
connectors=$!
./run-ace.sh
ace=$!
wait "$ace"
