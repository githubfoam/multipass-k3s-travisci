#!/bin/bash
kubectl apply -f kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml #install OpenEBS
kubectl get service --all-namespaces # find a Service IP,list all services in all namespaces-
kubectl get pods -n openebs -l openebs.io/component-name=openebs-localpv-provisioner #Observe localhost provisioner pod
kubectl get sc #Check the storage Class
echo "Waiting for openebs-localpv-provisioner to be ready ..."
for i in {1..60}; do # Timeout after 5 minutes, 150x5=300 secs
      if sudo kubectl get pods --namespace=openebs -l openebs.io/component-name=openebs-localpv-provisioner | grep Running ; then
        break
      fi
      sleep 5
done
echo "Waiting for openesb to be ready ..."
  for i in {1..60}; do # Timeout after 2 minutes, 60x2=300 secs
      if sudo kubectl get pods --namespace=openebs | grep Running ; then
        break
      fi
      sleep 2
done
kubectl get pods --all-namespaces
kubectl get pods --namespace=openebs
