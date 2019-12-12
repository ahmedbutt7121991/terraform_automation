###############################
####### DEVELOPMENT   #########
###############################


#MAIN file for calling modules and creating resource
provider "openstack"{
  user_name                     = var.ADMIN_USERNAME
  tenant_name                   = var.ADMIN_TENANTNAME
  password                      = var.OPENSTACK_ADMIN_PASSWORD
  auth_url                      = var.HORIZON_ACCESS_URL
  user_domain_name              = "Default"
  project_domain_name           = "Default"
  disable_no_cache_header       = true
}


###############################################################################
###############################################################################
####################        PUBLIC NETWORK            #########################
###############################################################################
###############################################################################
resource "openstack_networking_network_v2" "public" {                     ###
  name           = "public"                                               ###
//  admin_state_up = "true"                                                   ###
  external = true                                                           ###
  segments {                                                                ###
    segmentation_id   = "604"                                               ###
    network_type      = "vlan"                                              ###
    physical_network  = "physext"                                           ###
  }                                                                         ###
}                                                                           ###
###############################################################################
###############################################################################
####################        PUBLIC SUB-NETWORK            #####################
###############################################################################
###############################################################################
resource "openstack_networking_subnet_v2" "external_subnet" {               ###
  name       = "external_subnet"                                            ###
  network_id = openstack_networking_network_v2.public.id                  ###
  cidr       = "100.67.60.192/26"                                           ###
  gateway_ip = "100.67.60.193"                                              ###
  allocation_pool {                                                         ###
    end = "100.67.60.240"                                                   ###
    start = "100.67.60.194"                                                 ###
  }                                                                         ###
  enable_dhcp = false                                                       ###
}                                                                           ###
###############################################################################
###############################################################################

module "sanity_proj" {
  source = "../modules/project"
  project_id="${module.sanity_proj.project_id}"
}



//module "my_network" {
//  source = "../modules/networking"
////network_id = "${module.my_network.output_network_id}"
//}