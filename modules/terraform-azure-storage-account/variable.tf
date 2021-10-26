variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type = string
  # default = "OSIM"
}

variable "location" {
  description = "The name of the location in which the resources will be created"
  type = string
  # default = "west US"
}
variable "environment" {
  description = "The name of the environment in which the resources will be created"
  type = string
  # default = "prod"
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  type = string
  # default = "Premium"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS"
  type = string
  # default = "LRS"
}

variable "storage_name" {
  description = "Storage Name"
  type = string
  # default = "osimprod"
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
  # default = "prod"

  default = {
    source = "osim_prod"
  }
}

