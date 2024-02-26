variable "resource_group_name" {
    description = "A container that holds related resources for an Azure solution"
    default = "kubernetes-project"
  }

variable "location" {
    description = "Azure datacenter location, where resources will be deployed"
    default     = "West Europe"
  }

variable "storage_account_name" {
    description = "The name of the storage account for the helm repo blob"
    default = "helm-repo"
  }

variable "storage_container_name" {
    description = "container inside the storage account to store the helm repo"
    default     = "helm-repo-container"
  }