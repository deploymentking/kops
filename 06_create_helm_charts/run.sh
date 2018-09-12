#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

kubectl apply -f ${WORK_DIR}/rbac.yaml

helm init --service-account tiller

# https://docs.helm.sh/using_helm/#tiller-s-release-information
#helm init --override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}'
#helm init \
#    --override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' \
#    --tiller-tls \
#    --tiller-tls-verify \
#    --tiller-tls-cert=cert.pem \
#    --tiller-tls-key=key.pem \
#    --tls-ca-cert=ca.pem \
#    --service-account=accountname

helm create node-kops-thnks-tk

helm install node-kops-thnks-tk

helm list

helm history ${NAME_OF_LATEST_DEPLOYED_CHART}