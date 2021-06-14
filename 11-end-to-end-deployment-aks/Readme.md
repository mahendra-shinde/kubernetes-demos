## End to End Application deployment on AKS (Kubernetes Service) using ACR (Container registry)

> All the commands/scripts are RUN on Azure Cloud Shell (Bash) enviornment

1. Create a new ACR account using **cloud shell** (Available from azure portal)

    > Please set values for all Environment variables

        $ACRNAME= unique name for acr 
        $GROUPNAME= azure resource group (must exists) 

        eg:
        $ACRNAME=myacr0123
        $GROUPNAME=mygroup1

    ```bash
    $ az acr create -n $ACRNAME -g $GROUPNAME --sku Basic --admin-enabled
    ```
    
2.  Import (pull) my sample application image from docker hub. 

    ```bash
    $ az acr import -n myacr0123 --source docker.io/mahendrshinde/myweb:latest  -t myweb:latest
    ```

3.  Create a new AKS Cluster (Skip this step if AKS cluster exists)  

    ```bash
    ### Create a new AKS Cluster (Takes few minutes !)
    $ az aks create --resource-group $GROUPNAME --name myAKSCluster --node-count 2 --enable-addons monitoring --generate-ssh-keys
    ## Get the credentials for AKS cluster
    $ az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
    ```

4.  Test kubernetes cluster connectivity.

    ```bash
    $ kubectl cluster-info
    $ kubectl get all -n deafult
    ## perform clean-up for all existing deployments (Optional: for freeing up resources)
    $ kubectl delete deploy --all -n default
    ```

4.  First create a new kubernetes secret for your private container registry.

    ```bash
    $ PASS=$(az acr credential show -n myacr0123 -g storage-demo -o tsv --query "passwords[1].value")
    ## print password on screen (DEBUGGING)
    $ echo $PASS
    ## Prepare Login Server URL which is ACR Name with '.azurecr.io' as suffix.
    $ LOGINSERVER=$ACRNAME.azurecr.io
    ## Create a new registry secret
    $ kubectl create secret docker-registry reg1 --docker-server=$LOGINSERVER --docker-username=$ACRNAME --docker-password=$PASS 
    ```

5.  Now, use following deployment artefact "deploy-app.yaml" for creating pods using images on private registry (use command `nano deploy-app.yaml`)

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
                ### Docker registry secret mapping for current deployment
                imagePullSecrets:
                    ## NAME OF SECRET CREATED IN STEP# 4
                    - name: reg1
                containers:
                -   name: app1
                    imagePullPolicy: IfNotPresent
                    ## REPLACE WITH YOUR CONTAINER IMAGE NAME
                    image: myacr0123.azurecr.io/myweb:latest
                    ports:
                        - containerPort: 80

    ```
    In `nano` editor, press `CTRL+X` to close the editor, it would ask if you want to save changes, PRESS `Y` and then `ENTER` for accepting the file name.

6.  Now deploy using command:

    ```bash
    $ kubectl apply -f deploy-app.yaml
    $ kubectl get deploy -f deploy-app.yaml
    $ kubectl get rs -o wide
    ```

7.  Now, lets create a service using following artefact (use command `nano service1.yaml`)

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
        name: app1-svc
    spec:
        type: LoadBalancer
        selector:
            app: app1
        ports:
        - port: 80
            targetPort: 80
    ```

    In `nano` editor, press `CTRL+X` to close the editor, it would ask if you want to save changes, PRESS `Y` and then `ENTER` for accepting the file name.

8.  Deploy the service and wait for `public-ip`, once you get `public-ip` try accessing from web browser

    ```bash
    $ kubectl apply -f service1.yaml
    $ kubectl get svc app1-svc
    ```

10. Clean-Up (Using cloud-shell)

    ```bash
    ## Delete both service and deployment using files from CURRENT DIRECTORY 
    $ kubectl delete -f .
    ```