## Exposing a deployment through service

1.  Use the following sample deployment:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: app1
    spec:
        replicas: 3
        selector:
            matchLabels:
                app: app1
        template:
            metadata:
                labels:
                    app: app1
            spec:
                containers:
                -   name: app1
                    image: mahendrshinde/myweb:latest
                    ports:
                    - containerPort: 80
    ```
2.  Deploy and verify the deployment.

    ```shell
    $ kubectl apply -f deploy-app.yaml
    $ kubectl get deploy
    $ kubectl get rs -l app=app1
    ```
  
3.  Create a service definition for above deployment.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
        name: app1-svc
    spec:
    # On docker desktop load-balancer type would map service to 'localhost'
        type: LoadBalancer
        selector:
            app: app1
        ports:
        - port: 8080
            targetPort: 80
    ```

4.  Deploy the service

    ```shell
    $ kubectl apply -f service-1.yaml
    # view the service
    $ kubectl get svc app1-svc
    # view the endpoints
    $ kubectl get ep app1-svc 
    ```

5.  try opening web browser and visiting url `http://localhost:8080`. If you open two diffrent browsers, you should get different hostname (pod name) as an output.

## Testing the NodePort type service

1.  Delete the Service object

    ```
    $ kubectl delete svc app1-svc
    ```

2.  Open `service-1.yaml` and Change the Service Type at line#7 to NodePort

3.  Deploy the service once again and verify the nodePort value

    ```
    $ kubectl apply -f service-1.yml
    $ kubectl get svc
    ```

4.  Get the HostName for Node

    ```
    $ kubectl cluster-info
    ```

5.  Look at Kubernetes Master URL should be https://kubernetes.docker.internal:6443 (docker-desktop)

6.  Now, Use web-browser to access node-port service with URL like this one:

    http://kubernetes.docker.internal:30678

    > Please replace kubernetes.docker.internal with your Hostname

    > Please replace 30678 with your node-port (refer Step#4)

## Test ClusterIp service

1.  Create a new TEST-POD using [test-pod.yml](./test-pod.yml) file (Copy the text)

2.  Deploy the TESTPOD and Delete the OLD service

    ```
    $ kubectl delete svc app1-svc
    $ kubectl apply -f test-pod.yml
    ```

3.  Modify the `service-1.yaml` file and set service type at line#7 to `ClusterIP`, deploy the service.

    ```
    $ kubectl apply -f service-1.yaml
    ```

4.  Use newly deployed test-pod to test access to service-1

    ```
    $ kubectl exec -it testpod bash
    $ curl http://aap1-svc:8080
    $ curl http://app1-svc:8080
    $ exit
    ```

## Clean Up

```
$ kubectl delete -f . 
```