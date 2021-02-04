#!/bin/bash
kubectl -n jenkins create secret generic ssh-keys --from-file=id_rsa=./id_rsa --from-file=id_rsa.pub=./id_rsa.pub --from-file=config=./config
