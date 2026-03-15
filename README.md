# Overview

Setup DNS Zones for common Azure Services

## Test Status

- Baseline Plan ![baseline-plan](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-baseline-plan.yaml/badge.svg)
- Baseline Apply ![baseline-apply](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-baseline-apply.yaml/badge.svg)
- Baseline Multiple ![baseline-apply-multiple](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-baseline-apply-multiple.yaml/badge.svg)
- Storage ![storage](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-storage.yaml/badge.svg)
- KeyVault ![keyvault](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-keyvault.yaml/badge.svg)
- Cosmos DB ![cosmos](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-cosmos.yaml/badge.svg)
- Container Apps ![container-app](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-container-app.yaml/badge.svg)
- AI Services ![ai](https://github.com/Azure-Terraformer/terraform-azurerm-network-dns-zone/actions/workflows/tftests-ai.yaml/badge.svg)

## Feedback
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.62.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_link_name"></a> [link\_name](#input\_link\_name) | Name for the private DNS zone virtual network link. | `string` | n/a | yes |
| <a name="input_registration_enabled"></a> [registration\_enabled](#input\_registration\_enabled) | Whether auto-registration of VM records in the zone is enabled. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group where the Private DNS Zone will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | VNet ID to link the Private DNS Zone to. | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Private DNS zone name (e.g. privatelink.blob.core.windows.net). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | n/a |
| <a name="output_private_dns_zone_name"></a> [private\_dns\_zone\_name](#output\_private\_dns\_zone\_name) | n/a |
| <a name="output_vnet_link_id"></a> [vnet\_link\_id](#output\_vnet\_link\_id) | n/a |
<!-- END_TF_DOCS -->