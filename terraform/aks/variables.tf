
variable "namespace" {
  type        = string
  description = "Namespace to include in all resource names"
}

variable "location" {
  type        = string
  description = "Azure region for all resources"
}

variable "environment" {
  type        = string
  description = "Environment to add to each resource name and tag"
}


variable "vnet_address_space" {
  type        = string
  description = "Address space for the VNet container the cluster"
}

variable "admin_user_name" {
  type        = string
  description = "User Account Name for SSH access to nodes"
}

variable "admin_public_ssh_key" {
  type        = string
  sensitive   = true
  description = "Public SSH Key for remote admin access to nodes"
}


variable "default_node_pool_vm_size" {
  type        = string
  description = "Azure VM Size for the default node pool"

}

variable "authorized_ips" {
  description = "IP Addresses with access to the Kubernetes API"
}