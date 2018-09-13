view: yeezy_trans {

  sql_table_name: StockX.yeezy_trans ;;

  dimension: brand {
    type: string
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

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.Sale_Price ;;
    drill_fields: [item_name, size, date_date, sale_price]
  }

  dimension: size {
    type: string
    sql: cast(${TABLE}.Size AS string) ;;
  }

  dimension: shoe_size {
    type: number
    sql: ${TABLE}.Size ;;
  }

  measure: sp {
    type: sum
    sql: ${TABLE}.Sale_Price ;;
    drill_fields: [item_name, size, date_date, sale_price]
  }

  dimension: compound_pk {
    hidden: yes
    sql: CONCAT(${TABLE}.Item_Name, ' ', ${size});;
  }

  measure: count {
    type: count
    drill_fields: [item_name]
  }
}
