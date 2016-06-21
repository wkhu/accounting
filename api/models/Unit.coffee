Unit   = 
  adapter: 'mongo'
  schema: true
  attributes:
    unitName: 
      type: "string"
      unique: true
    user:
      model: "user"

module.exports = Unit