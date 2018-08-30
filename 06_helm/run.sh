#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

kubectl apply -f ${WORK_DIR}/rbac.yaml

helm init --service-account tiller

helm create node-kops-thnks-tk

helm install node-kops-thnks-tk

helm list

helm history ${NAME_OF_LATEST_DEPLOYED_CHART}