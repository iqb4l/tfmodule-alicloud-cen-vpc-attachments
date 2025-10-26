# Attach VPCs to Transit Router
resource "alicloud_cen_transit_router_vpc_attachment" "this" {
  for_each = var.vpc_attachments
  
  transit_router_vpc_attachment_name = each.value.attachment_name
  cen_id                             = var.cen_id
  vpc_id                             = each.value.vpc_id
  transit_router_id                  = var.transit_router_id
  auto_publish_route_enabled         = each.value.auto_publish_route_enabled
  vpc_owner_id                       = each.value.vpc_owner_id
  
  dynamic "zone_mappings" {
    for_each = each.value.zone_mappings
    content {
      zone_id    = zone_mappings.value.zone_id
      vswitch_id = zone_mappings.value.vswitch_id
    }
  }
}

# Associate route tables for each VPC
resource "alicloud_cen_transit_router_route_table_association" "rt_associations" {
  for_each = alicloud_cen_transit_router_vpc_attachment.this
  
  transit_router_route_table_id = var.route_table_id
  transit_router_attachment_id  = each.value.transit_router_attachment_id
}

# Propagate routes for each VPC
resource "alicloud_cen_transit_router_route_table_propagation" "rt_propagations" {
  for_each = alicloud_cen_transit_router_vpc_attachment.this
  
  transit_router_route_table_id = var.route_table_id
  transit_router_attachment_id  = each.value.transit_router_attachment_id
}
