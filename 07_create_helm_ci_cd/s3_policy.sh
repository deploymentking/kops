#!/usr/bin/env bash

S3_BUCKET=thnks-tk-helm

aws_switch io.thinkstack.admin

aws s3api put-bucket-policy --bucket ${S3_BUCKET} --policy file://./s3_policy.json