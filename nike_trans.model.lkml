connection: "lookerdata_standard_sql"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
fiscal_month_offset: -6

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: dates_dimension {
  join: nike_trans {
    sql_on: ${dates_dimension.primary_key} = ${nike_trans.date_date} ;;
    type: left_outer
    relationship: one_to_one
  }
}
