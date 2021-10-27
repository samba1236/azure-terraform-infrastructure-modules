variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type        = string
  # default     = "OSIM"
}

variable "vm_hostname" {
  type        = string
  description = "This variable defines the VM Name"
  # default     = "osimvm"
}

variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  # default     = "Central US"
}

variable "environment" {
  type        = string
  description = "Azure environment where all these resources will be provisioned"
  # default     = "prod"
}

# Azure VM Size
variable "vm_size" {
  type        = string
  description = "This variable defines the VM size"
  # default     = "Standard_D2_v2"
}

variable "delete_os_disk_on_termination" {
  type        = bool
  description = "Delete datadisk when machine is terminated"
  # default     = false
}

variable "vm_os_simple" {
  description = "This variable allows to use a simple name to reference Linux or Windows operating systems. When used, you can ommit the vm_os_publisher, vm_os_offer and vm_os_sku. The supported values are: 'UbuntuServer', 'WindowsServer', 'RHEL', 'openSUSE-Leap', 'CentOS','Debian','CoreOS','SLES'"
  type = string
  # default = "UbuntuServer"
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
  # default     = "latest"
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed"
  # default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure"
  # default     = "Sachin@123456789"
}

# variable "boot_diagnostics" {
#   type        = bool
#   description = "(Optional) Enable or Disable boot diagnostics"
#   # default     = false
# }

# variable "blob_storage_url" {
#   description = "Blob storage URL"
# }

variable "storage_account_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
  # default     = "Premium_LRS"
}

variable "nb_instances" {
  description = "Specify the number of vm instances"
  # default     = "1"
}

variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  # default     = false
}


variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "osim_prod"
  }
}

variable "network_interface_ids" {
  type    = list(string)
  description = "Azure network_interface_ids"
  # default     = ""
}