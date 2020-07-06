#!/bin/bash

export HELM_HOME=~/.helm

helm init --client-only

echo 'console:' + $CLOUD_URL
echo 'username:' + $CP4I_ADMIN_USERNAME
echo 'password:' + $CP4I_ADMIN_PASSWORD

cloudctl login -a $CLOUD_URL -n integration -u $CP4I_ADMIN_USERNAME -p $CP4I_ADMIN_PASSWORD --skip-ssl-validation

helm repo add ibm-entitled
https://raw.githubusercontent.com/IBM/charts/master/repo/entitled/; \

helm repo update;