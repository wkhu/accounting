Expense   = 
  adapter: 'mongo'
  schema: true
  attributes:
    date: "date"
    item: 
      type: "string"
      unique: true
    quantity: "integer"
    price: "float"
    total: "float"
    comment: "string"
    category: 
      model: "category"
    sheet:
      model: "sheet"


module.exports = Expense