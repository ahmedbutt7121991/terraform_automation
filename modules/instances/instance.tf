###############################
####### MOD INSTANCE   ########
###############################
######################
###   FLOATING IP  ###
######################
#Creating floating ip
resource "openstack_networking_floatingip_v2" "sanity_floatip" {
  pool = "public"
}
#CREATING INSTANCE
###########################################
#######     COMPUTE ITEMS   ###############
###########################################
##################################################
#######  SANITY INSTANCE CREATION   ##############
##################################################
resource "openstack_compute_instance_v2" "sanity_instance_1" {
  name            = "sanity_instance_1"
//  security_groups = [data.openstack_networking_secgroup_v2.secgroup.name,]
  image_name	= "centos_1"#var.IMAGE_NAME
  flavor_name	= "sanity_flavor"#var.FLAVOR_NAME
  key_pair	= "ssh-key"#var.SSH_KEY_NAME
  availability_zone = data.openstack_compute_availability_zones_v2.zones.names.2##USING DATA SOURCES
  network {
    port = var.port_id
  }
}

###########################################
####### FLOATING IP -> INSTANCE   #########
###########################################
resource "openstack_compute_floatingip_associate_v2" "sanity_floatip_1" {
  floating_ip = openstack_networking_floatingip_v2.sanity_floatip.address
  instance_id = var.instance_id
//  wait_until_associated = true
//  depends_on = ["openstack_networking_floatingip_v2.sanity_floatip",]
    provisioner "local-exec" {
//    command = "echo private_ip: ${openstack_compute_instance_v2.sanity_instance_1.access_ip_v4} \n public_ip:  ${openstack_networking_floatingip_v2.sanity_floatip.address
      command = "ping -c 20 google.com"
    }
  connection {
      user     = var.ssh_user_name
      host     = openstack_networking_floatingip_v2.sanity_floatip.address
      private_key = file(var.ssh_key_file)
    }
  provisioner "remote-exec" {
    inline = [
      "sudo ifconfig",
      "ping -c 5 8.8.8.8",
      "ping -c 10 192.168.90.1",
      "ping -c 5 google.com"
    ]
}
}
