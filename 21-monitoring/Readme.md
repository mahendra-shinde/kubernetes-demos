# Monitoring Cluster with Prometheus and Grafana

1. Prometheus: Monitoring tool with built in alert manager.

2. Grafana: Visualization tool, visualize data from prometheus.

1. Create a new namespace for monitoring services

    ```shell
    $ kubectl create ns monitoring
    ```

2.  set the password for admin user (grafana dashboard) using 'values.yaml' file

    ```yml
    grafana:
      adminPassword: 'Password@1234'      
    ```

    >> NOTE: You can enable INGRESS route for the grafana dashboard using following 'values.yaml' file

    ```yml
    grafana:
        adminPassword: 'Password@1234'

    ingress:
        enabled: true
        path: /*
        annotations:
            kubernetes.io/ingress.class: 'nginx'
    ```

3.  Download and install helm chart for prometheus and grafana

    ```shell
    $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    $ helm install my-monitor -f values.yaml  prometheus-community/kube-prometheus-stack --version 16.8.0 -n monitoring
    ```

5.  Default username is "admin" and password was set in step# 2 .

6.  Use following command to expose grafana on localhost:8085

    ```shell
    $ kubectl port-forward svc/my-monitor-grafana 8085:80 -n monitoring
    ```

7.  Visit http://localhost:8085

8.  You should be able to access lots of dashboards (pre-configured).