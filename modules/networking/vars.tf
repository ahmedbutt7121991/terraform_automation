#Variable declaration and default value assignment
variable "router_name" {
  default = "router_1"
}

variable "public_network" {
  default = "public"
}
#========== NETWORK VARS
variable "network_name" {
  default = "network_1"
}
variable "segment_id" {
  default = "221"
}
variable "network_type" {
  default = "vlan"
}
variable "physical_network" {
  default = "physint"
}
#========== SUBNET VARS
variable "subnet_name" {
  default = "subnet_1"
}
variable "cidr" {
  default = "192.168.70.0/24"
}
variable "ip_version" {
  default = "4"
}
variable "dns_nameservers" {
  type = list
  default = ["8.8.8.8", "8.8.4.4"]
}
#=========== PORT VAS
variable "port_name" {
  default = "port_1"
}
variable "ip_address" {
  default = "192.168.70.10"
}

variable "floatip_name" {
  default = "floatip_1"
}

variable "project_name" {
  default = "admin"
}

data "openstack_identity_project_v3" "project_1" {
  name = "${var.project_name}"
}