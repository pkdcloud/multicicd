# docker.mk

# variables

DOCKER_RUNNER ?= docker
DOCKER_REPOSITORY ?=
DOCKER_TAG ?=
DOCKER_REPO_URL ?=
DOCKER_REPO_USERNAME ?=
DOCKER_REPO_PASSWORD ?=

# targets

docker-build: docker-build-version docker-build-latest ## Runs docker-build-version & docker-build-latest

docker-build-version: env-DOCKER_REPOSITORY env-DOCKER_TAG ## Builds and tags the DOCKER_VERSION docker image
	@echo '[docker.mk] Building $(DOCKER_REPOSITORY):$(DOCKER_TAG) image'
	$(DOCKER_RUNNER) build . \
		--tag $(DOCKER_REPO_URL)/$(DOCKER_REPOSITORY):$(DOCKER_TAG)

docker-build-latest: env-DOCKER_REPOSITORY ## Builds and tags the latest docker image
	@echo '[docker.mk] Building $(DOCKER_REPOSITORY):latest image'
	$(DOCKER_RUNNER) build . \
		--tag $(DOCKER_REPO_URL)/$(DOCKER_REPOSITORY):latest

docker-publish: docker-publish-version docker-publish-latest ## Runs docker-publish-version & docker-publish-latest

docker-publish-version: docker-repo-auth env-DOCKER_REPOSITORY env-DOCKER_TAG ## Publishes the DOCKER_VERSION tagged container to DOCKER_REPO_URL
	@echo '[docker.mk] Publishing $(DOCKER_REPOSITORY):$(DOCKER_TAG) to $(DOCKER_REPO_URL)'
	docker push $(DOCKER_REPO_URL)/$(DOCKER_REPOSITORY):$(DOCKER_TAG)

docker-publish-latest: docker-repo-auth env-DOCKER_REPOSITORY ## Publishes the latest tagged container to DOCKER_REPO_URL
	@echo '[docker.mk] Publishing $(DOCKER_REPOSITORY):latest to $(DOCKER_REPO_URL)'
	docker push $(DOCKER_REPO_URL)/$(DOCKER_REPOSITORY):latest

docker-repo-auth: env-DOCKER_REPO_URL env-DOCKER_REPO_USERNAME env-DOCKER_REPO_PASSWORD ## Authenticates to DOCKER_REPO_URL
	@echo '[docker.mk] Logging in $(DOCKER_REPO_URL)'
	$(DOCKER_RUNNER) login $(DOCKER_REPO_URL) --username $(DOCKER_REPO_USERNAME) --password $(DOCKER_REPO_PASSWORD)

PHONY: docker_build docker-build-latest docker-build-version \
	docker-publish docker-publish-latest docker-publish-version docker-repo-auth

docker push lastknight.jfrog.io/docker-local/<DOCKER_REPOSITORY>:<DOCKER_TAG>
