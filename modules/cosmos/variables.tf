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

# If null => create all Cosmos API zones.
# Valid values: sql, mongo, cassandra, gremlin, table
variable "apis" {
  type        = set(string)
  default     = null
  description = "Which Cosmos APIs to create Private DNS zones for."
}

variable "registration_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
