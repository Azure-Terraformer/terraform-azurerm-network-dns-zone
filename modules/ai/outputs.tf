output "zones" {
  description = "Map of endpoint => zone name created."
  value       = module.dns.zones
}

output "zone_ids" {
  description = "Map of endpoint => Private DNS Zone ID."
  value       = module.dns.zone_ids
}

output "vnet_link_ids" {
  description = "Map of endpoint => VNet link ID."
  value       = module.dns.vnet_link_ids
}
