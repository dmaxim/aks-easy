
resource "azurerm_resource_group" "aks" {
  name     = join("-", ["rg", var.namespace, var.environment])
  location = var.location
}


# Create the Virtual Network And Subnet
module "network" {
  source              = "./modules/network"
  namespace           = var.namespace
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.aks.name
  vnet_address_space  = var.vnet_address_space
  subnets             = ["GatewaySubnet", "cluster-subnet"]
}

# Create the AKS Cluster
module "aks" {
  source               = "./modules/cluster"
  namespace            = var.namespace
  location             = var.location
  environment          = var.environment
  resource_group_name  = azurerm_resource_group.aks.name
  k8s_version          = "1.20.7"
  authorized_ips       = var.authorized_ips
  admin_user_name      = var.admin_user_name
  admin_public_ssh_key = var.admin_public_ssh_key
  default_node_pool    = local.default_node_pool
  cluster_vnet_id      = module.network.cluster_vnet_id
}

# Create additional node pools

module "nodepool" {
  source                = "./modules/cluster-node-pool"
  kubernetes_cluster_id = module.aks.cluster_id
  node_pools            = local.node_pools
}
