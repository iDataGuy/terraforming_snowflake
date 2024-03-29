locals {
  # Default values used for deployment logic, the contents of variables.yml would seldom change
  variables = yamldecode(file("./modules/roles/user_input.yml"))

 
  # A list of environments for new setup
  # envs = tolist(local.variables.environments)

  #environment
  env = local.variables.environments

  user_input = yamldecode(file("./modules/database/user_input.yml"))

  # A list of roles to be created in a new setup
  roles = tolist(local.variables.roles)
  
  role_map = { for role in local.roles : role.name => {
    name    = "${local.env}_${role.name}"
    comment = role.comment
  } } 

}











  # A map of roles to be assigned to other roles, for RBAC
# role_map_list = local.variables.rolemap
# rolemaps = { for v in local.variables.rolemap : v.role => {
#   role    = "${v.role}_${local.env}"
#   grantee = toset(tolist(["${v.grantee[0]}_${local.env}"]))
#   }
# }
#
# # A map of roles to be assigned to other roles, for RBAC
# system_rolemaps = { for v in local.variables.system_rolemap : v.role => {
#   role    = "${v.role}"
#   grantee = toset(tolist(["${v.grantee[0]}_${local.env}"]))
#   }
# }
#
#
# privilege_map_list = local.variables.privilegemap_db
# privilegemaps = { for v in local.variables.privilegemap_db : v.privilege => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   }
# }
#
# # privilege_map_schema = local.variables.privilege_map_schema
# privilegemapschema = { for v in local.variables.privilegemap_schema : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# privilegemaptable = { for v in local.variables.privilegemap_table : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# privilegemap_insert = { for v in local.variables.privilegemap_table_w : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# privilegemap_update = { for v in local.variables.privilegemap_table_upd : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# privilegemap_delete = { for v in local.variables.privilegemap_table_del : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# privilegemap_truncate = { for v in local.variables.privilegemap_table_truncate : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# privilegemap_engineer_qa = { for v in local.variables.privilegemap_table_all : v.schema => {
#   privilege = v.privilege
#   role      = tolist(v.role)
#   database  = v.database
#   schema    = v.schema
#   }
# }
#
# # db_with_env_rolemap = flatten([for i, v in toset(local.envs) : [
# #   for j, r in local.db_with_env : {
# #     role    = "${r}_${v}_ANALYST"
# #     grantee = [for k, g in local.db_with_env : "${g}_${v}_ETL"]
# #   }
# #   ]
# # ])
#
# # db_rolemap = flatten([local.db_without_env_rolemap, local.db_with_env_rolemap])
#
# # database_rolemap = { for dbr in local.db_rolemap : dbr.role => {
# #   grantee = dbr.grantee
# #   role    = dbr.role
# # } 
