# provider "azurerm" {
#   features {}
# }

resource "random_id" "this" {
  keepers = {
    rg = "${var.resource_group_name}-${var.environment}"

  }
  byte_length = 5
}

data "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}-${var.environment}"
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = var.lg_name # Globally unique
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  #   lifecycle {
  #   prevent_destroy = true
  # }
}
