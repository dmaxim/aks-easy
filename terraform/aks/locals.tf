locals {
  default_node_pool = {
    name       = "mxinfo"
    node_count = 2
    vm_size    = var.default_node_pool_vm_size
    subnet_id  = module.network.cluster_subnets[1].id
  }
  node_pools = {
    pool_two = {
      name                  = "mxinfo2"
      node_count            = 1
      vm_size               = var.default_node_pool_vm_size
      kubernetes_cluster_id = module.aks.cluster_id
      environment           = var.environment
      subnet_id  = module.network.cluster_subnets[1].id
    }
  }
}