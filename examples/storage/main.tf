resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "test" {
  name     = "${var.name_prefix}-rg-${random_string.suffix.result}"
  location = var.location
}

resource "azurerm_virtual_network" "test" {
  name                = "${var.name_prefix}-vnet-${random_string.suffix.result}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.250.0.0/16"]
}

module "dns" {

  # points to the module under test (repo root)
  source = "../../modules/storage"

  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_id   = azurerm_virtual_network.test.id
  registration_enabled = false

}
