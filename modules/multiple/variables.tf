variable "resource_group_name" {
  type        = string
  description = "Resource group where the Private DNS Zones will be created."
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link the Private DNS Zones to."
}

# Optional: provide a map of logical name => DNS zone FQDN. If null/empty => create all.
variable "zones" {
  type        = map(string)
  default     = null
  description = "Map of logical endpoint name to Private DNS Zone FQDN to create and link. When null, the calling module determines the full set of zones."
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
