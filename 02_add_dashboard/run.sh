#!/usr/bin/env bash

work_dir=$(cd `dirname $0` && pwd)

# Check here for latest release
# https://github.com/kubernetes/dashboard/releases
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.0/src/deploy/recommended/kubernetes-dashboard.yaml

# Create a ClusterRoleBinding for user kubernetes-dashboard created in yaml above
# https://github.com/kubernetes/dashboard/wiki/Creating-sample-user
# https://github.com/kubernetes/kops/blob/master/docs/addons.md#rbac
kubectl apply -f ${work_dir}/rbac.yaml

# Gets admin password
# kops get secrets kube --type secret -oplaintext

# Get bearer token for above user kubernetes-dashboard
echo
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep kubernetes-dashboard | awk '{print $1}') | grep "token:"

# Now access Dashboard via proxy at:
printf "\nhttp://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/\n\n"
kubectl proxy
