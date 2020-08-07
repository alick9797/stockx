view: adidas_trans_test {
  derived_table: {
    sql: SELECT * FROM   StockX.adidas_trans WHERE Category = "Y" OR {% condition category_fil %} adidas_trans.Category {% endcondition %} ;;
  }

  parameter: category_fil {
    type: unquoted
  }

  dimension: category_1 {
    type: string
    sql: ${TABLE}.Category ;;
  }
}
