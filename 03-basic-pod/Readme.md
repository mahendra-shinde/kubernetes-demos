## Basic Pod with TWO containers

This example uses a pod with two containers (nginx and mysql). 

1.  Create a new file basic-pod3.yaml 

    > click [here](./basic-pod3.yaml) for the complete file.

2.  Now, use `kubectl` to deploy this manifest on cluster.

    ```bash
    $ kubectl apply -f basic-pod3.yaml
    # verify the pod status (using pod name)
    $ kubectl get pods pod3
    ```

3.  Get description of deployed pod (to know containers)

    ```bash
    $ kubectl describe pods pod3
    ```

4.  Get inside `test` containers (using kubectl) to validate access to both web (80) and mysql (3306)
    
    ```bash
    $ kubectl exec pod3 -c test -it sh
    # Once inside the container test myweb running on 80
    $ wget --spider http://pod3:80
    # Now, lets test if MySQL is listening on port 3306
    $ telnet pod3 3306
    # Dont bother entering password, press ENTER to quit
    $ exit
    ```

3.  Clean-up, delete the recently created pod

    ```bash
    $ kubectl delete -f basic-pod3.yaml
    # verify pod deletion
    $ kubectl get pods
    ```
