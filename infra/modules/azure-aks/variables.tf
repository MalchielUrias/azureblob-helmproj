variable "resource_group_name" {
    description = "A container that holds related resources for an Azure solution"
    default = "kubernetes-project"
  }

variable "location" {
    description = "Azure datacenter location, where resources will be deployed"
    default     = "West Europe"
  }

variable "name" {
  default = "k8s-app"
}

variable "default_node_pool_name" {
  default = "k8s-app-nodepool"
}

variable "default_node_pool_vm_size" {
  default = "Standard_D2_v2"
}

variable "vnet_subnet_id" {
  type = string
}

variable "pod_subnet_id" {
  type = string
}

variable "default_node_pool_node_count" {
  default = 2
}


