#!/bin/bash

set -e
#kubectl create namespace auth
kubectl -n auth create secret tls k8s0.vdigi.local.tls --cert=../ssl/cert.crt --key=../ssl/cert.key
kubectl -n auth create secret generic github-client --from-literal=client-id=50b5c4b39d8a6732d67d --from-literal=client-secret=c9868db0975d2d50c8bb0e8f3a44e9e55e817d75
