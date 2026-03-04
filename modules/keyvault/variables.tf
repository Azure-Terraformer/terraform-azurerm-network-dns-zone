variable "resource_group_name" {
  type        = string
  description = "Resource group where the Private DNS Zones will be created."
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link the Private DNS Zones to."
}

variable "registration_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
