IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-openesb:
	bash app/deploy-openesb.sh

deploy-istio:
	bash app/deploy-istio.sh

push-image:
	docker push $(IMAGE)

.PHONY: deploy-openesb deploy-istio push-image
