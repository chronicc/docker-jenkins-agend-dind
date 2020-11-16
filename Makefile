
# CONFIGURATION

IMAGE_NAME ?= chronicc/jenkins-agent-dind#	Dedicated name of the built image
IMAGE_VERSION ?= latest#					Dedicated version of the built image
PARENT_NAME ?= jenkins/inbound-agent#		Name of the parent image
PARENT_VERSION ?= latest#					Version of the parent image
REGISTRY_USERNAME ?= ""#					Username used for login to the docker registry
REGISTRY_PASSWORD ?= ""#					Password used for login to the docker registry

.DEFAULT_GOAL:= help
.PHONY: clean help


# HELP

help: # Display a list of all parameters and targets in this Makefile
	@echo "\nPARAMETERS:"
	@grep -E '^[a-zA-Z\_-]+ \?= .*#.*$$' Makefile | tr '?' '#' | tr -d '=' \
		| awk 'BEGIN {FS="#[ \t]+"}; {printf "\033[36m%-30s\033[0m %s (Default: %s)\n", $$1, $$3, $$2}'
	@echo "\nTARGETS:"
	@grep -E '^([a-zA-Z\.\_-]+):.*#.*$$' Makefile | awk 'BEGIN {FS=":.*#[ \t]+"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# TARGETS

step.pull: # Pull the parent image from the docker registry
	docker pull $(PARENT_NAME):$(PARENT_VERSION)

step.build: Dockerfile # Build the docker image
	docker build -t $(IMAGE_NAME) \
		--build-arg PARENT_NAME=$(PARENT_NAME) \
		--build-arg PARENT_VERSION=$(PARENT_VERSION) \
		.

step.tag: # Tag the image with a version
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):$(IMAGE_VERSION)

step.login: # Log into the docker registry
	docker login -u "$(REGISTRY_USERNAME)" -p "$(REGISTRY_PASSWORD)"

step.push: # Push the image to docker registry
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)
	docker push $(IMAGE_NAME)

publish: step.pull step.build step.tag step.login step.push # Run a full build pipeline to publish a new image to the docker registry

clean: # Remove all parents and build images related to this repository
	docker rmi $(shell docker images -q --filter=reference='$(IMAGE_NAME)' --filter=reference='$(IMAGE_PARENT)')

