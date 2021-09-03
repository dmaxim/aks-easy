output "cluster_managed_identity" {
  value = azurerm_kubernetes_cluster.aks-cluster.identity[0].principal_id
}

output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks-cluster.id
}

