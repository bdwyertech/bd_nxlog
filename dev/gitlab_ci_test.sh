#!/bin/bash
# Runs GitlabCI Runner Locally

#gitlab-ci-multi-runner exec docker --docker-privileged --docker-volumes '/var/run/docker.sock:/var/run/docker.sock' \
# --docker-volumes '/tmp/test-kitchen/kitchen-cache:/root/.kitchen/cache:rw' \
# --docker-volumes '/tmp/test-kitchen/dokken:/root/.dokken:rw' \
#test:ChefDK

gitlab-ci-multi-runner exec docker --docker-privileged test:ChefDK

# gitlab-ci-multi-runner exec docker --docker-volumes '/var/run/docker.sock:/var/run/docker.sock' \
# --docker-image gitlab/dind:latest \
# test:ChefDK
