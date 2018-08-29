#!/usr/bin/env bash

work_dir=$(cd `dirname $0` && pwd)

kubectl apply -f ${work_dir}/deployment.yaml

kubectl get deployments
kubectl get pods
kubectl rollout status deployment/nodejs-hello-world-deployment

kubectl apply -f ${work_dir}/service.yaml
kubectl get service