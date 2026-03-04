module "dns" {
  for_each = var.zones

  # points to the module under test (repo root)
  source = "../.."

  resource_group_name = var.resource_group_name
  virtual_network_id  = var.virtual_network_id
  zone_name           = each.value
  link_name           = "${var.name_prefix}-${each.key}"

  registration_enabled = var.registration_enabled
  tags                 = var.tags
}
