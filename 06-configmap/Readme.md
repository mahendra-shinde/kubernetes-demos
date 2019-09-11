## Config Map Demo

1. Create a configmap from file [myconfig](./myconfig.yaml)

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
    name: myconfig
    data:
    MYSQL_ROOT_PASSWORD: Password@123
    MYSQL_USER: mahendra
    MYSQL_PASSWORD: Password@1234
    MYSQL_DATABASE: data1
    MYSQL_ROOT_HOST: 127.0.0.1
    ```

    Now, run following commands:

    ```shell
    $ kubectl apply -f ./myconfig.yml
    $ kubectl describe -f ./myconfig.yml
    ```

2.  Create a pod that uses ConfigMap [pod](./pod-3.yaml)

    ```yaml
    apiVersion: v1  
    kind: Pod       
    metadata:
    name: pod3    
    labels:       
        name: web3
    
    spec:
    containers:
    - name: db1
        image: mysql:5.7 
        envFrom:
        - configMapRef:
            name: myconfig
        resources:
        limits:
            memory: "512Mi"
            cpu: "500m"
        ports:
        - containerPort: 3306
    - name: test
        image: mahendrshinde/mysql-client:latest
        imagePullPolicy: IfNotPresent
        command: ['sh','-c','echo Hello World && sleep 3600']
        resources:
        limits:
            memory: "64Mi"
            cpu: "100m"
    ```
    Now, run following commands:

    ```shell
    $ kubectl apply -f ./pod-3.yaml
    $ kubectl get pods
    ```

3.  Once, pod status for "pod3" chages to RUNNING,
    try entering inside the pod.

    ```shell
    $ kubectl exec pod3 -c test -it sh  
    # try connecting mysql server (Use loopback ip or pod name)
    $ mysql -umahendra -pPassword@1234 -h pod3
    $ exit
    $ exit
    ```

4.  Delete the resources

    ```shell
    $ kubectl delete -f pod-3.yaml
    $ kubectl delete -f myconfig.yml
    ```