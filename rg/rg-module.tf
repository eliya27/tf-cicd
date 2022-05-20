# Resource module
resource "azurerm_resource_group" "rg-module" {
     name = var.resource_group_name
     location = var.resource_group_location
  
}
