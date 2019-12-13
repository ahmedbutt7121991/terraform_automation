###############################
####### MOD INSTANCE   ########
###############################

#VARIABLES DECLERATION
variable "ssh_user_name" {
  default = "centos"
}
variable "ssh_key_file" {
  default = "/home/osp_admin/terraform_automation/ssh-key"
}
variable "port_id" {}
variable "instance_id" {}
variable "flaot_ip" {}
variable "private_ip" {}


#DATA SOURCES DECLARATION
data "openstack_compute_availability_zones_v2" "zones" {}
