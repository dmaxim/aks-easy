
variable "namespace" {
    type = string
    description = "Namespace to include in all resource names"
}

variable "location" {
    type = string
    description = "Azure region for all resources"
}

variable "environment" {
    type = string
    description = "Environment to add to each resource name and tag"
}