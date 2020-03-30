#!/bin/bash
#
# Licensed Materials - Property of IBM
#
# 5737-H33
#
# (C) Copyright IBM Corp. 2018  All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

TARGET_SECRET_NAME=$1

######################################################
# Build up the arguments for the kubectl command
######################################################

SECRET_ARGS=

if [ -s ./mqsc.txt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=mqsc=./mqsc.txt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=mqsc="
fi

if [ -s ./adminPassword.txt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=adminPassword=./adminPassword.txt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=adminPassword="
fi

if [ -s ./appPassword.txt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=appPassword=./appPassword.txt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=appPassword="
fi

if [ -s ./keystorePassword.txt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=keystorePassword=./keystorePassword.txt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=keystorePassword="
fi

if [ -s ./keystore-mykey.key ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=keystoreKey-mykey=./keystore-mykey.key"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=keystoreKey-mykey="
fi

if [ -s ./keystore-mykey.crt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=keystoreCert-mykey=./keystore-mykey.crt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=keystoreCert-mykey="
fi

if [ -s ./keystore-mykey.pass ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=keystorePass-mykey=./keystore-mykey.pass"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=keystorePass-mykey="
fi

if [ -s ./truststorePassword.txt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=truststorePassword=./truststorePassword.txt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=truststorePassword="
fi

if [ -s ./truststoreCert-mykey.crt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=truststoreCert-mykey=./truststoreCert-mykey.crt"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=truststoreCert-mykey="
fi

if [ -s ./odbc.ini ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=odbcini=./odbc.ini"
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=odbcini="
fi

if [ -s ./policy.xml ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=policy=./policy.xml "
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=policy="
fi

if [ -s ./policyDescriptor.xml ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=policyDescriptor=./policyDescriptor.xml "
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=policyDescriptor="
fi

if [ -s ./serverconf.yaml ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=serverconf=./serverconf.yaml "
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=serverconf="
fi

if [ -s ./setdbparms.txt ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=setdbparms=./setdbparms.txt "
else
  SECRET_ARGS="${SECRET_ARGS} --from-literal=setdbparms="
fi

if [ -s ./extensions.zip ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=extensions=./extensions.zip "
fi

if [ -s ./switch.json ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=switch=./switch.json "
fi

if [ -s ./agentx.json ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=agentx=./agentx.json "
fi

if [ -s ./agentp.json ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=agentp=./agentp.json "
fi

if [ -s ./agentc.json ]; then
  SECRET_ARGS="${SECRET_ARGS} --from-file=agentc=./agentc.json "
fi

######################################################
# Create the Kubernetes secret resource
######################################################

echo "Creating secret"
echo "kubectl create secret generic ${TARGET_SECRET_NAME}${SECRET_ARGS}"
kubectl create secret generic ${TARGET_SECRET_NAME}${SECRET_ARGS}
