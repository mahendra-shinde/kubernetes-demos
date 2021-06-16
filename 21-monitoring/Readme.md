# Monitoring Cluster with Prometheus and Grafana

1. Prometheus: Monitoring tool with built in alert manager.

2. Grafana: Visualization tool, visualize data from prometheus.

1. Create a new namespace for monitoring services

    ```shell
    $ kubectl create ns monitoring
    ```

2.  Download and install helm chart for prometheus and grafana

    ```shell
    $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    $ helm install my-monitor prometheus-community/kube-prometheus-stack --version 16.8.0 -n monitoring
    ```

3.  Get the admin username and password (in base64 encoding)

    ```shell
    $ USER=$(kubectl get secret my-monitor-grafana --namespace monitoring -o jsonpath="{.data.admin-user}")
    $ PASSWORD=$(kubectl get secret my-monitor-grafana --namespace monitoring -o jsonpath="{.data.admin-password}" )
    echo "$USER , $PASSWORD"
    ```

4.  Decode both values using online base64 decoder `https://www.base64decode.org/`

5.  Default username is "admin" and default password "prom-operator"

6.  Use following command to expose grafana on localhost:8085

    ```shell
    $ kubectl port-forward svc/my-monitor-grafana 8085:80 -n monitoring
    ```

7.  Visit http://localhost:8085