## Basic Pod with TWO containers

This example uses a pod with two containers (nginx and mysql). 

1.  Create a new file basic-pod1.yaml with following code:

    ```yaml
    # following three lines provide META-DATA for current object
    apiVersion: v1  # k8s API version
    kind: Pod       # Type pf OBJECT this file manages/deploys
    metadata:
      name: pod2    # Unique name for this object
      labels:       # Optional labels (User defined key/value pairs)
        name: web1
    # The actual object (POD) definition 
    spec:
      containers:   # list of containers 
      # start of first container
      - name: web1  # name for container
        image: nginx:1.7.9  # container image 
        # Optional resource contraints
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        # application port (nginx uses 80)
        ports:
          - containerPort: 80
      # start of second container
      - name: test
        image: busybox
        command: ['sh','-c','echo Hello World && sleep 3600']
        resources:
          limits:
            memory: "64Mi"
            cpu: "100m"
    ```

    > click [here](./basic-pod2.yaml) for the complete file.

2.  Now, use `kubectl` to deploy this manifest on cluster.

    ```bash
    $ kubectl apply -f basic-pod2.yaml
    # verify the pod status (using pod name)
    $ kubectl get pods pod2
    ```

3.  Get description of deployed pod (to know containers)

    ```bash
    $ kubectl describe pods pod2
    ```

4.  Get inside `test` containers (using kubectl)
    
    ```bash
    $ kubectl exec pod2 -c test -it sh
    # Test the url http://pod2 
    $ wget --spider http://pod2
    $ exit
    ```
    The above command should display message `remote file exists` Which proves nginx working fine.

3.  Clean-up, delete the recently created pod

    ```bash
    $ kubectl delete -f basic-pod2.yaml
    # verify pod deletion
    $ kubectl get pods
    ```