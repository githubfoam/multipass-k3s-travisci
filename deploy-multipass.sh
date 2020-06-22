#!/bin/bash

echo "=============================Multipass============================================================="
multipass launch --name node1 #must be named as node1
multipass exec node1 -sudo sh -c "curl -sfL https://get.k3s.io | sh -"
TOKEN=`multipass exec node1 -sudo cat /var/lib/rancher/k3s/server/node-token`
echo $TOKEN
IP=`multipass list --format csv | grep "^node1" | cut -d, -f3`
echo $IP
COUNT=3 &&  echo $COUNT
for i in `seq 2 $COUNT`
  do
      multipass launch --name node$i | tee /dev/null
      multipass exec node$i -sudo sh -c "curl -sfL https://get.k3s.io | K3S_URL=https://$IP:6443 K3S_TOKEN=$TOKEN sh -"
done
sleep 10
multipass exec node1 sudo kubectl get nodes
multipass mount $HOME node1
multipass mount $HOME node1:/tmp
echo $HOME && ls -lai
multipass info node1
multipass exec node1 -- sudo sh -c "kubectl get pods --all-namespaces" # verify Traefik installed by default
multipass exec node1 -- sudo sh -c "kubectl get pods -n kube-system" # verify Traefik installed by default
multipass exec node1 -- sudo sh -c "kubectl get nodes" # verify Traefik installed by default

# echo "=============================openEBS============================================================="
# echo $HOME && ls -lai
# multipass transfer deploy-openesb.sh node1:deploy-openesb.sh
# multipass exec node1 -sudo mkdir app
# multipass transfer app/deploy-openesb.sh node1:app/deploy-openesb.sh
# multipass transfer app/deploy-openesb.sh node1:deploy-openesb.sh
multipass transfer Makefile node1:Makefile
# multipass exec node1 -sudo ls -lai
# multipass exec node1 -sudo apt-get install -qqy build-essential #required 4 Makefile
# # multipass exec node1 -sudo bash deploy-openesb.sh
# multipass exec node1 -sudo ls -lai app
# multipass exec node1 -sudo ls -lai app/deploy-openesb.sh #app/deploy-openesb.sh: No such file or directory
# multipass exec node1 -sudo make deploy-openesb




# multipass exec node1 -sudo sh -c "./deploy-openesb.sh"
# multipass exec node1 -sudo sh -c "kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml"
# echo "=============================Kubernetes Dashboard============================================================="
#Deploying the Kubernetes Dashboard
#Access the cluster from PC remotely
# cat /etc/rancher/k3s/k3s.yaml
# Save the copied configuration as ~/.kube/config
# edit the file and change the line server: https://localhost:6443 server: https://k3smaster:6443
# chmod 600 ~/.kube/config   limit the file's read/write permissions
# mkdir ~/.kube #Make a directory for the config Copy this configuration information
# apt update && sudo apt install -y apt-transport-https
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | \
# tee -a /etc/apt/sources.list.d/kubernetes.list
# apt update && apt install kubectl
# kubectl get nodes check out  cluster from PC
#Access the cluster from PC remotely


# multipass purge #purge to remove all deleted instances completely
