variables {
  location    = "eastus"
  name_prefix = "tf-test-ca-dns"
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

run "apply_containerapps_regions" {
  command = apply

  module {
    source = "./modules/container-app"
  }

  variables {
    resource_group_name = run.setup_network.resource_group_name
    virtual_network_id  = run.setup_network.virtual_network_id
    name_prefix         = var.name_prefix

    regions = ["eastus", "westus2"]

    tags = {
      purpose = "tf-test"
      service = "containerapps"
    }
  }

  assert {
    condition     = length(run.apply_containerapps_regions.zones) == 2
    error_message = "Expected 2 Container Apps private DNS zones (one per region)."
  }

  assert {
    condition     = run.apply_containerapps_regions.zones["eastus"] == "privatelink.eastus.azurecontainerapps.io"
    error_message = "eastus zone name mismatch."
  }

  assert {
    condition     = run.apply_containerapps_regions.zones["westus2"] == "privatelink.westus2.azurecontainerapps.io"
    error_message = "westus2 zone name mismatch."
  }

  assert {
    condition     = length(run.apply_containerapps_regions.vnet_link_ids) == 2
    error_message = "Expected 2 VNet links (one per region)."
  }
}
