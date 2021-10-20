## Managing Deployment, Scaling and Rolling updates

1.  Download the  deployment [deploy-1.yaml](./deploy-1.yaml) file using following command:

    > On Windows Powershell '-Outfile' is used for target filename, please replace it with '-o' on Mac or Linux Bash

    ```
    $ wget -outfile deploy-1.yaml https://raw.githubusercontent.com/mahendra-shinde/kubernetes-demos/master/09-deployment/deploy-1.yaml

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

4.  Now, lets try rolling update. Try changing yaml file and update image version from 1 to 2 using CLI.

    ```bash
    # Update container image for 'web' container for deployment 'deploy1'
    $ kubectl set  image deploy/deploy1 web=mahendrshinde/myweb:2
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
    Open `deploy-1.yaml` and replace `mahendrshinde/myweb:1` to `mahendrshinde/myweb:3`
    Use following command to apply changes and view rollout history.

    ```bash
    $ kubectl apply -f deploy-1.yaml --record
    $ kubectl rollout history -f deploy-1.yaml
    $ kubectl get rs -o wide -l app=web1
    ```
    
> the extra option `--record` records the current command and use it as `change-cause` for rollout history.
