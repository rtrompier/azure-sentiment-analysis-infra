resource "azurerm_load_test" "load_test" {
  name                = "lt-test-rtrm"
  resource_group_name = azurerm_resource_group.containers.name
  location            = "northeurope"
}