resource "azurerm_virtual_network" "aks" {
  name                = join("-", ["vnet", var.namespace, var.environment])
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
}


resource "azurerm_subnet" "aks" {
  for_each             = { for idx, subnet_name in var.subnets : subnet_name => idx }
  name                 = each.key
  resource_group_name  = var.resource_group_name
  address_prefixes     = [cidrsubnet(var.vnet_address_space, 8, each.value + 1)]
  virtual_network_name = azurerm_virtual_network.aks.name

}