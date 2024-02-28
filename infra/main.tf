# Main Terraform

# data "azurerm_resource_group" "kubernetes-project" {
#   name = "kubernetes-project"
# }


module "azure_blob" {
  source = "./modules/azure-blob"

#   resource_group_name = data.azurerm_resource_group.kubernetes-project

}

module "azure_vnet" {
  source = "./modules/azure-vnet"

#   resource_group_name = data.azurerm_resource_group.kubernetes-project
}

module "azure_mysql" {
  source = "./modules/azure-sql"

#   resource_group_name = data.azurerm_resource_group.kubernetes-project
}

module "aks" {
  source = "./modules/azure-aks"

#   resource_group_name = data.azurerm_resource_group.kubernetes-project
#   vnet_subnet_id = module.azure_vnet.subnetA_id
#   pod_subnet_id = module.azure_vnet.subnetB_id
}