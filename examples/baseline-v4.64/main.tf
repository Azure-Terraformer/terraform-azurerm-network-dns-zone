module "setup" {
  source = "../../testing/setup"

  name_prefix = var.name_prefix
  location    = var.location
}

module "dns" {
  source = "../.."

  resource_group_name  = module.setup.resource_group_name
  virtual_network_id   = module.setup.virtual_network_id
  zone_name            = "privatelink.blob.core.windows.net"
  link_name            = "storage"
  registration_enabled = false
}
