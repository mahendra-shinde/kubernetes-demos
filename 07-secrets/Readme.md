## Secret Demo
1. Create a secret from file [mysecret](./mysecret.yaml)

    ```yaml
    apiVersion: v1
    kind: Secret
    type: Opaque
    metadata:
        name: mysecret
    data:
        # Using root password: Password123
        MYSQL_ROOT_PASSWORD: UGFzc3dvcmQxMjM=
        # Using user password: Password1234
        MYSQL_PASSWORD: UGFzc3dvcmQxMjM0 
        MYSQL_DATABASE: ZGF0YTE= 
        MYSQL_USER: bWFoZW5kcmE=     
    ```

    Now, run following commands:

    ```bash
    $ kubectl apply -f ./mysecret.yml
    $ kubectl describe -f ./mysecret.yml
    ```

2.  Create a pod that uses ConfigMap [pod](./pod-4.yaml)

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
    name: pod4
    labels:
        name: web4

    spec:
    containers:
    -   name: db1
        image: mysql:5.7
        envFrom:
            - secretRef:
                name: mysecret
        resources:
            limits:
            memory: "1Gi"
            cpu: "500m"
        ports:
            - containerPort: 3306
    -   name: test
        image: mahendrshinde/mysql-client:latest
        imagePullPolicy: IfNotPresent
        command: ["sh", "-c", "echo Hello World && sleep 3600"]
        resources:
            limits:
            memory: "64Mi"
            cpu: "100m"
    ```
    Now, run following commands:

    ```bash
    $ kubectl apply -f ./pod-4.yaml
    $ kubectl get pods
    ```

3.  Once, pod status for "pod4" chages to RUNNING,
    try entering inside the pod.

    ```bash
    $ kubectl exec pod4 -c test -it sh  
    # try connecting mysql server (Use loopback ip or pod name)
    $ mysql -umahendra -pPassword@1234 -h pod3
    $ exit
    $ exit
    ```

4.  Delete the resources

    ```bash
    $ kubectl delete -f pod-4.yaml
    $ kubectl delete -f mysecret.yml
    ```