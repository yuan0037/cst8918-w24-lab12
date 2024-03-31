terraform {
  required_version = "~> 1.5"

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

resource "azurerm_resource_group" "rg" {
  name     = "yuan0037-githubactions-rg"
  location = "canadacentral"
}

resource "azurerm_storage_account" "backendstate" {
  name                     = "yuan0037githubactions01"
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
  # Provisioner to set ARM_ACCESS_KEY environment variable after resource creation
    provisioner "local-exec" {
        command = "export ARM_ACCESS_KEY=$(terraform output -raw primary_access_key)"
    }
}