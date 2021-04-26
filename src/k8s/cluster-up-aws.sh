#!/bin/bash
#

if [[ -z "$ENCRYPTION_KEY" ]]; then
    echo "Must provide ENCRYPTION_KEY in environment" 1>&2
    exit 1
fi

eksctl create cluster \
    --name complex-k8s \
    --region eu-west-1 \
    --nodegroup-name linux-nodes \
    --node-type t2.nano	\
    --nodes 2