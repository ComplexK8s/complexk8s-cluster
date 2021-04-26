#!/bin/bash
#
# aws-setup-eks.sh - Utility for setting up the EKS cluster
#
# Author: Rodrigo Alvares de Souza <rsouza01@gmail.com>
#
# History:
# Version 0.1: 2021/04/26 (rsouza) - First version

#FUNCTIONS DEFINITIONS

print2stringslncolor () {
        echo -e "\e[0m$1\e[1;34m$2\e[0m\n"
}


print2stringslncolorERROR () {
        echo -e "\e[0m$1\e[1;91m$2\e[0m\n"
}

printlncolor () {
        echo -e "\e[1;34m$1\e[0m\n"
}

printlncolorERROR () {
        echo -e "\e[1;91m$1\e[0m\n"
}
#END FUNCTIONS DEFINITIONS


# CONSTANTS
NO_ERROR=0
ERROR_INVALID_OPTION=1
ERROR_NO_OPERATION=2
ERROR_NO_CLUSTER=3

#MAIN PROGRAM
_OPERATION="info"
_CLUSTER_NAME="complex-k8s"
_NODE_GROUP_NAME="linux-nodes"
_NODE_TYPE="t2.nano"
_NUMBER_NODES=2
_DRY_RUN=


_VERSION=$(grep '^# Version ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#)

USE_MESSAGE="
$(basename "$0") - EKS Cluster maintenance (${_VERSION})
=============================================================================


This utility takes care of EKS cluster maintenance

Usage: $(basename "$0") [OPTIONS]

OPTIONS:    
  -o, --operation           Sets the operation to be performed (info, create, delete)
  -c, --cluster-name        Sets the cluster name
  -g, --node-group-name     Sets the node group name (default: linux-nodes)
  -t, --node-type           Sets node type (default: t2.nano)
  -n, --number-nodes        Sets the number of nodes (default: 2)

  -h, --help        Show this help screen and exits
  -V, --version     Show program version and exits
      --dry-run     Performs a dry run execution
"

#Command line arguments
while test -n "$1"
do
        case "$1" in
		-o | --operation) 
                        shift
                        _OPERATION=$1 
                ;;

		-c | --cluster-name) 
                        shift
                        _CLUSTER_NAME=$1 
                ;;

		-g | --node-group-name) 
                        shift
                        _NODE_GROUP_NAME=$1
                ;;

		-t | --node-type) 
                        shift
                        _NODE_TYPE=$1
                ;;

		-n | --number-nodes) 
                        shift
                        _NUMBER_NODES=$1
                ;;
		--dry-run) 
                        shift
                        _DRY_RUN='--dry-run'
                ;;



		-h | --help)
			echo "$USE_MESSAGE"
			exit $NO_ERROR
		;;

		-V | --version)
			echo -n "$(basename "$0")"
            echo " ${_VERSION}"
			exit $NO_ERROR
		;;

		*)
			echo Invalid option: "$1"
			exit $ERROR_INVALID_OPTION
		;;
	esac

	shift
done

# Debug info
printlncolor "***********************************************************************************"
printlncolor "                         CLUSTER PARAMETERS"
printlncolor "***********************************************************************************"
printlncolor "OPERATION => '$_OPERATION'"
printlncolor "CLUSTER_NAME => '$_CLUSTER_NAME'"
printlncolor "NODE_GROUP_NAME => '$_NODE_GROUP_NAME'"
printlncolor "NODE_TYPE => '$_NODE_TYPE'"
printlncolor "NUMBER_NODES => '$_NUMBER_NODES'"
printlncolor "DRY_RUN => '$_DRY_RUN'"
printlncolor "***********************************************************************************"

# Sanity checks
if [[ "$_OPERATION" = "" ]]
then    
    printlncolorERROR "No operation set. Exiting..."
    exit $ERROR_NO_OPERATION
fi

if [[ "$_CLUSTER_NAME" = "" ]]
then    
    printlncolorERROR "No cluster name set. Exiting..."
    exit $ERROR_NO_CLUSTER
fi

if [ "$_OPERATION" = "info" ]; then
    printlncolor "Getting info..."
    kubectl get nodes
    kubectl get pods
    exit $NO_ERROR
elif [ "$_OPERATION" = "create" ]; then
    printlncolor "Creating cluster ${_CLUSTER_NAME}"

    eksctl create cluster \
        --name "$_CLUSTER_NAME" \
        --nodegroup-name "$_NODE_GROUP_NAME" \
        --node-type "$_NODE_TYPE"	\
        --nodes "$_NUMBER_NODES" \
        $_DRY_RUN

    exit $NO_ERROR
elif [ "$_OPERATION" = "delete" ]; then
    printlncolor "Deleting cluster ${_CLUSTER_NAME}"

    eksctl delete cluster --name "$_CLUSTER_NAME"

    exit $NO_ERROR
else
    echo "$USE_MESSAGE"
    printlncolorERROR "No operation set. Exiting..."
    exit $ERROR_NO_OPERATION
fi