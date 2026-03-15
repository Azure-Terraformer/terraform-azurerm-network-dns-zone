output "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone."
  value       = azurerm_private_dns_zone.this.id
}

output "private_dns_zone_name" {
  description = "The name of the Private DNS Zone."
  value       = azurerm_private_dns_zone.this.name
}

output "vnet_link_id" {
  description = "The ID of the Virtual Network Link to the Private DNS Zone."
  value       = azurerm_private_dns_zone_virtual_network_link.this.id
}
