#!/usr/bin/env bash

work_dir=$(cd `dirname $0` && pwd)

kubectl apply -f ${work_dir}/pod.yaml
kubectl apply -f ${work_dir}/service.yaml
