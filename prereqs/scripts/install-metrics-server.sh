# TODO figure out how to edit yaml on command line.....

git clone https://github.com/kubernetes-sigs/metrics-server.git
pushd metrics-server
npx yaml2json deploy/kubernetes/metrics-server-deployment.yaml |\
 jq '.[1].spec.template.spec.containers[0].command=["/metrics-server","--kubelet-insecure-tls"]' |\
 npx json2yaml -

```

edit deploy/1.8+/metrics-server-deployment.yaml
```
command:
      - /metrics-server
      - --kubelet-insecure-tls
```

```
kubectl apply -f deploy/1.8+/
kubectl top pods
```
#You might need to restart any pods that are already running
