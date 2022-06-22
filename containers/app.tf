resource "azurerm_app_service_plan" "containers" {
  name                = "sp-test-rtrm"
  location            = azurerm_resource_group.containers.location
  resource_group_name = azurerm_resource_group.containers.name

  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
}

resource "azurerm_app_service" "sentiment_analysis" {
  name                = "as-test-rtrm"
  location            = azurerm_resource_group.containers.location
  resource_group_name = azurerm_resource_group.containers.name
  app_service_plan_id = azurerm_app_service_plan.containers.id
  https_only          = true

  site_config {
    linux_fx_version = "DOCKER|rtrompier/azure-sentiment-analysis:latest"
    http2_enabled    = true
    ftps_state       = "Disabled"
  }

  logs {
    failed_request_tracing_enabled  = true
    detailed_error_messages_enabled = true

    http_logs {
      file_system {
        retention_in_days = 4
        retention_in_mb   = 25
      }
    }
  }
}