output "zones" {
  description = "Map of endpoint => zone name created."
  value       = { for k, m in module.dns : k => m.private_dns_zone_name }
}

output "zone_ids" {
  description = "Map of endpoint => Private DNS Zone ID."
  value       = { for k, m in module.dns : k => m.private_dns_zone_id }
}

output "vnet_link_ids" {
  description = "Map of endpoint => VNet link ID."
  value       = { for k, m in module.dns : k => m.vnet_link_id }
}
