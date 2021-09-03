resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                            = join("-", ["aks", var.namespace, var.environment])
  location                        = var.location
  resource_group_name             = var.resource_group_name
  dns_prefix                      = join("-", ["aks", var.namespace, var.environment])
  kubernetes_version              = var.k8s_version
  api_server_authorized_ip_ranges = var.authorized_ips

  linux_profile {
    admin_username = var.admin_user_name

    ssh_key {
      key_data = var.admin_public_ssh_key
    }
  }

  default_node_pool {
    name            = var.default_node_pool.name
    node_count      = var.default_node_pool.node_count
    vm_size         = var.default_node_pool.vm_size
    os_disk_size_gb = 50
    max_pods        = 70
    type            = "VirtualMachineScaleSets"
    vnet_subnet_id  = var.default_node_pool.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled = false
    }
  }


  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
    }
  }

  tags = {
    environment = var.environment
  }
}


# Grant Managed Identity Permission to Create in the VNet
resource "azurerm_role_assignment" "vnet_contributor" {
  scope                = var.cluster_vnet_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks-cluster.identity[0].principal_id
}

