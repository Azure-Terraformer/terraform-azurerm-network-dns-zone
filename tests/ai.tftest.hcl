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
    source = "./examples/ai"
  }

  variables {
    location    = "eastus2"
    name_prefix = "tftest"
  }

}
