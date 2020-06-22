#!/bin/bash


echo "=============================Dashboard============================================================="
- brew cask install multipass
- multipass version
- sudo multipass launch --name k3s --cpus 4 --mem 4g --disk 20g
- multipass info k3s
#Install a single-node Kubernetes cluster on the VM with k3s
- sudo multipass exec k3s -- bash -c "curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -"
- brew install kubernetes-cli
- multipass info k3s
- K3S_IP=$(multipass info k3s | grep IPv4 | awk '{print $2}')
- echo $K3S_IP
# - sudo multipass exec k3s sudo cat /etc/rancher/k3s/k3s.yaml > k3s.yaml
# - cat k3s.yaml
# - sed -i '' "s/127.0.0.1/${K3S_IP}/" k3s.yaml #Replace the server with the cluster IP
# - export KUBECONFIG=${PWD}/k3s.yaml
# - kubectl get nodes
# - kubectl get all
# - kubectl get pods --all-namespaces
# - brew install helm@3
echo "=============================Dashboard============================================================="
