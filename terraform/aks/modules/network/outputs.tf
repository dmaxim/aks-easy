output "cluster_subnets" {
  value = [for subnet in azurerm_subnet.aks : { "id" : subnet.id, "name" : subnet.name }]
}


output "cluster_vnet_id" {
  value = azurerm_virtual_network.aks.id
}