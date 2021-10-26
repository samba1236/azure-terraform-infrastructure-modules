output "subnet" {
  value = "${azurerm_subnet.subnet.id}"
}

output "network_interface_ids" {
  value = "${azurerm_network_interface.vm.id}"
}