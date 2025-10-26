variable "cen_id" {
  type        = string
  description = "ID of the CEN instance"
}

variable "transit_router_id" {
  type        = string
  description = "ID of the Transit Router"
}

variable "route_table_id" {
  type        = string
  description = "ID of the Transit Router Route Table"
}

variable "vpc_attachments" {
  description = "Map of VPC attachments to connect to CEN"
  type = map(object({
    vpc_id                     = string
    vpc_owner_id               = string
    attachment_name            = string
    auto_publish_route_enabled = optional(bool, true)
    zone_mappings = list(object({
      zone_id    = string
      vswitch_id = string
    }))
  }))
  default = {}
}
