## HostPath Volume on Docker Desktop

> On Docker-Desktop, we dont get the azure-disk storage-class.
  Instead, use default "hostpath" storage-class

1.  Verify the name of default storage-class

    ```
    $ kubectl get sc
    ```

2.  Expected outcome is `hostpath`

3.  Deploy the new PVC (PersistedVolume Claim) from the attached [YML file](./my-pvc.yml).

    ```
    $ kubectl apply -f my-pvc.yml
    $ kubectl get pvc
    $ kubectl get pv
    ```

4.  Deploy the [sample](./deploy.yml) "Deployment" object.

    ```
    $ kubectl apply -f deploy.yml
    $ kubectl get pods
    $ kubectl describe po [FIRSTPODNAME]
    ```

5.  Clean-Up 

    ```
    $ kubectl delete -f deploy.yml
    $ kubectl delete -f my-pvc.yml
    ```

6.  Deploy the [StateFulSet](./deploy-sts.yml).

    ```
    $ kubectl apply -f deploy-sts.yml
    $ kubectl get pod
    ## After all pods are READY
    $ kubectl get pvc
    # kubectl get pv
    ```

7.  Try entering inside first pod and create a sample file.

    ```
    $ kubectl exec -it  pvc-deploy-0 -c web sh
    $ cd /usr/share/nginx/html/
    $ echo "Hello world" > file1.txt
    $ exit
    ```

8.  Delete the POD and wait for new POD to take it's place. Then check if file still exists!

    ```
    $ kubectl delete pod pvc-deploy-0
    $ kubectl exec -it  pvc-deploy-0 -c web sh
    $ cd /usr/share/nginx/html
    $ cat file1.txt
    $ exit
    ```

9.  Clean-Up

    ```
    $ kubectl scale sts pvc-deploy --replicas=0
    $ kubectl delete -f deploy-sts.yml
    ```