Kubernetes dashboard should be deployed immediately after bootstraping 1st master node.

Can be accessed here:
 kubectl proxy
 http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default

To Grant full admin privileges to Dashboard's Service Account. WARNING-SECURITY-RISK!!!
 kubectl create -f dashboard-admin.yaml
