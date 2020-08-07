connection: "lookerdata_standard_sql"

include: "*.view"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "create_process.view"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
datagroup: test_persist {
  #daily persistence
  sql_trigger: SELECT CURDATE() ;;
}

explore: explore_extended {
  extends: [create_process_base]
  # from: create_process_extend
  join: create_process_base {}
}

explore: create_process_base {
  join: create_process_extend {
    sql_on: ${create_process_base.brand} = ${create_process_extend.brand} ;;
    relationship: many_to_one
  }
  hidden: yes
}
