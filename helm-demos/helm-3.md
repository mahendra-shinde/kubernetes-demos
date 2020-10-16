Download the helm 3.4 from https://github.com/helm/helm/releases/tag/v3.3.4

Extract it C:\helm (no subdirectories)

> HELM Communicates with Kubernetes cluster using C:\Users\USERNAME\.kube\config

## Common commands:

1.  Search for Ready-to-deploy Helm Chart from all repositories

    helm search hub NAMEOFAPP

2.  Create a new helm chart named 'myapp'

    helm create myapp

3.  Deploy the chart 'myapp' and release-name 'app-v1'
    helm install app-v1 .\myapp

4.  Uninstall the helm-release 'app-v1'

    helm uninstall app-v1 

5.  Add the repository (bitnami)

    c:\helm\helm repo add bitnami https://charts.bitnami.com/bitnami

6.  Download and Extract "bitnami/jenkins" inside current directory

    c:\helm\helm pull --untar bitnami/jenkins

7.  Deploy it on cluster

    c:\helm\helm install myjenkins bitnami/jenkins



