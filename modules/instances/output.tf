#OUTPUT IN INSTANCES
###############################
####### MOD INSTANCE   ########
###############################
###########################################
#######     OUTPUT ITEMS   ################
###########################################
output "instance_id" {
  value = "${openstack_compute_instance_v2.sanity_instance_1.id}"
}
output "private_ip"{
  value = "${openstack_compute_instance_v2.sanity_instance_1.access_ip_v4}"
}
output "flaot_ip"{
  value = "${openstack_networking_floatingip_v2.sanity_floatip.address}"
}
