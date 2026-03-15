module "setup" {
  source = "../../testing/setup"

  name_prefix = var.name_prefix
  location    = var.location
}

module "dns" {

  # points to the module under test (repo root)
  source = "../../modules/cosmos"

  resource_group_name  = module.setup.resource_group_name
  virtual_network_id   = module.setup.virtual_network_id
  registration_enabled = false

}
