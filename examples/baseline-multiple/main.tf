module "setup" {
  source = "../../testing/setup"

  name_prefix = var.name_prefix
  location    = var.location
}

locals {
  zones = {
    cosmosdb     = "privatelink.documents.azure.com"
    eventgrid    = "privatelink.eventgrid.azure.com"
    keyvault     = "privatelink.vaultcore.azure.net"
    storage_blob = "privatelink.blob.core.windows.net"
    service_bus  = "privatelink.servicebus.windows.net"
  }
}

module "dns" {
  for_each = local.zones

  # points to the module under test (repo root)
  source = "../.."

  resource_group_name  = module.setup.resource_group_name
  virtual_network_id   = module.setup.virtual_network_id
  zone_name            = each.value
  link_name            = each.key
  registration_enabled = false

}
