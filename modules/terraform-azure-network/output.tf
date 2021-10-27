output "subnet" {
  value = "${azurerm_subnet.subnet.id}"
}

# output "network_interface_ids" {
#   value = "${azurerm_network_interface.vm.id}"
# }

output "network_interfaces" {
  value = [
    for nic in azurerm_network_interface.vm1 :
    {
      id                          = nic.id
      applied_dns_servers         = nic.applied_dns_servers
      internal_domain_name_suffix = nic.internal_domain_name_suffix
      mac_address                 = nic.mac_address
      private_ip_address          = nic.private_ip_address
      private_ip_addresses        = nic.private_ip_addresses
      virtual_machine_id          = nic.virtual_machine_id
    }
  ]
}

output "subnet_id" {
  description = "The ID of the Network Interface."
  value       = azurerm_subnet.subnet.id
}
