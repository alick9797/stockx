include: "create_process.view"
view: create_process_extend {
  extends: [create_process_base]

  dimension: item_name {
    type: string
    sql: ${TABLE}.Item_Name ;;
  }
  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
  }
}
