#!/usr/bin/env bash

# VERIFY ARGS
if [[ "$#" -ne 2 ]]; then
    echo "Usage: $0 hostname namespace"
    exit 1
fi

# SET PARAMS
NAMESPACE=$2
HOSTKEY=keypairs/${1}.key
HOSTCRT=keypairs/${1}.crt
FILENAME=${1}.tls.yaml
SECRNAME=${1}.tls

# CREATE KEYPAIRS
openssl req -newkey rsa:2048 -nodes -keyout keypairs/${1}.key -x509 -days 365 -out keypairs/${1}.crt

# CREATE TLS SECRET
cat <<-EOF > ../hosts/$FILENAME
apiVersion: v1
kind: Secret
metadata:
  name: $SECRNAME
  namespace: $NAMESPACE
type: kubernetes.io/tls
data:
  tls.crt: $(cat $HOSTCRT | base64 --wrap=0)
  tls.key: $(cat $HOSTKEY | base64 --wrap=0)
EOF
