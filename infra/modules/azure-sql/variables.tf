variable "resource_group_name" {
    description = "A container that holds related resources for an Azure solution"
    default = "kubernetes-project"
  }

variable "location" {
    description = "Azure datacenter location, where resources will be deployed"
    default     = "West Europe"
  }

variable "sqldb_name" {
  default = "k8sapp-sqldb"
}

variable "sqlserver_name" {
  default = "k8sapp-sqlserver"
}