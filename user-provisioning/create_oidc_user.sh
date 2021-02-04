#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 user"
    exit 1
fi

USER=$1
CLUSTERENDPOINT=https://192.168.33.9:6443
CLUSTERNAME=vdigitalgroup
CACERT=/etc/kubernetes/pki/ca.crt

mkdir -p clients/$USER

cat <<-EOF > clients/$USER/kubeconfig
apiVersion: v1
kind: Config
preferences:
  colors: true
current-context: $CLUSTERNAME
clusters:
- name: $CLUSTERNAME
  cluster:
    server: $CLUSTERENDPOINT
    certificate-authority-data: $(cat $CACERT | base64 --wrap=0)
contexts:
- context:
    cluster: $CLUSTERNAME
    user: $USER
  name: $CLUSTERNAME
EOF
