#!/usr/bin/env bash


# SET PARAMS
HOSTKEY=keypairs/tls.key
HOSTCRT=keypairs/tls.crt
FILENAME=traefik-default-server-secret.yaml
SECRNAME=traefik-default-server-secret

# CREATE KEYPAIRS
openssl req -newkey rsa:2048 -nodes -keyout keypairs/tls.key -x509 -days 365 -out keypairs/tls.crt -subj '/CN=*.vdigi.local'

# CREATE TLS SECRET
cat <<-EOF > ../common/$FILENAME
apiVersion: v1
kind: Secret
metadata:
  name: $SECRNAME
  namespace: traefik-ingress
type: kubernetes.io/tls
data:
  tls.crt: $(cat $HOSTCRT | base64 --wrap=0)
  tls.key: $(cat $HOSTKEY | base64 --wrap=0)
EOF
