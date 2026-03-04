locals {
  # Storage Private Link DNS zones
  # Reference: Azure Storage private endpoints have different zones per service.
  zones = {
    blob  = "privatelink.blob.core.windows.net"
    queue = "privatelink.queue.core.windows.net"
    table = "privatelink.table.core.windows.net"
    file  = "privatelink.file.core.windows.net"
    dfs   = "privatelink.dfs.core.windows.net"
    web   = "privatelink.web.core.windows.net"
  }

  # If endpoints is null => all zones
  selected = (
    var.endpoints == null
    ? local.zones
    : { for k, v in local.zones : k => v if contains(var.endpoints, k) }
  )
}

# Reuse your base module (one zone + one vnet link)
module "dns" {
  for_each = local.selected

  # Adjust path if your base module lives elsewhere
  source = "../../"

  resource_group_name = var.resource_group_name
  virtual_network_id  = var.virtual_network_id

  zone_name = each.value
  link_name = "${var.name_prefix}-storage-${each.key}"

  registration_enabled = var.registration_enabled
  tags                 = var.tags
}
