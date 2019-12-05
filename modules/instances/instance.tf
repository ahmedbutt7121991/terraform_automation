###############################
####### MOD INSTANCE   ########
###############################

#CREATING INSTANCE
###########################################
#######     COMPUTE ITEMS   ###############
###########################################
##################################################
#######  SANITY INSTANCE CREATION   ##############
##################################################
resource "openstack_compute_instance_v2" "sanity_instance_1" {
  name            = "sanity_instance_1"
  security_groups = ["default"]
  image_name	= "centos_1"#"${var.IMAGE_NAME}"
  flavor_name	= "sanity_flavor"#"${var.FLAVOR_NAME}"
  key_pair	= "ssh-key"#"${var.SSH_KEY_NAME}"
//  availability_zone = "${lookup(var.ZONE, var.AVAILABILITY_ZONES)}"
  availability_zone = "${data.openstack_compute_availability_zones_v2.zones.names[1]}"
  network {
    port = "${openstack_networking_port_v2.sub_port_simple.id}"
  }
}
###########################################
####### FLOATING IP -> INSTANCE   #########
###########################################
resource "openstack_compute_floatingip_associate_v2" "subnetwork_floatip" {
  floating_ip = "${openstack_networking_floatingip_v2.subnetwork_floatip.address}"
  instance_id = "${openstack_compute_instance_v2.subnetwork_instance_1.id}"
  wait_until_associated = "true"
  depends_on = ["openstack_compute_floatingip_associate_v2.vlan_floatip",]
//    provisioner "local-exec" {
//    command = "echo private_ip: ${openstack_compute_instance_v2.instance_2.access_ip_v4} \n public_ip:  ${openstack_networking_floatingip_v2.floatip_2.address}"
//  }
  connection {
      user     = "${var.SSH_USER_NAME}"
      host     = "${openstack_networking_floatingip_v2.subnetwork_floatip.address}"
      private_key = "${file(var.SSH_KEY_FILE)}"
    }
  provisioner "remote-exec" {
    inline = [
      "sudo ifconfig",
      "ping -c 5 8.8.8.8",
      "ping -c 10 192.168.90.10"
    ]
}
}
###########################################
#######     OUTPUT ITEMS   ################
###########################################

output "subnet_instance_private_ip"{
  value = "${openstack_compute_instance_v2.subnetwork_instance_1.access_ip_v4}"
}
output "vlanaware_instance_public_ip"{
  value = "${openstack_networking_floatingip_v2.vlan_floatip.address}"
}
output "subnet_instance_public_ip" {
  value = "${openstack_networking_floatingip_v2.subnetwork_floatip.address}"
}