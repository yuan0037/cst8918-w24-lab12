output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.backendstate.name
}

output "container_name" {
  value = azurerm_storage_container.backendstate.name
}

output "primary_access_key" {
  value = azurerm_storage_account.backendstate.primary_access_key
  sensitive = true
}
