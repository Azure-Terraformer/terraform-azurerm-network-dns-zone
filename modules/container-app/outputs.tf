output "zones" {
  description = "Map of region => zone name created."
  value       = { for r, m in module.dns : r => m.private_dns_zone_name }
}

output "zone_ids" {
  description = "Map of region => Private DNS Zone ID."
  value       = { for r, m in module.dns : r => m.private_dns_zone_id }
}

output "vnet_link_ids" {
  description = "Map of region => VNet link ID."
  value       = { for r, m in module.dns : r => m.vnet_link_id }
}
