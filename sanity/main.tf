###############################
####### SANITY SCRI   #########
###############################

#MAIN SCRIPT
#MAIN file for calling modules and creating resource
provider "openstack"{
  user_name                     = var.SANITY_USERNAME
  tenant_name                   = var.SANITY_TENANTNAME
  password                      = var.OPENSTACK_SANITY_PASSWORD
  auth_url                      = var.HORIZON_ACCESS_URL
  user_domain_name              = "Default"
  project_domain_name           = "Default"
  disable_no_cache_header       = true
}

module "my_general" {
  source = "../modules/general"
}

module "my_network" {
  source = "../modules/networking"
  router_id=module.my_network.router_id
  network_name = "sanity_network"
  network_id=module.my_network.network_id
  subnet_name = "sanity_subnet"
  cidr        = "192.168.90.0/24"
  subnet_id=module.my_network.subnet_id
  port_name = "sanity_port"
  ip_address = "192.168.90.10"
  port_id=module.my_network.port_id
  project_name = "sanity_1"
//  network_id = module.my_network.output_network_id
}

module "my_instance" {
  source="../modules/instances"
  port_id=module.my_network.port_id
  instance_id=module.my_instance.instance_id
  flaot_ip=module.my_instance.flaot_ip
  private_ip=module.my_instance.private_ip
}