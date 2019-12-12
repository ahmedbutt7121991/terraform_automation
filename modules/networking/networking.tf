###############################
####### MODE NETWORK   ########
###############################

#MODULE NAME ---> NETWORKING
#FILE NAME ---> NETWORKING
#PATH --> ~/terraform_automation/modules/networking/networking.tf
################
###   ROUTER ###
################
resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
//  admin_state_up      = "false"
  external_network_id = "3d8c3998-1b22-44ef-98ea-4c70339a41dd"
//  enable_snat = "true"
//  external_gateway = "public"
}
################
###  NETWORK ###
################
//###############################################################################
//###############################################################################
//####################        PUBLIC NETWORK            #########################
//###############################################################################
//###############################################################################
//resource "openstack_networking_network_v2" "public_1" {                     ###
//  name           = "public_1"                                               ###
//  admin_state_up = "true"                                                   ###
//  external = true                                                           ###
//  segments {                                                                ###
//    segmentation_id   = "604"                                               ###
//    network_type      = "vlan"                                              ###
//    physical_network  = "physext"                                           ###
//  }                                                                         ###
//}                                                                           ###
//###############################################################################
//###############################################################################
//####################        PUBLIC SUB-NETWORK            #####################
//###############################################################################
//###############################################################################
//resource "openstack_networking_subnet_v2" "public_subnet_1" {               ###
//  name       = "public_subnet_1"                                            ###
//  network_id = openstack_networking_network_v2.public_1.id             ###
//  cidr       = "100.67.60.192/26"                                           ###
//  gateway_ip = "100.67.60.193"                                              ###
//  allocation_pool {                                                         ###
//    end = "100.67.60.240"                                                   ###
//    start = "100.67.60.220"                                                 ###
//  }                                                                         ###
//  enable_dhcp = false                                                       ###
//}                                                                           ###
//###############################################################################
//###############################################################################
# PARENT Network Resource Creation
resource "openstack_networking_network_v2" "network" {
  name = var.network_name
//  segments {
//    segmentation_id   = var.segment_id
//    network_type = var.network_type
//    physical_network = var.physical_network
//  }
}
//resource "openstack_networking_rbac_policy_v2" "rbac_policy" {
//  action        = "access_as_shared"
//  object_id     = openstack_networking_network_v2.network.id
//  object_type   = "network"
//  target_tenant = data.openstack_identity_project_v3.project_1.id
//}
################
###SUBNETWORK###
################
# Creating PARENT Subnet for PARENT Network
resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.subnet_name
  network_id = var.network_id
  cidr       = var.cidr
  ip_version = var.ip_version
  dns_nameservers = var.dns_nameservers
}

################
###   PORTS  ###
################
#Creating Port parent
resource "openstack_networking_port_v2" "port" {
  depends_on = [
    openstack_networking_subnet_v2.subnet,
  ]

    name           = var.port_name
    network_id = var.network_id

    fixed_ip {
    subnet_id = var.subnet_id
    ip_address = var.ip_address
  }
}

####################
###SUBNET->ROUTER###
####################
resource "openstack_networking_router_interface_v2" "router_interface_port_1"{
  router_id = var.router_id
  subnet_id = var.subnet_id
//  subnet_id = openstack_networking_subnet_v2.subnet.id
}
####################
###SECURITY GROUP###
####################
resource "openstack_networking_secgroup_v2" "sanity_secgroup" {
  name        = "sanity_secgroup"
  description = "Sanity neutron security group"
}
##########################
###SECURITY GROUP RULES###
##########################
resource "openstack_networking_secgroup_rule_v2" "sanity_tcp_ingress_secgroup_rules" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sanity_secgroup.id
}
resource "openstack_networking_secgroup_rule_v2" "sanity_icmp_ingress_secgroup_rules" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sanity_secgroup.id
}
resource "openstack_networking_secgroup_rule_v2" "sanity_icmp_egress_secgroup_rules" {
  direction = "egress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sanity_secgroup.id
}