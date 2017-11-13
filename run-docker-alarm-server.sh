#!/bin/bash

#
# An auxiliary script to start a new Docker container. It should be used to test the 
# respective image. To deploy, use the composed repository, available in
# https://github.com/lnls-sirius/docker-alarm-composed .  
#
# Gustavo Ciotto Pinton
# Controls Group - Brazilian Synchrotron Light Source Laboratory - LNLS
#
. ./env-vars.sh

# Verifies if a container with the same name is already running.
CONTAINERS=$(docker ps -a | grep ${DOCKER_RUN_NAME})

if [ ! -z ${CONTAINERS:+x} ]; then

    echo "A container with the name ${DOCKER_RUN_NAME} is already running..."

    # Stops running container and deletes it.
    echo "Executing 'docker stop ${DOCKER_RUN_NAME}' ..."
    docker stop ${DOCKER_RUN_NAME} &> /dev/null

    echo "Executing 'docker rm ${DOCKER_RUN_NAME}' ..."
    docker rm ${DOCKER_RUN_NAME} &> /dev/null
fi

# Runs a new instance of the Docker image
docker run -d --name=${DOCKER_RUN_NAME} --network=${NETWORK_ID} \
    ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}

docker logs -f ${DOCKER_RUN_NAME}
