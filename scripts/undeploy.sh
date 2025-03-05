#!/bin/bash

set -x 

container_name=$1

container_id=$(docker ps --filter "name=${container_name}"  --format='{{json .ID}}')

if [[ -n "${container_id}" ]]; then
    docker container stop "${container_id}"
    docker container rm "${container_id}"
fi

set +x 