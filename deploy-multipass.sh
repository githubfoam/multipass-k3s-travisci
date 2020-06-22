#!/bin/bash

'sudo multipass launch --name node1' #must be named as node1
sudo multipass exec node1 -sudo sh -c "curl -sfL https://get.k3s.io | sh -"
TOKEN=`sudo multipass exec node1 -sudo cat /var/lib/rancher/k3s/server/node-token`
echo $TOKEN
IP=`sudo multipass list --format csv | grep "^node1" | cut -d, -f3`
echo $IP
COUNT=3 &&  echo $COUNT
for i in `seq 2 $COUNT`
  do
      sudo multipass launch --name node$i | tee /dev/null
      sudo multipass exec node$i -sudo sh -c "curl -sfL https://get.k3s.io | K3S_URL=https://$IP:6443 K3S_TOKEN=$TOKEN sh -"
done
sleep 10
sudo multipass exec node1 sudo kubectl get nodes
sudo multipass mount $HOME node1
sudo multipass mount $HOME node1:/tmp
echo $HOME && ls -lai
sudo multipass info node1
sudo multipass exec node1 -sudo sh -c "kubectl get pods --all-namespaces" # verify Traefik installed by default
sudo multipass exec node1 -sudo sh -c "kubectl get pods -n kube-system" # verify Traefik installed by default
sudo multipass exec node1 -sudo sh -c "kubectl get nodes" # verify Traefik installed by default
echo "=============================openEBS============================================================="
echo $HOME && ls -lai
# sudo multipass transfer deploy-openesb.sh node1:deploy-openesb.sh
sudo multipass exec node1 -sudo mkdir app
sudo multipass transfer app/deploy-openesb.sh node1:app/deploy-openesb.sh
# sudo multipass transfer app/deploy-openesb.sh node1:deploy-openesb.sh
sudo multipass transfer Makefile node1:Makefile
# sudo multipass exec node1 -sudo ls -lai
sudo multipass exec node1 -sudo apt-get install -qqy build-essential #required 4 Makefile
# sudo multipass exec node1 -sudo bash deploy-openesb.sh
sudo multipass exec node1 -sudo ls -lai app
sudo multipass exec node1 -sudo ls -lai app/deploy-openesb.sh #app/deploy-openesb.sh: No such file or directory
sudo multipass exec node1 -sudo make deploy-openesb
# sudo multipass exec node1 -sudo sh -c "./deploy-openesb.sh"
# sudo multipass exec node1 -sudo sh -c "kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml"
echo "=============================openEBS============================================================="
#Deploying the Kubernetes Dashboard
#Access the cluster from PC remotely
# sudo cat /etc/rancher/k3s/k3s.yaml
# Save the copied configuration as ~/.kube/config
# edit the file and change the line server: https://localhost:6443 server: https://k3smaster:6443
# chmod 600 ~/.kube/config   limit the file's read/write permissions
# sudo mkdir ~/.kube #Make a directory for the config Copy this configuration information
# sudo apt update && sudo apt install -y apt-transport-https
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | \
# sudo tee -a /etc/apt/sources.list.d/kubernetes.list
# sudo apt update && sudo apt install kubectl
# kubectl get nodes check out  cluster from PC
#Access the cluster from PC remotely
sudo multipass purge #purge to remove all deleted instances completely
