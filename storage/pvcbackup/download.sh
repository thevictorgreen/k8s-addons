#!/bin/bash

DOWNLOAD_URL=$(curl -s https://api.github.com/repos/aquasecurity/kube-bench/releases/latest \
        | grep browser_download_url \
        | grep kube-bench_0.4.0_linux_amd64.rpm \
        | cut -d '"' -f 4)
curl -s -L --create-dirs -o ~/downloadDir "$DOWNLOAD_URL"
