view: brand_comparison {

  derived_table: {
    sql:
    SELECT * FROM StockX.adidas
    union all
    SELECT * FROM StockX.nike
    union all
    SELECT brand, brand1, item_name, release_date, image_url, size, "s" as category, retail_price, annual_high, annual_low, volatility, total_sale, total_sale_count, last_sale_price, current_highest_bid, average_price, bid_count, ask_count FROM StockX.converse
    union all
    SELECT brand, brand1, item_name, release_date, image_url, size, "s" as category, retail_price, annual_high, annual_low, volatility, total_sale, total_sale_count, last_sale_price, current_highest_bid, average_price, bid_count, ask_count FROM StockX.off_white;;
  }

  dimension: brand_comparer {
    type: string
    sql: CASE WHEN {% condition brand_to_compare %} ${brand} {% endcondition %}
          THEN ${brand}
          ELSE "All other brands"
          END;;
  }

  filter: brand_to_compare {
    type: string
    suggest_dimension: brand
  }

  dimension: compound_pk {
    primary_key: yes
    hidden: no
    sql: CONCAT(${TABLE}.Item_Name, ' ', ${size});;
  }

  dimension: annual_high {
    type: number
    sql: ${TABLE}.Annual_High ;;
  }

  dimension: sell_or_hold {
    sql: ${TABLE}.current_highest_bid ;;
    html: {% if value > ap %}
          <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
          {% elsif value < ap %}
            <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
          {% endif %};;
  }

  dimension: annual_low {
    type: number
    sql: ${TABLE}.Annual_Low ;;
  }

  dimension: ask_count {
    type: number
    sql: ${TABLE}.Ask_Count ;;
  }

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
  }

  dimension: image {
    type: string
    sql: ${TABLE}.Image_URL ;;
    html: <img src="{{ value }}" class="center" height = 160 width = 230>;;
  }

  dimension: image_deet {
    type: string
    sql: ${TABLE}.Image_URL ;;
    html: <img src="{{ value }}" class="center" height = 250 width = 360>;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
    link: {
      label: "Shoe Detail"
      url: "https://dcl.dev.looker.com/dashboards/168?Shoe%20Name={{filterable_value}}"
    }
    drill_fields: [size]
    html: <p style="font-size:15px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
  }

  dimension: item_name_deet {
    type: string
    sql: ${TABLE}.Item_Name ;;
    link: {
      label: "Shoe Detail"
      url: "https://dcl.dev.looker.com/dashboards/168?Shoe%20Name={{filterable_value}}"
    }
    drill_fields: [size]
    html: <p style="font-size:25px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;

  }

  dimension: last_sale_price {

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
    value_format_name: usd_0
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
    html: <p style="font-size:15px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
    value_format_name: usd_0
  }

  dimension: test {
    sql: 'test, words' ;;
    html: {{filterable_value}} ;;
  }

  dimension: total_sale_count {
    type: number
    sql: ${TABLE}.Total_Sale_Count ;;
  }

  dimension: sale_count {
    sql: ${TABLE}.Total_Sale_Count ;;
    html: {% if value < 20 %}
          <p style="color: black; background-color: orange; font-size:130%; text-align:center">{{ rendered_value }}</p>
          {% elsif value < 40 AND > 20 %}
            <p style="color: black; background-color: yellow; font-size:130%; text-align:center">{{ rendered_value }}</p>
          {% elsif value < 60 AND > 40 %}
            <p style="color: black; background-color: lightblue; font-size:130%; text-align:center">{{ rendered_value }}</p>
          {% elsif value > 80 %}
            <p style="color: black; background-color: lightgreen; font-size:130%; text-align:center">{{ rendered_value }}</p>
          {% endif %};;
  }

  dimension: volatility {
    type: number
    sql: ${TABLE}.Volatility ;;
  }

  dimension: ap {

    sql: ${TABLE}.Average_Price ;;
  }

  measure: average_price {
    type: sum
    sql: ${TABLE}.Average_Price ;;
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.Total_Sale ;;
    html: <p style="font-size:15px; font-family:monotype; text-align:center;" > {{value}}</p>;;
    value_format_name: usd_0
  }

#   dimension: test {
#     sql: ${image_url} ;;
#     html: {{ value }} ;;
#   }

  measure: ts {
    type: sum
    sql: ${TABLE}.Total_Sale ;;
    html: <p style="font-size:50px; font-family:monotype; text-align:center;" > {{rendered_value}}</p>;;
    value_format_name: usd_0
  }

  measure: count_2016 {
    type: count_distinct
    sql: ${TABLE}.Item_Name ;;
    filters: {
      field: release
      value: "2016"
    }
  }

  measure: count_2017 {
    type: count_distinct
    sql: ${TABLE}.Item_Name ;;
    filters: {
      field: release
      value: "2017"
    }
  }

  measure: count_2018 {
    type: count_distinct
    sql: ${TABLE}.Item_Name ;;
    filters: {
      field: release
      value: "2018"
    }
  }

  measure: total_count {
    type: count_distinct
    sql: ${TABLE}.Item_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [item_name]
  }
}
