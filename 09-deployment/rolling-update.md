## Managing Deployment, Scaling and Rolling updates

1.  Create a deployment [deploy-1.yaml](./deploy-1.yaml) with following contents:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: deploy1
    spec:
        replicas: 3
        revisionHistoryLimit: 10
        strategy:
            rollingUpdate:
            maxSurge: 1
            maxUnavailable: 1
        minReadySeconds: 3
        selector:
            matchLabels:
                app: web1
        template:
            metadata:
                labels:
                    app: web1
            spec:
                containers:
                -   name: web
                    image: nginx:1.7.9
                    ports:
                -   containerPort: 80
    ```

2.  Now, run following commands to deploy.

    ```bash
    # Deploy
    $ kubectl apply -f deploy-1.yaml
    # Verify the deployment
    $ kubectl get deploy deploy1
    $ kubectl get rs -l app=web1
    $ kubectl get pods -l app=web1
    ```

3.  Try scaling deployment through command line

    ```bash
    $ kubectl scale deploy deploy1 --replicas=5  
    $ kubectl get deploy
    $ kubectl get rs -l app=web1
    ```

4.  Now, lets try rolling update. Try changing yaml file and update image version from 1.7.9 to 1.11.0 using CLI.

    ```bash
    # Update container image for 'web' container for deployment 'deploy1'
    $ kubectl set  image deploy/deploy1 web=nginx:1.11.0
    # View the rollout status, pod status and replica-sets
    $ kubectl rollout  status deploy/deploy1  
    $ kubectl get pods -l app=web1
    $ kubectl get rs -l app=web1
    ```

5.  Undo the last change (revert to last version) using following command:

    ```bash
    $ kubectl rollout undo deploy/deploy1    
    $ kubectl rollout status deploy/deploy1
    # View all replica sets along with image tags
    $ kubectl get rs -l app=web1 -o wide
    ```

6.  View the rollout history

    ```bash
    $ kubectl rollout history -f deploy-1.yaml
    ```

7.  Performing rolling update using declarative option (editing deploy-1.yaml)
    Open `deploy-1.yaml` and replace `nginx:1.7.9` to `nginx:1.13`
    Use following command to apply changes and view rollout history.

    ```bash
    $ kubectl apply -f deploy-1.yaml --record
    $ kubectl rollout history -f deploy-1.yaml
    $ kubectl get rs -o wide -l app=web1
    ```
    
> the extra option `--record` records the current command and use it as `change-cause` for rollout history.
