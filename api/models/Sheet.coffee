Sheet   = 
  adapter: 'mongo'
  schema: true
  attributes:
    name: "string"
    description: "string"
    user:
      model: "user"
    expenses:
      collection: "expense"
      via: "sheet"

module.exports = Sheet