variables {
  location    = "eastus"
  name_prefix = "tf-test-ca-dns"
}

provider "azurerm" {
  features {}
}

run "act" {
  command = apply

  module {
    source = "./examples/keyvault"
  }

  variables {
    location    = "eastus2"
    name_prefix = "tftest"
  }

}
