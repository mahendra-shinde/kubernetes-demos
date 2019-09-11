## Building Replica Sets

1.  Create a new YAML document `replica1.yaml` for 10 replicas of nginx container. 
    
    ```yaml
    apiVersion: apps/v1
    kind: ReplicaSet
    metadata:
    name: myapp
    spec:
    replicas: 10
    selector:
    ## Identify which PODS should be part of this Set
        matchLabels:
        name: myapp
    template: # Begining of POD Template
        metadata:
        ## define name of POD (Must MATCH with Line# 10 )
        name: myapp
        labels:
            name: myapp
        spec:
        containers:
            - image: nginx:1.7.9
            name: web
            ports:
                - containerPort: 80
    ```

2.  Now, use following commands to deploy the replica set on cluster.

    ```bash
    $ kubectl apply -f replica1.yaml
    # list all pods from current replica-set, should return 10 pods
    $ kubectl get pods -l name=myapp
    # Scaling from command-line (Imperative )
    $  kubectl scale --replicas=3 -f .\replica1.yaml  
    # list all pods from current replica-set, should return 3 running pods
    # Other pods might be in terminating stage.
    $ kubectl get pods -l name=myapp
    ```

3.  Test the declarative option for scaling, open `replica1.yaml` and change line# 11 to `replicas: 5` from original `replicas: 10`
    Now, run following command to apply and verify scaling operation.

    ```bash
    $ kubectl apply -f replica1.yaml
    # list all pods from current replica-set, should return 5 pods
    $ kubectl get rs
    $ kubectl get pods -l name=myapp
    ```

4.  Clean-up : delete the replica set.

    ```bash
    $ kubectl delete -f replica1.yaml
    # Check if pods are destroyed!
    $ kubectl get pods -l name=myapp
    ```

