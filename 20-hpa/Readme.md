## Horizontal Pod Autoscaler demo

1.  Use the [this](./deploy-app.yaml) for application deployment.

2.  Deploy and verify the deployment.

    ```shell
    $ kubectl apply -f deploy-app.yaml
    $ kubectl get deploy
    $ kubectl get rs -l app=app1
    ```
  
3.  Create a service definition for above deployment. use [this](./service-1.yaml) file.


4.  Deploy the service

    ```shell
    $ kubectl apply -f service-1.yaml
    # view the service
    $ kubectl get svc app1-svc
    # view the endpoints
    $ kubectl get ep app1-svc 
    ```

5.  try opening web browser and visiting url `http://localhost:8080`. If you open two diffrent browsers, you should get different hostname (pod name) as an output.

## Deploy Metrics API server

1.  Deploy [this](./metric-server.yaml) metrics server deployment file.

    ```shell
    $ kubectl apply -f metric-server.yaml
    $ kubectl describe -f metric-server.yaml
    ```

## Deploying the HPA

1.  Create a HPA file like [this](./hpa1.yaml).

2.  Deploy the HPA

    ```shell
    $ kubectl apply -f hpa1.yaml
    # Wait for 10 seconds
    $ kubectl get hpa
    # Wait 1 minutes
    $ kubectl get po
    $ kubectl get hpa
    ```

## Clean Up

1.  Delete all the resources

    ```
    $ kubectl delete -f .
    ```

> Please try using 'hpa-2.yaml' for newer v2 version of HPA (Works on Kubernetes v1.20+)