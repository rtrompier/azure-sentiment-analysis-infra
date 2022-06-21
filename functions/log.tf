resource "random_integer" "law_id" {
  min = 1
  max = 100
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "law-${var.location_lower}-${var.env_letter_lower}-hug-functions-${random_integer.law_id.result}"
  location            = azurerm_resource_group.functions.location
  resource_group_name = azurerm_resource_group.functions.name
  sku                 = "PerGB2018"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
# Tell our azure function that it needs to log to the log analytics workspace
resource "azurerm_monitor_diagnostic_setting" "mds_functions" {
  name                       = "mds-${var.location_lower}-${var.env_letter_lower}-hug-functions"
  target_resource_id         = azurerm_function_app.sentiment_analysis.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  log {
    category = "FunctionAppLogs"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  
  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}