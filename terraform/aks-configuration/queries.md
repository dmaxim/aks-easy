export IDENTITY_NAME=<agent pool managed identity name>
export IDENTITY_RESOURCE_GROUP=<resource group for nodes> # Generated when the cluster is created
export IDENTITY_CLIENT_ID=
export NODE_GROUP=$(az aks show -g ${CLUSTER_RESOURCE_GROUP} -n ${CLUSTER_NAME} --query nodeResourceGroup -o tsv)
export NODES_RESOURCE_ID=$(az group show -n $NODE_GROUP -o tsv --query "id")
az role assignment create --role "Virtual Machine Contributor" --assignee "$IDENTITY_CLIENT_ID" --scope $NODES_RESOURCE_ID

