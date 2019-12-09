## Using Static File share

1.  Create a new azure resource group and storage account 
    ```bash
    $ az group create --name mygroup --location southeastasia
    $ az storage account create -n maxunlimited -g mygroupP -l southeastasia --sku Standard_LRS
    
    ```
    > Replace following parameters with your choices:
        ```yaml
        mygroup: group name of your choice
        southeastasia: location of your choice
        maxunlimited: unique name for your storage account

        ```

2.   

1.  Create a new file share and create secret in kubernetes cluster.

    ```bash
    kubectl create secret generic  azure-secret --from-literal=azurestorageaccountname=trynxdiag --from-literal=azurestorageaccountkey=E88wg/MrEQu/qRjMgl83P65gOEjriuBhuIWiZ3vJFSwIST6k1Ok5HxCZXIER2ZEAqXwLPn2tu79BaC32Fh5W0A==
    ```
