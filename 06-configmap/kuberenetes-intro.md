Kubernetes Cluster Setup

1. Using kubeadm to bootstrap On-Premise Cluster
2. Using Docker Desktop for Windows (Single Node cluster)
3. For Windows 7/8 or Mac OS : Minikube (Single Node cluster)
4. Kubernetes on cloud (PaaS) AKS, EKS, GKE


Production like ENV : OnPremise using kubeadm 
                      Managed Kuberenets (PaaS) from Cloud Vendors

Kubernetes deployment architectures
    - POD           Single atomic Unit for deployment, Contains one or more containers & volumes
    - ReplicaSet    Enable Self Healing and Scaling for PODS
    - Deployment    To enable RollingUpdate and history of deployments
    - Service       To create an ENDPOINT for accessing POD
    - volumes       A Directory/Folder mounted inside the container
    - ConfigMap     A Set of KEY VALUE pairs injected inside the POD as ENV Vars
    - Secrets       Generic secrets : Basic Key Value pair where Value is encrypted with
                    Base64
                    TLS : Signed Certificates
                    docker-registry
    - Job           Background (Long running) application
    - CronJob       Scheduled Jobs
    - StatefulSet   Alternative to both ReplicaSet and Deployment
                    - Pods are created and destroyed in Fixed order
                    - Pod IPs are STATIC
                    - Used for Attaching Sessions to selected pod only (Sticky Session)
    - VolumeClass   - External Volume plugin (Connect with NFS, Azure Blob or Azure File Share)
    - PersistentVolume    Volume created and stored Outside kuberenetes cluster.
    - PersistentVolumeClaim     A Pod claims a part of persistentVolume