variable "resource_group_name" {
  type        = string
  description = "Resource group where the Private DNS Zone will be created."
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link the Private DNS Zone to."
}

variable "zone_name" {
  type        = string
  description = "Private DNS zone name (e.g. privatelink.blob.core.windows.net)."
}

variable "link_name" {
  type        = string
  description = "Name for the private DNS zone virtual network link."
}

variable "registration_enabled" {
  type        = bool
  description = "Whether auto-registration of VM records in the zone is enabled."
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
