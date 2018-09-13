# If necessary, uncomment the line below to include explore_source.
# include: "comparison.model.lkml"

view: tester {
  derived_table: {
    explore_source: nike_trans {
      column: date {field: trans_info.Date}
      column: pt {field: trans_info.Price}
      filters: {
        field: trans_info.item_name
        value: "Adilette Palace White"
      }
    }
  }
  dimension: date {
    type: date
  }
  dimension: pt {
    type: number
  }
}
