Item   = 
  adapter: 'mongo'
  schema: true
  attributes:
    itemName: "string"
    price: "float"
    description: "string"
    unit: 
      model: "unit"
    transactions:
      collection: 'transaction'
      via: 'item'
    user:
      model: "user"

module.exports = Item