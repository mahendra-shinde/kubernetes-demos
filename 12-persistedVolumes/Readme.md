## Persistant Volume claim

> Use this demo on AKS Cluster

> For `docker-desktop` use [this](./Readme-hostpath.md) readme.

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

Create the new Storage class [managed-disk](./managed-disk.yml)
```bash
$ kubectl apply -f managed-disk.yml 
$ kubectl get sc
```

Create a new [persistent volume claim](./managed-disk-claim.yml) 
```bash
$ kubectl apply -f managed-disk-claim.yml
$ kubectl get pvc
$ kubectl get pv
```

Create a [POD](./pv-pod.yml) to test PVC 
```bash
$ kubectl apply -f pv-pod.yml
$ kubectl describe -f pv-pod.yml
```
