## Basic Pod with Single container

This example uses a pod with single container (nginx). 

1.  Create a new file basic-pod1.yaml with following code:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
    name: pod1
    labels:
        name: web1
    spec:
        containers:
        - name: web1
          image: mahendrshinde/myweb:latest
          resources:
            limits:
                memory: "64Mi"
                cpu: "100m"
          ports:
          - containerPort: 80
    ```
    > click [here](./basic-pod1.yaml) for the complete file and comments.

2.  Now, use `kubectl` to deploy this manifest on cluster.

    ```bash
    $ kubectl apply -f basic-pod1.yaml
    # verify the pod status (using label filter)
    $ kubectl get pods -l name=web1
    ```
3.  Clean-up, delete the recently created pod

    ```bash
    $ kubectl delete -f basic-pod1.yaml
    # verify pod deletion
    $ kubectl get pod
    ```
