locals {
#  # Default values used for deployment logic, the contents of variables.yml would seldom change
  variables = yamldecode(file("./modules/schema/variables.yml"))
#
#


#environment
  environment = local.variables.environments
  database = "${local.environment}_${local.variables.database}"

  schema_details = { for schm in local.variables.schema : schm.name => {
    name = schm.name
    comment = schm.comment
    } 
  }

}

