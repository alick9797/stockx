view: nike_trans {
  sql_table_name: StockX.nike_trans ;;

  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
  }

  dimension: brand1 {
    type: string
    sql: ${TABLE}.Brand1 ;;
  }

  dimension: collab {
    type: yesno
    sql: ${TABLE}.Brand1 IS NULL ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  parameter: date_granularity {
    type: string
    default_value: "Month"
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: date_created {
    type: string
    label_from_parameter: date_granularity
    description: "When the Opportunity was created. Use in conjunction with Date Granularity."
    sql:
    CASE
    WHEN {% parameter date_granularity %} = 'Day' THEN CAST(${date_date} AS STRING)
    WHEN {% parameter date_granularity %} = 'Month' THEN CAST(${date_month} AS STRING)
    WHEN {% parameter date_granularity %} = 'Quarter' THEN CAST(${date_fiscal_quarter} AS STRING)
    WHEN {% parameter date_granularity %} = 'Year' THEN CAST(${date_year} AS STRING)
    ELSE NULL
  END ;;
#   html:
#   {% if date_granularity._parameter_value == "'Quarter'" %}
#   {{ date_fiscal_quarter._rendered_value }}
#   {% else %}  {{ value }}
#   {% endif %};;
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
      fiscal_quarter,
      year
    ]
    sql: ${TABLE}.Date ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
#     html: <p style="font-size:170%">{{value}}</p>  ;;
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
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.Item_Name, ' ', ${size});;
  }


  measure: count {
    type: count
    drill_fields: [item_name]
  }
}
