#!/bin/bash

set -e
#kubectl create namespace auth
kubectl -n auth create secret generic auth.vdigi.local.tls --from-file=../ssl/cert.crt --from-file=../ssl/cert.key --from-file=../ssl/rootCA.crt
kubectl -n auth create secret generic oidc-client --from-literal=client-id=example-app --from-literal=client-secret=ZXhhbXBsZS1hcHAtc2VjcmV0 --from-literal=redirect-uri=https://oidc-client:32001/callback --from-literal=issuer-uri=https://oidc-provider:32000/dex --from-literal=tls-cert=/etc/ssl/cert.crt --from-literal=tls-key=/etc/ssl/cert.key --from-literal=listen-address=https://0.0.0.0:32001 --from-literal=issuer-root-ca=/etc/ssl/rootCA.crt
