## Basic Volume demo

The basic volume (part of pod deployment) is destroyed along with POD.

1.  Create a new POD template using following code:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
    name: volume-pod1
    labels:
        name: volume-pod1
    spec:
    volumes:
        - name: vol1

    containers:
    - name: myapp
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

2.  Save the file using name `pod-volume1.yaml` and deploy using `kubectl`

    ```bash
    $ kubectl apply -f pod-volume1.yaml
    $ kubectl get po volume-pod1
    ```

3.  Execute `bash` on running pod (Enter inside pod container to verify volume)

    ```bash
    $ kubectl exec -it volume-pod1 bash
    $ cd /data
    $ echo "Testing the filesystem" > file1
    $ exit
    ```

4.  Try deleting and re-creating the pod and then test the `/data` directory to check if volume was deleted along with pod.

    ```bash
    $ kubectl delete -f volume-pod1.yaml
    # wait for 1 minutes and then
    $ kubectl apply -f volume-pod1.yaml
    # Execute bash on container 
    $ kubectl exec -it volume-pod1 bash
    $ cd /data
    # Try display content of file1
    $ cat file1
    # EXPECTED: File not found error
    # Now quit the bash and delete pod
    $ exit
    $ kubectl delete -f volume-pod1.yaml
    ```