view: dates_dimension {
  derived_table: {
    sql: SELECT CURRENT_DATE() - generate_series(0, 365 * 3 - 1) AS date ;;
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
