#!/bin/bash
BASH_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# download resources
rsync -avzh --exclude test ${BASH_SOURCE_DIR}/.. ${BASH_SOURCE_DIR}/tmp

pushd ${BASH_SOURCE_DIR}/tmp

# build image
DESIGNER_IMAGE=ibm-ace-designer-flows-prod:11.0.0.7-r2-amd64
CONNECTOR_IMAGE=ibm-ace-lcp-prod:11.0.0.7-r2-amd64
ACE_IMAGE=ibm-ace-server-prod:11.0.0.7-r2-amd64
pushd ${BASH_SOURCE_DIR}/../build
docker build -t dev.local/knapp-connect:latest --build-arg DESIGNER_IMAGE=${DESIGNER_IMAGE} --build-arg CONNECTOR_IMAGE=${CONNECTOR_IMAGE} --build-arg ACE_IMAGE=${ACE_IMAGE} .

popd
# configure secret
pushd config
./generateSecrets.sh my-secret
popd

# edit yaml
cat integration-server-knative-service.yaml |  sed "s/not accepted/accept/" > integration-server-knative-service.yaml.tmp
mv integration-server-knative-service.yaml.tmp integration-server-knative-service.yaml

kubectl apply -f integration-server-knative-service.yaml

time curl -X POST -H "Content-Type: application/json" http://ace-server-knative.default.example.com/Echo/Echo -d @- <<EOF
{
  "text": "HELLO WORLD"
}
EOF

popd


kubectl delete secret my-secret
kubectl delete ksvc ace-server-knative
