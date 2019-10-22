## End to End Application deployment on AKS (Kubernetes Service) using ACR (Container registry)

1. Create a new ACR account using cloud shell (Available from azure portal)

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
    $ az acr import -n $ACRNAME --source mahendrshinde/hostname:node
    ```

3.  