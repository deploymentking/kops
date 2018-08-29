#!/usr/bin/env bash

work_dir=$(cd `dirname $0` && pwd)

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
kubectl apply -f ${work_dir}/external_dns.yaml
