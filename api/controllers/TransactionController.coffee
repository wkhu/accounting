ObjectId = require('mongodb').ObjectID
module.exports =
  # show: (req, res) ->    
  #   id = req.query.id
  #   console.log req.query,'transaction show query'
  #   Transaction.find({item:id}).populateAll()
  #   .exec (err, data) ->
  #     console.log err, data, 'Transaction'
  #     res.json data if data
  #     res.serverError if err

  # showLatest: (req, res) ->    
  #   id = req.query.id
  #   console.log req.query,'req.query'
  #   Transaction.find({id:ObjectId(id)})
  #   .exec (err, data) ->
  #     console.log err, data, 'Transaction'
  #     res.json data[data.length-1] if data
  #     res.serverError err if err

  list: (req, res) ->
    console.log req.query,'trans list query'
    unless isEmpty req.query
      params = req.query
      paginate = 
        page: params.page
        limit: params.limit
      order = params.order
      if order and order.indexOf('-') > -1
        order = order + ' desc'
        order = order.replace('-','')
    console.log req.session.passport,'passport'
    Transaction.find().sort(order).paginate(paginate).populateAll()
    .exec (err, data) ->
      console.log err, data,'trans'
      Transaction.count()
      .exec (err, count) ->
        console.log err, count, 'trans count'
        result = 
          data: data
          count: count
        res.serverError err if err
        res.json result

  create: (req, res) ->
    data = req.body
    console.log data, 'trans create data'
    Transaction.create data
    .exec (err, data) ->
      console.log err, data, 'trans'
      res.serverError err if err
      res.json data


  # update: (req, res) ->
  #   id = req.params.id  
  #   trans = req.body
  #   console.log trans, 'trans'
  #   Transaction.findOne(id)
  #   .exec (err, data) ->
  #     res.serverError err if err
  #     if data 
  #       hist = 
  #         date: Date.now()
  #         userId: if req.session.passport.hasOwnProperty('user') then req.session.passport.user.id else null
  #         amount: +trans.amount
  #         action: +trans.action

  #       switch data.type
  #         when 0
  #           data.balance -= +trans.amount
  #           if data.balance is 0
  #             data.status = 1
  #           # hist.account = trans.account
  #         when 1
  #           if +trans.action is 0
  #             hist.action = 0
  #             data.totalAmount += +trans.amount
  #           else if +trans.action is 1
  #             hist.action = 1
  #             data.totalAmount -= +trans.amount
  #         else
  #           console.log 'Type not listed'
  #       data.history.push hist
  #       console.log data

  #       Transaction.update(data.id, data)
  #       .exec (err, data) ->
  #         res.serverError err if err
  #         res.json data[0]

  delete: (req, res) ->
    id = req.params.id
    console.log id, 'trans delete id'
    Transaction.destroy({id:id})
    .exec (err, data) ->
      console.log err, data, 'trans deleted'
      res.serverError err if err
      res.json data[0] if data
