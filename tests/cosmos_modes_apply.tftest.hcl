variables {
  location    = "eastus"
  name_prefix = "tf-test-cosmos-dns"
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
run "apply_cosmos_all" {
  command = apply

  module {
    source = "./modules/cosmos"
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

    # apis intentionally omitted => null default => ALL zones
  }

  assert {
    condition     = length(run.apply_cosmos_all.zones) == 5
    error_message = "Expected 5 Cosmos DNS zones (sql, mongo, cassandra, gremlin, table)."
  }

  assert {
    condition     = run.apply_cosmos_all.zones["sql"] == "privatelink.documents.azure.com"
    error_message = "SQL zone name mismatch in ALL mode."
  }

  assert {
    condition     = run.apply_cosmos_all.zones["mongo"] == "privatelink.mongo.cosmos.azure.com"
    error_message = "Mongo zone name mismatch in ALL mode."
  }

  assert {
    condition     = length(run.apply_cosmos_all.vnet_link_ids) == 5
    error_message = "Expected 5 VNet links in ALL mode."
  }
}

# -------------------------
# Mode B: create SUBSET
# -------------------------
run "apply_cosmos_subset" {
  command = apply

  module {
    source = "./modules/cosmos"
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

    apis = ["sql", "mongo"]
  }

  assert {
    condition     = length(run.apply_cosmos_subset.zones) == 2
    error_message = "Expected only 2 Cosmos DNS zones in SUBSET mode."
  }

  assert {
    condition     = contains(keys(run.apply_cosmos_subset.zones), "sql") && contains(keys(run.apply_cosmos_subset.zones), "mongo")
    error_message = "SUBSET mode did not include expected keys (sql, mongo)."
  }

  assert {
    condition     = !contains(keys(run.apply_cosmos_subset.zones), "gremlin")
    error_message = "SUBSET mode unexpectedly included gremlin."
  }

  assert {
    condition     = run.apply_cosmos_subset.zones["sql"] == "privatelink.documents.azure.com"
    error_message = "SQL zone name mismatch in SUBSET mode."
  }

  assert {
    condition     = run.apply_cosmos_subset.zones["mongo"] == "privatelink.mongo.cosmos.azure.com"
    error_message = "Mongo zone name mismatch in SUBSET mode."
  }

  assert {
    condition     = length(run.apply_cosmos_subset.vnet_link_ids) == 2
    error_message = "Expected 2 VNet links in SUBSET mode."
  }
}
