## Volume demo

The  Volume which would NOT be destroyed along with POD. After re-creating pod, same volume would be re-used (if deployed on same node).

1.  Create a new POD template using following code:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
    name: volume-pod2
    labels:
        name: volume-pod2
    spec:
      volumes:
        - name: vol1
        ## Directory on Node's Filesystem
        ## Deleting POD does not affect this directory
        ## Allows Sharing Volume between PODS in same NODE!
          hostPath:
            path: /var/myvol
            
    containers:
      - name: myapp2
        image: nginx:1.7.9
        volumeMounts:
        - name: vol1
          mountPath: "/data"
          readOnly: false
        resources:
        limits:
            memory: "64Mi"
            cpu: "100m"
        ports:
        - containerPort: 80
    ```
    Click [here](./pod-volume2.yaml) for complete YAML file.
    
2.  Save the file using name `pod-volume2.yaml` and deploy using `kubectl`

    ```bash
    $ kubectl apply -f pod-volume2.yaml
    $ kubectl get po volume-pod2
    ```

3.  Execute `bash` on running pod (Enter inside pod container to verify volume)

    ```bash
    $ kubectl exec -it volume-pod2 bash
    $ cd /data
    $ echo "Testing the filesystem" > file1
    $ exit
    ```
4.  Try deleting and re-creating the pod and then test the `/data` directory to check if volume was deleted along with pod.

    ```bash
    $ kubectl delete -f volume-pod2.yaml
    # wait for 1 minutes and then
    $ kubectl apply -f volume-pod2.yaml
    # Execute bash on container 
    $ kubectl exec -it volume-pod2 bash
    $ cd /data
    # Try display content of file1
    $ cat file1
    # EXPECTED: File should display `Testing the filesystem`
    # Now quit the bash and delete pod
    $ exit
    $ kubectl delete -f volume-pod2.yaml
    ```
