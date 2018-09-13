view: yeezy_fact {

  derived_table: {
    sql:
    SELECT item_name, annual_high, annual_low, ask_count, current_highest_bid, bid_count, last_sale_price, image_url, CAST(DATE_ADD(CAST(release_date as DATE), INTERVAL 2000 YEAR) as TIMESTAMP) AS release, size, total_sale, total_sale_count, retail_price, average_price, size
      FROM StockX.yeezy
      WHERE {% condition shoe_name %} yeezy.item_name {% endcondition %}
      ;;
  }

  filter: shoe_name {
    type: string
    suggest_dimension: item_name
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

  dimension: average_price {
    type: number
    sql: ${TABLE}.Average_Price ;;
  }

  dimension: bid_count {
    type: number
    sql: ${TABLE}.Bid_Count ;;
  }

  dimension: current_highest_bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Current_Highest_Bid ;;
  }

  dimension: image {
    type: string
    sql: ${TABLE}.Image_URL ;;
    html: <img src="{{ value }}" height = 300 width = 410>;;
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

  dimension: release {
    type: date
    sql: CAST(DATE_ADD(CAST(${TABLE}.release_date as DATE), INTERVAL 2000 YEAR) as TIMESTAMP);;
  }

  measure: retail_price {
    type: sum
    sql: ${TABLE}.Retail_Price ;;
  }

  dimension: size {
    type: string
    sql: cast(${TABLE}.Size AS string) ;;
  }

  dimension: total_sale {
    type: number
    sql: ${TABLE}.Total_Sale ;;
    drill_fields: [size, adidas_trans.Price]
  }
}
