connection: "lookerdata_standard_sql"

include: "*.view.lkml"
include: "trans_explores.explore.lkml"
# include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: product_data_group {
  max_cache_age: "4 hours"
}

datagroup: nike_transaction_check {
  sql_trigger: SELECT MAX(nike_trans.Date) FROM StockX.nike_trans  AS nike_trans ;;
  max_cache_age: "2 hours"
}

explore: adidas {
  join: adidas_trans {
    sql_on: ${adidas_trans.compound_pk} = ${adidas.compound_pk}  ;;
    type: inner
    relationship: one_to_many
  }
}

explore: adidas_trans_test {}

explore: adidas_trans {
  sql_always_where: ${category} = "Y" ;;
}

explore: nike {
  persist_with: nike_transaction_check
  join: nike_trans {
    sql_on: ${nike_trans.compound_pk} = ${nike.compound_pk} ;;
    type: inner
    relationship: one_to_many
  }
}

explore: jordan {
  join: jordan_trans {
    sql_on: ${jordan_trans.compound_pk} = ${jordan.compound_pk} ;;
    type: inner
    relationship: one_to_many
  }
}

explore: off_white {
  join: off_white_trans {
    sql_on: ${off_white_trans.compound_pk} = ${off_white.compound_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: kith {
  join: kith_trans {
    sql_on: ${kith.compound_pk} = ${kith_trans.compound_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: yeezy {
  join: yeezy_trans {
    sql_on: ${yeezy_trans.compound_pk} = ${yeezy.compound_pk}  ;;
    type: inner
    relationship: one_to_many
  }
}

explore: yeezy_trans {}

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
