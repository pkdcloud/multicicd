# multicicd makefile

# vars

DOCKER_REPOSITORY = lastknight/multicicd
DOCKER_TAG = 0.1
DOCKER_REPO_URL = lastknight.jfrog.io

# modules
include make/common.mk
include make/docker.mk
