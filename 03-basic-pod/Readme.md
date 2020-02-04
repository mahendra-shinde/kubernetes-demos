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
        image: mahendrshinde/myweb:latest  # container image 
        # Optional resource contraints
        resources:
          limits:
            memory: "64Mi"
            cpu: "100m"
        # application port (nginx uses 80)
        ports:
          - containerPort: 80
    # start of second container
      - name: db1
        image: mysql:5.7 
        env:
        # Every variable need "name" and "value"
        - name: MYSQL_USER
            value: mahendra
        - name: MYSQL_PASSWORD
            value: pass@1234
        - name: MYSQL_ROOT_PASSWORD
            value: Pass123456
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
          - containerPort: 3306
    ```

    > click [here](./basic-pod3.yaml) for the complete file.

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

4.  Get inside `test` containers (using kubectl) to validate access to both web (80) and mysql (3306)
    
    ```bash
    $ kubectl exec pod3 -c test -it sh
    # Once inside the container test myweb running on 80
    $ wget --spider http://pod3:80
    # Now, lets test if MySQL is listening on port 3306
    $ telnet pod3 3306
    # Dont bother entering password, press ENTER to quit
    $ exit
    ```

3.  Clean-up, delete the recently created pod

    ```bash
    $ kubectl delete -f basic-pod3.yaml
    # verify pod deletion
    $ kubectl get pods
    ```