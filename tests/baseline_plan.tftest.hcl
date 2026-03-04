# Uses Terraform's native test framework (terraform test)
# Mocking requires Terraform >= 1.7.0
# Docs: https://developer.hashicorp.com/terraform/language/tests/mocking

mock_provider "azurerm" {}

run "creates_zone_and_vnet_link" {
  command = plan

  variables {
    resource_group_name  = "rg-test"
    virtual_network_id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test"
    zone_name            = "privatelink.blob.core.windows.net"
    link_name            = "app-dev-storage-blob"
    registration_enabled = false
    tags = {
      env = "test"
    }
  }

  # Zone name should match input
  assert {
    condition     = azurerm_private_dns_zone.this.name == "privatelink.blob.core.windows.net"
    error_message = "Private DNS Zone name didn't match expected."
  }

  # Link should use our name and inputs
  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.this.name == "app-dev-storage-blob"
    error_message = "VNet link name didn't match expected."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.this.registration_enabled == false
    error_message = "registration_enabled should be false by default."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.this.virtual_network_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test"
    error_message = "virtual_network_id didn't match expected."
  }
}
