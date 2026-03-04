
output "zone_names" {
  value = { for k, m in module.dns : k => m.private_dns_zone_name }
}

output "zone_ids" {
  value = { for k, m in module.dns : k => m.private_dns_zone_id }
}

output "vnet_link_ids" {
  value = { for k, m in module.dns : k => m.vnet_link_id }
}
