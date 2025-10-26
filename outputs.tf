output "vpc_attachment_ids" {
  description = "Map of all VPC attachment IDs"
  value = {
    for key, attachment in alicloud_cen_transit_router_vpc_attachment.this :
    key => attachment.transit_router_attachment_id
  }
}

output "association_ids" {
  description = "Map of route table association IDs"
  value = {
    for key, assoc in alicloud_cen_transit_router_route_table_association.rt_associations :
    key => assoc.id
  }
}

output "propagation_ids" {
  description = "Map of route table propagation IDs"
  value = {
    for key, prop in alicloud_cen_transit_router_route_table_propagation.rt_propagations :
    key => prop.id
  }
}