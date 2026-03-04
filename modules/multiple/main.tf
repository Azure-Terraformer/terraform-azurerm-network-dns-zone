
# Reuse your base module (one zone + one vnet link)
module "dns" {
  for_each = var.zones

  # Adjust path if your base module lives elsewhere
  source = "../../"

  resource_group_name = var.resource_group_name
  virtual_network_id  = var.virtual_network_id

  zone_name = each.value
  link_name = each.key

  registration_enabled = var.registration_enabled
  tags                 = var.tags
}
