#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

kubectl apply -f ${WORK_DIR}/pod.yaml
kubectl apply -f ${WORK_DIR}/service.yaml
