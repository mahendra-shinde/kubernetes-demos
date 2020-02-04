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
                - containerPort: 3000
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