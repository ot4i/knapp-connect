## build the single image to support designer flows
```
pushd build
./build.sh
popd
```
If you see errors at this step such as
```
Get https://cp.icr.io/v2/cp/icp4i/ace/ibm-ace-lcp-prod/manifests/11.0.0.6.1-amd64: unauthorized: authentication required
```
then ensure that you have logged into the entitled registry.

Validate that your images has been built by running

```
docker images | grep knapp-connect
```

and you should see something like
```
dev.local/knapp-connect                                                                  latest              9d1c188f89ac        8 seconds ago       4.36GB
```

Take a minute to inspect the Docker file and you will notice that it starts with the 3 ace images ( ace-server, connectors and designer) and copies the relevant files into a single image.

The entry point is the `run.sh` bash script.  You can find this in the downloaded zip at `build/run.sh`.  This bash script runs the 3 processes in the background, and forwards any `SIGTERM` signals to ensure a graceful container shut down.
