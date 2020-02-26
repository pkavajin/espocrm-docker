ESPOCRM_VERSION := 5.7.11
IMAGE := kavatech/espocrm:$(ESPOCRM_VERSION)

docker-build:
	docker build --build-arg ESPOCRM_VERSION='$(ESPOCRM_VERSION)' -t $(IMAGE) .

docker-push: docker-build
	docker push $(IMAGE)

docker-run: docker-build
	docker run -p 8080:80 -it $(IMAGE)
