## StatefulSet

- Identity Preserved, you delete pod named 'web-1' another pod would be created with same name!
- PersistedVolumeClaims are also assigned to NEW pod from OLD pod.
- Pods are CREATE and DESTROYED in ORDER
    Last pods are FIRST tobe REMOVED

### Benefits
 - Stable, unique network identities for pods
 - Stable, persistent storage (using PVC)
 - Ordered and graceful scaling

### Limitations:
 - Every sts needs Persistent Volume
 - Deleting STS will not delete volume
 - Volumes need manual deletion
 - Need a Headless service (Service without ClusterIP)
 - Does not guarantees Pod termination when STS is deleting
   1. kubectl scale sts web --replicas=0
   2. kubectl delete sts web


1. Delete all old deployments and pods
    
    ```
    $ kubectl delete deploy --all
    $ kubectl delete pod --all
    ```

2.  Deploy the [StatefulSet](./deploy.yaml)

    ```
    $ kubectl apply -f deploy.yaml
    $ kubectl get sts
    $ kubectl get po
    $ kubectl get svc
    ```

3.  Try deleting the pods and scaling Statefulset

    ```
    $ kubectl scale sts web --replicas=5
    $ kubectl get po -w
    # CTRL+C to stop
    $ kubectl delete po web-1
    ```

4.  Clean up

    ```
    $ kubectl scale sts web --replicas=0
    $ kubectl delete -f deploy.yaml
    $ kubectl delete pvc --all
    ```