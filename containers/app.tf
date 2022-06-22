resource "azurerm_app_service_plan" "containers" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.containers.location
  resource_group_name = azurerm_resource_group.containers.name

  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
}

resource "azurerm_app_service" "sentiment_analysis" {
  name                = "example-app-service"
  location            = azurerm_resource_group.containers.location
  resource_group_name = azurerm_resource_group.containers.name
  app_service_plan_id = azurerm_app_service_plan.containers.id

  site_config {
    linux_fx_version = "DOCKER|rtrompier/azure-sentiment-analysis:latest"
  }
}