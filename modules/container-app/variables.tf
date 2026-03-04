variable "resource_group_name" {
  type        = string
  description = "Resource group where the Private DNS Zones will be created."
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link the Private DNS Zones to."
}

variable "name_prefix" {
  type        = string
  description = "Prefix used to build link names (e.g. app-env)."
}

variable "regions" {
  type        = set(string)
  description = "Azure regions to create Container Apps private DNS zones for (e.g. eastus, westus2)."
}

variable "registration_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
