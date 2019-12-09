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
                image: mahendrshinde/hostname:node
                resources:
                    limits:
                        memory: "128Mi"
                        cpu: "500m"
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
        type: ClusterIP
        selector:
            app: app1
        ports:
        -   port: 8080
            targetPort: "3000"
    ```

4.  Deploy the service

    ```shell
    $ kubectl apply -f service-1.yaml
    # view the service
    $ kubectl get svc app1-svc
    # view the endpoints
    $ kubectl get ep app1-svc 
    ```

5.  Create the ingress controller (basic version as service)

    ```yaml
    kind: Service
    apiVersion: v1
    metadata:
        name: ingress-nginx
        namespace: ingress-nginx
    labels:
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/part-of: ingress-nginx
    spec:
        externalTrafficPolicy: Local
        type: LoadBalancer
        selector:
            app.kubernetes.io/name: ingress-nginx
            app.kubernetes.io/part-of: ingress-nginx
        ports:
        - name: http
          port: 80
          targetPort: http
        - name: https
          port: 443
          targetPort: https
    ```

6. 
