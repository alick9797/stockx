connection: "lookerdata_standard_sql"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: product_data_group {
  max_cache_age: "4 hours"
}


explore: brand_comparison {
  join: trans_info {
    relationship: one_to_many
    type: left_outer
    sql_on: ${trans_info.compound_pk} = ${brand_comparison.compound_pk};;
  }
}

# explore: brand_comparison {
#   join: trans_info {
#     sql_on: 1 = 1 ;;
#     type: cross
#
#   }
# }

explore: trans_info {
}


explore: nike {}
