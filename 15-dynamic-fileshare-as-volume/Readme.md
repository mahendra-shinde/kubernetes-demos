## Persistant Volume claim with Azure FileShare

> Use this demo on AKS Cluster

> You need either existing AKS cluster or create new one with *Azure Credentials*

Command to create new AKS cluster using Azure CLI
```bash
$ az group create -n aks-group1 -l southeastasia
$ az aks create -n myaks9090 -g aks-group1 -l southeastasia --node-count=2  --generate-ssh-keys
```

Command to get the credentials
```bash
$ az aks get-credentials -n myaks9090 -g aks-group1
```

Create a new [persisted volume claim](./az-file-pvc.yml)
```
$ kubectl apply -f az-file-pvc.yml
$ kubectl get pvc
$ kubectl describe -f az-file-pvc.yml
```

Create a [deployment](./pvc-app.yml)
```
$ kubectl apply -f pvc-app.yml
$ kubectl describe -f pvc-app.yml
``` 

Test application from local browser
```
$ kubectl get svc az-app-svc
## Use the external-ip as website address!
```