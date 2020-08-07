view: adidas_trans {

  filter: date_fil {
    type: date
    default_value: "2 days ago"
  }



  sql_table_name: StockX.adidas_trans ;;

  parameter: date_param{
    type: unquoted
  }



# derived_table: {
#   sql: SELECT * FROM StockX.adidas_trans WHERE {% date_start date_fil %} ;;
# }

  dimension: email {
    sql: {{ _user_attributes['email'] }}  ;;
  }

  dimension: brand {
    view_label: "brandz"
    group_label: "BRANDS"
    description: "brand1"
    type: string
    sql: ${TABLE}.Brand ;;
    link: {
      label: "copy"
      url: "{{ value }}"
    }
    html: <a href="{{link}}">test</a> ;;
#     html: <p font-size=150%> {{ rendered_value }} </p>
  }

  dimension: brand1 {
    view_label: "brandz"
#     group_label: "BRANDS"
    description: "brand2"
    type: string
    sql: ${TABLE}.Brand1 ;;
    link: {
      label: "copy"
      url: "{{ value }}"
    }
  }

  measure: brand_count_test {
    type: count_distinct
    sql: ${brand1} ;;

  }
#   measure: brands_test {
#     type: list
#     list_field: brand1
#     sql: length(${brands_test}) ;;
#   }

#   dimension: tester {
#     type: number
#     sql: LENGTH(${brands_test}) ;;
#   }

#   measure: count {
#     type: number
#     sql: LENGTH(${brands_test}) ;;
#   }
#
  dimension: is_collab {
    type: yesno
    sql: ${brand1} IS NOT NULL ;;
    html:  <div style="text-align:center;font-weight: bold; color:red">{{ rendered_value }}</div> ;;
  }


  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
    value_format: "###.####"
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }


  dimension: date_start {
    type: date
    sql: {% date_start date_fil %} ;;
  }

  dimension_group: date {
    type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
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

  measure: price_25 {
    type: percentile
    percentile: 25
    sql: ${TABLE}.Price ;;
  }

  measure: price_50 {
    type: median
    sql: ${TABLE}.Price ;;
  }

  measure: price_75 {
    type: percentile
    percentile: 75
    sql: ${TABLE}.Price ;;
  }

  dimension: size {
    type: string
    sql: cast(${TABLE}.Size AS string) ;;
  }

  dimension: shoe_size {
    type: number
    sql: ${TABLE}.Size ;;
    value_format: "##.#"
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
#     html: <a href="{{link}}">test</a> ;;
    html: {{rendered_value}}  ;;
  }

  set: trans_detail {
    fields: [
      adidas_trans.item_name, adidas_trans.size, adidas_trans.Price
    ]
  }

}

test: order_id_is_unique {
  explore_source: adidas_trans {
    column: brand {}
    column: count {}
    sorts: [count: desc]
    limit: 1
  }
  assert: order_id_is_unique {
    expression: ${adidas_trans.count} = 1 ;;
  }
  }
# test: status_is_not_null {
#   explore_source: adidas_trans {
#     column: brand {}
#     sorts: [brand: desc]
#     limit: 1
#   }
#   assert: status_is_not_null {
#     expression: NOT is_null(${adidas_trans.item_name}) ;;
#   }


# }
