# By default, run blocks execute with command = apply (integration-style).
# We'll keep it explicit for clarity. :contentReference[oaicite:1]{index=1}

variables {
  location    = "eastus"
  name_prefix = "privdns-test"
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

run "apply_module_under_test" {
  command = apply

  # This run uses the module in the repo root by default (no module {} block).
  # We pass in the RG/VNet created in setup via run.<name> outputs. :contentReference[oaicite:2]{index=2}
  variables {
    resource_group_name  = run.setup_network.resource_group_name
    virtual_network_id   = run.setup_network.virtual_network_id
    zone_name            = "privatelink.blob.core.windows.net"
    link_name            = "${var.name_prefix}-blob"
    registration_enabled = false
    tags = {
      purpose = "tf-test"
    }
  }

  # Update these resource addresses if your module uses different names.
  assert {
    condition     = azurerm_private_dns_zone.this.name == "privatelink.blob.core.windows.net"
    error_message = "DNS zone name was not created as expected."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.this.virtual_network_id == run.setup_network.virtual_network_id
    error_message = "VNet link did not attach to the expected VNet."
  }
}
