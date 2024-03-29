terraform {
  required_version = "~> 1.5"

  backend "azurerm" {
    resource_group_name  = "yuan0037-Default-WestUS3-rg"
    storage_account_name = "yuan0037tfstorage"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.3"
    }
  }
}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
}

provider "cloudinit" {
  # Configuration options
}

variable "resource_prefix" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "yuan0037-lab12"
}

resource "azurerm_resource_group" "rg" {
  name     = "yuan0037-githubactions-rg"
  location = "canadacentral"
}

resource "azurerm_storage_account" "backendstate" {
  name                     = "yuan0037githubactions"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = {
    purpose = "cst8918-w24-lab12"
  }
}

resource "azurerm_storage_container" "backendstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backendstate.name
  container_access_type = "private"
}