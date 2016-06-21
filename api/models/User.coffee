bcrypt = require('bcrypt')

User   = 
  adapter: 'mongo'
  schema: true
  attributes:
    username: 
      type: "string"
      unique: true
    email: 
      type: "string"
      unique: true
    password: "string"
    firstName: "string"
    lastName: "string"
    userType:
      type: "integer"
      defaultsTo: 1
    status:
      type: "integer"
      defaultsTo: 1
    lastLoggedIn: 
      type: "date"
      defaultsTo: new Date()

  toJSON: ->
    obj = @toObject()
    delete obj.pass
    obj


  beforeCreate: (user, cb) ->
    bcrypt.genSalt(10, (err, salt) ->
      bcrypt.hash(user.password, salt, (err, hash) ->
        if err
          console.log err
          cb(err)
        else
          console.log hash,'hash'
          user.password = hash
          cb null, user
      )
    )
module.exports = User