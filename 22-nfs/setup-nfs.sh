## Please replace following values as per your environment
SHARED_DIR=/mnt/nfsdir
NODES=10.0.0.0/16
apt update -y
apt install nfs-kernel-server -y
mkdir -p $SHARED_DIR
chown nobody:nogroup $SHARED_DIR
chmod 777 $SHARED_DIR
echo "/mnt/nfsdir $NODES(rw,sync,no_subtree_check)" >> /etc/exports 
exportfs -a
systemctl restart nfs-kernel-server
