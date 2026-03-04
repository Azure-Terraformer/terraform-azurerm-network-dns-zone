locals {
  zones = {
    for region, _display in var.locations :
    region => "privatelink.${region}.${var.domain_suffix}"
  }
}

# Reuse your base module (one zone + one vnet link)
module "dns" {

  source = "../../modules/multiple"

  resource_group_name  = var.resource_group_name
  virtual_network_id   = var.virtual_network_id
  registration_enabled = var.registration_enabled
  tags                 = var.tags
  zones                = local.zones
}
