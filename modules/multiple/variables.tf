variable "resource_group_name" {
  type        = string
  description = "Resource group where the Private DNS Zones will be created."
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link the Private DNS Zones to."
}

# Optional: choose a subset. If null/empty => create all.
# Valid values: blob, queue, table, file, dfs, web
variable "zones" {
  type        = map(string)
  default     = null
  description = "Which storage endpoints to create DNS zones for. Null means all."
}

variable "registration_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
