view: dates_dimension {
  derived_table: {
    sql: SELECT *
FROM UNNEST(GENERATE_DATE_ARRAY(DATE_ADD(CURRENT_DATE(), INTERVAL -365*3 day), CURRENT_DATE())) as date ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension_group: date {
    label: "Master Date"
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.date ;;
  }
}
