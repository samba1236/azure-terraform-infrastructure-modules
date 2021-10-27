# provider "azurerm" {
#   features {}
# }

#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  name     = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_names
  resource_group_name  = data.azurerm_resource_group.network.name
  address_prefix       = var.address_prefixes
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints = ["Microsoft.Sql"]
}

resource "azurerm_network_security_group" "vm" {
  name                          = "${var.vm_hostname}-nsg"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags
}

resource "azurerm_network_interface" "vm1" {
  count                         = var.nb_instances
  name                          = "${var.vm_hostname}-nic"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  ip_configuration {
    name                          = "${var.vm_hostname}-ip"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address            = ""
  }
  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "test" {
  count                           = var.nb_instances
  network_interface_id            = azurerm_network_interface.vm1[count.index].id
  network_security_group_id       = azurerm_network_security_group.vm.id
}

