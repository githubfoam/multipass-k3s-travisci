#!/bin/bash

echo "=============================Multipass============================================================="
multipass launch --name node1 #must be named as node1
multipass exec node1 -- sudo sh -c "curl -sfL https://get.k3s.io | sh -"
TOKEN=`multipass exec node1 -- sudo cat /var/lib/rancher/k3s/server/node-token`
echo $TOKEN
IP=`multipass list --format csv | grep "^node1" | cut -d, -f3`
echo $IP
COUNT=3 &&  echo $COUNT
for i in `seq 2 $COUNT`
  do
      multipass launch --name node$i | tee /dev/null
      multipass exec node$i -- sudo sh -c "curl -sfL https://get.k3s.io | K3S_URL=https://$IP:6443 K3S_TOKEN=$TOKEN sh -"
done
sleep 10
multipass exec node1 -- sudo kubectl get nodes
multipass mount $HOME node1
multipass mount $HOME node1:/tmp
echo $HOME && ls -lai
multipass info node1

echo "=============================microk8s============================================================="

# https://www.kubeflow.org/docs/started/workstation/getting-started-multipass/
multipass exec node1 -- sudo snap install microk8s --classic
# multipass exec node1 -- sudo microk8s.status --wait-ready
echo "Waiting for Kubernetes to be ready ..."
for i in {1..150}; do # Timeout after 5 minutes, 150x2=300 secs
    if microk8s kubectl get pods --namespace=kube-system | grep Running ; then
      break
    fi
    sleep 2
done

multipass exec node1 -- sudo microk8s.enable dns dashboard storage # Enable common services
multipass exec node1 -- sudo microk8s kubectl get nodes
multipass exec node1 -- sudo microk8s kubectl get services
multipass exec node1 -- sudo microk8s.kubectl config current-context
multipass exec node1 -- sudo microk8s.kubectl config get-clusters
multipass exec node1 -- sudo microk8s.kubectl config get-contexts
multipass exec node1 -- sudo microk8s.kubectl config view -h

echo "=============================kubeflow============================================================="
multipass exec node1 -- sudo microk8s.enable kubeflow # Enable Kubeflow
multipass info kubeflow # if you used Multipass, you can get the IP address of the VM with either
multipass list # if you used Multipass, you can get the IP address of the VM with either
# http://” Your kubeflow VM IP”:“Ambassador PORT”

# Getting started with Jupyter notebooks on Kubeflow
# https://www.kubeflow.org/docs/notebooks/setup/


multipass purge #purge to remove all deleted instances completely
