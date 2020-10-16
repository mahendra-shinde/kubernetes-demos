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
    ```