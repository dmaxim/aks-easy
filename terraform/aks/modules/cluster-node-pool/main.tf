
resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  for_each              = var.node_pools
  name                  = each.value.name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  vnet_subnet_id = each.value.subnet_id

  tags = {
    Environment = each.value.environment
  }
}