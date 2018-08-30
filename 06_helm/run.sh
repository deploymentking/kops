#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

kubectl apply -f ${WORK_DIR}/rbac.yaml

helm init --service-account tiller