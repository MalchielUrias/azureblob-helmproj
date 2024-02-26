# Main Terraform

module "azure_blob" {
  source = "./modules/azure-blob"

}

module "azure_vnet" {
  source = "./modules/azure-vnet"
}

module "azure_mysql" {
  source = "./modules/azure-sql"
}

module "aks" {
  source = "./modules/azure-aks"

  vnet_subnet_id = module.azure_vnet.subnetA.id 
  pod_subnet_id = module.azure_vnet.subnetB.id
}