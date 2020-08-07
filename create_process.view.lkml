include: "*.view"
view: create_process_base {
  derived_table: {
    datagroup_trigger: test_persist
    create_process: {
      sql_step: create table ${SQL_TABLE_NAME} AS
                SELECT * FROM StockX.adidas_trans;;
    }
  }
  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
    link: {
      label: "copy"
      url: "{{ value }}"
    }
  }
}
