#!/bin/bash

## WARNING: THIS SCRIPT CONTAINS SERVERAL CRITICAL VULNERABLITIES.
## FOR TEST PURPOSES ONLY. DO NOT RUN IN A PRODUCTION ENVIRONMENT!!!

## Vulnerables version 0.3
## A script to quickly start and stop docker containers. 

DIRECTORY="vulhub"

# Array of six default containers to start that have been
# carefully select to avoid port number conflicts. In total
# these will consume less than 1GB of system memory. 

CONTAINERS[0]="$DIRECTORY/coldfusion/CVE-2017-3066/docker-compose.yml"
#CONTAINERS[1]="$DIRECTORY/openssl/CVE-2014-0160/docker-compose.yml"
#CONTAINERS[0]="$DIRECTORY/activemq/CVE-2016-3088/docker-compose.yml"
# CONTAINERS[1]="$DIRECTORY/grafana/CVE-2021-43798/docker-compose.yml" 
#CONTAINERS[4]="$DIRECTORY/cacti/CVE-2022-46169/docker-compose.yml"
# ONTAINERS[2]="$DIRECTORY/apisix/CVE-2021-45232/docker-compose.yml"

# Randomly choose six vulnerable containers to start
#random () {
#
#}

# List all available containers
#list () {
#
#}

# Check system for requirements
init_check () {

    # Check whether vulhub folder exists
    if [[ ! -d vulhub ]]
    then
        echo "The vulhub folder was not found. Download from https://github.com/vulhub/vulhub"
        exit 1
    fi

    # Check whether docker is installed
    docker --version > /dev/null 2>&1
    if [[ $? -ne 0 ]]
    then
        echo "Docker is not installed. Read: https://docs.docker.com/get-docker/ "
        exit 3
    fi

    # Check whether docker-compose is installed
    docker compose version > /dev/null 2>&1
    if [[ $? -ne 0 ]]
    then
        echo "Docker-compose is not installed. Read: https://docs.docker.com/compose/install/"
        exit 3
    fi
}

# Start each container with docker-compose
start () {
    for i in "${CONTAINERS[@]}"
    do
        docker compose -f "${i}" up -d
        if [[ $? -ne 0 ]]
        then
            exit 1 # Exit docker engine is not running
        fi
    done
}

stop () {
    for i in "${CONTAINERS[@]}"
    do
        docker compose -f "${i}" down -v
        if [[ $? -ne 0 ]]
        then
            echo "You may need to manually disable container(s) using docker."
            echo "To show running containers type: docker ps"
            #exit 1 # Exit docker engine is not running
        fi
    done
}

if [[ $1 == "start" ]]
then
    init_check
    echo "Starting all docker containers..."
    start
elif [[ $1 == "stop" ]]
then
    init_check
    echo "Stopping all docker containers ..."
    stop
elif [[ $1 == "list" ]]
then
    echo -e "Listing all available Docker containers from vulhub."
    # TODO: List all the available Docker containers. Check if they are running.
else
    echo -e "\n\e[31m\e[1mVulnerables\e[0m: a quick and simple way of starting multiple Docker containers from vulhub.\n"
    echo -e "Usage: $0 [start or stop]\n"
fi
