
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
