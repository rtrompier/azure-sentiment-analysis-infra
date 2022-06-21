resource "azurerm_container_group" "containers" {
  name                = "cg-test-rtrm"
  location            = azurerm_resource_group.containers.location
  resource_group_name = azurerm_resource_group.containers.name
  ip_address_type     = "Public"
  dns_name_label      = "sentiment-analysis"
  os_type             = "Linux"

  container {
    name   = "sentiment-analysis"
    image  = "rtrompier/azure-sentiment-analysis:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}