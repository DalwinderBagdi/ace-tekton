#!/bin/bash

RANDOM_RELEASE_NAME_STRING=$( cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 10 | head -n 1)
RELEASE=ace-server-tekton-dev-$RANDOM_RELEASE_NAME_STRING
TRACE_ENABLED=false
PULL_SECRET=$(oc get secrets -n ace | grep deployer-dockercfg |  awk -F' ' '{print $1 }')
PRODUCTION_DEPLOY=false
FILE_STORAGE="ibmc-file-gold"
IMAGE_REGISTRY=cp.icr.io
ACE_IMAGE=$IMAGE

# In case of production, it can be set to "3"
REPLICA_COUNT=1
if [ "$PRODUCTION" = "true" ]; then
  REPLICA_COUNT="3";
fi;

IMAGE_REGISTRY=cp.icr.io

ACE_IMAGE=$IMAGE_REGISTRY/ibm-ace-server-prod:11.0.0.6.1
if [ ! -z "$IMAGE" ];  then
  ACE_IMAGE=$IMAGE;
fi;

echo
echo "Running Helm Install"
echo

helm install ibm-entitled/ibm-ace-server-icp4i-prod \
          --name $RELEASE \
          --namespace ace \
          --tls \
          --set license=accept \
          --set image.aceonly=$ACE_IMAGE \
          --set aceonly.replicaCount=1 \
          --set image.pullSecret=$PULL_SECRET \
          --set productionDeployment=$PRODUCTION_DEPLOY \
          --set odTracingConfig.enabled=$TRACE_ENABLED \
          --tls \
          --debug
