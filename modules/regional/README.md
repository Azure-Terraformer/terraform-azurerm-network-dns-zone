<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns"></a> [dns](#module\_dns) | ../../modules/multiple | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_suffix"></a> [domain\_suffix](#input\_domain\_suffix) | n/a | `string` | n/a | yes |
| <a name="input_locations"></a> [locations](#input\_locations) | n/a | `set(string)` | n/a | yes |
| <a name="input_registration_enabled"></a> [registration\_enabled](#input\_registration\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group where the Private DNS Zones will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | VNet ID to link the Private DNS Zones to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_link_ids"></a> [vnet\_link\_ids](#output\_vnet\_link\_ids) | Map of endpoint => VNet link ID. |
| <a name="output_zone_ids"></a> [zone\_ids](#output\_zone\_ids) | Map of endpoint => Private DNS Zone ID. |
| <a name="output_zones"></a> [zones](#output\_zones) | Map of endpoint => zone name created. |
<!-- END_TF_DOCS -->