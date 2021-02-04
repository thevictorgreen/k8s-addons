#!/usr/bin/env bash

# VERIFY ARGS
if [[ "$#" -ne 3 ]]; then
    echo "Usage: $0 nodename key value"
    exit 1
fi

# SET PARAMS
NODE=$1
KEY=$2
VALUE=$3

# CHECK IF NODE EXISTS
kubectl get nodes $NODE --show-labels
if [[ $? -eq 1 ]];then
   exit 1
fi

# SET LABEL ON NODE
kubectl label nodes $NODE $KEY=$VALUE

# DISPLAY LABELS
kubectl get nodes $NODE --show-labels
