variable "lg_name" {
  type        = string
  description = "Log Analytics name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}
variable "environment" {
  type        = string
  description = "environment name"
}

############################
# log analytics
############################

variable "sku" {
  type = string
}

variable "retention_in_days" {
  type = string
}