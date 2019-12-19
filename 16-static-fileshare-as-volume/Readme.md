## Using Static File share

1.  Create a new azure resource group and storage account 
    ```bash
    $ az group create --name mygroup --location southeastasia
    $ az storage account create -n maxunlimited -g mygroup -l southeastasia --sku Standard_LRS
    $ az storage share create -n share1  --account-name maxunlimited --account-key enroR84onGRQlnJWQX+qxu2RStLEMFzgoGG2rURo2Q5MNvjZQf8GKhwRAttNR4JYd56gRwSqwQvjiCYRkqNqQw== --quota 5

    
    ```
    > Replace following parameters with your choices:
        ```yaml
        mygroup: group name of your choice
        southeastasia: location of your choice
        maxunlimited: unique name for your storage account

        ```

2.  Create a new file share and create secret in kubernetes cluster.

    ```bash
    kubectl create secret generic  azure-secret --from-literal=azurestorageaccountname=maxunlimited --from-literal=azurestorageaccountkey=enroR84onGRQlnJWQX+qxu2RStLEMFzgoGG2rURo2Q5MNvjZQf8GKhwRAttNR4JYd56gRwSqwQvjiCYRkqNqQw==
    ```
