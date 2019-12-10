###############################
####### DEVELOPMENT   #########
###############################


#MAIN file for calling modules and creating resource
provider "openstack"{
  user_name                     = "${var.ADMIN_USERNAME}"
  tenant_name                   = "${var.ADMIN_TENANTNAME}"
  password                      = "${var.OPENSTACK_ADMIN_PASSWORD}"
  auth_url                      = "${var.HORIZON_ACCESS_URL}"
  user_domain_name              = "Default"
  project_domain_name           = "Default"
  disable_no_cache_header       = true
}

module "sanity_proj" {
  source = "../modules/project"
  project_id="${module.sanity_proj.project_id}"
}



//module "my_network" {
//  source = "../modules/networking"
////network_id = "${module.my_network.output_network_id}"
//}