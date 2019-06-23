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

module.exports = Item