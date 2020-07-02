# Setting-up private registry (Azure Container Registry) credentials

1. Create a new ACR using portal or following Azure CLI

    ```bash
    $ az acr create -n maxunlimited -g aks-group1 --sku basic
    ```

2. Get the credentials for your ACR using Azure CLI.

    ```bash
    $ az acr credential show -n maxunlimited -g aks-group1
    ```

3. The above command should produce all the credentials for registry. you need following details for registry-credentials (please replace values given below with your credentials):

    ```yaml
    server-url: maxunlimited
    ```
