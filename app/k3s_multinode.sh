#!/bin/bash


echo "=============================Dashboard============================================================="
#     # - cat $HOME/.ssh/id_rsa.pub
#     # https://linuxconfig.org/install-and-set-up-kvm-on-ubuntu-18-04-bionic-beaver-linux
#     - sudo apt-get -qqy install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager
#     - sudo multipass launch --name node1
#     - sudo multipass exec node1 -- sudo sh -c "curl -sfL https://get.k3s.io | sh -"
#     - TOKEN=`sudo multipass exec node1 -- sudo cat /var/lib/rancher/k3s/server/node-token`
#     - echo $TOKEN
#     - IP=`sudo multipass list --format csv | grep "^node1" | cut -d, -f3`
#     - echo $IP
#     - COUNT=3 &&  echo $COUNT
#     - |
#       for i in `seq 2 $COUNT`
#       do
#           sudo multipass launch --name node$i | tee /dev/null
#           sudo multipass exec node$i -- sudo sh -c "curl -sfL https://get.k3s.io | K3S_URL=https://$IP:6443 K3S_TOKEN=$TOKEN sh -"
#       done
#     - sleep 10
#     - sudo multipass exec node1 sudo kubectl get nodes
echo "=============================Dashboard============================================================="
