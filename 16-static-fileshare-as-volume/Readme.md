## Using Static File share

1.  Create a new azure resource group and storage account 

    ```bash
    ### Please change below values to suite your requirements
    $ GROUPNAME=mygroup
    $ STRNAME=maxunlimited
    $ LOCATION=southeastasia

    # create a resource group
    $ az group create --name $GROUPNAME --location $LOCATION
    
    # create a new storage account
    $ az storage account create -n $STRNAME -g $GROUPNAME -l $LOCATION --sku Standard_LRS

    # get the access key for newly created account
    $ key=$(az storage account keys list -n $STRNAME -g $GROUPNAME -o json --query [0].value)

    # Create a new file share using Access key to storage account
    $ az storage share create -n share1  --account-name $STRNAME --account-key $key --quota 5    
    ```

2.  Create a new secret in kubernetes cluster.

    ```bash
    ## Using the same shell as step1, this command uses variables from step1
    $ kubectl create secret generic  azure-secret --from-literal=azurestorageaccountname=$STRNAME --from-literal=azurestorageaccountkey=$key
    ```

3.  Now, deploy [the pod](./deploy-static-volume.yaml) and test the volume.

    ```bash
    $ kubectl apply -f https://raw.githubusercontent.com/mahendra-shinde/kubernetes-demos/master/16-static-fileshare-as-volume/deploy-static-volume.yaml
    
    ```