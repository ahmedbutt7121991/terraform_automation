#MAIN SCRIPT
#MAIN file for calling modules and creating resource
provider "openstack"{
  user_name                     = "${var.SANITY_USERNAME}"
  tenant_name                   = "${var.SANITY_TENANTNAME}"
  password                      = "${var.OPENSTACK_SANITY_PASSWORD}"
  auth_url                      = "${var.HORIZON_ACCESS_URL}"
  user_domain_name              = "Default"
  project_domain_name           = "Default"
  disable_no_cache_header       = true
}

module "my_network" {
  source = "../modules/networking"
  router_name = "sanity_router"
  network_name = "sanity_network"
  subnet_name = "sanity_subnet"
  cidr        = "192.168.90.0/24"
  port_name = "sanity_port"
  ip_address = "192.168.90.10"
  project_name = "sanity_1"
//  network_id = "${module.my_network.output_network_id}"
}