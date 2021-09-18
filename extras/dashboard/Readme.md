# Deploying Kubernetes Dashboard 

1. You need to deploy the latest dashboard manifest using following commands:

    ```
    $ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.3.1/aio/deploy/recommended.yaml
    $ kubectl get all -n kubernetes-dashboard
    ```

2.  Now, You need to create special user with ADMIN permissions to access dashboard.
    I have the YAML file created, [here](./role-binding.yml) it is.

    ```
    $ kubectl apply -f role-binding.yml
    ```

3.  Use Powershell to access the secret token used for authentication (all in single line!!).

    ```pwsh
    $ kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
    ```

4.  Now, you must have token printed on your powershell terminal, just copy entire text (dont add any extra spaces!) 

5.  Now, you need to switch on the kubectl proxy to access the dashboard (uses port-forwarding). You can press `CTRL+C` to stop the proxy.

    ```
    $ kubectl proxy
    ```

6.  Now access this url and use `TOKEN` copied from step# 4 to login.

    `http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy`