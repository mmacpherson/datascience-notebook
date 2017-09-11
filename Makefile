BASE_IMAGE_NAME=jupyter/tensorflow-notebook

IMAGE_NAME=notebook-image
CONTAINER_NAME=notebook-container

PORT_EXPOSED_BY_CONTAINER=8888
PORT_EXPOSED_TO_HOST=8888


pull:
	docker pull $(BASE_IMAGE_NAME)


build: pull
	docker build -t $(IMAGE_NAME) .


# -- if your host port is taken, do a `make run PORT_EXPOSED_TO_HOST=<some_open_port>`
run:
	docker run -d \
    --name $(CONTAINER_NAME) \
    -p $(PORT_EXPOSED_TO_HOST):$(PORT_EXPOSED_BY_CONTAINER) \
    $(IMAGE_NAME) \
    start-notebook.sh \
    --NotebookApp.token=''


stop:
	docker stop $(CONTAINER_NAME) -t 1 && docker rm $(CONTAINER_NAME)


clean: stop
	docker rmi $(IMAGE_NAME)
