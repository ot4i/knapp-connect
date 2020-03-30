kubectl apply --selector knative.dev/crd-install=true \
--filename https://github.com/knative/serving/releases/download/v0.12.0/serving.yaml \
--filename https://github.com/knative/eventing/releases/download/v0.12.0/eventing.yaml \
--filename https://github.com/knative/serving/releases/download/v0.12.0/monitoring.yaml

kubectl apply \
--filename https://github.com/knative/serving/releases/download/v0.12.0/serving.yaml \
#--filename https://github.com/knative/eventing/releases/download/v0.12.0/eventing.yaml \
#--filename https://github.com/knative/serving/releases/download/v0.12.0/monitoring.yaml


REMAINING_COUNT=1
while [ $REMAINING_COUNT -gt 0 ]
do
  date
  REMAINING=$(kubectl get pods --namespace knative-serving -o json | jq '.items[]|select(.status.phase!="Running")')
  REMAINING_COUNT=$(echo ${REMAINING} | jq '.phase' | wc -l)
  echo ${REMAINING} | jq '{"name":.metadata.name,"status":.status.phase,"conditions":.status.conditions}'
  date
  sleep 1
done

REMAINING_COUNT=1
while [ $REMAINING_COUNT -gt 0 ]
do
  date
  REMAINING=$(kubectl get pods --namespace knative-eventing -o json | jq '.items[]|select(.status.phase!="Running")')
  REMAINING_COUNT=$(echo ${REMAINING} | jq '.phase' | wc -l)
  echo ${REMAINING} | jq '{"name":.metadata.name,"status":.status.phase,"conditions":.status.conditions}'
  date
  sleep 1
done

REMAINING_COUNT=1
while [ $REMAINING_COUNT -gt 0 ]
do
  date
  REMAINING=$(kubectl get pods --namespace knative-monitoring -o json | jq '.items[]|select(.status.phase!="Running")')
  REMAINING_COUNT=$(echo ${REMAINING} | jq '.phase' | wc -l)
  echo ${REMAINING} | jq '{"name":.metadata.name,"status":.status.phase,"conditions":.status.conditions}'
  date
  sleep 1
done
