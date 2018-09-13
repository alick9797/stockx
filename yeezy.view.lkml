view: yeezy {
  sql_table_name: StockX.yeezy ;;

  dimension: compound_pk {
    primary_key: yes
    hidden: no
    sql: CONCAT(${TABLE}.Item_Name, ' ', ${size});;
  }

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
    html: <img src="{{ value }}" class="center" height = 160 width = 230>;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
    html: <p style="font-size:15px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
    drill_fields: [size]
  }

  dimension: last_sale_price {
    type: number
    sql: ${TABLE}.Last_Sale_Price ;;
  }

  dimension: release {
    type: date
    sql: CAST(DATE_ADD(CAST(${TABLE}.release_date as DATE), INTERVAL 2000 YEAR) as TIMESTAMP);;
  }

#   dimension_group: release {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
# #     sql: DATE_ADD(DATE_FORMAT(${TABLE}.release_date, "%m%d%Y"), 2000, "YEARS");;
#     sql: DATE_ADD(CAST(nike.release_date as DATE), INTERVAL 2000 YEAR);;
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
    html: <p style="font-size:15px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
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

  measure: ts {
    type: sum
    sql: ${TABLE}.Total_Sale ;;
    html: <p style="font-size:15px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
    value_format_name: usd_0
  }

  measure: ts_1 {
    type: sum
    sql: ${TABLE}.Total_Sale ;;
    html: <p style="font-size:50px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
    value_format_name: usd_0
  }

  measure: count {
    type: count
    drill_fields: [item_name]
  }
}
