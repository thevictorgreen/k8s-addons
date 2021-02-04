#!/bin/env bash
for node in {etcd0,etcd1,k8s0,k8s1,k8s2,k8s3};do ssh root@${node}.vdigi.local;done
