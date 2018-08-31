#!/usr/bin/env bash

set -e

S3_BUCKET=thnks-tk-helm
REPO_NAME=thnks-tk-charts
CHART_NAME=node-kops-thnks-tk
CHART_VERSION=0.1.2

aws_switch io.thinkstack.admin

aws s3api create-bucket \
    --bucket ${S3_BUCKET} \
    --region ${AWS_REGION} \
    --create-bucket-configuration LocationConstraint=${AWS_REGION}

# install helm s3 plugin
helm plugin install https://github.com/hypnoglow/helm-s3.git

# initialize s3 bucket
helm s3 init s3://${S3_BUCKET}/charts

# add reference to the s3 helm repository created above
helm repo add ${REPO_NAME} s3://${S3_BUCKET}/charts

# package the chart
helm package ${CHART_NAME}

# push package to helm s3 repository
helm s3 push ./${CHART_NAME}-${CHART_VERSION}.tgz ${REPO_NAME}

# check status
helm search ${CHART_NAME}

# install from s3
helm install ${REPO_NAME}/${CHART_NAME}