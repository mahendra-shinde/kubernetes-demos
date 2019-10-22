1. Get the credentials for AKS cluster

    $ az aks get-credetials -n {CLUSTER-NAME} -g {RESOURCE-GROUP}
    ## Install kubectl 
    $ az aks install-cli

2.  Verify the connectivity to cluster

    $ kubectl cluster-info

3.  Create a namespace for your deployments

    $ kubectl create namespace {yourname} 
    $ kubectl get namespaces

4.  Run a sample nginx 

    $ kubectl run app1 --image=nginx:1.7.9 --namespace=mahendra --replicas=3  

5.  List all artefacts deployed in namespace `mahendra`

    $ kubectl get all -n mahendra

6.  List only PODS

    $ kubectl get pods -n mahendra

7.  Delete the first pod and verify the new one
    
    $ kubectl delete pod {POD_NAME} -n mahendra
    $ kubectl get pods -n mahendra

8.  Scale Up/Down
    $ kubectl scale deploy app1 --replicas=5 -n mahendra 
    $ kubectl get rs -n mahendra
    $ kubectl scale deploy app1 --replicas=2 -n mahendra 
    $ kubectl get rs -n mahendra

9.  Exposing Deployment using Service

    $ kubectl expose deployment app1 --port=80 --type=LoadBalancer -n mahendra
    $ kubectl get ep -n mahendra
    $ kubectl get svc -n mahendra