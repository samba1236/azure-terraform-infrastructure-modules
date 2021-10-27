# provider "azurerm" {
#   features {}
# }

resource "random_id" "sa" {
  keepers = {
    storage_name = var.storage_name
  }
  byte_length = 2
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.storage_name}${lower(random_id.sa.hex)}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = var.tags
}