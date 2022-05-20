resource "azurerm_resource_group" "rg-group" {
        name = var.rs_group_name
        location = var.rs_group_location
}
