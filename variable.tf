variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type        = string
  default     = "OSIM"
}
variable "location" {
  description = "The name of the location in which the resources will be created"
  type        = string
  default     = "West Europe"
}
variable "environment" {
  description = "The env"
  type        = string
  default     = "prod"
}

############################
#  tfstate storage container
############################

# variable "storage_account_name" {
#   description = "The env"
#   type        = string
#   default     = "osimprodtfstatecontainer"
# }
# variable "container_name" {
#   description = "The env"
#   type        = string
#   default     = "tfstatefile"
# }
# variable "key" {
#   description = "The env"
#   type        = string
#   default     = "osim.prd.terraform.tfstate"
# }

############################
# VM storage Account
############################

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  type        = string
  default     = "Premium"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS"
  type        = string
  default     = "LRS"
}

variable "storage_name" {
  description = "Storage Name"
  type        = string
  default     = "osimprod"
}


############################
# VM Network
############################

variable "vm_hostname" {
  description = "Name of the vm_hostname"
  type        = string
  default     = "osimvm"
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "osim_prod_vnet"
}
variable "address_space" {
  type        = string
  description = "The address space that is used by the virtual network."
  default     = "10.246.0.0/23"
}

variable "address_prefixes" {
  type        = string
  description = "The address prefix to use for the subnet."
  default     = "10.246.1.0/24"
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = string
  default     = "osim_prod_subnet"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ApplicationName = "osim_prod"
  }
}

variable "storage_account_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
  default     = "Premium_LRS"
}

# variable "subnet_id" {
#   type    = string
#   # default = "osimprodsubnet"
# }


variable "nb_instances" {
  description = "Specify the number of vm instances"
  default     = "1"
}

variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  default     = false
}

# variable "network_interface_ids" {
#   type        = list(string)
#   description = "Azure network_interface_ids"
#   # default     = ""
# }

############################
# VM
############################
variable "vm_size" {
  type        = string
  description = "This variable defines the VM size"
  default     = "Standard_DS1_v2"
}

variable "delete_os_disk_on_termination" {
  type        = bool
  description = "Delete datadisk when machine is terminated"
  default     = false
}

variable "vm_os_simple" {
  description = "This variable allows to use a simple name to reference Linux or Windows operating systems. When used, you can ommit the vm_os_publisher, vm_os_offer and vm_os_sku. The supported values are: 'UbuntuServer', 'WindowsServer', 'RHEL', 'openSUSE-Leap', 'CentOS','Debian','CoreOS','SLES'"
  type        = string
  default     = "UbuntuServer"
}

variable "vm_os_id" {
  description = "The resource ID of the image that you want to deploy if you are using a custom image.Note, need to provide is_windows_image = true for windows custom images."
  default     = ""
}


variable "vm_os_publisher" {
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_offer" {
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_sku" {
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_version" {
  description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "latest"
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed"
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure"
  default     = "Sachin@123456789"
}

# variable "boot_diagnostics" {
#   type        = bool
#   description = "(Optional) Enable or Disable boot diagnostics"
#   default     = false
# }

# variable "blob_storage_url" {
#   description = "Blob storage URL"
# }


############################
# log analytics
############################

# variable "lg_name" {
#   type        = string
#   description = "Log Analytics name"
#   default     = "osimVmLogAna"
# }

# variable "sku" {
#   type    = string
#   default = "Premium"
# }

# variable "retention_in_days" {
#   type    = string
#   default = "30"
# }