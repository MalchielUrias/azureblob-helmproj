resource "azurerm_storage_account" "helm-repo" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "helm-repo" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.helm-repo.name
  container_access_type = "private"
}

# resource "azurerm_storage_blob" "helm-repo" {
#   name                   = var.helm_chart
#   storage_account_name   = var.blob_name
#   storage_container_name = azurerm_storage_container.helm-repo.name
#   type                   = "Block"
#   source                 = "some-local-file.zip"
# }