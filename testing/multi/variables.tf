variable "resource_group_name" {
  type = string
}
variable "virtual_network_id" {
  type = string
}
variable "zones" {
  type = map(string)
}
variable "name_prefix" {
  type = string
}
variable "registration_enabled" {
  type    = bool
  default = false
}
variable "tags" {
  type    = map(string)
  default = {}
}
