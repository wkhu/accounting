bcrypt = require 'bcrypt'

module.exports =
  show: (req, res) ->    
    console.log req.session,'session user'
    id = if req.params.id is 'self' then req.session.passport.user.id else req.params.id
    console.log id,'id'
    User.findOne(id)
    .exec (err, data) ->
      console.log data, 'user show data' 
      res.json data if data
      res.serverError err if err
      
  list: (req, res) ->
    console.log req.query,'userlist query'
    unless isEmpty req.query
      console.log 'sud cat'
      params = req.query
      paginate = 
        page: params.page
        limit: params.limit
      console.log params,'params'
      order = params.order
      if order.indexOf('-') > -1
        console.log order, 'type:',typeof(order)
        order = order + ' desc'
        order = order.replace('-','')

    console.log order,'order'
    User.find().sort(order).paginate(paginate)
    .exec (err, result) ->
      User.count()
      .exec (err, count) ->
        result = 
          data: result
          count: count
        res.serverError err if err
        res.json result

    # User.find({,sort:'createdAt DESC'})
    # .exec (err, result) ->
    #   res.serverError err if err
    #   res.json result

  create: (req, res) ->
    console.log 'create'
    data = req.body
    console.log data
    User.create data
    .exec (err, data) ->
      res.serverError err if err
      res.json data


  update: (req, res) ->
    # id = req.params.id  
    user = req.body
    console.log user, 'user'
    User.update user.id, user
    .exec (err, data) ->
      console.log err, data,'errdata'
      res.serverError err if err
      res.json data[0] if data
    # Transaction.findOne(id)
    # .exec (err, data) ->
    #   res.serverError err if err
    #   if data 
    #     hist = 
    #       date: Date.now()
    #       userId: if req.session.passport.hasOwnProperty('user') then req.session.passport.user.id else null
    #       amount: +trans.amount
    #       action: +trans.action

    #     switch data.type
    #       when 0
    #         data.balance -= +trans.amount
    #         if data.balance is 0
    #           data.status = 1
    #         # hist.account = trans.account
    #       when 1
    #         if +trans.action is 0
    #           hist.action = 0
    #           data.totalAmount += +trans.amount
    #         else if +trans.action is 1
    #           hist.action = 1
    #           data.totalAmount -= +trans.amount
    #       else
    #         console.log 'Type not listed'
    #     data.history.push hist
    #     console.log data

    #     Transaction.update(data.id, data)
    #     .exec (err, data) ->
    #       res.serverError err if err
    #       res.json data[0]

  delete: (req, res) ->
    id = req.params.id
    console.log id, 'id'
    User.destroy({id:id})
    .exec (err, data) ->
      res.serverError err if err
      res.json data[0] if data


  changePassword: (req, res) ->
    console.log req.session.passport.user.id, 'session user'
    id = req.session.passport.user.id
    password = req.body
    console.log password, 'password'
    User.findOne(id)
    .exec (err, data)->
      console.log err, data, 'errdata'

      bcrypt.compare password.currentPassword, data.password,(err, result) ->
        console.log err, result, 'bcrypt'
        if err 
          console.log(err,'err')
          res.json { message: 'Server error.' }
        else if !result
          console.log('incorrect pass');
          res.json { message: 'Invalid current password.' }
        else
          bcrypt.genSalt 10, (err, salt) ->
            bcrypt.hash password.newPassword, salt, (err, hash) ->
              if err
                res.json {message: 'Error hashing.'}
              else
                console.log hash,'hash'
                data.password = hash
                data.save (err,s) ->
                  console.log err, s, 'updated'
                  res.json {message: 'Successfully updated password.'}
      