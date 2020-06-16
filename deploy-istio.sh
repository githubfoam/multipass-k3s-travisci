#!/bin/bash
# cd /root/
# launch.sh>&2
VERSION="1.6.2"
if [[ ! -d "/root/istio-1.0.0" ]]; then
  echo "Downloading Istio... this may take a couple of moments">&2
  #curl -s -L https://git.io/getLatestIstio | ISTIO_VERSION=1.0.0 sh -
  curl -s -L https://git.io/getLatestIstio | ISTIO_VERSION=$VERSION sh -
  echo "Download completed.">&2
else
  echo "Istio already exists">&2
fi
#export PATH="$PATH:/root/istio-1.0.0/bin";
#cd /root/istio-1.0.0
# kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml -n istio-system
# kubectl apply -f install/kubernetes/istio-demo-auth.yaml
# kubectl apply -f /root/katacoda.yaml
# kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
# kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
# kubectl apply -f samples/bookinfo/networking/destination-rule-all-mtls.yaml
cd istio-$VERSION
export PATH=$PWD/bin:$PATH;
#use the demo configuration profile. It’s selected to have a good set of defaults for testing,
#there are other profiles for production or performance testing.
istioctl install --set profile=demo
kubectl label namespace default istio-injection=enabled
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yamls
kubectl get services
kubectl get pods
#kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
echo $(kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>")
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
