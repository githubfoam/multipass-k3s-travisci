IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-multipass:
	bash deploy-multipass-microk8s.sh
deploy-multipass:
	bash deploy-multipass-microk8s.sh
multipass-openesb:
	bash app/multipass-openesb.sh
deploy-istio:
	bash app/deploy-istio.sh
push-image:
	docker push $(IMAGE)
.PHONY: deploy-openesb deploy-istio push-image
