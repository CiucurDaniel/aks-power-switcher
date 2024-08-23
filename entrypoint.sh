#!/bin/bash

exit_with_error_message() {
    echo "$1"
    exit 1
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 start|stop"
    echo "       Start or stop an aks cluster based on given argument"
    exit_with_error_message "Illegal number of arguments"

elif [ "$1" != "start" ]  && [ "$1" != "stop" ]; then
    exit_with_error_message "Unkown action. Possible actions: start, stop."

else 
    echo "Proceding to $1 the cluster"
fi

az login --service-principal -u ${ARM_CLIENT_ID} -p ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID} --output none

desired_status=$( [ "$1" == "start" ] && echo "Running" || echo "Stopped" )
echo "Desired status is: $desired_status"

cluster_state=$( az aks show --name ${CLUSTER_NAME} --resource-group ${RESOURCE_GROUP} | jq -r ".powerState.code" )

if [ "$cluster_state" == "$desired_status" ]; then 
        echo "Cluster state is already: $desired_status"
        exit 0
else
        az aks $1 --name ${CLUSTER_NAME} --resource-group ${RESOURCE_GROUP}

        if [ $? -ne 0 ]; then exit_with_error_message "There was an error when trying to $1 the cluster. Please notify DevOps team to investigate"; fi
fi