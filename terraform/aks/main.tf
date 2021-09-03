
resource "azurerm_resource_group" "aks" {
    name = join("-", ["rg", var.namespace, var.environment])
    location = var.location
}