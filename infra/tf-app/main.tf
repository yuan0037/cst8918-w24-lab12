
resource "azurerm_resource_group" "rg" {
  name     = "yuan0037-a12-rg"
  location = "canadacentral"
      provisioner "local-exec" {
        # command = "export subscriptionId=$(az account show --query id -o tsv)"
        command = <<-EOT
                export subscriptionId=$(az account show --query id -o tsv)
                export tenantId=$(az account show --query tenantId -o tsv)
                export resourceGroupName=$(terraform output -raw resource_group_name)
        EOT
    }
}


resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}