# Uses Terraform's native test framework (terraform test)
# Mocking requires Terraform >= 1.7.0
# Docs: https://developer.hashicorp.com/terraform/language/tests/mocking

mock_provider "azurerm" {}

run "creates_zone_and_vnet_link_v4_64" {
  command = plan

  module {
    source = "./examples/baseline-v4.64"
  }

  variables {
    location    = "eastus"
    name_prefix = "privdns-test"
  }
}
