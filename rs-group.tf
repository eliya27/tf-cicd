resource "azurerm_resource_group" "rs-group" {
        name = var.rs_group_name
        location = var.rs_group_location
}
