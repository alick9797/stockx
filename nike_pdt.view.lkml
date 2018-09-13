view: nike_pdt {
  derived_table: {
    sql: SELECT item_name, total_sale, total_sale_count, size, average_price
        FROM StockX.nike
        WHERE {% condition item_comp %} nike.item_name {% endcondition %}
        ;;
  }

  filter: item_comp {
    type: string
    suggest_dimension: item_name
  }

  dimension: item_name {
    type: string
  }
  dimension: total_sale_count {
    type: number
  }
  dimension: size {
    type: number
  }
  dimension: average_price {
    type: number
  }
  dimension: total_sale {
    type: number
  }
}
