view: nike {
  sql_table_name: StockX.nike ;;

  dimension: compound_pk {
    primary_key: yes
    hidden: no
    sql: CONCAT(${TABLE}.Item_Name, ' ', ${size});;
  }

#   parameter: p_number_input {
#     type: number
#   }
#
#   dimension: parameter_as_a_value {
#     type: number
#     sql: COALESCE({% parameter p_number_input %}, 0) ;;
#   }
#
#   dimension:  five_times {
#     type: number
#     sql: 5* {% parameter p_number_input %} ;;
#   }
#
#   filter: f_string_input {
#     type:  string
# #     suggestions: ["Commercial", "Non-Commercial"]
#     suggest_dimension: shoe_size_category
#   }
#
#   measure: dynamic_count_of_string_input {
#     type: sum
#     sql: CASE WHEN  {% condition f_string_input %}
#                     ${shoe_size_category}
#                     {% endcondition %}
#                   THEN 1
#       ELSE NULL END ;;
#   }
#
#   dimension: shoe_size_category {
#     type: string
#     sql: CASE WHEN ${shoe_size} <= 4.0 THEN 'Tiny Toed Totes'
#           WHEN ${shoe_size} > 4.0 AND ${shoe_size} <= 9.0 THEN 'Regular Roxannes'
#           WHEN ${shoe_size} > 9.0 AND ${shoe_size} <= 12.0 THEN 'Growth Spurts'
#           WHEN ${shoe_size} > 12.0 AND ${shoe_size} <= 18.0 THEN 'Full on Flippers'
#           WHEN ${shoe_size} > 18.0 THEN 'Boy, You Must Be Shaq'
#           END ;;
#   }

  dimension: annual_high {
    type: number
    sql: ${TABLE}.Annual_High ;;
  }

  dimension: annual_low {
    type: number
    sql: ${TABLE}.Annual_Low ;;
  }

  dimension: ask_count {
    type: number
    sql: ${TABLE}.Ask_Count ;;
  }

#   dimension: average_price {
#     type: number
#     sql: ${TABLE}.Average_Price ;;
#   }

  dimension: bid_count {
    type: number
    sql: ${TABLE}.Bid_Count ;;
  }

  dimension: brand {

    tags: ["email", "user_id"]
    sql: ${TABLE}.Brand ;;

  }

  dimension: brand1 {
    type: string
    sql: ${TABLE}.Brand1 ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: collab {
    type: yesno
    sql: ${TABLE}.Brand1 IS NULL ;;
  }

  dimension: current_highest_bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Current_Highest_Bid ;;
  }

  dimension: image_url {
    type: string
    sql: ${TABLE}.Image_URL ;;
  }

  dimension: image {
    type: string
    sql: ${TABLE}.Image_URL ;;
    html: <img src="{{ value }}" height = 300 width = 500>;;

  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
    drill_fields: [size]
  }

  dimension: last_sale_price {
    type: number
    sql: ${TABLE}.Last_Sale_Price ;;
  }

  dimension_group: release {
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
    sql: date_add(${TABLE}.release_date, 2000, "YEAR");;
  }

#   dimension: release_date {
#     type: date_time
#     sql: ${TABLE}.Release_Date ;;
#   }

  measure: retail_price {
    type: sum
    sql: ${TABLE}.Retail_Price ;;
  }

  dimension: size {
    type: string
    sql: cast(${TABLE}.Size AS string) ;;
  }

  dimension: shoe_size {
    type: number
    sql: ${TABLE}.Size ;;
    value_format: "0.0"
  }

  dimension: total_sale {
    type: number
    sql: ${TABLE}.Total_Sale ;;
    drill_fields: [size, adidas_trans.Price]
  }


  dimension: total_sale_count {
    type: number
    sql: ${TABLE}.Total_Sale_Count ;;
  }

  dimension: volatility {
    type: number
    sql: ${TABLE}.Volatility ;;
  }

  measure: average_price {
    type: sum
    sql: ${TABLE}.Average_Price ;;
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.Total_Sale ;;
  }

  measure: count {
    type: count
    drill_fields: [item_name]
  }
}
