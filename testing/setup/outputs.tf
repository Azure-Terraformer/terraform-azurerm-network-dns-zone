output "resource_group_name" {
  value = azurerm_resource_group.test.name
}

output "virtual_network_id" {
  value = azurerm_virtual_network.test.id
}

output "location" {
  value = azurerm_resource_group.test.location
}
