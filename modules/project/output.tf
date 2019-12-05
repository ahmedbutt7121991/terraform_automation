#OUTPUT VARIABLED FOR PROJECT
###############################
####### MODE PROJECT   ########
###############################
output "project_id" {
  value = "${openstack_identity_project_v3.sanity_project.id}"
}