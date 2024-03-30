terraform {
  required_version = "~> 1.5"

  backend "azurerm" {
    resource_group_name  = "yuan0037-githubactions-rg"
    storage_account_name = "yuan0037githubactions01"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
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
  use_oidc = true
}

provider "cloudinit" {
  # Configuration options
}