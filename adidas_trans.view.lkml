view: adidas_trans {

  sql_table_name: StockX.adidas_trans ;;

  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
  }

  dimension: brand1 {
    type: string
    sql: ${TABLE}.Brand1 ;;
  }

  dimension: is_collab {
    type: yesno
    sql: ${brand1} IS NOT NULL ;;
  }


  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Date ;;
    drill_fields: [trans_detail*]
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
  }

  measure: price_total {
    type: sum
    sql: ${TABLE}.Price ;;
    value_format: "$0"
    drill_fields: [item_name, date_date, size, price]
  }

  dimension: size {
    type: string
    sql: cast(${TABLE}.Size AS string) ;;
  }

  dimension: shoe_size {
    type: number
    sql: ${TABLE}.Size ;;
  }

  dimension: compound_pk {
#     primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.Item_Name, ' ', ${size});;
  }

#   measure: transaction_count {
#     type: count
#     sql: ${item_name} ;;
#   }

  measure: count {
    type: count
    drill_fields: [item_name]
  }

  set: trans_detail {
    fields: [
      adidas_trans.item_name, adidas_trans.size, adidas_trans.Price
    ]
  }

}

# test: order_id_is_unique {
#   explore_source: adidas_trans {
#     column: brand {}
#     column: count {}
#     sorts: [count: desc]
#     limit: 1
#   }
#   assert: order_id_is_unique {
#     expression: ${adidas_trans.count} = 1 ;;
#   }
test: status_is_not_null {
  explore_source: adidas_trans {
    column: brand {}
    sorts: [brand: desc]
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${adidas_trans.item_name}) ;;
  }


}
