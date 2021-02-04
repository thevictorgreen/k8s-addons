#!/bin/env bash
rm -rf $HOME/.kube/cache  
rm -rf $HOME/.kube/config  
rm -rf $HOME/.kube/http-cache
scp root@k8smaster000.management.skyfall.io:/etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
