terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.82.0"
    }
  }
  # Terraform State Storage to Azure Storage Container
  # backend "azurerm" {
  #   resource_group_name   = "${var.resource_group_name}-${var.environment}"
  #   storage_account_name  = var.storage_account_name
  #   container_name        = var.container_name
  #   key                   = var.key
  # }  
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group_name" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
}

module "osim-azure-storage-account" {
  source = "./modules/terraform-azure-storage-account"
  # name                     = "buyinnov${var.storage_name}${lower(random_id.sa.hex)}"
  resource_group_name      = azurerm_resource_group.resource_group_name.name
  location                 = azurerm_resource_group.resource_group_name.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  storage_name             = var.storage_name
  # tags                     = var.tags
  environment = var.environment
  depends_on  = [azurerm_resource_group.resource_group_name]

}

module "terraform-azure-network" {
  source              = "./modules/terraform-azure-network"
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.resource_group_name.name
  location            = var.location
  address_space       = [var.address_space]
  tags                = var.tags

  address_prefixes = var.address_prefixes
  subnet_names     = var.subnet_names
  # virtual_network_name = azurerm_virtual_network.vnet.name
  # service_endpoints = ["Microsoft.Sql"]
  vm_hostname    = var.vm_hostname
  nb_instances   = var.nb_instances
  environment    = var.environment

  # subnet_id = module.terraform-azure-network.subnet_id

  depends_on = [azurerm_resource_group.resource_group_name]

}

module "terraform-azure-virtual-machine" {
  source                        = "./modules/terraform-azure-virtual-machine"
  resource_group_name           = azurerm_resource_group.resource_group_name.name
  location                      = azurerm_resource_group.resource_group_name.location
  vm_hostname                   = var.vm_hostname
  vm_size                       = var.vm_size
  delete_os_disk_on_termination = var.delete_os_disk_on_termination
  vm_os_id                      = var.vm_os_id
  vm_os_publisher               = var.vm_os_publisher
  vm_os_offer                   = var.vm_os_offer
  vm_os_sku                     = var.vm_os_sku
  vm_os_version                 = var.vm_os_version
  is_windows_image              = var.is_windows_image
  nb_instances                  = var.nb_instances
  vm_os_simple                  = var.vm_os_simple
  storage_account_type          = var.storage_account_type
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  # boot_diagnostics              = var.boot_diagnostics
  # blob_storage_url              = var.blob_storage_url
  environment = var.environment

  network_interface_ids = [for n in module.terraform-azure-network.network_interfaces : n.id]
  depends_on = [azurerm_resource_group.resource_group_name]

}

# module "terraform-log-analytics" {
#   source              = "./modules/terraform-log-analytics"
#   resource_group_name = azurerm_resource_group.resource_group_name.name
#   # location                      = azurerm_resource_group.resource_group_name.location
#   sku               = var.sku
#   retention_in_days = var.retention_in_days
#   lg_name           = var.lg_name
#   environment       = var.environment
#   depends_on        = [azurerm_resource_group.resource_group_name]

# }