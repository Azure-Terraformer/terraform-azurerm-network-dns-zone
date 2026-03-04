# Integration test (real Azure apply)
# Demonstrates:
#  - Mode A: endpoints = null (default) => create all storage zones
#  - Mode B: endpoints = ["blob","dfs"] => create subset

variables {
  location    = "eastus"
  name_prefix = "tf-test-storage-dns"
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

# -------------------------
# Mode A: create ALL zones
# -------------------------
run "apply_storage_all" {
  command = apply

  module {
    source = "./modules/storage"
  }

  variables {
    resource_group_name  = run.setup_network.resource_group_name
    virtual_network_id   = run.setup_network.virtual_network_id
    name_prefix          = var.name_prefix
    registration_enabled = false
    tags = {
      purpose = "tf-test"
      mode    = "all"
    }

    # endpoints intentionally omitted => null default => ALL zones
  }

  # Expect 6 zones
  assert {
    condition     = length(run.apply_storage_all.zones) == 6
    error_message = "Expected 6 storage DNS zones (blob, queue, table, file, dfs, web)."
  }

  # Spot-check a couple zone names
  assert {
    condition     = run.apply_storage_all.zones["blob"] == "privatelink.blob.core.windows.net"
    error_message = "Blob zone name mismatch in ALL mode."
  }

  assert {
    condition     = run.apply_storage_all.zones["dfs"] == "privatelink.dfs.core.windows.net"
    error_message = "DFS zone name mismatch in ALL mode."
  }

  # Ensure each zone got a VNet link too
  assert {
    condition     = length(run.apply_storage_all.vnet_link_ids) == 6
    error_message = "Expected 6 VNet links in ALL mode."
  }
}

# -------------------------
# Mode B: create SUBSET
# -------------------------
run "apply_storage_subset" {
  command = apply

  module {
    source = "./modules/storage"
  }

  variables {
    resource_group_name  = run.setup_network.resource_group_name
    virtual_network_id   = run.setup_network.virtual_network_id
    name_prefix          = "${var.name_prefix}-subset"
    registration_enabled = false
    tags = {
      purpose = "tf-test"
      mode    = "subset"
    }

    endpoints = ["blob", "dfs"]
  }

  # Expect 2 zones
  assert {
    condition     = length(run.apply_storage_subset.zones) == 2
    error_message = "Expected only 2 storage DNS zones in SUBSET mode."
  }

  # Must include blob & dfs (and only those)
  assert {
    condition     = contains(keys(run.apply_storage_subset.zones), "blob") && contains(keys(run.apply_storage_subset.zones), "dfs")
    error_message = "SUBSET mode did not include expected keys (blob, dfs)."
  }

  assert {
    condition     = !contains(keys(run.apply_storage_subset.zones), "queue")
    error_message = "SUBSET mode unexpectedly included queue."
  }

  assert {
    condition     = run.apply_storage_subset.zones["blob"] == "privatelink.blob.core.windows.net"
    error_message = "Blob zone name mismatch in SUBSET mode."
  }

  assert {
    condition     = run.apply_storage_subset.zones["dfs"] == "privatelink.dfs.core.windows.net"
    error_message = "DFS zone name mismatch in SUBSET mode."
  }

  assert {
    condition     = length(run.apply_storage_subset.vnet_link_ids) == 2
    error_message = "Expected 2 VNet links in SUBSET mode."
  }
}
