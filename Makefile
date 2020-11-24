ESPOCRM_VERSION := 6.0.3
IMAGE := kavatech/espocrm:$(ESPOCRM_VERSION)-1

docker-build:
	docker build --build-arg ESPOCRM_VERSION='$(ESPOCRM_VERSION)' -t $(IMAGE) .

docker-push: docker-build
	docker push $(IMAGE)

docker-run: docker-build
	docker run -p 8080:80 -it $(IMAGE)
