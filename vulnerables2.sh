## A script to quickly start and stop docker containers. 

DIRECTORY="vulhub"

# Array of six default containers to start that have been
# carefully select to avoid port number conflicts. In total
# these will consume less than 1GB of system memory. 

#CONTAINERS[0]="$DIRECTORY/nacos/CVE-2021-29441/docker-compose.yml"
# CONTAINERS[0]="$DIRECTORY/log4j/CVE-2021-44228/docker-compose.yml"
#CONTAINERS[2]="$DIRECTORY/elasticsearch/CVE-2015-1427/docker-compose.yml"
#CONTAINERS[3]="$DIRECTORY/cmsms/CVE-2021-26120/docker-compose.yml" 
#CONTAINERS[4]="$DIRECTORY/ffmpeg/CVE-2016-1897/docker-compose.yml"
CONTAINERS[0]="$DIRECTORY/saltstack/CVE-2020-11651/docker-compose.yml"

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