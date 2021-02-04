[Rook Ceph Setup]

Edit cluster.yaml
verify the useAllNodes: false 
is desired and update the nodes section
with the worker node name and raw unformatted block
device to use for the osd device 

Cluster Setup
kubectl create -f common.yaml
kubectl create -f operator.yaml
kubectl create -f cluster.yaml

Verify all OSDs are online
watch kubectl -n rook-ceph get pods

StorageClass, Snapshot Class, Toolbox setup
kubectl create -f storageclass.yaml
kubectl create -f snapshotclass.yaml
kubectl create -f toolbox.yaml
kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

[PVC Smoke Test]



[PVC Snapshot Smoke Test]



[PVC Restore Snapshot Smoke Test]
