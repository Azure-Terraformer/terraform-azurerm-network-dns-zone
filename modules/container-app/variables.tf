variable "resource_group_name" {
  type        = string
  description = "Resource group where the Private DNS Zones will be created."
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link the Private DNS Zones to."
}

variable "locations" {
  type        = set(string)
  description = "Set of Azure regions for which regional Container App private DNS zones will be created."
}

variable "registration_enabled" {
  type        = bool
  description = "Whether auto-registration of VM DNS records in the zone is enabled."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources created by this module."
  default     = {}
}
