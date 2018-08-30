#!/usr/bin/env bash

WORK_DIR=$(cd `dirname $0` && pwd)

export NAME=kops.thnks.tk
#kops edit cluster ${NAME}

# https://github.com/kubernetes/kops/blob/master/docs/iam_roles.md
# Add the following to the spec to allow additional IAM policies for updating Route53
#spec:
#  additionalPolicies:
#    node: |
#      [
#        {
#          "Effect": "Allow",
#          "Action": [
#            "route53:ChangeResourceRecordSets"
#          ],
#          "Resource": [
#            "arn:aws:route53:::hostedzone/*"
#          ]
#        },
#        {
#          "Effect": "Allow",
#          "Action": [
#            "route53:ListHostedZones",
#            "route53:ListResourceRecordSets"
#          ],
#          "Resource": [
#            "*"
#          ]
#        }
#      ]

# https://github.com/kubernetes-incubator/external-dns/blob/master/docs/tutorials/aws.md
kubectl apply -f ${WORK_DIR}/external_dns.yaml
