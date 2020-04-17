# include: "ad*.view"
# include: "ni*.view"
# include: "jo*.view"
#
# explore: adidas {
#   join: adidas_trans {
#     sql_on: ${adidas_trans.compound_pk} = ${adidas.compound_pk}  ;;
#     type: inner
#     relationship: one_to_many
#   }
# }
#
# explore: adidas_trans {}
#
# explore: nike {
#   join: nike_trans {
#     sql_on: ${nike_trans.compound_pk} = ${nike.compound_pk} ;;
#     type: inner
#     relationship: one_to_many
#   }
# }
#
# explore: jordan {
#   join: jordan_trans {
#     sql_on: ${jordan_trans.compound_pk} = ${jordan.compound_pk} ;;
#     type: inner
#     relationship: one_to_many
#   }
# }
