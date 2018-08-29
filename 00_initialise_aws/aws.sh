#!/usr/bin/env bash

brew update && brew install kops

DOMAIN=thnks.tk
DOMAIN_DOT=${DOMAIN}.
SUB_DOMAIN=kops
S3_BUCKET=thnks-tk-state-store

aws_switch io.thinkstack.admin
aws iam create-group --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name ${SUB_DOMAIN}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name ${SUB_DOMAIN}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name ${SUB_DOMAIN}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name ${SUB_DOMAIN}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name ${SUB_DOMAIN}
aws iam create-user --user-name ${SUB_DOMAIN}
aws iam add-user-to-group --user-name ${SUB_DOMAIN} --group-name ${SUB_DOMAIN}
aws iam create-access-key --user-name ${SUB_DOMAIN}

# add keys to ~/.aws/credentials
aws configure --profile io.thinkstack.kops

ID=$(uuidgen)
aws route53 create-hosted-zone --name ${SUB_DOMAIN}.${DOMAIN} --caller-reference ${ID} | jq .DelegationSet.NameServers
HOSTED_ZONE=$(aws route53 list-hosted-zones | jq --arg dom "${DOMAIN}." '.HostedZones[] | select(.Name==$dom) | .Id' | sed 's/\"//g')

aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE} --change-batch file://./route53_subdomain.json
dig ns kops.thnks.tk
aws s3api create-bucket --bucket ${S3_BUCKET} --region eu-west-1
aws s3api put-bucket-versioning --bucket ${S3_BUCKET} --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket ${S3_BUCKET} --server-side-encryption-configuration file://./s3_encryption.json
