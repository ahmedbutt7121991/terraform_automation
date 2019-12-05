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
  name                = "${var.router_name}"
  admin_state_up      = "false"
  external_network_id = "45d3d1ac-f2a8-4b69-85c0-e8cbfc7f3552"
//  enable_snat = "true"
//  external_gateway = "public"
}
################
###  NETWORK ###
################
# PARENT Network Resource Creation
resource "openstack_networking_network_v2" "network" {
  name = "${var.network_name}"
  admin_state_up = false
//  segments {
//    segmentation_id   = "${var.segment_id}"
//    network_type = "${var.network_type}"
//    physical_network = "${var.physical_network}"
//  }
}
//resource "openstack_networking_rbac_policy_v2" "rbac_policy" {
//  action        = "access_as_shared"
//  object_id     = "${openstack_networking_network_v2.network.id}"
//  object_type   = "network"
//  target_tenant = data.openstack_identity_project_v3.project_1.id
//}
################
###SUBNETWORK###
################
# Creating PARENT Subnet for PARENT Network
resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.subnet_name}"
  network_id = "${var.network_id}"
  cidr       = "${var.cidr}"
  ip_version = "${var.ip_version}"
  dns_nameservers = "${var.dns_nameservers}"
}

################
###   PORTS  ###
################
#Creating Port parent
resource "openstack_networking_port_v2" "port" {
  depends_on = [
    "openstack_networking_subnet_v2.subnet",
  ]

    name           = "${var.port_name}"
    network_id = "${var.network_id}"
    admin_state_up = false

    fixed_ip {
    subnet_id = "${var.subnet_id}"
    ip_address = "${var.ip_address}"
  }
}

####################
###SUBNET->ROUTER###
####################
resource "openstack_networking_router_interface_v2" "router_interface_port_1"{
  router_id = "${var.router_id}"
  subnet_id = "${var.subnet_id}"
//  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}
