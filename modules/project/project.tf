#CREATING NEW PROJECT AND USER
##################################
#######   MODE PROJECT   #########
##################################
#Creating a Project
resource "openstack_identity_project_v3" "sanity_project" {
  name        = var.sanity_tenantname
  description = "Sanity Testing Project"
  enabled = true
}
###USING DATA_SOURCE
data "openstack_identity_project_v3" "sanity_project" {
  name = var.sanity_tenantname
  depends_on = [openstack_identity_project_v3.sanity_project,]
}

###############################
#######     USER   ############
###############################
resource "openstack_identity_user_v3" "sanity_user" {
  default_project_id = data.openstack_identity_project_v3.sanity_project.id ###USING DATA_SOURCE
  name               = var.sanity_username
  description        = "Sanity user for Sanity Project"
  enabled = true
  password = var.openstack_sanity_password

  ignore_change_password_upon_first_use = true

//  multi_factor_auth_enabled = false

//  depends_on = ["openstack_identity_project_v3.sanity_1",]
}
###############################
#######     ROLE   ############
###############################
resource "openstack_identity_role_v3" "sanity_role" {
  name = var.sanity_rolename
}
resource "openstack_identity_role_assignment_v3" "sanity_role_assignment" {
  user_id    = openstack_identity_user_v3.sanity_user.id
  project_id = var.project_id
  role_id    = openstack_identity_role_v3.sanity_role.id
  depends_on = [openstack_identity_role_v3.sanity_role,
                openstack_identity_user_v3.sanity_user,
                openstack_identity_project_v3.sanity_project,
              ]
}