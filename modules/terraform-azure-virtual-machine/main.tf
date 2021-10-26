# provider "azurerm" {
#   features {}
# }

module "os" {
  source                        = "./os"
  vm_os_simple                  = var.vm_os_simple
}

data "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}-${var.environment}"
}

# resource "azurerm_network_interface" "vm" {
#   name                          = "${var.vm_hostname}-nic"
#   resource_group_name           = "${var.resource_group_name}-${var.environment}"
#   location                      = var.location
# }

resource "azurerm_virtual_machine" "vm-linux" {
  count                         = ! contains(tolist(var.vm_os_simple, var.vm_os_offer), "Windows") && ! var.is_windows_image ? var.nb_instances : 0
  name                          = var.vm_hostname
  resource_group_name           = data.azurerm_resource_group.this.name
  location                      = data.azurerm_resource_group.this.location
  vm_size                       = var.vm_size
  # network_interface_ids         = [element(azurerm_network_interface.vm.*.id, count.index)]
  network_interface_ids         = var.azurerm_network_interface.id
  delete_os_disk_on_termination = var.delete_os_disk_on_termination

  storage_image_reference {
    id                          = var.vm_os_id
    publisher                   = (var.vm_os_id == "") ? coalesce(var.vm_os_publisher, module.os.calculated_value_os_publisher) : ""
    offer                       = (var.vm_os_id == "") ? coalesce(var.vm_os_offer, module.os.calculated_value_os_offer) : ""
    sku                         = (var.vm_os_id == "") ? coalesce(var.vm_os_sku, module.os.calculated_value_os_sku) : ""
    version                     = (var.vm_os_id == "") ? var.vm_os_version : ""
  }

  storage_os_disk {
    name                        = "${var.vm_hostname}-osdisk"
    create_option               = "FromImage"
    caching                     = "ReadWrite"
    managed_disk_type           = var.storage_account_type
  }

  os_profile {
    computer_name               = var.vm_hostname
    admin_username              = var.admin_username
    admin_password              = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags                          = var.tags

  boot_diagnostics {
    enabled                     = var.boot_diagnostics
    # storage_uri                 = var.blob_storage_url
  }
}

