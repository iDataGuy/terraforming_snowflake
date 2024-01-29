terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
      configuration_aliases = [snowflake.snow_db_admin]
    }
  }
}

resource "snowflake_schema" "schema" {
  provider = snowflake.snow_db_admin
  database            = local.database
  name                = each.value.name
  comment             = each.value.comment
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
  for_each            = local.schema_details
}

