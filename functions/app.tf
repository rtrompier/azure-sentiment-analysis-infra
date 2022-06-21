resource "azurerm_storage_account" "accounts" {
  name                              = "aswedappsextrtrmtest"
  resource_group_name               = azurerm_resource_group.functions.name
  location                          = azurerm_resource_group.functions.location
  account_tier                      = "Standard"
  account_replication_type          = "ZRS"
  shared_access_key_enabled         = true
  infrastructure_encryption_enabled = true
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"

  blob_properties {
    versioning_enabled       = true
    last_access_time_enabled = true
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }

  tags = {
    Tier = "Backend"
  }
}

resource "azurerm_service_plan" "functions" {
  name                = "sp-azure-functions-example"
  resource_group_name = azurerm_resource_group.functions.name
  location            = azurerm_resource_group.functions.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_function_app" "sentiment-analysis" {
  name                       = "azure-sentiment-analysis"
  location                   = azurerm_resource_group.functions.location
  resource_group_name        = azurerm_resource_group.functions.name
  app_service_plan_id        = azurerm_service_plan.functions.id
  storage_account_name       = azurerm_storage_account.accounts.name
  storage_account_access_key = azurerm_storage_account.accounts.primary_access_key
  os_type                    = "linux"
  version                    = "~4"
  https_only                 = true

  app_settings {
    FUNCTIONS_WORKER_RUNTIME = "python"
  }

  site_config {
    http2_enabled    = true
    linux_fx_version = "python|3.9"
  }
}