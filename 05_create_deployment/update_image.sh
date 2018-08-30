#!/usr/bin/env bash

if [ ! $1 ]; then
  echo "Usage: $(basename $0) TAG"
  echo
  echo "  TAG - The new tag to apply to the image e.g. 1.0.5"
  exit
fi

DEPLOYMENT=nodejs-hello-world-deployment

kubectl set image deployment/${DEPLOYMENT} nodejs-hello-world=deploymentking/kops-node-app:$1  --record=true

kubectl rollout status deployment/${DEPLOYMENT}

kubectl rollout history deployment/${DEPLOYMENT}