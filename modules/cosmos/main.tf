locals {
  zones = {
    sql       = "privatelink.documents.azure.com"
    mongo     = "privatelink.mongo.cosmos.azure.com"
    cassandra = "privatelink.cassandra.cosmos.azure.com"
    gremlin   = "privatelink.gremlin.cosmos.azure.com"
    table     = "privatelink.table.cosmos.azure.com"
  }

  selected = (
    var.apis == null
    ? local.zones
    : { for k, v in local.zones : k => v if contains(var.apis, k) }
  )
}

module "dns" {
  for_each = local.selected

  # base module at repo root
  source = "../.."

  resource_group_name = var.resource_group_name
  virtual_network_id  = var.virtual_network_id

  zone_name = each.value
  link_name = "${var.name_prefix}-cosmos-${each.key}"

  registration_enabled = var.registration_enabled
  tags                 = var.tags
}
