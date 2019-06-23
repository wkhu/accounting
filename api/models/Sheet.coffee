Sheet   = 
  adapter: 'mongo'
  schema: true
  attributes:
    name: "string"
    description: "string"
    expenses:
      collection: "expense"
      via: "sheet"

module.exports = Sheet