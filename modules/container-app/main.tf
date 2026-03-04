locals {
  # Container Apps private DNS zone is region-scoped:
  # privatelink.<region>.azurecontainerapps.io
  zones_by_region = {
    for r in var.regions :
    r => "privatelink.${r}.azurecontainerapps.io"
  }
}

module "dns" {
  for_each = local.zones_by_region

  # base module at repo root
  source = "../.."

  resource_group_name = var.resource_group_name
  virtual_network_id  = var.virtual_network_id

  zone_name = each.value
  link_name = "${var.name_prefix}-containerapps-${each.key}"

  registration_enabled = var.registration_enabled
  tags                 = var.tags
}
