terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
  backend "azurerm" {} # Overrided by environmentylized backend
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  # storage_use_azuread        = true
}

resource "azurerm_resource_group" "containers" {
  name     = "RG-${var.location_upper}-${var.env_letter_upper}-CONTAINERS"
  location = var.location

  tags = {
    ApplicationName           = "azure-containers"
    ApplicationProcessOwner   = "remy.trompier@hcuge.ch"
    ApplicationTechnicalOwner = "remy.trompier@hcuge.ch"
    DirectionName             = "dsi"
    BusinessDescription       = "Azure Containers resources"
    UnderRegulation           = false
    PopulationType            = "External"
    Region                    = var.location_upper
    EnvironmentName           = var.env_name
  }
}