


#Grant Managed Identity Permission to Create in the VNet - need to verify if the scope needs to be on the VMSS or the resource group for the nodes
resource "azurerm_role_assignment" "virtual_machine_contributor" {
  scope                = var.virtual_machine_scope
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = var.agent_pool_service_principal_id
}

# Grant the Managed Identity Operator
resource "azurerm_role_assignment" "managed_identity_operator" {
  scope                = var.resource_group_scope
  role_definition_name = "Managed Identity Operator"
  principal_id         = var.agent_pool_service_principal_id
}