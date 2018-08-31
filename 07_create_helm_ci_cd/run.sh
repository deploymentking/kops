#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

kubectl create -f ${WORK_DIR}/rbac.yaml

helm install \
    --name jenkins \
    --set rbac.install=true,Master.RunAsUser=1000,Master.FsGroup=1000 \
    stable/jenkins
