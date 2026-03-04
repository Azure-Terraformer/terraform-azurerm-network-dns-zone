module "dns" {

  source = "../../modules/multiple"

  resource_group_name  = var.resource_group_name
  virtual_network_id   = var.virtual_network_id
  registration_enabled = var.registration_enabled
  tags                 = var.tags
  zones = {
    openai = "privatelink.openai.azure.com"
    cog    = "privatelink.cognitiveservices.azure.com"
    ais    = "privatelink.services.ai.azure.com"
  }
}
