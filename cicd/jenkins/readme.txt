1:  Create namespace
    kubectl apply -f namespace.yaml

2:  Create rbac
    kubectl -n jenkins apply -f rbac.yaml

3:  Create PVCs
    kubectl -n jenkins apply -f pvc.yaml

4:  Create service
    kubectl -n jenkins apply -f service.yaml

5:  Create Deployment
    kubectl -n jenkins apply -f deployment.yaml

6:  Create SSH Keys for Jenkins User
    kubectl -n jenkins exec --stdin --tty jenkins-55f77fc8fd-9sjbz -- /bin/sh
    ssh-keygen -t rsa
    touch config
    echo "StrictHostKeyChecking no" > config

7:  Copy public and private keys into this directory

8:  Create secrets
    ./make_secrets.sh

9:  Grab initial username and password from Jenkins
    kubectl -n jenkins logs -f jenkins-pod

10: Login to Jenkins Service

11: Add cname record to aws lb internal and external 






