variables {
  location    = "eastus"
  name_prefix = "tf-multi-privdns"
}

provider "azurerm" {
  features {}
}

run "setup_network" {
  command = apply

  module {
    source = "./testing/setup"
  }

  variables {
    location    = var.location
    name_prefix = var.name_prefix
  }
}

run "apply_multiple_dns_zones" {
  command = apply

  module {
    source = "./testing/multi"
  }

  variables {
    resource_group_name = run.setup_network.resource_group_name
    virtual_network_id  = run.setup_network.virtual_network_id
    name_prefix         = var.name_prefix

    tags = {
      purpose = "tf-test"
    }

    zones = {
      cosmosdb     = "privatelink.documents.azure.com"
      eventgrid    = "privatelink.eventgrid.azure.com"
      keyvault     = "privatelink.vaultcore.azure.net"
      storage_blob = "privatelink.blob.core.windows.net"
      service_bus  = "privatelink.servicebus.windows.net"
    }
  }

  # sanity: we created 5 instances
  assert {
    condition     = length(run.apply_multiple_dns_zones.zone_ids) == 5
    error_message = "Expected 5 Private DNS Zones to be created."
  }

  # spot-check a couple of outputs
  assert {
    condition     = run.apply_multiple_dns_zones.zone_names["storage_blob"] == "privatelink.blob.core.windows.net"
    error_message = "storage_blob zone name mismatch."
  }

  assert {
    condition     = run.apply_multiple_dns_zones.zone_names["keyvault"] == "privatelink.vaultcore.azure.net"
    error_message = "keyvault zone name mismatch."
  }

  # ensure each instance created a vnet link too
  assert {
    condition     = length(run.apply_multiple_dns_zones.vnet_link_ids) == 5
    error_message = "Expected 5 VNet links to be created."
  }
}
