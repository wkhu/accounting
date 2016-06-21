Category   = 
  adapter: 'mongo'
  schema: true
  attributes:
    name: "string"
    description: "string"
    expenses:
      collection: "expense"
      via: "category"

module.exports = Category