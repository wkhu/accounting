Transaction   = 
  adapter: 'mongo'
  schema: true
  attributes:
    date: "date"
    item: 
      model: "item" 
    price: "float"
    type: "boolean"
    quantity: "integer"

module.exports = Transaction