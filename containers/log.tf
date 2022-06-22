resource "random_integer" "law_id" {
  min = 1
  max = 100
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "law-${var.location_lower}-${var.env_letter_lower}-test-rtrm-${random_integer.law_id.result}"
  location            = azurerm_resource_group.containers.location
  resource_group_name = azurerm_resource_group.containers.name
  sku                 = "PerGB2018"
}

data "azurerm_monitor_diagnostic_categories" "app_service_diag_cat" {
  resource_id = azurerm_app_service.sentiment_analysis.id
}

resource "azurerm_monitor_diagnostic_setting" "gateway_diag" {
  name                       = "monitoring"
  target_resource_id         = azurerm_app_service.sentiment_analysis.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.app_service_diag_cat.logs
    content {
      category = log.value
      enabled  = true

      retention_policy {
        enabled = false
      }
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}