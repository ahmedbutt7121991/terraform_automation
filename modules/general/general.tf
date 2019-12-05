###############################
####### MOD GENERAL   #########
###############################

#GENERAL ITEMS LIKE FLAVOR KEYPAIR IMAGE AND SECGROUP
###########################################
#######     GENERAL ITEMS   ###############
###########################################
#Creating KEY-PAIR for SSH
#################################
#######     KEY PAIR   ##########
#################################
resource "openstack_compute_keypair_v2" "ssh-key" {
  name = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgR8LqMUAHATFZMbeyo4OobarANGKq+EtNNdmI2aunpM8vUR56xqi9Wp4I2PmYCJb+EOAmK9+hAnPOBHeCP1N5Xtmi3yastQKIFuQM3A6ZUNP5g0CLVdYCwUmLfzPw7nsBfBeFKU1qkKe39+7Kfoal/pTyhX9HcXS2NiMs/1PVsLcVcnKnqP2R0peQ1c3uhgMI0GJ4OhLB6AVXKAf/hmkEug8GY4SVup5YL2kIHaC1QGY5rFMMzgkEnp3uIBQzMGLZ/0zRDINiAJsXOMSWcOv4xyn1cqKdAr/MRh00ABo45XzsvsSm/DiyjfhC6jP2w7keleS0bikTGWfqEccXBCxN osp_admin@director.r60.lab"
}
#Creating Centos Images
###############################
#######     IMAGES   ##########
###############################
resource "openstack_images_image_v2" "centos_1" {
  name             = "centos_1"
  image_source_url = "http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  container_format = "bare"
  disk_format      = "qcow2"
}
###############################
#######     FLAVOR   ##########
###############################
//#Creating Flavor
//resource "openstack_compute_flavor_v2" "flavor_1" {
//  name  = "flavor_1"
//  ram   = "8049"
//  vcpus = "4"
//  disk  = "50"
//  is_public = true
//
//  extra_specs = {
//    "hw:cpu_policy"        = "dedicated",
//    "hw:cpu_thread_policy" = "require",
//    "hw:mem_page_size"     = "large",
//    "hw:numa_node"         = "1"
//  }
//}