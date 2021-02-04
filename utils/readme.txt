kubectl -n cluster-utils exec -ti dnsutils-m0 -- nslookup kubernetes.default
kubectl -n cluster-utils exec --stdin --tty dnsutils-m1 -- /bin/sh
