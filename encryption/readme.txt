[kubeapiserver flags]
- --experimental-encryption-provider-config=/etc/kubernetes/encryption/encryption.conf

[Volume]
- hostPath:
      path: /etc/kubernetes/encryption
      type: DirectoryOrCreate
    name: cluster-encryption-policy

[VolumeMounts]
- mountPath: /etc/kubernetes/encryption
      name: cluster-encryption-policy
      readOnly: true
