view: trans_info {
  derived_table: {
    sql:
    SELECT * FROM StockX.adidas_trans
    union all
    SELECT * FROM StockX.nike_trans
    union all
    SELECT brand, brand1, item_name, date, size, "w" as cateogry, price FROM StockX.converse_trans;;
  }

#   dimension: item_comparer {
#     type: string
#     sql: CASE WHEN {% condition item_to_compare %} ${item_name} {% endcondition %}
#           THEN ${item_name}
#           ELSE "All other shoes"
#           END;;
#   }
#
#   filter: item_to_compare {
#     type: string
#     suggest_dimension: item_name
#   }


  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
  }

  dimension: brand1 {
    type: string
    sql: ${TABLE}.Brand1 ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
    drill_fields: [size]
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
  }

  dimension: is_before_mtd {
    type: yesno
    sql: EXTRACT(Year from ${date_date}) < EXTRACT(Year from CURRENT_DATE);;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
  }

#   measure: price_total {
#     type: count
#     sql: ${TABLE}.price ;;
#   }

#   measure: pt {
#     type: count
#     sql: CASE WHEN ${price_total} IS NOT NULL THEN ${price_total} ELSE 0;;
#   }

#   measure: value {
#     type: number
#     sql: coalesce(${price_total},0) ;;
#   }

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

  dimension: collab {
    type: yesno
    sql: ${TABLE}.Brand1 IS NOT Null ;;
  }

#   measure: transaction_count {
#     type: count
#     sql: CASE WHEN CONCAT(${TABLE}.Item_Name, ' ', ${size}, ' ', CAST(${price} AS STRING)) != 0 THEN CONCAT(${TABLE}.Item_Name, ' ', ${size}, ' ', CAST(${price} AS STRING)) ELSE 0;;
#     drill_fields: [item_name, size, date_date, price]
#   }


}
