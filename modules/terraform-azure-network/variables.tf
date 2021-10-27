variable "vnet_name" {
  description = "Name of the vnet to create"
  type = string
  # default = "osim_prod_vnet"
}

variable "location" {
  description = "location of the vnet to create"
  type = string
  # default = "location"
}
variable "environment" {
  description = "environment of the vnet to create"
  type = string
  # default = "prod"
}

variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type = string
  # default = "OSIM"
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  # default     = "10.246.0.0/23"
}

variable "address_prefixes" {
  description = "The address prefix to use for the subnet."
  # default     = "10.246.1.0/24"
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type = string
  # default = "osim_prod_subnet"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ApplicationName = "osim_prod"
  }
}

# variable "vnet_subnet_id" {
#   type = string
#   # default = "osim_prod_subnet"
# }

variable "nb_instances" {
  description = "Specify the number of vm instances"
  # default     = "1"
}


variable "vm_hostname" {
  description = "vm_hostname."
  # default     = false
}

# variable "vnet_subnet_id" {
#   description = "The subnet id of the virtual network where the virtual machines will reside."
#   type        = string
#   default     = 1

# }