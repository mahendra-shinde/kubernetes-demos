# Setting-up private registry (Azure Container Registry) credentials

1. Create a new ACR using portal or following Azure CLI

    ```bash
    $ az group create -n aks-group1 -l southeastasia
    $ az acr create -n maxunlimited -g aks-group1 --sku basic
    ```

2. Get the credentials for your ACR using Azure CLI.

    ```bash
    $ az acr update -n maxunlimited --admin-enabled true
    $ az acr credential show -n maxunlimited -g aks-group1
    ```

3. The above command should produce all the credentials for registry. you need following details for registry-credentials (please replace values given below with your credentials):

    ```yaml
    username: maxunlimited
    server-url: maxunlimited.azurecr.io
    password: <copy from step#2>
    ```

    ```
    $ kubectl create secret docker-registry acrsecret --docker-server=maxunlimited.azurecr.io --docker-username=maxunlimited --docker-password=vT6LCl2xfDB=w8i4ADRRpSYL+49Mnx4F
    ```

4.  Deploy the application

    ```
    $ kubectl apply -f private-image-pod.yaml
    $ kubectl describe deploy app123
    ```
