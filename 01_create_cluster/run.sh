#!/usr/bin/env bash

SUB_DOMAIN=kops
DOMAIN=thnks.tk
S3_BUCKET=thnks-tk-state-store

export NAME=kops.thnks.tk
export KOPS_STATE_STORE=s3://${S3_BUCKET}

kops create cluster --name=${NAME} \
                    --dns-zone=${SUB_DOMAIN}.${DOMAIN} \
                    --master-count=3 \
                    --master-size=t2.micro \
                    --master-zones=eu-west-1a,eu-west-1b,eu-west-1c \
                    --node-count=3 \
                    --node-size=t2.micro \
                    --zones=eu-west-1a,eu-west-1b,eu-west-1c \
                    --ssh-public-key=~/.ssh/thnks_tk.pub

kops update cluster ${NAME} --yes
