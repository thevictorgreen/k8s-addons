#!/bin/env bash

# get namespace data
kubectl get ns --output json > namespaces.json
ns_count=$(cat namespaces.json |jq -r '.items | length')
ns_count=$((ns_count-1))


# Iterate through all namespaces
for ns_index in $(seq 0 $ns_count);
do
  # Get current namespace
  namespace=$(cat namespaces.json |jq -r --arg jq_variable "$ns_index" '.items | .[$jq_variable|tonumber] | .metadata.name')

  # get pvc data for this namespace
  kubectl -n $namespace get pvc --output json > pvcs.json

  # get number of pvcs for this namespace
  pvc_count=$(cat pvcs.json |jq -r '.items | length')
  pvc_count=$((pvc_count-1))

  # Only execute if namespace has at least 1 pvc
  if [[ $pvc_count -ge 0 ]]
  then

    for pvc_index in $(seq 0 $pvc_count);
    do

      t1=$( date |cut -d' ' -f1)
      t2=$( date |cut -d' ' -f2)
      t4=$( date |cut -d' ' -f4)
      t5=$( date |cut -d' ' -f5)
      t6=$( date |cut -d' ' -f6)
      t7=$( date |cut -d' ' -f7)
      ts=${t1}-${t2}-${t4}-${t5}-${t6}-${t7}
      ts=$( echo $ts | sed 's/:/-/g' )
      pvc_name=$(cat pvcs.json |jq -r --arg jq_variable "$pvc_index" '.items | .[$jq_variable|tonumber] | .metadata.name')
      echo "$pvc_name: $ts"

cat <<EOF > ${pvc_name}-backup.yaml
apiVersion: snapshot.storage.k8s.io/v1alpha1
kind: VolumeSnapshot
metadata:
  name: $( echo ${pvc_name}-snapshot-${ts} | tr '[:upper:]' '[:lower:]' )
  namespace: $namespace
spec:
  snapshotClassName: csi-rbdplugin-snapclass
  source:
    name: ${pvc_name}
    kind: PersistentVolumeClaim
EOF

      kubectl create -f ${pvc_name}-backup.yaml
      
    done
    
  fi

done

rm -rf *.json 
rm -rf *.yaml
