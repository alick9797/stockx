view: adidas {
  sql_table_name: StockX.adidas ;;

  dimension: compound_pk {
    primary_key: yes
    #hidden: no
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

  dimension: ask_count_String {
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

  dimension: collab {
    type: yesno
    sql: ${TABLE}.Brand1 IS NOT Null ;;
  }

  dimension: current_highest_bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Current_Highest_Bid ;;
  }

  dimension: image_url {
    type: string
    sql: ${TABLE}.Image_URL ;;
    link: {
      label: "transactional data"
      url: "/dashboards/658?item_name={{ adidas.item_name}}"
    }
  }

  dimension: image {
    type: string
    sql: ${TABLE}.Image_URL ;;
    html: <img src="{{rendered_value}}" height = 300 width = 400>;;
    link: {
      label: "drill"
      url: "/dashboards/658?item_name={{ adidas.item_name}}&size={{ adidas.size }}&date={{_filters['adidas_trans.date_year'] | url_encode}}"
    }
    link: {
      label: "drill to item"
      url: "/explore/transaction/adidas?fields=adidas.item_name,adidas.size&f[adidas.item_name]={{_filter['adidas.item_name']}}&f[adidas_trans.date_year]={{_filters['adidas_trans.date_year'] | url_encode}}"
    }
  }



  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
    link: {
      label: "drill to item"
      url: "/explore/transaction/adidas?fields=adidas.item_name,adidas.size&f[adidas.item_name]={{_filter['adidas.item_name']&f[adidas_trans.date_year]={{_filters['adidas_trans.date_year'] | url_encode}}}}"
    }
  }

  dimension: last_sale_price {
    type: number
    sql: ${TABLE}.Last_Sale_Price ;;
  }

  dimension: release {
    type: date
    sql: CAST(DATE_ADD(CAST(${TABLE}.release_date as DATE), INTERVAL 2000 YEAR) as TIMESTAMP);;
  }

#   dimension: release_date {
#     type: date_time
#     sql: ${TABLE}.Release_Date ;;
#   }

  dimension: retail_price {
    type: number
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
    type: average
    sql: ${TABLE}.Average_Price ;;
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.Total_Sale ;;
    drill_fields: [trans_detail*]
  }

  measure: count {
    type: count_distinct
    sql: ${item_name} ;;
    drill_fields: [item_name]
  }

  set: trans_detail {
    fields: [
      adidas_trans.item_name, adidas_trans.size, adidas_trans.Price
    ]
  }
}
