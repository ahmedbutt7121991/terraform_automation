###############################
####### MODE NETWORK   ########
###############################

//#Getting output values
output "router_id" {
  value = "${openstack_networking_router_v2.router.id}"
}
output "network_id" {
  value = "${openstack_networking_network_v2.network.id}"
}
output "subnet_id" {
  value = "${openstack_networking_subnet_v2.subnet.id}"
}
output "port_id" {
  value = "${openstack_networking_port_v2.port.id}"
}
//
////output "public_network_id" {
////  value = "${openstack_networking_network_v2.public.id}"
////}
//
//output "output_network_id" {
//  value = "${openstack_networking_network_v2.network.id}"
//}