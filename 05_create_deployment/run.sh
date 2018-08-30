#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

kubectl apply -f ${WORK_DIR}/deployment.yaml

kubectl get deployments
kubectl get pods
kubectl rollout status deployment/nodejs-hello-world-deployment

kubectl apply -f ${WORK_DIR}/service.yaml
kubectl get service